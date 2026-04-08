package tuxwars.battle.gameobjects.player
{
   import com.citrusengine.physics.*;
   import com.dchoc.avatar.*;
   import com.dchoc.game.*;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.gameobjects.stats.modifier.*;
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.utils.*;
   import nape.dynamics.ArbiterList;
   import nape.geom.*;
   import nape.phys.Body;
   import nape.shape.*;
   import tuxwars.*;
   import tuxwars.battle.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.graphics.*;
   import tuxwars.battle.input.*;
   import tuxwars.battle.net.messages.battle.*;
   import tuxwars.battle.net.messages.history.*;
   import tuxwars.battle.net.responses.*;
   import tuxwars.battle.rewards.*;
   import tuxwars.battle.states.player.*;
   import tuxwars.battle.states.player.ai.*;
   import tuxwars.battle.states.weapon.*;
   import tuxwars.battle.ui.*;
   import tuxwars.battle.weapons.*;
   import tuxwars.battle.world.*;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   import tuxwars.items.*;
   import tuxwars.items.managers.*;
   import tuxwars.player.*;
   import tuxwars.utils.*;
   
   public class PlayerGameObject extends AvatarGameObject implements IScore
   {
      public static const MODE_WALK:String = "WalkMode";
      
      public static const MODE_AIM:String = "AimMode";
      
      public static const MODE_FIRE:String = "FireMode";
      
      private static const SEPARATOR:String = "_";
      
      private static const CHICKEN_OUT_GRAPHIC_EXPORT:String = "chicken_out";
      
      private var _checkForShoot:Boolean = true;
      
      private var _mode:String;
      
      private var _moveControls:PlayerMoveControls;
      
      private var _infoContainer:InfoContainer;
      
      private var _weapon:Weapon;
      
      private var _healtBar:HealthBar;
      
      private var _fired:Boolean;
      
      private var _inventory:Inventory;
      
      private var _wornItemsContainer:WornItems;
      
      private var _rewardsHandler:RewardsHandler;
      
      private var _emoticonItem:EmoticonItem;
      
      private var _chickenOutGraphic:MovieClip;
      
      private var playerBoosters:PlayerBoosters;
      
      private var playerBoosterStatContainer:PlayerStats;
      
      private var playingFallAnimation:Boolean;
      
      private var gainedScoreForTextEffect:int;
      
      private var gainedKillScoreForTextEffect:int;
      
      private var fallStartTime:int;
      
      private var _suicide:Boolean;
      
      private var resetSuicideTagger:Tagger;
      
      private var lastDamageTagger:Tagger;
      
      private var lastImpulseTagger:Tagger;
      
      private var _tabIndex:int;
      
      private var _walkDistance:Number;
      
      private var lastX:Number;
      
      private var dieMessageSent:Boolean;
      
      private const _followerIdsAtDeath:Vector.<String>;
      
      public function PlayerGameObject(param1:PlayerGameObjectDef, param2:TuxWarsGame)
      {
         var _loc3_:* = undefined;
         this._wornItemsContainer = new WornItems(null,this);
         this._followerIdsAtDeath = new Vector.<String>();
         this._inventory = param1.inventory;
         super(param1,param2);
         this.resetSuicideTagger = new Tagger(this);
         this.activate();
         this._rewardsHandler = !!BattleLoader.isPracticeMode() ? new EmptyRewardsHandler(this) : new RewardsHandler(this);
         createStat("WalkSpeed",body);
         createStat("MaxSpeed",body);
         createStat("JumpPower",body);
         createStat("Score",body);
         this.playerStats.walkSpeed = WorldPhysics.getWalkSpeed();
         this.playerStats.maxSpeed = WorldPhysics.getMaxSpeed();
         this.playerStats.jumpPower = WorldPhysics.getJumpPower();
         this._moveControls = new PlayerMoveControls(this);
         this._infoContainer = new InfoContainer(this);
         setCollisionFilterValues(PhysicsCollisionCategories.Get("PENGUIN"),-1,2);
         changeState(new PlayerInactiveState(this),true);
         MessageCenter.addListener("WeaponSelected",this.weaponSelected);
         MessageCenter.addListener("ingameBetPlaced",this.addBetEffect);
         LogUtils.addDebugLine("Player","Player " + this._id + " wearing items.","PlayerGameObject");
         for each(_loc3_ in param1.wornItems)
         {
            this._wornItemsContainer.wearItem(_loc3_.id);
            avatar.wearClothing(_loc3_);
         }
         this.playerBoosters = new PlayerBoosters(this);
         this.playerBoosterStatContainer = new PlayerStats();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._moveControls.dispose();
         this._moveControls = null;
         this._infoContainer.dispose();
         this._infoContainer = null;
         if(this._weapon)
         {
            MessageCenter.removeListener("WeaponPutAwayAnimPlayed",this.removeWeapon);
            this._weapon.dispose();
            this._weapon = null;
         }
         this._inventory = null;
         this._wornItemsContainer.dispose();
         this._wornItemsContainer = null;
         this._rewardsHandler.dispose();
         this._rewardsHandler = null;
         this._healtBar.dispose();
         this._healtBar = null;
         MessageCenter.removeListener("WeaponSelected",this.weaponSelected);
         MessageCenter.removeListener("ingameBetPlaced",this.addBetEffect);
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         var _loc2_:Damage = null;
         if(!body)
         {
            return;
         }
         super.physicsUpdate(param1);
         if(this.isDead())
         {
            return;
         }
         if(isDeadHP())
         {
            this.sendDieMessage();
            return;
         }
         var _loc3_:PlayerState = state as PlayerState;
         if(_loc3_ != null)
         {
            _loc3_.physicsUpdate(param1);
         }
         this.moveControls.physicsUpdate();
         this.limitWalkSpeed();
         this.updateWalkDistance();
         this.playerBoosters.updateBoosters();
         this.updateEmoticon(param1);
         if(Boolean(this._moveControls.isFallingDown()) && linearVelocity.y > 125 && !this.playingFallAnimation)
         {
            this.changeAnimation("fall");
            this.playingFallAnimation = true;
            this.fallStartTime = DCGame.getTime();
         }
         else if(!this._moveControls.isFallingDown() && Boolean(this.playingFallAnimation))
         {
            _loc2_ = this.stats.getStat("HP").getLastModifier(Damage) as Damage;
            this.changeAnimation(_loc2_ && _loc2_.hasTakenDamage("Collision") && _loc2_.creationTime > this.fallStartTime ? "damagefall" : "landjump",false,this.landCallback);
            this.playingFallAnimation = false;
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(this.isDead())
         {
            return;
         }
         if(this._weapon)
         {
            this._weapon.logicUpdate(param1);
         }
         this.updateHealthBar(param1);
         if(this.gainedScoreForTextEffect > 0 || this.gainedKillScoreForTextEffect > 0)
         {
            this.addScoreEffect();
         }
         else if(this.gainedScoreForTextEffect < 0)
         {
            this.reduceScoreEffect();
         }
      }
      
      public function handleAction(param1:ActionResponse) : void
      {
         switch(param1.responseType)
         {
            case 35:
               if(isDeadHP())
               {
                  this.die();
               }
               this.dieMessageSent = false;
               break;
            case 34:
               this.playerBoosters.addBooster(UseBoosterResponse(param1).boosterId);
               break;
            case 9:
            case 55:
            case 37:
            case 17:
               break;
            default:
               PlayerState(state).handleMessage(param1);
         }
      }
      
      public function activate() : void
      {
         if(this.lastDamageTagger != this.resetSuicideTagger || this.lastImpulseTagger != this.resetSuicideTagger)
         {
            this.lastDamageTagger = this.resetSuicideTagger;
            this.lastImpulseTagger = this.resetSuicideTagger;
            LogUtils.log("Activate: Marking last damage tagger: " + this.lastDamageTagger + " and impulse tagger: " + this.lastImpulseTagger,this,0,"Tag",false);
         }
      }
      
      public function get walkDistance() : Number
      {
         return Math.round(this._walkDistance);
      }
      
      public function set walkDistance(param1:Number) : void
      {
         this._walkDistance = param1;
      }
      
      public function set mode(param1:String) : void
      {
         LogUtils.addDebugLine("Player",this._id + " Setting mode to " + param1,"PlayerGameObject");
         this._mode = param1;
      }
      
      public function get mode() : String
      {
         return this._mode;
      }
      
      public function get wornItemsContainer() : WornItems
      {
         return this._wornItemsContainer;
      }
      
      override public function get stats() : Stats
      {
         return !!this._wornItemsContainer ? this._wornItemsContainer.getWornItemsStats() : null;
      }
      
      public function get playerStats() : PlayerStats
      {
         return this.stats as PlayerStats;
      }
      
      public function addPlayerBoosterStat(param1:String, param2:Stat) : void
      {
         this.playerBoosterStatContainer.addStat(param1,param2,body);
      }
      
      public function findPlayerBoosterStat(param1:String) : Stat
      {
         return this.playerBoosterStatContainer.getStat(param1);
      }
      
      public function get playerBoosterStats() : Stats
      {
         return this.playerBoosterStatContainer;
      }
      
      public function removePlayerBoosterStat(param1:String, param2:Stat) : void
      {
         this.playerBoosterStatContainer.removeStat(param1,param2);
      }
      
      public function get rewardsHandler() : RewardsHandler
      {
         return this._rewardsHandler;
      }
      
      public function get suicide() : Boolean
      {
         return this._suicide;
      }
      
      public function set suicide(param1:Boolean) : void
      {
         this._suicide = param1;
      }
      
      public function isAI() : Boolean
      {
         return false;
      }
      
      public function createHud() : void
      {
         this._healtBar = new HealthBar(this);
         container.addChild(this._healtBar);
         (this.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(this._healtBar,false,true);
      }
      
      public function addScore(param1:String, param2:int, param3:Boolean = false) : void
      {
         if(param2 != 0)
         {
            if(!this._markedForRemoval)
            {
               LogUtils.log(this._id + " got " + param2 + " score from " + param1,"PlayerGameObject",0,"Score",false,false,false);
               if(this.playerStats)
               {
                  if(this.playerStats.score)
                  {
                     this.playerStats.score.addModifier(new StatAdd(param1,param2));
                     if(param2 > 0)
                     {
                        MessageCenter.sendEvent(new PlayerScoreChanged(this,param2));
                     }
                     HistoryMessageFactory.sendScoreMessage(this);
                     if(!param3)
                     {
                        this.gainedScoreForTextEffect += param2;
                     }
                     else
                     {
                        this.gainedKillScoreForTextEffect += param2;
                     }
                  }
                  else
                  {
                     LogUtils.log(this._id + " stat score is null, markedForRemoval: " + this._markedForRemoval,"PlayerGameObject",2,"Score");
                  }
               }
               else
               {
                  LogUtils.log(this._id + " stats are null, markedForRemoval: " + this._markedForRemoval,"PlayerGameObject",2,"Score");
               }
            }
            else
            {
               LogUtils.log(this._id + " is marked for removal: " + this._markedForRemoval + ", example player get markedForRemoval when they are disconnected","PlayerGameObject",0,"Score");
            }
         }
      }
      
      public function addScoreFromDamage(param1:String, param2:int) : void
      {
         if(param2 < 0)
         {
            LogUtils.log("No score for negative damage: " + param2 + " from " + param1 + " to " + this._id,"PlayerGameObject",3,"Score",true,true);
            return;
         }
         var _loc3_:int = param2 * (100 / (90 + param2 / 3));
         LogUtils.log("Converted: " + param2 + " to score: " + _loc3_,"PlayerGameObject",0,"Score",false,false,false);
         this.addScore("Damaged_" + param1,_loc3_);
      }
      
      public function reduceScoreFromDamage(param1:String, param2:int) : void
      {
         var _loc3_:int = param2 * (100 / (90 + param2 / 3)) * (-1 * BattleOptions.getRow().findField("ScoreDamager").value);
         LogUtils.log("Converted: " + param2 + " to score: " + _loc3_,"PlayerGameObject",0,"Score",false,false,false);
         var _loc4_:int = this.getScore();
         if(_loc3_ + _loc4_ < 0)
         {
            _loc3_ = _loc4_ * -1;
         }
         this.addScore("Damaged_" + param1,_loc3_);
      }
      
      public function getScore() : int
      {
         try
         {
            return this.playerStats.score.calculateRoundedValue();
         }
         catch(e:Error)
         {
            LogUtils.addDebugLine("Error",e.message);
            LogUtils.addDebugLine("Error",e.getStackTrace());
         }
         return 0;
      }
      
      override public function canTakeDamage() : Boolean
      {
         return !this.isDead() && !isDeadHP() && !this.isSpawning();
      }
      
      override public function reduceHitPoints(param1:Damage) : void
      {
         super.reduceHitPoints(param1);
         if(param1.amount != 0)
         {
            if(param1.amount > 0)
            {
               MessageCenter.sendEvent(new SoundMessage("PlaySound",Sounds.getHurt()));
            }
            HistoryMessageFactory.sendHitPointsMessage(this);
         }
      }
      
      public function get weapon() : Weapon
      {
         return this._weapon;
      }
      
      public function getMissileBoosterEmissions() : Array
      {
         return this.playerBoosters.getMissileBoostingEmissions();
      }
      
      public function getExplosionBoosterEmissions() : Array
      {
         return this.playerBoosters.getExplosionBoostingEmissions();
      }
      
      public function changeWeapon(param1:String) : void
      {
         LogUtils.log(this._id + " setting weapon to " + param1,"PlayerGameObject",1,"Weapon",false);
         if(this._weapon)
         {
            if(this.isDead())
            {
               this.removeWeapon(new Message("WeaponPutAwayAnimPlayed",{"player":this}));
            }
            else
            {
               this._weapon.changeState(new WeaponPutAwayState(this._weapon,this.game as TuxWarsGame,param1));
            }
         }
         else if(param1)
         {
            this.createWeapon(param1);
         }
      }
      
      public function createWeapon(param1:String, param2:Boolean = false) : void
      {
         LogUtils.log(this._id + " creating weapon " + param1,"PlayerGameObject",1,"Weapon",false);
         var _loc3_:WeaponItem = !!this._inventory.hasItem(param1,true) ? this._inventory.getItem(param1,true) as WeaponItem : ItemManager.createItem(param1) as WeaponItem;
         this._weapon = _loc3_.getAsWearableItem() as Weapon;
         this.replayAnimation();
         this._weapon.player = this;
         avatar.addBodyPart(this._weapon.bodyPart);
         avatar.putOnItem(this._weapon);
         this._weapon.changeState(new WeaponDrawState(this._weapon,this.game as TuxWarsGame),param2);
         MessageCenter.addListener("WeaponPutAwayAnimPlayed",this.removeWeapon);
      }
      
      public function isDead() : Boolean
      {
         return state is PlayerDeadState;
      }
      
      public function isSpawning() : Boolean
      {
         return state is PlayerSpawningState;
      }
      
      public function get moveControls() : PlayerMoveControls
      {
         return this._moveControls;
      }
      
      public function get infoContainer() : InfoContainer
      {
         return this._infoContainer;
      }
      
      public function set walking(param1:Boolean) : void
      {
         if(Boolean(this._weapon) && Boolean(this._weapon.isAiming()))
         {
            this._weapon.weaponClip.gotoAndStop("aim");
         }
      }
      
      public function updateHealthBar(param1:int) : void
      {
         if(this._healtBar)
         {
            this._healtBar.logicUpdate(param1);
         }
      }
      
      override public function changeAnimation(param1:String, param2:Boolean = true, param3:Function = null) : Boolean
      {
         var _loc4_:String = null;
         if(avatar.currentAnimation)
         {
            _loc4_ = avatar.currentAnimation.classDefinitionName;
            if(_loc4_ == "dying" && param1 != "spawn")
            {
               return false;
            }
         }
         return avatar.animate(this.getAnimation(param1,param2,param3));
      }
      
      public function aim(param1:Vec2 = null) : Vec2
      {
         var _loc2_:Vec2 = !!param1 ? param1.copy() : Vec2.get(int(container.mouseX),int(container.mouseY));
         if(direction == 1 && _loc2_.x < 0)
         {
            direction = 0;
         }
         else if(direction == 0 && _loc2_.x >= 0)
         {
            direction = 1;
         }
         if(Boolean(this.weapon) && this.weapon.isAiming())
         {
            this.weapon.aim(_loc2_.copy());
         }
         LogUtils.addDebugLine("Weapon",this._id + " aiming at " + _loc2_,"PlayerGameObject");
         return _loc2_;
      }
      
      public function get fired() : Boolean
      {
         return this._fired;
      }
      
      public function set fired(param1:Boolean) : void
      {
         this._fired = param1;
      }
      
      public function get checkForShoot() : Boolean
      {
         return this._checkForShoot;
      }
      
      public function set checkForShoot(param1:Boolean) : void
      {
         this._checkForShoot = param1;
      }
      
      public function isShooting() : Boolean
      {
         return state is PlayerActiveFireSubState || state is AIPlayerActiveFireSubState;
      }
      
      public function get inventory() : Inventory
      {
         return this._inventory;
      }
      
      override public function affectsGameObject(param1:String, param2:PhysicsGameObject) : Boolean
      {
         if(param1 == "penguin" || param1 == "player" && (param2 == null || param2 is PlayerGameObject && _loc3_._id == this._id) || param1 == "enemy" && (param2 == null || param2 is PlayerGameObject && _loc4_._id != this._id))
         {
            return true;
         }
         return super.affectsGameObject(param1,param2);
      }
      
      public function useBooster(param1:String) : void
      {
         this.playerBoosters.addBooster(param1);
      }
      
      public function reduceBoosterDurations(param1:String, param2:int) : void
      {
         this.playerBoosters.reduceBoosterDurations(param1,param2);
      }
      
      public function isBoosterCategoryActivated(param1:Array) : Boolean
      {
         return this.playerBoosters.isBoosterCategoryActivated(param1);
      }
      
      override public function handleExplosionImpulse(param1:Vec2, param2:PhysicsGameObject) : void
      {
         super.handleExplosionImpulse(param1,param2);
         if(param2)
         {
            this.lastImpulseTagger = new Tagger(param2);
            LogUtils.log("Marking last impulse tagger: " + this.lastImpulseTagger,this,1,"Tag",false,false,false);
         }
      }
      
      override public function handleExplosionDamage(param1:Damage) : void
      {
         if(!this.canTakeDamage())
         {
            return;
         }
         super.handleExplosionDamage(param1);
         if(param1.taggingPlayer)
         {
            this.lastDamageTagger = new Tagger(param1.taggingPlayer);
            LogUtils.log("Marking last damage tagger: " + this.lastDamageTagger,this,1,"Tag",false,false,false);
         }
         if(param1.amount > 0)
         {
            this.changeAnimation("damagehit",false,this.hitCallback);
            this.reduceBoosterDurations("Hit",1);
         }
      }
      
      public function useEmoticon(param1:String) : void
      {
         if(Boolean(this._emoticonItem) && !this._emoticonItem.isFinished())
         {
            return;
         }
         this._emoticonItem = ItemManager.createItem(param1) as EmoticonItem;
         this._emoticonItem.tagger = new Tagger(this);
         var _loc2_:SoundReference = Sounds.getSoundReference(param1);
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc2_.getMusicID(),_loc2_.getStart(),_loc2_.getType()));
         }
         if(this._emoticonItem)
         {
            container.addChild(this._emoticonItem.getEmoticonItemGraphicMovieClip());
            this._emoticonItem.animIn();
            (this.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(this._emoticonItem.getEmoticonItemGraphicMovieClip(),true,false);
            MessageCenter.sendMessage("Emoticons",this);
         }
      }
      
      public function chickeningOut(param1:int) : void
      {
         if(param1 == 1)
         {
            if(!this._chickenOutGraphic)
            {
               this._chickenOutGraphic = DCResourceManager.instance.getFromSWF("flash/characters/penguin_overhead_animations.swf","chicken_out");
            }
            container.addChild(this._chickenOutGraphic);
            (this.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(this._chickenOutGraphic,false,false);
         }
         else if(this._chickenOutGraphic)
         {
            container.removeChild(this._chickenOutGraphic);
         }
      }
      
      public function setTabIndex(param1:int) : void
      {
         this._tabIndex = param1;
      }
      
      public function getTabIndex() : int
      {
         return this._tabIndex;
      }
      
      public function respawn(param1:Vec2, param2:Boolean) : void
      {
         if(!param1)
         {
            param1 = this.findSpawnPoint();
         }
         body.position = param1.copy(true);
         updateGraphics();
         if(param2)
         {
            body.allowMovement = false;
         }
         LogUtils.log("Spawning player: " + this + " loc: " + bodyLocation + " stepTime: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"PhysicsWorld",false,false,false);
      }
      
      public function get followerIdsAtDeath() : Vector.<String>
      {
         return this._followerIdsAtDeath;
      }
      
      override public function handleBeginContact(param1:Body, param2:ArbiterList) : void
      {
         if(!body || Boolean(param1.userData.gameObject.isSensorEnabled))
         {
            return;
         }
         if(!body.allowMovement)
         {
            body.allowMovement = true;
         }
         this.handleCollision(param1,param2);
         var _loc3_:Boolean = Boolean(BattleManager.isActivePlayer(this._id));
         if(!_loc3_ || _loc3_ && !(param1.userData.gameObject is PlayerGameObject))
         {
            updateTag(param1.userData.gameObject);
         }
      }
      
      override protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         if(!this.canTakeDamage())
         {
            return;
         }
         super.handleCollision(param1,param2);
         var _loc3_:Number = findFirstCollisionImpulse(param2,param1);
         takeCollisionDamage(_loc3_,param1.userData.gameObject);
         LogUtils.log("PlayerGameObject collision impulse: " + _loc3_ + " other: " + (param1.userData.gameObject != null ? param1.userData.gameObject.id : null) + " stepTime: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Collision",false,false,false);
         LogUtils.log("Other tag: " + param1.userData.gameObject.tag,this,1,"Tag",false,false,false);
      }
      
      override protected function outOfWorld() : void
      {
         if(this.isDead() || isDeadHP() || this.isSpawning())
         {
            return;
         }
         LogUtils.log("Out of world death: " + this._id,this,0,"Match",false);
         emptyCollectedDamage();
      }
      
      override protected function createStats() : Stats
      {
         return new PlayerStats();
      }
      
      private function die() : void
      {
         var _loc1_:Tagger = null;
         var _loc2_:PlayerGameObject = null;
         if(!this.isDead() && !this.isSpawning() && Boolean(this.isPossibleToDieBasedOnWeaponState()))
         {
            LogUtils.log(this._id + " is dead. Rest In Pieces.",this,1,"Match",false,false,true);
            LogUtils.log(this._id + " state: " + state,this,1,"Match",false,false,true);
            _loc1_ = tag.findLatestPlayerTagger();
            if(Boolean(_loc1_) && _loc3_._id != this._id)
            {
               _loc2_ = _loc1_.gameObject as PlayerGameObject;
               _loc2_.addScore("Killed_" + this._id,Tuner.getField("KillOpponentBonus").value,false);
            }
            this._suicide = this.wasSuicide(_loc1_);
            changeState(new PlayerDeadState(this),true);
            MessageCenter.sendMessage("PlayerDied",this);
            emptyCollectedDamage();
            MessageCenter.sendEvent(new ChallengePlayerDiedMessage(this,"TODO"));
            this._followerIdsAtDeath.splice(0,this._followerIdsAtDeath.length);
            LogUtils.log("PlayerGameObject died hp: " + calculateHitPoints(),this,1,"Player",false,false,false);
            this.removeEmoticon();
         }
      }
      
      private function findSpawnPoint() : Vec2
      {
         var _loc1_:SpawnPointFinder = new SpawnPointFinder((this.game as TuxWarsGame).tuxWorld);
         var _loc2_:Number = Circle(body.shapes.at(0)).radius * 2;
         var _loc3_:Vec2 = _loc1_.findSpawnLocation(_loc2_);
         if(!_loc3_)
         {
            LogUtils.log("Didn\'t find a spawn location for player: " + this,this,2,"PhysicsWorld",false);
         }
         return _loc3_;
      }
      
      private function getAnimation(param1:String, param2:Boolean = true, param3:Function = null) : AvatarAnimation
      {
         var _loc4_:String = param1.split("_")[0];
         switch(_loc4_)
         {
            case "idle":
            case "walk":
            case "fire":
            case "jump":
            case "damagehit":
            case "landjump":
               if(this._weapon)
               {
                  idleMode = false;
                  return new AvatarAnimation(_loc4_ + "_" + this._weapon.animationType,param2,param3);
               }
               break;
         }
         if(this._weapon)
         {
            idleMode = false;
            return new AvatarAnimation("idle" + "_" + this._weapon.animationType,param2,param3);
         }
         return new AvatarAnimation(_loc4_,param2,param3);
      }
      
      private function hitCallback() : void
      {
         if(!this.isDead())
         {
            idleMode = true;
         }
      }
      
      private function landCallback() : void
      {
         idleMode = true;
      }
      
      private function limitWalkSpeed() : void
      {
         var _loc1_:Number = Math.abs(linearVelocity.x);
         var _loc2_:Number = this.playerStats.maxSpeed.calculateValue();
         if(_loc1_ > _loc2_)
         {
            body.velocity.x = body.velocity.x > 0 ? _loc2_ : -_loc2_;
         }
      }
      
      private function updateEmoticon(param1:int) : void
      {
         if(this._emoticonItem)
         {
            this._emoticonItem.reduceDuration(param1);
            if(this._emoticonItem.isFinished())
            {
               this.removeEmoticon();
            }
         }
      }
      
      private function removeEmoticon() : void
      {
         if(this._emoticonItem)
         {
            container.removeChild(this._emoticonItem.getEmoticonItemGraphicMovieClip());
            this._emoticonItem.dispose();
            this._emoticonItem = null;
         }
      }
      
      private function removeWeapon(param1:Message) : void
      {
         var _loc2_:PlayerGameObject = param1.data.player;
         if(_loc2_ == this)
         {
            LogUtils.addDebugLine("Weapon",this._id + " removing weapon " + this._weapon.id,"PlayerGameObject");
            MessageCenter.removeListener("WeaponPutAwayAnimPlayed",this.removeWeapon);
            avatar.removeBodyPart(this._weapon.bodyPart);
            avatar.takeOffItem(this._weapon);
            this._weapon.dispose();
            this._weapon = null;
            if(param1.data.weapon != null)
            {
               this.createWeapon(param1.data.weapon);
            }
            else
            {
               this.replayAnimation();
            }
         }
      }
      
      private function sendDieMessage() : void
      {
         var _loc1_:SpawnPointFinder = null;
         if(!this.dieMessageSent && !this.isDead() && !this.isSpawning() && Boolean(this.isPossibleToDieBasedOnWeaponState()) && (Boolean(BattleManager.isLocalPlayersTurn()) || Boolean(BattleManager.isPracticeMode())))
         {
            _loc1_ = new SpawnPointFinder((this.game as TuxWarsGame).tuxWorld,new Random(getTimer()));
            MessageCenter.sendEvent(new DieMessage(this._id,_loc1_.findSpawnLocation(Circle(body.shapes.at(0)).radius * 2),_loc1_.wasRandomPoint));
            this.dieMessageSent = true;
         }
      }
      
      private function wasSuicide(param1:Tagger) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc2_:* = this.getLatestTagger().gameObject;
         if(_loc2_._id == this._id)
         {
            if(!param1)
            {
               LogUtils.log(this._id + " was Suicide: " + true + " no playerTagger",this,1,"Match",false,false,true);
            }
            else
            {
               _loc3_ = param1.gameObject;
               if(_loc3_._id == this._id)
               {
                  LogUtils.log(this._id + " was Suicide: " + true + " self",this,1,"Match",false,false,true);
               }
               else
               {
                  LogUtils.log(this._id + " was Suicide: " + false + " other",this,1,"Match",false,false,true);
               }
            }
         }
         else
         {
            LogUtils.log(this._id + " was Suicide: " + false + " last tagger not self",this,1,"Match",false,false,true);
         }
         return (!param1 || _loc4_._id == this._id) && _loc5_._id == this._id;
      }
      
      private function getLatestTagger() : Tagger
      {
         return this.lastDamageTagger.time > this.lastImpulseTagger.time ? this.lastDamageTagger : this.lastImpulseTagger;
      }
      
      private function isPossibleToDieBasedOnWeaponState() : Boolean
      {
         if(this.weapon != null && (this.weapon.state is WeaponDrawState || this.weapon.state is WeaponPutAwayState))
         {
            return false;
         }
         return true;
      }
      
      private function weaponSelected(param1:Message) : void
      {
         var _loc2_:WeaponItem = param1.data;
         if(Boolean(BattleManager.isLocalPlayer(this._id)) && Boolean(BattleManager.isLocalPlayersTurn()) && !this._fired)
         {
            if(this._weapon != null && this._weapon.id != _loc2_.id)
            {
               MessageCenter.sendEvent(new ChangeWeaponMessage(_loc2_.id,this._id));
            }
            else if(!this._weapon)
            {
               MessageCenter.sendMessage("PlayerFireMode",_loc2_.id);
            }
         }
      }
      
      private function replayAnimation() : void
      {
         var _loc1_:Function = avatar.paperDoll.animation.getCallback();
         avatar.paperDoll.animation.clearCallback();
         this.changeAnimation(avatar.currentAnimation.classDefinitionName,avatar.paperDoll.animation.isLooping(),_loc1_);
      }
      
      private function addScoreEffect() : void
      {
         var _loc1_:String = "";
         if(this.gainedScoreForTextEffect - this.gainedKillScoreForTextEffect > 0)
         {
            _loc1_ += ProjectManager.getText("GAINED_SCORE_TEXT_EFFECT",[this.gainedScoreForTextEffect - this.gainedKillScoreForTextEffect]) + " ";
         }
         if(this.gainedKillScoreForTextEffect > 0)
         {
            _loc1_ += ProjectManager.getText("GAINED_KILL_SCORE_TEXT_EFFECT",[this.gainedKillScoreForTextEffect]);
         }
         var _loc2_:TextEffect = (this.game as TuxWarsGame).tuxWorld.addTextEffect(2,_loc1_,container.x,container.y,false);
         (this.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
         this.gainedScoreForTextEffect = 0;
         this.gainedKillScoreForTextEffect = 0;
      }
      
      private function reduceScoreEffect() : void
      {
         var _loc1_:String = "";
         if(this.gainedScoreForTextEffect < 0)
         {
            _loc1_ += ProjectManager.getText("GAINED_NEGATIVE_SCORE_TEXT_EFFECT",[this.gainedScoreForTextEffect]) + " ";
         }
         var _loc2_:TextEffect = (this.game as TuxWarsGame).tuxWorld.addTextEffect(2,_loc1_,container.x,container.y,false);
         (this.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
         this.gainedScoreForTextEffect = 0;
         this.gainedKillScoreForTextEffect = 0;
      }
      
      private function addBetEffect(param1:Message) : void
      {
         var _loc2_:TextEffect = null;
         if(this._id == param1.data.id)
         {
            _loc2_ = (this.game as TuxWarsGame).tuxWorld.addTextEffect(8,null,container.x,container.y,false);
            (this.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
         }
      }
      
      private function updateWalkDistance() : void
      {
         if(this.moveControls.walking)
         {
            if(isNaN(this.lastX))
            {
               this.lastX = bodyLocation.x;
               return;
            }
            this._walkDistance += Math.abs(this.lastX - bodyLocation.x);
            this.lastX = bodyLocation.x;
         }
         else
         {
            this.lastX = NaN;
         }
      }
   }
}

