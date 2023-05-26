package tuxwars.battle.gameobjects
{
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.physics.PhysicsStat;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.states.State;
   import com.dchoc.states.StateMachine;
   import com.dchoc.utils.LogUtils;
   import flash.geom.Point;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.Contact;
   import nape.dynamics.InteractionFilter;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.shape.Shape;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.data.WorldPhysics;
   import tuxwars.battle.effects.TextEffect;
   import tuxwars.battle.explosions.ExplosionShape;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.rewards.CumulativeDamage;
   import tuxwars.battle.world.Collider;
   import tuxwars.battle.world.loader.Level;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   import tuxwars.data.RewardConfig;
   import tuxwars.data.SoundHelper;
   import tuxwars.data.SoundManager;
   import tuxwars.data.SoundMessage;
   import tuxwars.data.SoundReference;
   import tuxwars.data.Sounds;
   
   public class PhysicsGameObject extends TuxGameObject implements Collider
   {
      
      public static const GROUP_PENGUIN:String = "PENGUIN";
      
      public static const GROUP_TERRAIN:String = "TERRAIN";
      
      public static const GROUP_LEVEL_OBJECT:String = "LEVEL_OBJECT";
      
      public static const GROUP_POWER_UP:String = "POWER_UP";
      
      public static const GROUP_MISSILE:String = "MISSILE";
      
      public static const GROUP_FOLLOWER:String = "FOLLOWER";
      
      public static const GROUP_WATER:String = "WATER";
      
      public static const GROUP_ALL:Array = ["FOLLOWER","LEVEL_OBJECT","MISSILE","PENGUIN","POWER_UP","TERRAIN","WATER"];
      
      public static const DAMAGE_ID_OUT_OF_WORLD_ALIVE:String = "OOWorldAlive";
      
      public static const DAMAGE_ID_COLLISION:String = "Collision";
      
      public static const DAMAGE_ID_POWER_UP_HEAL:String = "PowerUpHeal";
      
      public static const DAMAGE_KILL_SCRIPT:String = "KillScript";
      
      private static var groupCounterPositive:int = 1;
      
      private static var groupCounterNegative:int = -1;
       
      
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
      
      public function PhysicsGameObject(def:PhysicsGameObjectDef, game:DCGame)
      {
         super(def,game);
         _tag = createTag();
         createBody(def);
         if(body)
         {
            _isSensorEnabled = hasSensor(body);
         }
         _soundID = this._id;
         setCollisionFilterValues(-1,-1);
         MessageCenter.addListener("StartCollisionPlayback",startCollisionPlayback);
         MessageCenter.addListener("PlayerRemoved",playerRemoved);
         LogUtils.log("Created: " + shortName + " at: " + bodyLocation,this,1,"PhysicsWorld",false,false,false);
      }
      
      public static function resetStaticCounters() : void
      {
         groupCounterPositive = 1;
         groupCounterNegative = -1;
      }
      
      override public function dispose() : void
      {
         MessageCenter.removeListener("StartCollisionPlayback",startCollisionPlayback);
         MessageCenter.removeListener("PlayerRemoved",playerRemoved);
         stateMachine.dispose();
         _currentContacts.splice(0,_currentContacts.length);
         _followers.splice(0,_followers.length);
         for each(var damageSource in _damageSources)
         {
            damageSource.dispose();
         }
         _damageSources.splice(0,_damageSources.length);
         _tag.clear();
         _tag = null;
         destroyBody();
         super.dispose();
      }
      
      public function physicsUpdate(deltaTime:int) : void
      {
         if(!body)
         {
            return;
         }
         stateMachine.logicUpdate(deltaTime);
         if(_hasHPs)
         {
            updateDamageCollection(deltaTime);
         }
         if(isOutOfWorld())
         {
            outOfWorld();
            return;
         }
         _elapsedTime += deltaTime;
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(body)
         {
            updateGraphics();
         }
      }
      
      override public function get state() : State
      {
         return stateMachine.state;
      }
      
      override public function exitCurrentState(clearQueue:Boolean = false) : void
      {
         stateMachine.exitCurrentState(clearQueue);
      }
      
      override public function changeState(state:State, immediately:Boolean = false) : void
      {
         stateMachine.changeState(state,immediately);
      }
      
      public function get isSensorEnabled() : Boolean
      {
         return _isSensorEnabled;
      }
      
      public function get soundId() : String
      {
         return _soundID;
      }
      
      public function set soundId(value:String) : void
      {
         _soundID = value;
      }
      
      public function playEndSound(value:String) : void
      {
         var sound:SoundReference = Sounds.getSoundReference(value);
         if(sound)
         {
            MessageCenter.sendEvent(new SoundMessage("StopSound",value,sound.getLoop(),sound.getType(),"LoopSound"));
            MessageCenter.sendEvent(new SoundMessage("EndSound",sound.getMusicID(),sound.getEnd(),sound.getType()));
         }
      }
      
      override public function markForRemoval() : void
      {
         super.markForRemoval();
         destroyBody();
         playEndSound(this is LevelGameObject ? (this as LevelGameObject).material : _soundID);
      }
      
      public function get tag() : Tag
      {
         return _tag;
      }
      
      protected function hasContact() : Boolean
      {
         if(body)
         {
            return body.interactingBodies().length > 0;
         }
         return false;
      }
      
      public function handleExplosionImpulse(location:Vec2, taggerGameObject:PhysicsGameObject) : void
      {
         if(taggerGameObject && !(taggerGameObject is TerrainGameObject) || taggerGameObject is TerrainGameObject && (taggerGameObject as TerrainGameObject).isDynamic() && taggerGameObject != this)
         {
            tag.update(taggerGameObject.tag);
            tag.add(taggerGameObject);
         }
      }
      
      public function handleExplosionDamage(damageSource:Damage) : void
      {
         if(!canTakeDamage())
         {
            return;
         }
         var _loc2_:Stat = !!this.stats ? this.stats.getStat("HP") : null;
         if(_loc2_)
         {
            reduceHitPointsCumulative(damageSource);
         }
      }
      
      public function handleExplosionTerrain(location:Vec2, explosionShape:ExplosionShape) : void
      {
      }
      
      public function isDeadHP() : Boolean
      {
         return calculateHitPoints() <= 0;
      }
      
      public function enteredWater() : void
      {
         if(!body)
         {
            return;
         }
         var _loc4_:SoundHelper = SoundHelper;
         if(tuxwars.data.SoundHelper._instance == null)
         {
            new tuxwars.data.SoundHelper();
         }
         var _loc1_:String = tuxwars.data.SoundHelper._instance.AreaReceiver(body.bounds.width * body.bounds.height);
         var _loc5_:SoundHelper = SoundHelper;
         if(tuxwars.data.SoundHelper._instance == null)
         {
            new tuxwars.data.SoundHelper();
         }
         var _loc2_:String = tuxwars.data.SoundHelper._instance.SpeedReceiver(linearVelocity.length);
         var _loc3_:SoundReference = Sounds.getSoundReference("WaterHit" + _loc1_ + _loc2_);
         if(_loc3_)
         {
            MessageCenter.sendEvent(new SoundMessage("PlaySound",_loc3_.getMusicID(),_loc3_.getStart(),_loc3_.getType(),"PlaySound"));
         }
      }
      
      public function exitedWater() : void
      {
      }
      
      public function get lastContactLocations() : Vec2
      {
         return _lastContactLocations;
      }
      
      public function get lastBodyLocations() : Vec2
      {
         return _lastBodyLocation;
      }
      
      public function get lastLinearDirection() : Vec2
      {
         return _lastLinearDirection;
      }
      
      public function get bodyLocationPoint() : Point
      {
         var _loc1_:Vec2 = bodyLocation;
         if(_loc1_)
         {
            return _loc1_.toPoint();
         }
         return null;
      }
      
      public function get bodyLocation() : Vec2
      {
         if(body)
         {
            return body.position.copy();
         }
         return null;
      }
      
      public function setCollisionFilterValues(group:uint, mask:uint, fluidGroup:int = -1) : void
      {
         var _loc4_:* = null;
         if(body)
         {
            _loc4_ = new InteractionFilter();
            _loc4_.collisionGroup = group;
            _loc4_.collisionMask = mask;
            if(fluidGroup != -1)
            {
               _loc4_.fluidGroup = fluidGroup;
            }
            body.setShapeFilters(_loc4_);
            LogUtils.log("Collision set Mask: " + mask + " group: " + group,this,0,"Collision",false,false,false);
         }
      }
      
      public function get damageSources() : Vector.<CumulativeDamage>
      {
         return _damageSources;
      }
      
      protected function createTag() : Tag
      {
         return new Tag(this);
      }
      
      protected function get allowDisplayObjectRotation() : Boolean
      {
         return _allowDisplayObjectRotation;
      }
      
      protected function set allowDisplayObjectRotation(value:Boolean) : void
      {
         _allowDisplayObjectRotation = value;
      }
      
      protected function get playCollisionSounds() : Boolean
      {
         return _playCollisionSounds;
      }
      
      protected function set playCollisionSounds(value:Boolean) : void
      {
         _playCollisionSounds = value;
      }
      
      protected function outOfWorld() : void
      {
         if(!this._markedForRemoval)
         {
            _lastLinearDirection = body.velocity.copy();
            markForRemoval();
            emptyCollectedDamage();
            LogUtils.log(this._id + ": Out of world!","PhysicsGameObject",1,"LevelObjects",false,false,false);
         }
      }
      
      protected function emptyCollectedDamage() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:* = null;
         if(_hasHPs && canTakeDamage())
         {
            _loc2_ = calculateHitPoints();
            LogUtils.log("Empty collected damage: hp: " + _loc2_ + " obj = " + toString(),this,1,"DamageApply",false);
            if(_loc2_ > 0)
            {
               _loc1_ = tag.findLatestPlayerTagger();
               if(_loc1_ && this is PlayerGameObject)
               {
                  _loc3_ = _loc1_.gameObject as PlayerGameObject;
                  reduceHitPointsCumulative(new Damage(this._game,"OOWorldAlive","-1",1,null,_loc3_));
                  reduceHitPoints(new Damage(this._game,"OOWorldAlive","-1",_loc2_,null,_loc3_));
               }
               else
               {
                  reduceHitPointsCumulative(new Damage(this._game,"OOWorldAlive","-1",1,null,null));
                  reduceHitPoints(new Damage(this._game,"OOWorldAlive","-1",_loc2_,null,null));
               }
            }
            if(hasCumulativeDamageSources())
            {
               updateDamageCollection(0);
            }
         }
      }
      
      protected function isOutOfWorld() : Boolean
      {
         var _loc2_:Level = (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.level;
         return bodyLocation.y > _loc2_.height + 150 || bodyLocation.y < -15000 || bodyLocation.x > _loc2_.width + 150 || bodyLocation.x < -150;
      }
      
      protected function updateTag(other:PhysicsGameObject) : void
      {
         if(!tag || other is TerrainGameObject && !(other as TerrainGameObject).isDynamic() || other == this)
         {
            return;
         }
         if(other.tag && !other.tag.isDefaultTagger())
         {
            if(tag.isDefaultTagger() || tag.latestTagger && other.tag.latestTagger && tag.latestTagger.time < other.tag.latestTagger.time)
            {
               tag.update(other.tag);
            }
         }
         tag.add(other);
      }
      
      protected function handleCollision(otherBody:Body, arbiterList:ArbiterList) : void
      {
         MessageCenter.sendEvent(new ChallengePhysicsObjectContactMessage(this,otherBody.userData.gameObject,findFirstCollisionPosition(arbiterList)));
         if(_playCollisionSounds)
         {
            SoundManager.markCollision(this,otherBody.userData.gameObject);
         }
      }
      
      protected function takeCollisionDamage(impulse:Number, other:PhysicsGameObject) : void
      {
         var _loc7_:int = 0;
         var _loc3_:* = null;
         var _loc8_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var velocityTagger:* = null;
         if(impulse >= WorldPhysics.getFallImpulseThreshold() && canTakeDamage())
         {
            _loc7_ = impulse * WorldPhysics.getFallDamageMultiplier();
            _loc3_ = other != null ? other.tag.findLatestPlayerTagger() : null;
            _loc8_ = other is PlayerGameObject ? other as PlayerGameObject : (!!_loc3_ ? _loc3_.gameObject as PlayerGameObject : null);
            var _loc9_:*;
            LogUtils.log("PhysicsGameObject collision damage, impulse: " + impulse + ", damage: " + _loc7_ + ", from: " + (other != null ? (_loc9_ = other, _loc9_._uniqueId) : null) + ", stepTime: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,1,"Collision",false,false,false);
            LogUtils.log("Other tag: " + other.tag,this,1,"Tag",false,false,false);
            if(_loc7_ >= WorldPhysics.getFallDamageEffectStartValue())
            {
               _loc4_ = !!_loc8_ ? _loc8_.linearVelocity : null;
               _loc6_ = this.linearVelocity;
               velocityTagger = null;
               if(_loc4_ && _loc6_)
               {
                  velocityTagger = _loc4_.length >= _loc6_.length ? _loc8_ : this as PlayerGameObject;
               }
               else if(_loc6_ && _loc6_.length > 0)
               {
                  velocityTagger = this as PlayerGameObject;
               }
               else if(_loc4_ && _loc4_.length > 0)
               {
                  velocityTagger = _loc8_;
               }
               var _loc10_:* = other;
               reduceHitPointsCumulative(new Damage(other,"Collision",_loc10_._uniqueId,_loc7_,null,velocityTagger != this ? velocityTagger : null));
               MessageCenter.sendEvent(new ChallengeTakeCollisionDamageMessage(this,other,_loc7_));
            }
            if(_loc7_ >= RewardConfig.getTaggedObjectThreshold())
            {
               if(_loc8_)
               {
                  _loc8_.rewardsHandler.damageDoneToTarget(_loc7_,this);
               }
            }
         }
      }
      
      override protected function loadGraphics() : void
      {
         super.loadGraphics();
         if(this._displayObject.numChildren > 1)
         {
            this._displayObject.setChildIndex(!!this.graphics ? this._displayObject.getChildByName(this.graphics.export) : null,0);
         }
      }
      
      protected function createBody(def:PhysicsGameObjectDef) : void
      {
         var density:Number = NaN;
         var restitution:Number = NaN;
         var friction:Number = NaN;
         body = new Body(def.bodyDef.type);
         body.position = def.position.copy(true);
         body.allowRotation = !def.bodyDef.fixedRotation;
         body.rotation = isNaN(def.bodyDef.angle) ? 0 : def.bodyDef.angle;
         body.isBullet = def.bodyDef.bullet;
         body.gravMassScale = def.bodyDef.gravityScale;
         body.velocity = !!def.bodyDef.linearVelocity ? def.bodyDef.linearVelocity.copy(true) : Vec2.weak();
         body.userData.gameObject = this;
         for each(var shape in def.shapes)
         {
            density = shape.material.density;
            restitution = shape.material.elasticity;
            friction = shape.material.dynamicFriction;
            body.shapes.add(shape.copy());
         }
         body.space = def.space;
         correctPhysicsStatBodyAndBaseValue("GravityScale",def.shapes.length > 0 ? body.gravMassScale : 0);
         correctPhysicsStatBodyAndBaseValue("Density",density);
         correctPhysicsStatBodyAndBaseValue("Restitution",restitution);
         correctPhysicsStatBodyAndBaseValue("Friction",friction);
         updateGraphics();
      }
      
      private function correctPhysicsStatBodyAndBaseValue(statName:String, value:Number) : void
      {
         var _loc3_:PhysicsStat = stats.create(statName,body,value) as PhysicsStat;
         if(!_loc3_)
         {
            stats.deleteStat(statName);
            stats.create(statName,body,value);
         }
      }
      
      protected function updateGraphics() : void
      {
         if(body)
         {
            this._displayObject.x = bodyLocation.x;
            this._displayObject.y = bodyLocation.y;
            if(_allowDisplayObjectRotation && body.allowRotation)
            {
               this._displayObject.rotation = body.rotation;
            }
         }
      }
      
      public function handleEndContact(otherBody:Body, arbiterList:ArbiterList) : void
      {
         if(!body || otherBody.userData.gameObject.isSensorEnabled)
         {
            return;
         }
         if(!hasContact())
         {
            _timeFromLastContact = DCGame.getTime();
         }
         var _loc3_:int = _currentContacts.indexOf(otherBody.userData.gameObject);
         if(_loc3_ != -1)
         {
            _currentContacts.splice(_loc3_,1);
         }
      }
      
      public function handleBeginContact(otherBody:Body, arbiterList:ArbiterList) : void
      {
         if(!body || otherBody.userData.gameObject.isSensorEnabled)
         {
            return;
         }
         handleCollision(otherBody,arbiterList);
         updateTag(otherBody.userData.gameObject);
         _timeFromLastContact = 0;
         _lastBodyLocation = bodyLocation;
         _lastLinearDirection = body.velocity.copy();
         _lastContactLocations = findFirstCollisionPosition(arbiterList);
      }
      
      public function handleOngoingContact(otherBody:Body, arbiterList:ArbiterList) : void
      {
      }
      
      public function reduceHitPointsCumulative(damageSource:Damage) : void
      {
         var _loc3_:* = null;
         if(damageSource.amount == 0)
         {
            return;
         }
         if(damageSource.taggingPlayer)
         {
            for each(var cumulativeDamage in _damageSources)
            {
               if(cumulativeDamage.isPlayer(damageSource.taggingPlayer))
               {
                  cumulativeDamage.addDamage(damageSource);
                  return;
               }
            }
            _damageSources.push(new CumulativeDamage(this,damageSource,(this.game as tuxwars.TuxWarsGame).tuxWorld));
         }
         else
         {
            reduceHitPoints(damageSource);
            if(this is PlayerGameObject)
            {
               _loc3_ = (this.game as tuxwars.TuxWarsGame).tuxWorld.addTextEffect(0,damageSource.amount.toString(),this._displayObject.x,this._displayObject.y,false);
               (this.game as tuxwars.TuxWarsGame).tuxWorld.ignoreLevelSizeScale(_loc3_.movieClip,true,false);
            }
         }
         if((!damageSource.taggingPlayer || damageSource.taggingPlayer == this) && BattleManager.getTurnTimeLeft() < 17000)
         {
            tag.clear();
         }
      }
      
      public function get elapsedTime() : int
      {
         return _elapsedTime;
      }
      
      public function get timeFromLastContact() : int
      {
         return _timeFromLastContact != 0 ? DCGame.getTime() - _timeFromLastContact : 0;
      }
      
      public function hasCumulativeDamageSources() : Boolean
      {
         return _damageSources.length > 0;
      }
      
      public function get linearVelocity() : Vec2
      {
         if(body)
         {
            return body.velocity.copy();
         }
         return null;
      }
      
      public function get lastLinearVelocity() : Vec2
      {
         return _lastLinearVelocity;
      }
      
      public function set lastLinearVelocity(lv:Vec2) : void
      {
         _lastLinearVelocity = lv;
      }
      
      public function get followers() : Vector.<Follower>
      {
         return _followers;
      }
      
      public function getFollower(followerId:String) : Follower
      {
         for each(var fo in _followers)
         {
            var _loc3_:* = fo;
            if(_loc3_._id == followerId)
            {
               return fo;
            }
         }
         return null;
      }
      
      protected function destroyBody() : void
      {
         if(body)
         {
            if(!lastLinearVelocity && body.velocity.length != 0)
            {
               lastLinearVelocity = body.velocity.copy();
            }
            while(!body.constraints.empty())
            {
               body.constraints.at(0).space = null;
            }
            body.shapes.clear();
            body.space = null;
            body = null;
         }
      }
      
      protected function findFirstCollisionPosition(arbiterList:ArbiterList) : Vec2
      {
         var i:int = 0;
         var _loc2_:* = null;
         var j:int = 0;
         for(i = 0; i < arbiterList.length; )
         {
            if(arbiterList.at(i).isCollisionArbiter())
            {
               _loc2_ = CollisionArbiter(arbiterList.at(i));
               j = 0;
               if(j < _loc2_.contacts.length)
               {
                  return _loc2_.contacts.at(j).position.copy();
               }
            }
            i++;
         }
         return null;
      }
      
      protected function findFirstCollisionImpulse(arbiterList:ArbiterList, other:Body) : Number
      {
         var i:int = 0;
         var _loc4_:* = null;
         var j:int = 0;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = null;
         var _loc3_:Number = NaN;
         for(i = 0; i < arbiterList.length; )
         {
            if(arbiterList.at(i).isCollisionArbiter())
            {
               _loc4_ = CollisionArbiter(arbiterList.at(i));
               j = 0;
               if(j < _loc4_.contacts.length)
               {
                  _loc7_ = _loc4_.contacts.at(j);
                  _loc5_ = _loc7_.totalImpulse(other);
                  _loc8_ = Vec2.get(_loc5_.x,_loc5_.y);
                  _loc3_ = _loc8_.length;
                  _loc8_.dispose();
                  return _loc3_;
               }
            }
            i++;
         }
         return 0;
      }
      
      private function hasSensor(body:Body) : Boolean
      {
         var i:int = 0;
         for(i = 0; i < body.shapes.length; )
         {
            if(body.shapes.at(i).sensorEnabled)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      private function startCollisionPlayback(msg:Message) : void
      {
         _playCollisionSounds = true;
         MessageCenter.removeListener("StartCollisionPlayback",startCollisionPlayback);
      }
      
      private function playerRemoved(msg:Message) : void
      {
         var i:int = 0;
         for(i = _tag.taggers.length - 1; i >= 0; )
         {
            if(_tag.taggers[i].gameObject && _tag.taggers[i].gameObject.id == msg.data)
            {
               _tag.taggers.splice(i,1);
            }
            i--;
         }
      }
      
      private function updateDamageCollection(deltaTime:int) : void
      {
         var cumulativeDamage:* = null;
         var i:int = 0;
         var deleteObjects:Boolean = false;
         for each(cumulativeDamage in _damageSources)
         {
            cumulativeDamage.physicsUpdate(deltaTime);
            if(cumulativeDamage.isTriggered())
            {
               deleteObjects = true;
            }
         }
         if(deleteObjects)
         {
            for(i = _damageSources.length - 1; i >= 0; )
            {
               cumulativeDamage = _damageSources[i];
               if(cumulativeDamage.isTriggered())
               {
                  _damageSources.splice(i,1);
               }
               i--;
            }
         }
      }
      
      public function get currentContacts() : Vector.<PhysicsGameObject>
      {
         return _currentContacts;
      }
      
      public function set timeFromLastContact(value:int) : void
      {
         _timeFromLastContact = value;
      }
      
      public function getBody() : Body
      {
         return body;
      }
   }
}
