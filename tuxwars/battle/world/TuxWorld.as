package tuxwars.battle.world
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.game.DCGame;
   import com.dchoc.game.GameWorld;
   import com.dchoc.gameobjects.GameObject;
   import com.dchoc.gameobjects.GameObjectDef;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.Random;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import flash.geom.Point;
   import nape.geom.AABB;
   import nape.geom.Vec2;
   import nape.phys.BodyList;
   import no.olog.utilfunctions.assert;
   import org.as3commons.lang.StringUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.BattleSimulation;
   import tuxwars.battle.data.BattleOptions;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.data.particles.ThemeParticleData;
   import tuxwars.battle.effects.ParticleSystem;
   import tuxwars.battle.effects.ShakeEffect;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.gameobjects.Follower;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.gameobjects.player.PlayerGameObjectDef;
   import tuxwars.battle.missiles.Missile;
   import tuxwars.battle.net.BattleResponse;
   import tuxwars.battle.net.UpdateGameWorldMessage;
   import tuxwars.battle.net.messages.control.EndGameConfirmMessage;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.ActionResponseFactory;
   import tuxwars.battle.states.player.PlayerSpawningState;
   import tuxwars.battle.ui.FeedbackItem;
   import tuxwars.battle.world.loader.Level;
   import tuxwars.challenges.ChallengeManager;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   import tuxwars.player.Player;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.utils.UniqueCounters;
   
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
      
      private var levelSizeScaleIgnoreds:Vector.<DisplayObject>;
      
      private var _turnEnd:Boolean;
      
      private var numUpdatesUntilClientReady:int;
      
      private var lastFrameTime:int = -1;
      
      private var shownOneMinuteLeft:Boolean;
      
      private var shownTenSecondsLeft:Boolean;
      
      public function TuxWorld(game:TuxWarsGame)
      {
         levelSizeScaleIgnoreds = new Vector.<DisplayObject>();
         super(game);
      }
      
      override public function init(value:* = null) : void
      {
         var i:int = 0;
         assert("Value is null.",true,value != null);
         removeMarkedGameObjects = false;
         initCamera(calculateZoomLevel(value.level as Level));
         _physicsWorld = new PhysicsWorld(this);
         _physicsWorld.loadLevel(value.level as Level);
         createPlayers(value.players);
         addPlayers();
         particleSystem = new ParticleSystem(this);
         textFXQueue = new Vector.<TextEffect>();
         playLevelTheme();
         var _loc3_:BattleOptions = BattleOptions;
         worldUpdateTime = tuxwars.battle.data.BattleOptions.getRow().findField("WorldUpdateTime").value;
         levelRainEffectData = _physicsWorld.level.theme.getRainParticleData();
         levelRainTimer = 0;
         if(levelRainEffectData)
         {
            levelRainActivationTimes = new Vector.<int>(levelRainEffectData.hardness);
         }
         levelWaterEffectData = _physicsWorld.level.theme.getWaterParticleData();
         levelWaterTimer = 0;
         if(levelWaterEffectData)
         {
            levelWaterActivationTimes = new Vector.<int>(levelWaterEffectData.hardness);
         }
         MessageCenter.addListener("UpdateGameWorld",updateWorldHandler);
         MessageCenter.addListener("BattleResponse",handleResponse);
         this._camera.updateZoom();
         while(i < 10)
         {
            counterFlags[i] = false;
            i++;
         }
         physicsWorld.logLevelData(true,true);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MessageCenter.removeListener("UpdateGameWorld",updateWorldHandler);
         MessageCenter.removeListener("BattleResponse",handleResponse);
         for each(var feedback in feedbackItems)
         {
            feedback.dispose();
         }
         feedbackItems.splice(0,feedbackItems.length);
         for each(var textEffect in textFXQueue)
         {
            textEffect.dispose();
         }
         textFXQueue.splice(0,textFXQueue.length);
         _physicsWorld.dispose();
         _physicsWorld = null;
         _players.splice(0,_players.length);
         _players = null;
         if(shakeFX)
         {
            shakeFX.dispose();
            shakeFX = null;
         }
         particleSystem.dispose();
         particleSystem = null;
         levelSizeScaleIgnoreds.splice(0,levelSizeScaleIgnoreds.length);
         updateWorldMessages.splice(0,updateWorldMessages.length);
         shownOneMinuteLeft = false;
         shownTenSecondsLeft = false;
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         handleEffects(deltaTime);
         if(gameEnded && updateWorldMessages.length == 0)
         {
            endGameConfirm();
            gameEnded = false;
         }
      }
      
      override public function createGameObject(def:GameObjectDef) : *
      {
         var _loc2_:GameObject = super.createGameObject(def);
         var _loc3_:* = _loc2_;
         _loc2_.uniqueId = UniqueCounters.next(_loc3_._id,"TuxWorld").toString();
         return _loc2_;
      }
      
      public function get turnEnd() : Boolean
      {
         return _turnEnd;
      }
      
      public function set turnEnd(value:Boolean) : void
      {
         _turnEnd = value;
         if(_turnEnd)
         {
            numUpdatesUntilClientReady = updateWorldMessages.length;
         }
      }
      
      public function get gameEnded() : Boolean
      {
         return _gameEnded;
      }
      
      public function set gameEnded(value:Boolean) : void
      {
         _gameEnded = value;
      }
      
      public function get physicsWorld() : PhysicsWorld
      {
         return _physicsWorld;
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return this._game as TuxWarsGame;
      }
      
      public function get players() : Array
      {
         return _players;
      }
      
      public function getPlayerIndex(player:PlayerGameObject) : int
      {
         return _players.indexOf(player);
      }
      
      public function removePlayer(id:String) : void
      {
         var _loc2_:int = getIndexOfPlayerWithId(id);
         var _loc3_:PlayerGameObject = _players.splice(_loc2_,1)[0];
         delete PLAYER_CACHE[id];
         this._objectContainer.removeChild(_loc3_.container);
         _loc3_.markForRemoval();
      }
      
      public function getIndexOfPlayerWithId(id:String) : int
      {
         var i:int = 0;
         var _loc2_:* = null;
         for(i = 0; i < _players.length; )
         {
            _loc2_ = _players[i];
            var _loc4_:* = _loc2_;
            if(_loc4_._id == id)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function findPlayer(id:String) : PlayerGameObject
      {
         if(!PLAYER_CACHE.hasOwnProperty(id))
         {
            PLAYER_CACHE[id] = DCUtils.find(_players,"id",id);
         }
         return PLAYER_CACHE[id];
      }
      
      public function forceEndGameConfirm() : void
      {
         LogUtils.log("Forcing game to proceede to end_game_confirm",this,0,"Messages",false,false,false);
         endGameConfirm();
      }
      
      public function addParticle(particleRef:ParticleReference, locX:int, locY:int, angle:Number = 0) : void
      {
         if(isWorldReady() && particleSystem)
         {
            particleSystem.addParticleEffect(particleRef,locX,locY,angle);
         }
      }
      
      public function addFeedbackItem(type:String, loc:Point, gain:int, appearTime:int = -1, waitTime:int = -1, flyTime:int = -1, swf:String = null, export:String = null, icon:MovieClip = null) : void
      {
         var _loc11_:FeedbackItem = new FeedbackItem(type,loc.x,loc.y,gain,_physicsWorld.level.width,_physicsWorld.level.height,appearTime,waitTime,flyTime,swf,export,icon);
         this._objectContainer.addChild(_loc11_.getMovieClip());
         feedbackItems.push(_loc11_);
         var sound:SoundReference = Sounds.getSoundReference("NONE");
         if(type == "drop_exp")
         {
            sound = Sounds.getSoundReference("GetExp");
         }
         else if(type == "drop_coins" || "drop_cash")
         {
            sound = Sounds.getSoundReference("GetCoins");
         }
         else if(type == "drop_generic_item")
         {
         }
         if(sound)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",sound.getMusicID(),sound.getStart(),sound.getType(),"PlaySound"));
         }
      }
      
      public function addTextEffect(type:int, text:String, locX:int, locY:int, useFeedbackLayer:Boolean, params:* = null) : TextEffect
      {
         var fx:* = null;
         var _loc7_:int = 0;
         _loc7_ = 70;
         if(textFXQueue.length >= 1)
         {
            fx = textFXQueue[0];
            if(type == 6 || type == 4)
            {
               if(fx.type == 6 || fx.type == 4)
               {
                  type = 5;
                  var _loc10_:DCGame = DCGame;
                  locX = Number(com.dchoc.game.DCGame._stage.stageWidth) >> 1;
                  var _loc11_:DCGame = DCGame;
                  locY = Number(com.dchoc.game.DCGame._stage.stageHeight) * _loc7_ / 100;
               }
               else
               {
                  var _loc12_:DCGame = DCGame;
                  var _loc13_:DCGame = DCGame;
                  fx.setXY(Number(com.dchoc.game.DCGame._stage.stageWidth) >> 1,Number(com.dchoc.game.DCGame._stage.stageHeight) * _loc7_ / 100);
               }
            }
         }
         var _loc9_:TextEffect = new TextEffect(type,text,locX,locY,params);
         if(useFeedbackLayer)
         {
            var _loc14_:DCGame = DCGame;
            com.dchoc.game.DCGame._infoLayer.addChild(_loc9_.movieClip);
         }
         else
         {
            this._objectContainer.addChild(_loc9_.movieClip);
         }
         textFXQueue.push(_loc9_);
         return _loc9_;
      }
      
      public function ignoreLevelSizeScale(mc:DisplayObject, scaleYDistanceAboveCharacter:Boolean, scaleYDistanceBelowCharacter:Boolean) : void
      {
         var _loc5_:Number = 1 / Number(this._camera.zoom);
         mc.scaleX = _loc5_;
         mc.scaleY = _loc5_;
         var yCoordinateChange:Number = 0;
         if(scaleYDistanceAboveCharacter)
         {
            yCoordinateChange = -(65 + Number(this._camera.zoom) * 10);
            if(mc.y > 0)
            {
               yCoordinateChange += mc.y;
            }
         }
         else if(scaleYDistanceBelowCharacter)
         {
            yCoordinateChange = 55 - Number(this._camera.zoom) * 10;
         }
         mc.y = yCoordinateChange;
         storeIgnoredLevelSizeScaleObject(mc);
      }
      
      private function storeIgnoredLevelSizeScaleObject(mc:DisplayObject) : void
      {
         var i:int = 0;
         for(i = 0; i < levelSizeScaleIgnoreds.length; )
         {
            if(!levelSizeScaleIgnoreds[i] || !levelSizeScaleIgnoreds[i].parent)
            {
               levelSizeScaleIgnoreds[i] = mc;
               return;
            }
            i++;
         }
         levelSizeScaleIgnoreds.push(mc);
      }
      
      override public function cameraZoomingUpdated() : void
      {
         var i:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:int = physicsWorld.level.width * Number(this._camera.zoom);
         var _loc7_:int = physicsWorld.level.height * Number(this._camera.zoom);
         var _loc6_:int = _loc9_ * 0.5;
         var _loc4_:int = _loc7_ * 0.5;
         var _loc11_:DCGame = DCGame;
         var _loc5_:int = int(com.dchoc.game.DCGame._stage.stageWidth);
         var _loc12_:DCGame = DCGame;
         var _loc1_:int = int(com.dchoc.game.DCGame._stage.stageHeight);
         var _loc2_:int = _loc5_ * 0.5;
         var _loc3_:int = _loc1_ * 0.5;
         this._camera.worldX = _loc2_ - _loc6_;
         this._camera.worldY = _loc3_ - _loc4_;
         for(i = levelSizeScaleIgnoreds.length - 1; i >= 0; )
         {
            if(levelSizeScaleIgnoreds[i] && levelSizeScaleIgnoreds[i].parent)
            {
               _loc8_ = 1 / Number(this._camera.zoom);
               levelSizeScaleIgnoreds[i].scaleX = _loc8_;
               levelSizeScaleIgnoreds[i].scaleY = _loc8_;
            }
            else
            {
               levelSizeScaleIgnoreds.splice(i,1);
            }
            i--;
         }
      }
      
      public function addCameraShake(time:int, strength:Number) : void
      {
         if(time == 0 || strength == 0)
         {
            return;
         }
         if(!shakeFX)
         {
            shakeFX = new ShakeEffect(time,strength,this);
         }
      }
      
      public function getAffectedGameObjects(hitLocation:Vec2, radius:Number, includeWeapons:Boolean) : Vector.<PhysicsGameObject>
      {
         var i:int;
         var gameObject:PhysicsGameObject;
         var affectedObjects:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
         var bodyList:BodyList = _physicsWorld.space.bodiesInCircle(hitLocation,radius);
         for(i = 0; i < bodyList.length; )
         {
            gameObject = bodyList.at(i).userData.gameObject as PhysicsGameObject;
            if(gameObject && affectedObjects.indexOf(gameObject) == -1 && (includeWeapons || !(gameObject is Missile)) && !(gameObject is Follower))
            {
               affectedObjects.push(gameObject);
            }
            i++;
         }
         affectedObjects.sort(function(obj1:PhysicsGameObject, obj2:PhysicsGameObject):int
         {
            var _loc3_:* = obj1;
            var _loc4_:* = obj2;
            return StringUtils.compareTo(_loc3_._uniqueId,_loc4_._uniqueId);
         });
         return affectedObjects;
      }
      
      public function getAffectedGameObjectsInAABB(aabb:AABB, includeWeapons:Boolean) : Vector.<PhysicsGameObject>
      {
         var i:int;
         var gameObject:PhysicsGameObject;
         var affectedObjects:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
         var bodyList:BodyList = _physicsWorld.space.bodiesInAABB(aabb);
         for(i = 0; i < bodyList.length; )
         {
            gameObject = bodyList.at(i).userData.gameObject as PhysicsGameObject;
            if(gameObject && affectedObjects.indexOf(gameObject) == -1 && (includeWeapons || !(gameObject is Missile)) && !(gameObject is Follower))
            {
               affectedObjects.push(gameObject);
            }
            i++;
         }
         affectedObjects.sort(function(obj1:PhysicsGameObject, obj2:PhysicsGameObject):int
         {
            var _loc3_:* = obj1;
            var _loc4_:* = obj2;
            return StringUtils.compareTo(_loc3_._uniqueId,_loc4_._uniqueId);
         });
         return affectedObjects;
      }
      
      public function turnOffRain() : void
      {
         levelRainEffectData = null;
      }
      
      public function turnOffWaterFx() : void
      {
         levelWaterEffectData = null;
      }
      
      public function reduceParticlesAmount(reduction:int) : void
      {
         particleSystem.reduceParticlesAmount(reduction);
      }
      
      public function calculateNormalZoomLevel() : Number
      {
         return 668 / physicsWorld.level.height;
      }
      
      override protected function postInputUpdate(deltaTime:int) : void
      {
         if(turnEnd)
         {
            if(numUpdatesUntilClientReady > 0)
            {
               processNextWorldUpdate();
               numUpdatesUntilClientReady--;
            }
            else
            {
               BattleManager.getCurrentActivePlayer().moveControls.endTurn();
               BattleManager.turnEnd();
               turnEnd = false;
            }
         }
         else if(updateWorldMessages.length > 0)
         {
            processNextWorldUpdate();
         }
      }
      
      override protected function fullscreenChanged(event:FullScreenEvent) : void
      {
         super.fullscreenChanged(event);
         physicsWorld.fullscreenChanged(event.fullScreen);
         this._camera.zoom = calculateZoomLevel(_physicsWorld.level);
      }
      
      private function processNextWorldUpdate() : void
      {
         var _loc2_:UpdateGameWorldMessage = updateWorldMessages.shift();
         for each(var response in _loc2_.responses)
         {
            handleResponse(response);
         }
      }
      
      private function handleResponse(response:BattleResponse) : void
      {
         switch(response.responseType)
         {
            case 1:
               updateWorld(response);
               break;
            case 36:
               physicsWorld.createPowerUp(response.data.pid);
               break;
            case 22:
               BattleManager.removeClient(response.data);
               break;
            default:
               handlePlayerActions(response);
         }
      }
      
      private function updateWorld(response:BattleResponse) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Object = response.data;
         var _loc9_:BattleSimulation = BattleManager.getSimulation();
         var _loc7_:int = int(_loc2_.hasOwnProperty("mtl") ? _loc2_.mtl : _loc9_.getMatchTimeLeft() - worldUpdateTime);
         _loc9_.updateMatchTime(_loc7_);
         var _loc8_:int = int(_loc2_.hasOwnProperty("ttl") ? _loc2_.ttl : _loc9_.getTurnTimeLeft() - worldUpdateTime);
         _loc9_.updateTurnTime(_loc8_);
         handleRespawningPlayers(_loc2_.respawn);
         handleResumingPlayers(_loc2_.resume);
         var _loc3_:int = _loc9_.getMatchDuration();
         var _loc6_:int = _loc9_.getMatchTimeLeft();
         if(!shownOneMinuteLeft && _loc6_ <= 60000 && _loc3_ > 60000)
         {
            BattleManager.showText(ProjectManager.getText("MATCH_MINUTE_LEFT"),6,false);
            shownOneMinuteLeft = true;
         }
         else if((shownOneMinuteLeft || _loc3_ <= 60000) && !shownTenSecondsLeft && _loc6_ <= 10000 && _loc3_ > 10000)
         {
            var _loc10_:DCGame = DCGame;
            BattleManager.showText(ProjectManager.getText("MATCH_TEN_SECONDS_LEFT"),5,false,null,Number(com.dchoc.game.DCGame._stage.stageHeight) / 2);
            shownTenSecondsLeft = true;
         }
         if(_loc9_.getMatchTimeLeft() < 10000)
         {
            _loc5_ = _loc6_ / 1000;
            _loc4_ = _loc5_ - 1;
            if(_loc5_ > 0 && !counterFlags[_loc4_])
            {
               counterFlags[_loc4_] = true;
               var _loc11_:DCGame = DCGame;
               BattleManager.showText(null,7,false,_loc4_,Number(com.dchoc.game.DCGame._stage.stageHeight) / 2);
            }
         }
         update(worldUpdateTime);
      }
      
      private function handleRespawningPlayers(players:Array) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         for each(var data in players)
         {
            _loc2_ = data.dead_dude;
            _loc3_ = findPlayer(_loc2_);
            if(_loc3_ && _loc3_.isDead() && !_loc5_._markedForRemoval)
            {
               LogUtils.log("Respawning player " + _loc3_,this,1,"Player",false,false,false);
               _loc3_.changeState(new PlayerSpawningState(_loc3_,data),true);
            }
            else if(!_loc3_)
            {
               LogUtils.log("Couldn\'t find player to respawn: " + _loc2_,this,2,"Player");
            }
         }
      }
      
      private function handleResumingPlayers(players:Array) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         for each(var data in players)
         {
            _loc2_ = data.dead_dude;
            _loc3_ = findPlayer(_loc2_);
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
      
      private function handleEffects(deltaTime:int) : void
      {
         var i:int = 0;
         var j:int = 0;
         var _loc2_:* = null;
         if(particleSystem)
         {
            particleSystem.logicUpdate(deltaTime);
         }
         playLevelThemeEffects(deltaTime);
         if(shakeFX)
         {
            if(shakeFX.logicUpdate(deltaTime))
            {
               shakeFX = null;
            }
         }
         if(textFXQueue)
         {
            for(i = textFXQueue.length - 1; i >= 0; )
            {
               if(textFXQueue[i].isFinished())
               {
                  textFXQueue[i].dispose();
                  textFXQueue.splice(i,1);
               }
               i--;
            }
         }
         for(j = feedbackItems.length - 1; j >= 0; )
         {
            _loc2_ = feedbackItems[j];
            if(_loc2_.finished)
            {
               _loc2_.dispose();
               feedbackItems.splice(j,1);
            }
            j--;
         }
      }
      
      private function updateWorldHandler(msg:UpdateGameWorldMessage) : void
      {
         updateWorldMessages.push(msg);
      }
      
      private function handlePlayerActions(response:BattleResponse) : void
      {
         var _loc3_:ActionResponse = ActionResponseFactory.createActionResponse(response.data);
         var _loc2_:Boolean = BattleManager.isLocalPlayer(_loc3_.senderId);
         MessageCenter.sendEvent(_loc3_);
         var _loc4_:PlayerGameObject = findPlayer(_loc3_.id);
         if(_loc4_)
         {
            _loc4_.handleAction(_loc3_);
         }
      }
      
      private function update(time:int) : void
      {
         try
         {
            _physicsWorld.updatePhysicsWorld(time);
         }
         catch(e:Error)
         {
            LogUtils.log(e.getStackTrace(),this,3,"ErrorLogging");
            MessageCenter.sendEvent(new ErrorMessage("TuxWorld Error","update","TuxWorld Exception somewhere",null,null,"error_tuxworld"));
         }
      }
      
      private function endGameConfirm() : void
      {
         if(!gameEndConfirmSent)
         {
            LogUtils.log("End Game Confirm.",this,1,"Match",true,false,true);
            var _loc1_:* = tuxGame.tuxWorld;
            MessageCenter.sendEvent(new ChallengeEndGameConfirm(_loc1_._gameObjects,tuxGame.tuxWorld.players));
            MessageCenter.sendEvent(new MatchEndedMessage(tuxGame.tuxWorld.players));
            var _loc2_:ChallengeManager = ChallengeManager;
            if(!tuxwars.challenges.ChallengeManager._instance)
            {
               tuxwars.challenges.ChallengeManager._instance = new tuxwars.challenges.ChallengeManager();
            }
            tuxwars.challenges.ChallengeManager._instance.physicsUpdate(0);
            MessageCenter.sendEvent(new EndGameConfirmMessage());
            BattleManager.endGame();
            gameEndConfirmSent = true;
         }
      }
      
      private function playLevelTheme() : void
      {
         MessageCenter.sendEvent(new SoundMessage("StopAllSound"));
         Sounds.playGuitar();
         var _loc1_:SoundReference = _physicsWorld.level.theme.getLevelAmbienceSound();
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
      
      private function playLevelThemeEffects(dt:int) : void
      {
      }
      
      private function createPlayers(players:Array) : void
      {
         var _loc2_:int = 0;
         var i:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         _players = [];
         var _loc10_:BattleManager = BattleManager;
         var _loc8_:Random = new Random(tuxwars.battle.BattleManager._seed,"Create Players Random",Config.debugMode);
         var origStartingLocations:Vector.<Vec2> = _physicsWorld.getStartLocations();
         var newStartingLocations:* = new Vector.<Vec2>();
         var _loc11_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            newStartingLocations = origStartingLocations;
         }
         else
         {
            while(origStartingLocations.length > 0)
            {
               _loc2_ = _loc8_.integer(origStartingLocations.length);
               newStartingLocations.push(origStartingLocations[_loc2_]);
               origStartingLocations.splice(_loc2_,1);
            }
         }
         var tabIndex:int = 1;
         for(i = 0; i < players.length; )
         {
            _loc5_ = players[i];
            LogUtils.addDebugLine("Player","Creating PlayerGameObject for: " + _loc5_.id,"TuxWorld");
            _loc4_ = new PlayerGameObjectDef(_physicsWorld.space);
            _loc4_.loadPlayer(_loc5_);
            _loc4_.position = newStartingLocations[i];
            _players[i] = createGameObject(_loc4_);
            _players[i].setTabIndex(tabIndex++);
            _players[i].createHud();
            i++;
         }
      }
      
      private function addPlayers() : void
      {
         for each(var player in _players)
         {
            this._objectContainer.addChild(player.container);
         }
      }
      
      private function removePlayers() : void
      {
         for each(var player in _players)
         {
            this._objectContainer.removeChild(player.container);
         }
         _players = [];
      }
      
      private function calculateZoomLevel(level:Level) : Number
      {
         var _loc2_:DCGame = DCGame;
         return Number(com.dchoc.game.DCGame._stage.stageHeight) / level.height;
      }
   }
}
