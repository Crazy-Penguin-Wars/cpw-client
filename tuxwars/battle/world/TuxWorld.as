package tuxwars.battle.world
{
   import com.dchoc.game.DCGame;
   import com.dchoc.game.GameWorld;
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.gameobjects.GameObjectDef;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.FullScreenEvent;
   import flash.geom.Point;
   import nape.geom.*;
   import nape.phys.BodyList;
   import no.olog.utilfunctions.*;
   import org.as3commons.lang.*;
   import tuxwars.*;
   import tuxwars.battle.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.data.particles.ThemeParticleData;
   import tuxwars.battle.effects.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.missiles.*;
   import tuxwars.battle.net.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.battle.net.responses.*;
   import tuxwars.battle.states.player.*;
   import tuxwars.battle.ui.*;
   import tuxwars.battle.world.loader.*;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   import tuxwars.player.Player;
   import tuxwars.tutorial.*;
   import tuxwars.utils.*;
   
   public class TuxWorld extends GameWorld
   {
      private static const MINUTE:int = 60000;
      
      private static const TEN_SECONDS:int = 10000;
      
      private static const PENGUIN_PIVOT_POINT_TOP:int = 65;
      
      private static const PENGUIN_PIVOT_POINT_BOTTOM:int = 55;
      
      private const updateWorldMessages:Vector.<UpdateGameWorldMessage> = new Vector.<UpdateGameWorldMessage>();
      
      private const feedbackItems:Vector.<FeedbackItem> = new Vector.<FeedbackItem>();
      
      private const PLAYER_CACHE:Object = {};
      
      private const counterFlags:Vector.<Boolean> = new Vector.<Boolean>();
      
      private var _physicsWorld:PhysicsWorld;
      
      private var _players:Array;
      
      private var particleSystem:ParticleSystem;
      
      private var textFXQueue:Vector.<TextEffect>;
      
      private var shakeFX:ShakeEffect;
      
      private var levelRainEffectData:ThemeParticleData;
      
      private var levelRainTimer:int;
      
      private var levelRainActivationTimes:Vector.<int>;
      
      private var levelWaterEffectData:ThemeParticleData;
      
      private var levelWaterTimer:int;
      
      private var levelWaterActivationTimes:Vector.<int>;
      
      private var worldUpdateTime:int;
      
      private var gameEndConfirmSent:Boolean;
      
      private var _gameEnded:Boolean;
      
      private var levelSizeScaleIgnoreds:Vector.<DisplayObject> = new Vector.<DisplayObject>();
      
      private var _turnEnd:Boolean;
      
      private var numUpdatesUntilClientReady:int;
      
      private var lastFrameTime:int = -1;
      
      private var shownOneMinuteLeft:Boolean;
      
      private var shownTenSecondsLeft:Boolean;
      
      public function TuxWorld(param1:TuxWarsGame)
      {
         super(param1);
      }
      
      override public function init(param1:* = null) : void
      {
         var _loc2_:int = 0;
         assert("Value is null.",true,param1 != null);
         removeMarkedGameObjects = false;
         initCamera(this.calculateZoomLevel(param1.level as Level));
         this._physicsWorld = new PhysicsWorld(this);
         this._physicsWorld.loadLevel(param1.level as Level);
         this.createPlayers(param1.players);
         this.addPlayers();
         this.particleSystem = new ParticleSystem(this);
         this.textFXQueue = new Vector.<TextEffect>();
         this.playLevelTheme();
         this.worldUpdateTime = BattleOptions.getRow().findField("WorldUpdateTime").value;
         this.levelRainEffectData = this._physicsWorld.level.theme.getRainParticleData();
         this.levelRainTimer = 0;
         if(this.levelRainEffectData)
         {
            this.levelRainActivationTimes = new Vector.<int>(this.levelRainEffectData.hardness);
         }
         this.levelWaterEffectData = this._physicsWorld.level.theme.getWaterParticleData();
         this.levelWaterTimer = 0;
         if(this.levelWaterEffectData)
         {
            this.levelWaterActivationTimes = new Vector.<int>(this.levelWaterEffectData.hardness);
         }
         MessageCenter.addListener("UpdateGameWorld",this.updateWorldHandler);
         MessageCenter.addListener("BattleResponse",this.handleResponse);
         this._camera.updateZoom();
         while(_loc2_ < 10)
         {
            this.counterFlags[_loc2_] = false;
            _loc2_++;
         }
         this.physicsWorld.logLevelData(true,true);
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         super.dispose();
         MessageCenter.removeListener("UpdateGameWorld",this.updateWorldHandler);
         MessageCenter.removeListener("BattleResponse",this.handleResponse);
         for each(_loc1_ in this.feedbackItems)
         {
            _loc1_.dispose();
         }
         this.feedbackItems.splice(0,this.feedbackItems.length);
         for each(_loc2_ in this.textFXQueue)
         {
            _loc2_.dispose();
         }
         this.textFXQueue.splice(0,this.textFXQueue.length);
         this._physicsWorld.dispose();
         this._physicsWorld = null;
         this._players.splice(0,this._players.length);
         this._players = null;
         if(this.shakeFX)
         {
            this.shakeFX.dispose();
            this.shakeFX = null;
         }
         this.particleSystem.dispose();
         this.particleSystem = null;
         this.levelSizeScaleIgnoreds.splice(0,this.levelSizeScaleIgnoreds.length);
         this.updateWorldMessages.splice(0,this.updateWorldMessages.length);
         this.shownOneMinuteLeft = false;
         this.shownTenSecondsLeft = false;
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this.handleEffects(param1);
         if(this.gameEnded && this.updateWorldMessages.length == 0)
         {
            this.endGameConfirm();
            this.gameEnded = false;
         }
      }
      
      override public function createGameObject(param1:GameObjectDef) : *
      {
         var _loc2_:GameObject = super.createGameObject(param1);
         var _loc3_:* = _loc2_;
         _loc2_.uniqueId = UniqueCounters.next(_loc3_.id,"TuxWorld").toString();
         return _loc2_;
      }
      
      public function get turnEnd() : Boolean
      {
         return this._turnEnd;
      }
      
      public function set turnEnd(param1:Boolean) : void
      {
         this._turnEnd = param1;
         if(this._turnEnd)
         {
            this.numUpdatesUntilClientReady = this.updateWorldMessages.length;
         }
      }
      
      public function get gameEnded() : Boolean
      {
         return this._gameEnded;
      }
      
      public function set gameEnded(param1:Boolean) : void
      {
         this._gameEnded = param1;
      }
      
      public function get physicsWorld() : PhysicsWorld
      {
         return this._physicsWorld;
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return this._game as TuxWarsGame;
      }
      
      public function get players() : Array
      {
         return this._players;
      }
      
      public function getPlayerIndex(param1:PlayerGameObject) : int
      {
         return this._players.indexOf(param1);
      }
      
      public function removePlayer(param1:String) : void
      {
         var _loc2_:int = this.getIndexOfPlayerWithId(param1);
         var _loc3_:PlayerGameObject = this._players.splice(_loc2_,1)[0];
         delete this.PLAYER_CACHE[param1];
         this._objectContainer.removeChild(_loc3_.container);
         _loc3_.markForRemoval();
      }
      
      public function getIndexOfPlayerWithId(param1:String) : int
      {
         var _loc4_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:PlayerGameObject = null;
         _loc2_ = 0;
         while(_loc2_ < this._players.length)
         {
            _loc3_ = this._players[_loc2_];
            _loc4_ = _loc3_;
            if(_loc4_._id == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public function findPlayer(param1:String) : PlayerGameObject
      {
         if(!this.PLAYER_CACHE.hasOwnProperty(param1))
         {
            this.PLAYER_CACHE[param1] = DCUtils.find(this._players,"id",param1);
         }
         return this.PLAYER_CACHE[param1];
      }
      
      public function forceEndGameConfirm() : void
      {
         LogUtils.log("Forcing game to proceede to end_game_confirm",this,0,"Messages",false,false,false);
         this.endGameConfirm();
      }
      
      public function addParticle(param1:ParticleReference, param2:int, param3:int, param4:Number = 0) : void
      {
         if(isWorldReady() && Boolean(this.particleSystem))
         {
            this.particleSystem.addParticleEffect(param1,param2,param3,param4);
         }
      }
      
      public function addFeedbackItem(param1:String, param2:Point, param3:int, param4:int = -1, param5:int = -1, param6:int = -1, param7:String = null, param8:String = null, param9:MovieClip = null) : void
      {
         var _loc10_:FeedbackItem = new FeedbackItem(param1,param2.x,param2.y,param3,this._physicsWorld.level.width,this._physicsWorld.level.height,param4,param5,param6,param7,param8,param9);
         this._objectContainer.addChild(_loc10_.getMovieClip());
         this.feedbackItems.push(_loc10_);
         var _loc11_:SoundReference = Sounds.getSoundReference("NONE");
         if(param1 == "drop_exp")
         {
            _loc11_ = Sounds.getSoundReference("GetExp");
         }
         else if(param1 == "drop_coins" || Boolean("drop_cash"))
         {
            _loc11_ = Sounds.getSoundReference("GetCoins");
         }
         else if(param1 == "drop_generic_item")
         {
         }
         if(_loc11_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc11_.getMusicID(),_loc11_.getStart(),_loc11_.getType(),"PlaySound"));
         }
      }
      
      public function addTextEffect(param1:int, param2:String, param3:int, param4:int, param5:Boolean, param6:* = null) : TextEffect
      {
         var _loc7_:TextEffect = null;
         var _loc8_:int = 0;
         _loc8_ = 70;
         if(this.textFXQueue.length >= 1)
         {
            _loc7_ = this.textFXQueue[0];
            if(param1 == 6 || param1 == 4)
            {
               if(_loc7_.type == 6 || _loc7_.type == 4)
               {
                  param1 = 5;
                  param3 = DCGame.getStage().stageWidth >> 1;
                  param4 = DCGame.getStage().stageHeight * _loc8_ / 100;
               }
               else
               {
                  _loc7_.setXY(DCGame.getStage().stageWidth >> 1,DCGame.getStage().stageHeight * _loc8_ / 100);
               }
            }
         }
         var _loc9_:TextEffect = new TextEffect(param1,param2,param3,param4,param6);
         if(param5)
         {
            DCGame._infoLayer.addChild(_loc9_.movieClip);
         }
         else
         {
            this._objectContainer.addChild(_loc9_.movieClip);
         }
         this.textFXQueue.push(_loc9_);
         return _loc9_;
      }
      
      public function ignoreLevelSizeScale(param1:DisplayObject, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:Number = 1 / this._camera.zoom;
         param1.scaleX = _loc4_;
         param1.scaleY = _loc4_;
         var _loc5_:Number = 0;
         if(param2)
         {
            _loc5_ = -(65 + this._camera.zoom * 10);
            if(param1.y > 0)
            {
               _loc5_ += param1.y;
            }
         }
         else if(param3)
         {
            _loc5_ = 55 - this._camera.zoom * 10;
         }
         param1.y = _loc5_;
         this.storeIgnoredLevelSizeScaleObject(param1);
      }
      
      private function storeIgnoredLevelSizeScaleObject(param1:DisplayObject) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < this.levelSizeScaleIgnoreds.length)
         {
            if(!this.levelSizeScaleIgnoreds[_loc2_] || !this.levelSizeScaleIgnoreds[_loc2_].parent)
            {
               this.levelSizeScaleIgnoreds[_loc2_] = param1;
               return;
            }
            _loc2_++;
         }
         this.levelSizeScaleIgnoreds.push(param1);
      }
      
      override public function cameraZoomingUpdated() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Number = Number(NaN);
         var _loc3_:int = this.physicsWorld.level.width * this._camera.zoom;
         var _loc4_:int = this.physicsWorld.level.height * this._camera.zoom;
         var _loc5_:int = _loc3_ * 0.5;
         var _loc6_:int = _loc4_ * 0.5;
         var _loc7_:int = int(DCGame.getStage().stageWidth);
         var _loc8_:int = int(DCGame.getStage().stageHeight);
         var _loc9_:int = _loc7_ * 0.5;
         var _loc10_:int = _loc8_ * 0.5;
         this._camera.worldX = _loc9_ - _loc5_;
         this._camera.worldY = _loc10_ - _loc6_;
         _loc1_ = this.levelSizeScaleIgnoreds.length - 1;
         while(_loc1_ >= 0)
         {
            if(Boolean(this.levelSizeScaleIgnoreds[_loc1_]) && Boolean(this.levelSizeScaleIgnoreds[_loc1_].parent))
            {
               _loc2_ = 1 / this._camera.zoom;
               this.levelSizeScaleIgnoreds[_loc1_].scaleX = _loc2_;
               this.levelSizeScaleIgnoreds[_loc1_].scaleY = _loc2_;
            }
            else
            {
               this.levelSizeScaleIgnoreds.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      public function addCameraShake(param1:int, param2:Number) : void
      {
         if(param1 == 0 || param2 == 0)
         {
            return;
         }
         if(!this.shakeFX)
         {
            this.shakeFX = new ShakeEffect(param1,param2,this);
         }
      }
      
      public function getAffectedGameObjects(param1:Vec2, param2:Number, param3:Boolean) : Vector.<PhysicsGameObject>
      {
         var i:int = 0;
         var gameObject:PhysicsGameObject = null;
         var hitLocation:Vec2 = param1;
         var radius:Number = param2;
         var includeWeapons:Boolean = param3;
         var affectedObjects:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
         var bodyList:BodyList = this._physicsWorld.space.bodiesInCircle(hitLocation,radius);
         i = 0;
         while(i < bodyList.length)
         {
            gameObject = bodyList.at(i).userData.gameObject as PhysicsGameObject;
            if(gameObject && affectedObjects.indexOf(gameObject) == -1 && (includeWeapons || !(gameObject is Missile)) && !(gameObject is Follower))
            {
               affectedObjects.push(gameObject);
            }
            i++;
         }
         affectedObjects.sort(function(param1:PhysicsGameObject, param2:PhysicsGameObject):int
         {
            var _loc3_:* = param1;
            var _loc4_:* = param2;
            return StringUtils.compareTo(_loc3_._uniqueId,_loc4_._uniqueId);
         });
         return affectedObjects;
      }
      
      public function getAffectedGameObjectsInAABB(param1:AABB, param2:Boolean) : Vector.<PhysicsGameObject>
      {
         var i:int = 0;
         var gameObject:PhysicsGameObject = null;
         var aabb:AABB = param1;
         var includeWeapons:Boolean = param2;
         var affectedObjects:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
         var bodyList:BodyList = this._physicsWorld.space.bodiesInAABB(aabb);
         i = 0;
         while(i < bodyList.length)
         {
            gameObject = bodyList.at(i).userData.gameObject as PhysicsGameObject;
            if(gameObject && affectedObjects.indexOf(gameObject) == -1 && (includeWeapons || !(gameObject is Missile)) && !(gameObject is Follower))
            {
               affectedObjects.push(gameObject);
            }
            i++;
         }
         affectedObjects.sort(function(param1:PhysicsGameObject, param2:PhysicsGameObject):int
         {
            var _loc3_:* = param1;
            var _loc4_:* = param2;
            return StringUtils.compareTo(_loc3_._uniqueId,_loc4_._uniqueId);
         });
         return affectedObjects;
      }
      
      public function turnOffRain() : void
      {
         this.levelRainEffectData = null;
      }
      
      public function turnOffWaterFx() : void
      {
         this.levelWaterEffectData = null;
      }
      
      public function reduceParticlesAmount(param1:int) : void
      {
         this.particleSystem.reduceParticlesAmount(param1);
      }
      
      public function calculateNormalZoomLevel() : Number
      {
         return 668 / this.physicsWorld.level.height;
      }
      
      override protected function postInputUpdate(param1:int) : void
      {
         if(this.turnEnd)
         {
            if(this.numUpdatesUntilClientReady > 0)
            {
               this.processNextWorldUpdate();
               --this.numUpdatesUntilClientReady;
            }
            else
            {
               BattleManager.getCurrentActivePlayer().moveControls.endTurn();
               BattleManager.turnEnd();
               this.turnEnd = false;
            }
         }
         else if(this.updateWorldMessages.length > 0)
         {
            this.processNextWorldUpdate();
         }
      }
      
      override protected function fullscreenChanged(param1:FullScreenEvent) : void
      {
         super.fullscreenChanged(param1);
         this.physicsWorld.fullscreenChanged(param1.fullScreen);
         this._camera.zoom = this.calculateZoomLevel(this._physicsWorld.level);
      }
      
      private function processNextWorldUpdate() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:UpdateGameWorldMessage = this.updateWorldMessages.shift();
         for each(_loc2_ in _loc1_.responses)
         {
            this.handleResponse(_loc2_);
         }
      }
      
      private function handleResponse(param1:BattleResponse) : void
      {
         switch(param1.responseType)
         {
            case 1:
               this.updateWorld(param1);
               break;
            case 36:
               this.physicsWorld.createPowerUp(param1.data.pid);
               break;
            case 22:
               BattleManager.removeClient(param1.data);
               break;
            default:
               this.handlePlayerActions(param1);
         }
      }
      
      private function updateWorld(param1:BattleResponse) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = param1.data;
         var _loc5_:BattleSimulation = BattleManager.getSimulation();
         var _loc6_:int = int(!!_loc4_.hasOwnProperty("mtl") ? _loc4_.mtl : _loc5_.getMatchTimeLeft() - this.worldUpdateTime);
         _loc5_.updateMatchTime(_loc6_);
         var _loc7_:int = int(!!_loc4_.hasOwnProperty("ttl") ? _loc4_.ttl : _loc5_.getTurnTimeLeft() - this.worldUpdateTime);
         _loc5_.updateTurnTime(_loc7_);
         this.handleRespawningPlayers(_loc4_.respawn);
         this.handleResumingPlayers(_loc4_.resume);
         var _loc8_:int = _loc5_.getMatchDuration();
         var _loc9_:int = _loc5_.getMatchTimeLeft();
         if(!this.shownOneMinuteLeft && _loc9_ <= 60000 && _loc8_ > 60000)
         {
            BattleManager.showText(ProjectManager.getText("MATCH_MINUTE_LEFT"),6,false);
            this.shownOneMinuteLeft = true;
         }
         else if((Boolean(this.shownOneMinuteLeft) || _loc8_ <= 60000) && !this.shownTenSecondsLeft && _loc9_ <= 10000 && _loc8_ > 10000)
         {
            BattleManager.showText(ProjectManager.getText("MATCH_TEN_SECONDS_LEFT"),5,false,null,DCGame.getStage().stageHeight / 2);
            this.shownTenSecondsLeft = true;
         }
         if(_loc5_.getMatchTimeLeft() < 10000)
         {
            _loc2_ = _loc9_ / 1000;
            _loc3_ = _loc2_ - 1;
            if(_loc2_ > 0 && !this.counterFlags[_loc3_])
            {
               this.counterFlags[_loc3_] = true;
               BattleManager.showText(null,7,false,_loc3_,DCGame.getStage().stageHeight / 2);
            }
         }
         this.update(this.worldUpdateTime);
      }
      
      private function handleRespawningPlayers(param1:Array) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:PlayerGameObject = null;
         for each(_loc4_ in param1)
         {
            _loc2_ = _loc4_.dead_dude;
            _loc3_ = this.findPlayer(_loc2_);
            if(_loc3_ && _loc3_.isDead() && !_loc5_._markedForRemoval)
            {
               LogUtils.log("Respawning player " + _loc3_,this,1,"Player",false,false,false);
               _loc3_.changeState(new PlayerSpawningState(_loc3_,_loc4_),true);
            }
            else if(!_loc3_)
            {
               LogUtils.log("Couldn\'t find player to respawn: " + _loc2_,this,2,"Player");
            }
         }
      }
      
      private function handleResumingPlayers(param1:Array) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:String = null;
         var _loc3_:PlayerGameObject = null;
         for each(_loc4_ in param1)
         {
            _loc2_ = _loc4_.dead_dude;
            _loc3_ = this.findPlayer(_loc2_);
            if(_loc3_ && _loc3_.isSpawning() && !_loc5_._markedForRemoval)
            {
               LogUtils.log("Resuming player: " + _loc3_,this,1,"Player",false,false,false);
               PlayerSpawningState(_loc3_.state).resume();
            }
            else if(!_loc3_)
            {
               LogUtils.log("Couldn\'t find player to resume: " + _loc2_,this,2,"Player");
            }
         }
      }
      
      private function handleEffects(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:FeedbackItem = null;
         if(this.particleSystem)
         {
            this.particleSystem.logicUpdate(param1);
         }
         this.playLevelThemeEffects(param1);
         if(this.shakeFX)
         {
            if(this.shakeFX.logicUpdate(param1))
            {
               this.shakeFX = null;
            }
         }
         if(this.textFXQueue)
         {
            _loc2_ = this.textFXQueue.length - 1;
            while(_loc2_ >= 0)
            {
               if(this.textFXQueue[_loc2_].isFinished())
               {
                  this.textFXQueue[_loc2_].dispose();
                  this.textFXQueue.splice(_loc2_,1);
               }
               _loc2_--;
            }
         }
         _loc3_ = this.feedbackItems.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_ = this.feedbackItems[_loc3_];
            if(_loc4_.finished)
            {
               _loc4_.dispose();
               this.feedbackItems.splice(_loc3_,1);
            }
            _loc3_--;
         }
      }
      
      private function updateWorldHandler(param1:UpdateGameWorldMessage) : void
      {
         this.updateWorldMessages.push(param1);
      }
      
      private function handlePlayerActions(param1:BattleResponse) : void
      {
         var _loc2_:ActionResponse = ActionResponseFactory.createActionResponse(param1.data);
         var _loc3_:Boolean = Boolean(BattleManager.isLocalPlayer(_loc2_.senderId));
         MessageCenter.sendEvent(_loc2_);
         var _loc4_:PlayerGameObject = this.findPlayer(_loc2_.id);
         if(_loc4_)
         {
            _loc4_.handleAction(_loc2_);
         }
      }
      
      private function update(param1:int) : void
      {
         trace("Disabled try-catch because of the insanely useless error message");
         trace("try");
         trace("{");
         this._physicsWorld.updatePhysicsWorld(param1);
         trace("}");
         trace("catch(e:Error)");
         trace("{");
         trace("   LogUtils.log(e.getStackTrace(),this,3,\'ErrorLogging\');");
         trace("   MessageCenter.sendEvent(new ErrorMessage(\'TuxWorld Error\',\'update\',\'TuxWorld Exception somewhere\',null,null,\'error_tuxworld\'));");
         trace("}");
      }
      
      private function endGameConfirm() : void
      {
         var _loc1_:* = undefined;
         if(!this.gameEndConfirmSent)
         {
            LogUtils.log("End Game Confirm.",this,1,"Match",true,false,true);
            _loc1_ = this.tuxGame.tuxWorld;
            MessageCenter.sendEvent(new ChallengeEndGameConfirm(_loc1_._gameObjects,this.tuxGame.tuxWorld.players));
            MessageCenter.sendEvent(new MatchEndedMessage(this.tuxGame.tuxWorld.players));
            if(!ChallengeManager.instance)
            {
               ChallengeManager.instance = new ChallengeManager();
            }
            ChallengeManager.instance.physicsUpdate(0);
            MessageCenter.sendEvent(new EndGameConfirmMessage());
            BattleManager.endGame();
            this.gameEndConfirmSent = true;
         }
      }
      
      private function playLevelTheme() : void
      {
         MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
         Sounds.playGuitar();
         var _loc1_:SoundReference = this._physicsWorld.level.theme.getLevelAmbienceSound();
         if(_loc1_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",_loc1_.getMusicID(),_loc1_.getLoop(),_loc1_.getType()));
         }
         var _loc2_:SoundReference = Sounds.getSoundReference("BattleMusic");
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("LoopMusic",_loc2_.getMusicID(),_loc2_.getLoop(),_loc2_.getType()));
         }
      }
      
      private function playLevelThemeEffects(param1:int) : void
      {
      }
      
      private function createPlayers(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Player = null;
         var _loc5_:PlayerGameObjectDef = null;
         this._players = [];
         var _loc6_:Random = new Random(BattleManager._seed,"Create Players Random",Config.debugMode);
         var _loc7_:Vector.<Vec2> = this._physicsWorld.getStartLocations();
         var _loc8_:* = new Vector.<Vec2>();
         if(Tutorial._tutorial)
         {
            _loc8_ = _loc7_;
         }
         else
         {
            while(_loc7_.length > 0)
            {
               _loc2_ = _loc6_.integer(_loc7_.length);
               _loc8_.push(_loc7_[_loc2_]);
               _loc7_.splice(_loc2_,1);
            }
         }
         var _loc9_:int = 1;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            LogUtils.addDebugLine("Player","Creating PlayerGameObject for: " + _loc4_.id,"TuxWorld");
            _loc5_ = new PlayerGameObjectDef(this._physicsWorld.space);
            _loc5_.loadPlayer(_loc4_);
            _loc5_.position = _loc8_[_loc3_];
            this._players[_loc3_] = this.createGameObject(_loc5_);
            this._players[_loc3_].setTabIndex(_loc9_++);
            this._players[_loc3_].createHud();
            _loc3_++;
         }
      }
      
      private function addPlayers() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._players)
         {
            this._objectContainer.addChild(_loc1_.container);
         }
      }
      
      private function removePlayers() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this._players)
         {
            this._objectContainer.removeChild(_loc1_.container);
         }
         this._players = [];
      }
      
      private function calculateZoomLevel(param1:Level) : Number
      {
         return DCGame.getStage().stageHeight / param1.height;
      }
   }
}

