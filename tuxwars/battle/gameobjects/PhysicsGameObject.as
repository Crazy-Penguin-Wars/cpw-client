package tuxwars.battle.gameobjects
{
   import com.dchoc.game.*;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.physics.*;
   import com.dchoc.messages.*;
   import com.dchoc.states.*;
   import com.dchoc.utils.*;
   import flash.geom.Point;
   import nape.dynamics.*;
   import nape.geom.*;
   import nape.phys.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.data.*;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.explosions.ExplosionShape;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.rewards.*;
   import tuxwars.battle.world.*;
   import tuxwars.battle.world.loader.Level;
   import tuxwars.challenges.events.*;
   import tuxwars.data.*;
   
   public class PhysicsGameObject extends TuxGameObject implements Collider
   {
      public static const GROUP_PENGUIN:String = "PENGUIN";
      
      public static const GROUP_TERRAIN:String = "TERRAIN";
      
      public static const GROUP_LEVEL_OBJECT:String = "LEVEL_OBJECT";
      
      public static const GROUP_POWER_UP:String = "POWER_UP";
      
      public static const GROUP_MISSILE:String = "MISSILE";
      
      public static const GROUP_FOLLOWER:String = "FOLLOWER";
      
      public static const GROUP_WATER:String = "WATER";
      
      public static const DAMAGE_ID_OUT_OF_WORLD_ALIVE:String = "OOWorldAlive";
      
      public static const DAMAGE_ID_COLLISION:String = "Collision";
      
      public static const DAMAGE_ID_POWER_UP_HEAL:String = "PowerUpHeal";
      
      public static const DAMAGE_KILL_SCRIPT:String = "KillScript";
      
      private static var groupCounterPositive:int = 1;
      
      private static var groupCounterNegative:int = -1;
      
      public static const GROUP_ALL:Array = ["FOLLOWER","LEVEL_OBJECT","MISSILE","PENGUIN","POWER_UP","TERRAIN","WATER"];
      
      private const _currentContacts:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
      
      private const _followers:Vector.<Follower> = new Vector.<Follower>();
      
      private const _damageSources:Vector.<CumulativeDamage> = new Vector.<CumulativeDamage>();
      
      private const stateMachine:StateMachine = new StateMachine();
      
      private var _tag:Tag;
      
      private var _lastContactLocations:Vec2;
      
      private var _lastBodyLocation:Vec2;
      
      private var _lastLinearDirection:Vec2;
      
      private var _lastLinearVelocity:Vec2;
      
      private var _soundID:String;
      
      public var body:Body;
      
      private var _playCollisionSounds:Boolean;
      
      private var _allowDisplayObjectRotation:Boolean = true;
      
      protected var _elapsedTime:int;
      
      private var _timeFromLastContact:int;
      
      private var _isSensorEnabled:Boolean;
      
      public function PhysicsGameObject(param1:PhysicsGameObjectDef, param2:DCGame)
      {
         super(param1,param2);
         this._tag = this.createTag();
         this.createBody(param1);
         if(this.body)
         {
            this._isSensorEnabled = this.hasSensor(this.body);
         }
         this._soundID = this.id;
         this.setCollisionFilterValues(-1,-1);
         MessageCenter.addListener("StartCollisionPlayback",this.startCollisionPlayback);
         MessageCenter.addListener("PlayerRemoved",this.playerRemoved);
         LogUtils.log("Created: " + shortName + " at: " + this.bodyLocation,this,1,"PhysicsWorld",false,false,false);
      }
      
      public static function resetStaticCounters() : void
      {
         groupCounterPositive = 1;
         groupCounterNegative = -1;
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         MessageCenter.removeListener("StartCollisionPlayback",this.startCollisionPlayback);
         MessageCenter.removeListener("PlayerRemoved",this.playerRemoved);
         this.stateMachine.dispose();
         this._currentContacts.splice(0,this._currentContacts.length);
         this._followers.splice(0,this._followers.length);
         for each(_loc1_ in this._damageSources)
         {
            _loc1_.dispose();
         }
         this._damageSources.splice(0,this._damageSources.length);
         this._tag.clear();
         this._tag = null;
         this.destroyBody();
         super.dispose();
      }
      
      public function physicsUpdate(param1:int) : void
      {
         if(!this.body)
         {
            return;
         }
         this.stateMachine.logicUpdate(param1);
         if(_hasHPs)
         {
            this.updateDamageCollection(param1);
         }
         if(this.isOutOfWorld())
         {
            this.outOfWorld();
            return;
         }
         this._elapsedTime += param1;
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(this.body)
         {
            this.updateGraphics();
         }
      }
      
      override public function get state() : State
      {
         return this.stateMachine.state;
      }
      
      override public function exitCurrentState(param1:Boolean = false) : void
      {
         this.stateMachine.exitCurrentState(param1);
      }
      
      override public function changeState(param1:State, param2:Boolean = false) : void
      {
         this.stateMachine.changeState(param1,param2);
      }
      
      public function get isSensorEnabled() : Boolean
      {
         return this._isSensorEnabled;
      }
      
      public function get soundId() : String
      {
         return this._soundID;
      }
      
      public function set soundId(param1:String) : void
      {
         this._soundID = param1;
      }
      
      public function playEndSound(param1:String) : void
      {
         var _loc2_:SoundReference = Sounds.getSoundReference(param1);
         if(_loc2_)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",param1,_loc2_.getLoop(),_loc2_.getType(),"LoopSound"));
            MessageCenter.sendEvent(new SoundMessage("EndSound",_loc2_.getMusicID(),_loc2_.getEnd(),_loc2_.getType()));
         }
      }
      
      override public function markForRemoval() : void
      {
         super.markForRemoval();
         this.destroyBody();
         this.playEndSound(this is LevelGameObject ? (this as LevelGameObject).material : this._soundID);
      }
      
      public function get tag() : Tag
      {
         return this._tag;
      }
      
      protected function hasContact() : Boolean
      {
         if(this.body)
         {
            return this.body.interactingBodies().length > 0;
         }
         return false;
      }
      
      public function handleExplosionImpulse(param1:Vec2, param2:PhysicsGameObject) : void
      {
         if(param2 && !(param2 is TerrainGameObject) || param2 is TerrainGameObject && Boolean((param2 as TerrainGameObject).isDynamic()) && param2 != this)
         {
            this.tag.update(param2.tag);
            this.tag.add(param2);
         }
      }
      
      public function handleExplosionDamage(param1:Damage) : void
      {
         if(!canTakeDamage())
         {
            return;
         }
         var _loc2_:String = "HP";
         var _loc3_:Stat = !!this.stats ? this.stats.getStat(_loc2_) : null;
         if(_loc3_)
         {
            this.reduceHitPointsCumulative(param1);
         }
      }
      
      public function handleExplosionTerrain(param1:Vec2, param2:ExplosionShape) : void
      {
      }
      
      public function isDeadHP() : Boolean
      {
         return calculateHitPoints() <= 0;
      }
      
      public function enteredWater() : void
      {
         if(!this.body)
         {
            return;
         }
         var _loc1_:SoundHelper = SoundHelper;
         if(SoundHelper._instance == null)
         {
            new SoundHelper();
         }
         var _loc2_:String = SoundHelper._instance.AreaReceiver(this.body.bounds.width * this.body.bounds.height);
         var _loc3_:SoundHelper = SoundHelper;
         if(SoundHelper._instance == null)
         {
            new SoundHelper();
         }
         var _loc4_:String = SoundHelper._instance.SpeedReceiver(this.linearVelocity.length);
         var _loc5_:SoundReference = Sounds.getSoundReference("WaterHit" + _loc2_ + _loc4_);
         if(_loc5_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc5_.getMusicID(),_loc5_.getStart(),_loc5_.getType(),"PlaySound"));
         }
      }
      
      public function exitedWater() : void
      {
      }
      
      public function get lastContactLocations() : Vec2
      {
         return this._lastContactLocations;
      }
      
      public function get lastBodyLocations() : Vec2
      {
         return this._lastBodyLocation;
      }
      
      public function get lastLinearDirection() : Vec2
      {
         return this._lastLinearDirection;
      }
      
      public function get bodyLocationPoint() : Point
      {
         var _loc1_:Vec2 = this.bodyLocation;
         if(_loc1_)
         {
            return _loc1_.toPoint();
         }
         return null;
      }
      
      public function get bodyLocation() : Vec2
      {
         if(this.body)
         {
            return this.body.position.copy();
         }
         return null;
      }
      
      public function setCollisionFilterValues(param1:uint, param2:uint, param3:int = -1) : void
      {
         var _loc4_:InteractionFilter = null;
         if(this.body)
         {
            _loc4_ = new InteractionFilter();
            _loc4_.collisionGroup = param1;
            _loc4_.collisionMask = param2;
            if(param3 != -1)
            {
               _loc4_.fluidGroup = param3;
            }
            this.body.setShapeFilters(_loc4_);
            LogUtils.log("Collision set Mask: " + param2 + " group: " + param1,this,0,"Collision",false,false,false);
         }
      }
      
      public function get damageSources() : Vector.<CumulativeDamage>
      {
         return this._damageSources;
      }
      
      protected function createTag() : Tag
      {
         return new Tag(this);
      }
      
      protected function get allowDisplayObjectRotation() : Boolean
      {
         return this._allowDisplayObjectRotation;
      }
      
      protected function set allowDisplayObjectRotation(param1:Boolean) : void
      {
         this._allowDisplayObjectRotation = param1;
      }
      
      protected function get playCollisionSounds() : Boolean
      {
         return this._playCollisionSounds;
      }
      
      protected function set playCollisionSounds(param1:Boolean) : void
      {
         this._playCollisionSounds = param1;
      }
      
      protected function outOfWorld() : void
      {
         if(!this._markedForRemoval)
         {
            this._lastLinearDirection = this.body.velocity.copy();
            this.markForRemoval();
            this.emptyCollectedDamage();
            LogUtils.log(this.id + ": Out of world!","PhysicsGameObject",1,"LevelObjects",false,false,false);
         }
      }
      
      protected function emptyCollectedDamage() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Tagger = null;
         var _loc3_:PlayerGameObject = null;
         if(_hasHPs && canTakeDamage())
         {
            _loc1_ = calculateHitPoints();
            LogUtils.log("Empty collected damage: hp: " + _loc1_ + " obj = " + toString(),this,1,"DamageApply",false);
            if(_loc1_ > 0)
            {
               _loc2_ = this.tag.findLatestPlayerTagger();
               if(Boolean(_loc2_) && this is PlayerGameObject)
               {
                  _loc3_ = _loc2_.gameObject as PlayerGameObject;
                  this.reduceHitPointsCumulative(new Damage(this._game,"OOWorldAlive","-1",1,null,_loc3_));
                  reduceHitPoints(new Damage(this._game,"OOWorldAlive","-1",_loc1_,null,_loc3_));
               }
               else
               {
                  this.reduceHitPointsCumulative(new Damage(this._game,"OOWorldAlive","-1",1,null,null));
                  reduceHitPoints(new Damage(this._game,"OOWorldAlive","-1",_loc1_,null,null));
               }
            }
            if(this.hasCumulativeDamageSources())
            {
               this.updateDamageCollection(0);
            }
         }
      }
      
      protected function isOutOfWorld() : Boolean
      {
         var _loc1_:Level = (this.game as TuxWarsGame).tuxWorld.physicsWorld.level;
         return this.bodyLocation.y > _loc1_.height + 150 || this.bodyLocation.y < -15000 || this.bodyLocation.x > _loc1_.width + 150 || this.bodyLocation.x < -150;
      }
      
      protected function updateTag(param1:PhysicsGameObject) : void
      {
         if(!this.tag || param1 is TerrainGameObject && !(param1 as TerrainGameObject).isDynamic() || param1 == this)
         {
            return;
         }
         if(Boolean(param1.tag) && !param1.tag.isDefaultTagger())
         {
            if(this.tag.isDefaultTagger() || this.tag.latestTagger && param1.tag.latestTagger && this.tag.latestTagger.time < param1.tag.latestTagger.time)
            {
               this.tag.update(param1.tag);
            }
         }
         this.tag.add(param1);
      }
      
      protected function handleCollision(param1:Body, param2:ArbiterList) : void
      {
         MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,param1.userData.gameObject,this.findFirstCollisionPosition(param2)));
         if(this._playCollisionSounds)
         {
            SoundManager.markCollision(this,param1.userData.gameObject);
         }
      }
      
      protected function takeCollisionDamage(param1:Number, param2:PhysicsGameObject) : void
      {
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:Tagger = null;
         var _loc5_:PlayerGameObject = null;
         var _loc6_:Vec2 = null;
         var _loc7_:Vec2 = null;
         var _loc8_:* = null;
         if(param1 >= WorldPhysics.getFallImpulseThreshold() && canTakeDamage())
         {
            _loc3_ = param1 * WorldPhysics.getFallDamageMultiplier();
            _loc4_ = param2 != null ? param2.tag.findLatestPlayerTagger() : null;
            _loc5_ = param2 is PlayerGameObject ? param2 as PlayerGameObject : (!!_loc4_ ? _loc4_.gameObject as PlayerGameObject : null);
            _loc9_ = param2;
            LogUtils.log("PhysicsGameObject collision damage, impulse: " + param1 + ", damage: " + _loc3_ + ", from: " + (param2 != null ? _loc9_._uniqueId : null) + ", stepTime: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Collision",false,false,false);
            LogUtils.log("Other tag: " + param2.tag,this,1,"Tag",false,false,false);
            if(_loc3_ >= WorldPhysics.getFallDamageEffectStartValue())
            {
               _loc6_ = !!_loc5_ ? _loc5_.linearVelocity : null;
               _loc7_ = this.linearVelocity;
               _loc8_ = null;
               if(Boolean(_loc6_) && Boolean(_loc7_))
               {
                  _loc8_ = _loc6_.length >= _loc7_.length ? _loc5_ : this as PlayerGameObject;
               }
               else if(Boolean(_loc7_) && _loc7_.length > 0)
               {
                  _loc8_ = this as PlayerGameObject;
               }
               else if(Boolean(_loc6_) && _loc6_.length > 0)
               {
                  _loc8_ = _loc5_;
               }
               _loc10_ = param2;
               this.reduceHitPointsCumulative(new Damage(param2,"Collision",_loc10_._uniqueId,_loc3_,null,_loc8_ != this ? _loc8_ : null));
               MessageCenter.sendEvent(new ChallengeTakeCollisionDamageMessage(this,param2,_loc3_));
            }
            if(_loc3_ >= RewardConfig.getTaggedObjectThreshold())
            {
               if(_loc5_)
               {
                  _loc5_.rewardsHandler.damageDoneToTarget(_loc3_,this);
               }
            }
         }
      }
      
      override protected function loadGraphics() : void
      {
         super.loadGraphics();
         if(this.displayObject.numChildren > 1)
         {
            this.displayObject.setChildIndex(!!this.graphics ? this.displayObject.getChildByName(this.graphics.export) : null,0);
         }
      }
      
      protected function createBody(param1:PhysicsGameObjectDef) : void
      {
         var _loc5_:* = undefined;
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         this.body = new Body(param1.bodyDef.type);
         this.body.position = param1.position.copy(true);
         this.body.allowRotation = !param1.bodyDef.fixedRotation;
         this.body.rotation = !!isNaN(param1.bodyDef.angle) ? 0 : param1.bodyDef.angle;
         this.body.isBullet = param1.bodyDef.bullet;
         this.body.gravMassScale = param1.bodyDef.gravityScale;
         this.body.velocity = !!param1.bodyDef.linearVelocity ? param1.bodyDef.linearVelocity.copy(true) : Vec2.weak();
         this.body.userData.gameObject = this;
         for each(_loc5_ in param1.shapes)
         {
            _loc2_ = Number(_loc5_.material.density);
            _loc3_ = Number(_loc5_.material.elasticity);
            _loc4_ = Number(_loc5_.material.dynamicFriction);
            this.body.shapes.add(_loc5_.copy());
         }
         this.body.space = param1.space;
         this.correctPhysicsStatBodyAndBaseValue("GravityScale",param1.shapes.length > 0 ? this.body.gravMassScale : 0);
         this.correctPhysicsStatBodyAndBaseValue("Density",_loc2_);
         this.correctPhysicsStatBodyAndBaseValue("Restitution",_loc3_);
         this.correctPhysicsStatBodyAndBaseValue("Friction",_loc4_);
         this.updateGraphics();
      }
      
      private function correctPhysicsStatBodyAndBaseValue(param1:String, param2:Number) : void
      {
         var _loc3_:PhysicsStat = stats.create(param1,this.body,param2) as PhysicsStat;
         if(!_loc3_)
         {
            stats.deleteStat(param1);
            stats.create(param1,this.body,param2);
         }
      }
      
      protected function updateGraphics() : void
      {
         if(this.body)
         {
            this.displayObject.x = this.bodyLocation.x;
            this.displayObject.y = this.bodyLocation.y;
            if(Boolean(this._allowDisplayObjectRotation) && this.body.allowRotation)
            {
               this.displayObject.rotation = this.body.rotation;
            }
         }
      }
      
      public function handleEndContact(param1:Body, param2:ArbiterList) : void
      {
         if(!this.body || Boolean(param1.userData.gameObject.isSensorEnabled))
         {
            return;
         }
         if(!this.hasContact())
         {
            this._timeFromLastContact = DCGame.getTime();
         }
         var _loc3_:int = int(this._currentContacts.indexOf(param1.userData.gameObject));
         if(_loc3_ != -1)
         {
            this._currentContacts.splice(_loc3_,1);
         }
      }
      
      public function handleBeginContact(param1:Body, param2:ArbiterList) : void
      {
         if(!this.body || Boolean(param1.userData.gameObject.isSensorEnabled))
         {
            return;
         }
         this.handleCollision(param1,param2);
         this.updateTag(param1.userData.gameObject);
         this._timeFromLastContact = 0;
         this._lastBodyLocation = this.bodyLocation;
         this._lastLinearDirection = this.body.velocity.copy();
         this._lastContactLocations = this.findFirstCollisionPosition(param2);
      }
      
      public function handleOngoingContact(param1:Body, param2:ArbiterList) : void
      {
      }
      
      public function reduceHitPointsCumulative(param1:Damage) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:TextEffect = null;
         if(param1.amount == 0)
         {
            return;
         }
         if(param1.taggingPlayer)
         {
            for each(_loc3_ in this._damageSources)
            {
               if(_loc3_.isPlayer(param1.taggingPlayer))
               {
                  _loc3_.addDamage(param1);
                  return;
               }
            }
            this._damageSources.push(new CumulativeDamage(this,param1,(this.game as TuxWarsGame).tuxWorld));
         }
         else
         {
            reduceHitPoints(param1);
            if(this is PlayerGameObject)
            {
               _loc2_ = (this.game as TuxWarsGame).tuxWorld.addTextEffect(0,param1.amount.toString(),this.displayObject.x,this.displayObject.y,false);
               (this.game as TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc2_.movieClip,true,false);
            }
         }
         if((!param1.taggingPlayer || param1.taggingPlayer == this) && BattleManager.getTurnTimeLeft() < 17000)
         {
            this.tag.clear();
         }
      }
      
      public function get elapsedTime() : int
      {
         return this._elapsedTime;
      }
      
      public function get timeFromLastContact() : int
      {
         return this._timeFromLastContact != 0 ? int(DCGame.getTime() - this._timeFromLastContact) : 0;
      }
      
      public function hasCumulativeDamageSources() : Boolean
      {
         return this._damageSources.length > 0;
      }
      
      public function get linearVelocity() : Vec2
      {
         if(this.body)
         {
            return this.body.velocity.copy();
         }
         return null;
      }
      
      public function get lastLinearVelocity() : Vec2
      {
         return this._lastLinearVelocity;
      }
      
      public function set lastLinearVelocity(param1:Vec2) : void
      {
         this._lastLinearVelocity = param1;
      }
      
      public function get followers() : Vector.<Follower>
      {
         return this._followers;
      }
      
      public function getFollower(param1:String) : Follower
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         for each(_loc2_ in this._followers)
         {
            _loc3_ = _loc2_;
            if(_loc3_._id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      protected function destroyBody() : void
      {
         if(this.body)
         {
            if(!this.lastLinearVelocity && this.body.velocity.length != 0)
            {
               this.lastLinearVelocity = this.body.velocity.copy();
            }
            while(!this.body.constraints.empty())
            {
               this.body.constraints.at(0).space = null;
            }
            this.body.shapes.clear();
            this.body.space = null;
            this.body = null;
         }
      }
      
      protected function findFirstCollisionPosition(param1:ArbiterList) : Vec2
      {
         var _loc2_:int = 0;
         var _loc3_:CollisionArbiter = null;
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            if(param1.at(_loc2_).isCollisionArbiter())
            {
               _loc3_ = CollisionArbiter(param1.at(_loc2_));
               _loc4_ = 0;
               if(_loc4_ < _loc3_.contacts.length)
               {
                  return _loc3_.contacts.at(_loc4_).position.copy();
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function findFirstCollisionImpulse(param1:ArbiterList, param2:Body) : Number
      {
         var _loc3_:int = 0;
         var _loc4_:CollisionArbiter = null;
         var _loc5_:int = 0;
         var _loc6_:Contact = null;
         var _loc7_:Vec3 = null;
         var _loc8_:Vec2 = null;
         var _loc9_:Number = Number(NaN);
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param1.at(_loc3_).isCollisionArbiter())
            {
               _loc4_ = CollisionArbiter(param1.at(_loc3_));
               _loc5_ = 0;
               if(_loc5_ < _loc4_.contacts.length)
               {
                  _loc6_ = _loc4_.contacts.at(_loc5_);
                  _loc7_ = _loc6_.totalImpulse(param2);
                  _loc8_ = Vec2.get(_loc7_.x,_loc7_.y);
                  _loc9_ = _loc8_.length;
                  _loc8_.dispose();
                  return _loc9_;
               }
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function hasSensor(param1:Body) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.shapes.length)
         {
            if(param1.shapes.at(_loc2_).sensorEnabled)
            {
               return true;
            }
            _loc2_++;
         }
         return false;
      }
      
      private function startCollisionPlayback(param1:Message) : void
      {
         this._playCollisionSounds = true;
         MessageCenter.removeListener("StartCollisionPlayback",this.startCollisionPlayback);
      }
      
      private function playerRemoved(param1:Message) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this._tag.taggers.length - 1;
         while(_loc2_ >= 0)
         {
            if(Boolean(this._tag.taggers[_loc2_].gameObject) && this._tag.taggers[_loc2_].gameObject.id == param1.data)
            {
               this._tag.taggers.splice(_loc2_,1);
            }
            _loc2_--;
         }
      }
      
      private function updateDamageCollection(param1:int) : void
      {
         var _loc2_:CumulativeDamage = null;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         for each(_loc2_ in this._damageSources)
         {
            _loc2_.physicsUpdate(param1);
            if(_loc2_.isTriggered())
            {
               _loc4_ = true;
            }
         }
         if(_loc4_)
         {
            _loc3_ = this._damageSources.length - 1;
            while(_loc3_ >= 0)
            {
               _loc2_ = this._damageSources[_loc3_];
               if(_loc2_.isTriggered())
               {
                  this._damageSources.splice(_loc3_,1);
               }
               _loc3_--;
            }
         }
      }
      
      public function get currentContacts() : Vector.<PhysicsGameObject>
      {
         return this._currentContacts;
      }
      
      public function set timeFromLastContact(param1:int) : void
      {
         this._timeFromLastContact = param1;
      }
      
      public function getBody() : Body
      {
         return this.body;
      }
   }
}

