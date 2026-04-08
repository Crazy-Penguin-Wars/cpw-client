package tuxwars.battle.gameobjects
{
   import com.citrusengine.physics.*;
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.geom.*;
   import flash.utils.*;
   import nape.constraint.Constraint;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.InteractionFilter;
   import nape.geom.*;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.battle.net.responses.*;
   import tuxwars.battle.simplescript.*;
   import tuxwars.items.*;
   import tuxwars.items.references.StatBonusReference;
   
   public class Follower extends PhysicsEmissionGameObject
   {
      public static const TRIGGER_ENTER:String = "Enter";
      
      public static const TRIGGER_UPDATE:String = "Update";
      
      private static const TRIGGER_EXIT:String = "Exit";
      
      public static const TARGET_ALL:String = "All";
      
      private static const TARGET_SINGLE:String = "Single";
      
      private static const TARGET_SINGLE_RANDOM:String = "SingleRandom";
      
      private static const TARGET_SELECTION_CLOSEST:String = "Closest";
      
      public static const TARGET_SELECTION_RANDOM:String = "Random";
      
      private static const TARGET_SELECTION_FARTHEST:String = "Farthest";
      
      private static const TYPE_SELF:String = "Self";
      
      private static const TYPE_DEFENCIVE:String = "Defencive";
      
      public static const TYPE_AGRESSIVE:String = "Agressive";
      
      public static const TYPE_STATUS:String = "Status";
      
      public static const TYPE_STATUS_PERMANENT:String = "StatusPermanent";
      
      private static const AT_SELF:String = "Self";
      
      private static const AT_FOLLOWED:String = "Followed";
      
      public static const AT_TARGET:String = "Target";
      
      private static const ACTIVATE_ONCE:int = -1;
      
      private static const COLOR_TRANSFORM_RESET:ColorTransform = new ColorTransform();
      
      public var _type:String;
      
      private var _emitAt:String;
      
      private var _multipleEmissions:Boolean;
      
      private var _activations:int;
      
      private var _activationsOriginal:int;
      
      private var _isActivationsUnlimited:Boolean;
      
      private var _duration:int;
      
      private var _durationOriginal:int;
      
      private var _isDurationUnlimited:Boolean;
      
      private var _activateIn:int;
      
      private var _activationCooldownOriginal:int;
      
      private const _activationCooldownList:Dictionary;
      
      private var _affectedObjects:Array;
      
      private var _applyToObjects:Array;
      
      private var _triggers:Array;
      
      private var _target:String;
      
      private var _targetSelection:String;
      
      private var _selectedTarget:PhysicsGameObject;
      
      private var _followedObjectReal:PhysicsGameObject;
      
      private var _joint:Constraint;
      
      private var _statBonuses:Stats;
      
      private var _colorTransformFollower:ColorTransform;
      
      private var _colorReference:ColorReference;
      
      private const _scriptUniqueIds:Array;
      
      public function Follower(param1:FollowerDef, param2:DCGame)
      {
         var _loc4_:* = undefined;
         this._activationCooldownList = new Dictionary(true);
         this._scriptUniqueIds = [];
         super(param1,param2);
         this._type = param1.type;
         this._emitAt = param1.emitAt;
         this._activations = param1.activations;
         this._activationsOriginal = param1.activations;
         this._isActivationsUnlimited = this._activations == 0;
         this._duration = param1.duration;
         this._durationOriginal = param1.duration;
         this._activateIn = param1.activateIn;
         this._multipleEmissions = param1.multipleEmissions;
         this._isDurationUnlimited = this._duration == 0;
         this._activationCooldownOriginal = param1.activationCooldown;
         this._affectedObjects = param1.affectedObjects;
         this._applyToObjects = param1.applyToObjects;
         this._triggers = !!param1.triggers ? param1.triggers : [];
         this._target = param1.target;
         this._targetSelection = param1.targetSelection;
         allowDisplayObjectRotation = false;
         playCollisionSounds = false;
         setCollisionFilterValues(PhysicsCollisionCategories.Get("FOLLOWER"),EmitterUtils.getBitsFor(param1.affectedObjects));
         var _loc3_:StatBonusReference = param1.statBonuses;
         if(_loc3_ != null)
         {
            this._statBonuses = new Stats();
            for each(_loc4_ in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               if(_loc3_.getStat(_loc4_))
               {
                  this._statBonuses.setStat(_loc4_,_loc3_.getStat(_loc4_));
               }
            }
         }
         this._colorReference = param1.colorReference;
         if(this._colorReference)
         {
            this._colorTransformFollower = new ColorTransform(this._colorReference.redMultiplier,this._colorReference.greenMultiplier,this._colorReference.blueMultiplier,this._colorReference.alphaMultiplier,this._colorReference.redOffset,this._colorReference.greenOffset,this._colorReference.blueOffset,this._colorReference.alphaOffset);
         }
         body.mass = 1e-28;
      }
      
      public function init(param1:PhysicsGameObject, param2:Tagger) : void
      {
         var _loc4_:* = undefined;
         LogUtils.log("Setting follower: " + shortName + " on followed object: " + param1.shortName + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
         if(this._statBonuses != null)
         {
            for each(_loc4_ in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               param1.stats.addStat(_loc4_,this._statBonuses.getStat(_loc4_),body);
            }
         }
         if(param1.followers)
         {
            param1.followers.push(this);
         }
         this._followedObjectReal = param1;
         var _loc3_:InteractionFilter = param1.body.shapes.at(0).filter.copy();
         body.setShapeFilters(_loc3_);
         tag.add(param2.gameObject);
         this.applyColorTransform2();
         if(!SimpleScriptManager.instance)
         {
            new SimpleScriptManager();
         }
         this._joint = SimpleScriptManager.instance.runWithName(false,"AddJoint",[this,param1],new SimpleScriptParams());
         this._joint.space = body.space;
      }
      
      override public function dispose() : void
      {
         LogUtils.log("Disposing follower: " + shortName + " on followed object: " + (!!this.followedObject ? this.followedObject.shortName : null) + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
         if(this._joint)
         {
            this._joint.active = false;
            this._joint.space = null;
            this._joint = null;
         }
         super.dispose();
         this.removeEffectsOnFollowedObject();
         this._colorReference = null;
         if(this._statBonuses != null)
         {
            this._statBonuses.dispose();
         }
         this._statBonuses = null;
         this._followedObjectReal = null;
         this._affectedObjects = null;
         this._applyToObjects = null;
         this._selectedTarget = null;
         this._duration = 0;
         MessageCenter.removeListener("ActionResponse",this.actionHandler);
      }
      
      public function removeEffectsOnFollowedObject() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:int = 0;
         if(this.followedObject)
         {
            if(this._statBonuses != null)
            {
               LogUtils.log("Removing follower: " + shortName + " stats from object: " + (!!this.followedObject ? this.followedObject.shortName : null) + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
               for each(_loc2_ in Equippable.EQUIPPABLE_BONUS_STATS)
               {
                  if(this.followedObject.stats)
                  {
                     this.followedObject.stats.removeStat(_loc2_,this._statBonuses.getStat(_loc2_));
                  }
               }
            }
            this.removeColorTransform();
            if(this.followedObject.followers)
            {
               _loc1_ = int(this.followedObject.followers.indexOf(this));
               if(_loc1_ != -1)
               {
                  LogUtils.log("Remove follower: " + shortName + " from object: " + (!!this.followedObject ? this.followedObject.shortName : null) + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  this.followedObject.followers.splice(_loc1_,1);
               }
            }
         }
      }
      
      override public function markForRemoval() : void
      {
         if(this._scriptUniqueIds.length > 0)
         {
            LogUtils.log("Waiting for server responses for scripts: " + this._scriptUniqueIds.toString() + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
            return;
         }
         super.markForRemoval();
      }
      
      override public function physicsUpdate(param1:int) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:PhysicsGameObject = null;
         var _loc3_:* = undefined;
         super.physicsUpdate(param1);
         if(!body)
         {
            return;
         }
         if(!this._markedForRemoval)
         {
            _loc2_ = this.followedObject;
            if(_loc2_ == null || !_loc2_.body)
            {
               LogUtils.log("Removing follower: " + shortName + " because nothing to follow, stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
               super.markForRemoval();
            }
            else if(_loc2_._hasHPs && _loc2_.isDeadHP() || _loc2_ is PlayerGameObject && (Boolean((_loc2_ as PlayerGameObject).isDead()) || Boolean((_loc2_ as PlayerGameObject).isSpawning())))
            {
               if(this._type != "StatusPermanent")
               {
                  if(_loc2_ is PlayerGameObject)
                  {
                     if(this._scriptUniqueIds.length > 0)
                     {
                        return;
                     }
                     this.removeEffectsOnFollowedObject();
                  }
                  LogUtils.log("Removing follower: " + shortName + ", player: " + (_loc2_ as PlayerGameObject).shortName + " is dead, stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  super.markForRemoval();
               }
               if(_loc2_ is PlayerGameObject)
               {
                  (_loc2_ as PlayerGameObject).followerIdsAtDeath.push(this._id);
               }
            }
            if(this._markedForRemoval)
            {
               return;
            }
         }
         this._activateIn -= param1;
         if(this._activationCooldownOriginal > 0)
         {
            for(_loc4_ in this._activationCooldownList)
            {
               if(this._activationCooldownList[_loc4_] >= 0)
               {
                  LogUtils.log("Updating follower: " + shortName + " activationCooldownList[ " + _loc4_ + " ] from " + this._activationCooldownList[_loc4_] + " by deltaTime: " + -param1 + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  this._activationCooldownList[_loc4_] -= param1;
               }
            }
         }
         if(this.triggerAt("Update"))
         {
            _loc3_ = this.getTargets();
            for each(_loc5_ in _loc3_)
            {
               this.possibleActivate(_loc5_);
            }
         }
         this.updateDuration(param1);
         if(!this._markedForRemoval)
         {
            if(this._scriptUniqueIds.length <= 0)
            {
               if(!this.hasDuration)
               {
                  LogUtils.log("Follower: " + shortName + " marked for removal, reason: Duration ended, stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  this.markForRemoval();
               }
               else if(!this.hasActivations)
               {
                  LogUtils.log("Follower: " + shortName + " marked for removal, reason: No more activations left, stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  this.markForRemoval();
               }
               else if(!this.hasFollowedObject)
               {
                  LogUtils.log("Follower: " + shortName + " marked for removal, reason: No object to follow, stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  this.markForRemoval();
               }
            }
         }
      }
      
      private function updateDuration(param1:int) : void
      {
         if(!this._isDurationUnlimited && this._duration > 0)
         {
            this._duration -= param1;
            if(this._duration <= 0)
            {
               LogUtils.log("Duration: " + this._duration + ") elapsed follower: " + shortName + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
            }
         }
      }
      
      private function get hasDuration() : Boolean
      {
         return this._duration > 0 || Boolean(this._isDurationUnlimited);
      }
      
      private function updateActivations() : void
      {
         if(!this._isActivationsUnlimited && this._activations > 0)
         {
            --this._activations;
            if(this._activations <= 0)
            {
               if(this._joint)
               {
                  this._joint.active = false;
                  this._joint.space = null;
                  this._joint = null;
               }
               LogUtils.log("Activations: " + this._activations + "  elapsed for follower: " + shortName + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
            }
         }
      }
      
      private function get hasActivations() : Boolean
      {
         return this._activations > 0 || Boolean(this._isActivationsUnlimited);
      }
      
      private function getTargets() : Vector.<PhysicsGameObject>
      {
         var foundSelectedTarget:Boolean = false;
         var i:int = 0;
         var target:PhysicsGameObject = null;
         var player:PlayerGameObject = null;
         var fo:PhysicsGameObject = null;
         var origin:Vec2 = null;
         var d1:Vec2 = null;
         var d2:Vec2 = null;
         var str:String = null;
         var t:PhysicsGameObject = null;
         var random:int = 0;
         var targets:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
         var bodyList:BodyList = body.interactingBodies();
         i = 0;
         for(; i < bodyList.length; i++)
         {
            target = bodyList.at(i).userData.gameObject as PhysicsGameObject;
            if(Boolean(target) && target != this)
            {
               if(!(target._hasHPs && target.isDeadHP()))
               {
                  if(target is PlayerGameObject)
                  {
                     player = PlayerGameObject(target);
                     if(player.isDead() || player.isSpawning())
                     {
                        continue;
                     }
                  }
                  if((this._selectedTarget == null || this._selectedTarget == target) && targets.indexOf(target) == -1)
                  {
                     targets.push(target);
                  }
                  if(this._selectedTarget == target)
                  {
                     foundSelectedTarget = true;
                     break;
                  }
               }
            }
         }
         if((this._type == "Status" || this._type == "StatusPermanent") && this.hasFollowedObject)
         {
            fo = this.followedObject;
            if(targets.indexOf(fo) == -1)
            {
               targets.push(fo);
            }
         }
         if(!foundSelectedTarget && this._selectedTarget != null || this._target == "SingleRandom")
         {
            this._selectedTarget = null;
         }
         if(targets.length == 0)
         {
            return targets;
         }
         origin = this.body.position;
         d1 = Vec2.get();
         d2 = Vec2.get();
         targets.sort(function(param1:PhysicsGameObject, param2:PhysicsGameObject):int
         {
            var _loc3_:Vec2 = param1.bodyLocation;
            var _loc4_:Vec2 = param2.bodyLocation;
            d1.x = origin.x - _loc3_.x;
            d1.y = origin.y - _loc3_.y;
            d2.x = origin.x - _loc4_.x;
            d2.y = origin.y - _loc4_.y;
            return d2.length - d1.length;
         });
         d1.dispose();
         d2.dispose();
         str = "";
         for each(t in targets)
         {
            str += t.shortName + ", ";
         }
         LogUtils.log(shortName + ": got targets: " + str,this,1,"Follower",false,false,false);
         if(Boolean(this.singleTarget) && targets.length > 1)
         {
            switch(this._targetSelection)
            {
               case "Closest":
                  targets.splice(0,targets.length - 1);
                  break;
               case "Farthest":
                  targets.splice(1,targets.length - 1);
                  break;
               case "Random":
               default:
                  if(this._targetSelection != "Random")
                  {
                     LogUtils.log("Follower with singleTarget has a targeting of :" + this._targetSelection + " that is not specified, using random",this,0,"Follower",true,true,false);
                  }
                  LogUtils.log("Call to random getTargets()",this,0,"Random",false,false,false);
                  random = int(BattleManager.getRandom().integer(0,targets.length));
                  targets.splice(0,random);
                  targets.splice(random,targets.length - 1);
            }
         }
         return targets;
      }
      
      private function isActivated() : Boolean
      {
         return this._activateIn <= 0;
      }
      
      private function triggerAt(param1:String) : Boolean
      {
         return this._triggers.indexOf(param1) != -1 && Boolean(this.isActivated());
      }
      
      public function get hasFollowedObject() : Boolean
      {
         var _loc1_:PhysicsGameObject = this.followedObject;
         return _loc1_ != null && !_loc2_._markedForRemoval;
      }
      
      public function get followedObject() : PhysicsGameObject
      {
         if(this.followedObjectReal is Follower)
         {
            return (this.followedObjectReal as Follower).followedObject;
         }
         return this.followedObjectReal;
      }
      
      public function get followedObjectReal() : PhysicsGameObject
      {
         if(this._followedObjectReal != null && Boolean(_loc1_._markedForRemoval))
         {
            return null;
         }
         return this._followedObjectReal;
      }
      
      override public function handleBeginContact(param1:Body, param2:ArbiterList) : void
      {
         if(!body || Boolean(param1.userData.gameObject.isSensorEnabled))
         {
            return;
         }
         if(this.triggerAt("Enter"))
         {
            this.possibleActivate(param1.userData.gameObject as PhysicsGameObject);
         }
      }
      
      override public function handleEndContact(param1:Body, param2:ArbiterList) : void
      {
         if(!body || Boolean(param1.userData.gameObject.isSensorEnabled))
         {
            return;
         }
         if(this.triggerAt("Exit"))
         {
            this.possibleActivate(param1.userData.gameObject as PhysicsGameObject);
         }
      }
      
      private function get singleTarget() : Boolean
      {
         switch(this._target)
         {
            case "Single":
            case "SingleRandom":
               return true;
            case "All":
               return false;
            default:
               LogUtils.log("Unspecified target: " + this._target,this,2,"Follower",true,true,false);
               return false;
         }
      }
      
      private function possibleActivate(param1:PhysicsGameObject) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         if(param1 && this.isActivated() && this.hasDuration && Boolean(this.hasActivations))
         {
            if(EmitterUtils.affectsObject(this._affectedObjects,!!this.tag.findLatestPlayerTagger() ? this.tag.findLatestPlayerTagger().gameObject : null,param1))
            {
               _loc2_ = param1;
               if(!this._activationCooldownList[_loc2_._uniqueId])
               {
                  this.selectTargetAndActivate(param1);
               }
               else if(this._activationCooldownOriginal == -1)
               {
                  _loc3_ = param1;
                  if(this._activationCooldownList[_loc3_._uniqueId] != -1)
                  {
                     this.selectTargetAndActivate(param1);
                  }
               }
               else
               {
                  _loc4_ = param1;
                  if(this._activationCooldownList[_loc4_._uniqueId] <= 0)
                  {
                     this.selectTargetAndActivate(param1);
                  }
               }
            }
         }
      }
      
      private function selectTargetAndActivate(param1:PhysicsGameObject) : void
      {
         switch(this._type)
         {
            case "Agressive":
               this.activate(param1,param1);
               break;
            case "Defencive":
            case "Status":
            case "StatusPermanent":
               this.activate(param1,this.followedObject);
               break;
            case "Self":
               this.activate(param1,this);
               break;
            default:
               if(this._type != null)
               {
                  LogUtils.log("Type: " + this._type + " not specified",this,2,"Follower",true,true,true);
               }
               this.activate(param1,this);
         }
      }
      
      private function activate(param1:PhysicsGameObject, param2:PhysicsGameObject) : void
      {
         var _loc9_:* = undefined;
         var _loc3_:PhysicsGameObject = null;
         var _loc4_:SimpleScriptParams = null;
         var _loc5_:Vec2 = null;
         var _loc6_:Boolean = false;
         var _loc7_:PhysicsGameObject = null;
         var _loc8_:String = null;
         if(param2 && param2.body && (this._selectedTarget == null || this._selectedTarget == param2) && Boolean(this.isActivated()))
         {
            _loc3_ = this.getEmitAt(param2);
            if(Boolean(_loc3_) && Boolean(_loc3_.body))
            {
               LogUtils.log("Activated: " + shortName + " target: " + param2 + " emitAt: " + _loc3_,this,2,"Follower",false,false,false);
               _loc4_ = new SimpleScriptParams(param2,_loc3_);
               _loc5_ = this.getActivationLocation(param2);
               if(_loc5_)
               {
                  _loc6_ = Boolean(emissions) && emissions.length > 0 && emissions[0] != null;
                  switch(this._emitAt)
                  {
                     case "Target":
                        if(!_loc6_ && param2 is PhysicsEmissionGameObject)
                        {
                           _loc4_.emission = this.multipleEmissions(param2 as PhysicsEmissionGameObject,_loc5_);
                           break;
                        }
                     case "Followed":
                        _loc7_ = this.followedObject;
                        if(!_loc6_ && _loc7_ is PhysicsEmissionGameObject)
                        {
                           _loc4_.emission = this.multipleEmissions(_loc7_ as PhysicsEmissionGameObject,_loc5_);
                           break;
                        }
                     case "Self":
                     default:
                        _loc4_.emission = this.multipleEmissions(this,_loc5_);
                  }
               }
            }
            setEmissionsParams("SimpleScriptCompleted",true);
            MessageCenter.addListener("ActionResponse",this.actionHandler);
            if(!SimpleScriptManager.instance)
            {
               new SimpleScriptManager();
            }
            _loc8_ = SimpleScriptManager.instance.run(true,this,_loc4_);
            if(_loc8_)
            {
               this._scriptUniqueIds.push(_loc8_);
            }
            if(Boolean(this.singleTarget) && this._selectedTarget == null)
            {
               this._selectedTarget = param2;
            }
            LogUtils.log("Activated follower: " + shortName + " against target: " + param1.shortName + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
            _loc9_ = param1;
            this._activationCooldownList[_loc9_._uniqueId] = this._activationCooldownOriginal;
            this.updateActivations();
         }
      }
      
      private function getActivationLocation(param1:PhysicsGameObject) : Vec2
      {
         var _loc2_:PhysicsGameObject = null;
         switch(this._emitAt)
         {
            case "Target":
               if(Boolean(param1) && Boolean(param1.body))
               {
                  return param1.body.position.copy();
               }
            case "Followed":
               _loc2_ = this.followedObject;
               if(Boolean(_loc2_) && Boolean(_loc2_.body))
               {
                  return _loc2_.body.position.copy();
               }
            case "Self":
         }
         if(this.body)
         {
            return this.body.position.copy();
         }
         return null;
      }
      
      private function actionHandler(param1:ActionResponse) : void
      {
         var _loc2_:int = 0;
         if(param1.responseType == 55)
         {
            _loc2_ = int(this._scriptUniqueIds.indexOf((param1 as SimpleScriptResponse).scriptId));
            if(_loc2_ != -1)
            {
               this._scriptUniqueIds.splice(_loc2_,1);
               if(this._scriptUniqueIds.length <= 0)
               {
                  MessageCenter.addListener("ActionResponse",this.actionHandler);
               }
            }
         }
      }
      
      private function multipleEmissions(param1:PhysicsEmissionGameObject, param2:Vec2) : *
      {
         if(this._multipleEmissions)
         {
            return new EmissionSpawn(param1,param2,tag.findLatestPlayerTagger());
         }
         return param1;
      }
      
      private function getEmitAt(param1:PhysicsGameObject) : PhysicsGameObject
      {
         var _loc2_:PhysicsGameObject = null;
         switch(this._emitAt)
         {
            case "Target":
               if(param1)
               {
                  return param1;
               }
               LogUtils.log("No target physicsGameObject, falltrought",this,2,"Follower",false,false,true);
            case "Followed":
               _loc2_ = this.followedObject;
               if(_loc2_)
               {
                  return _loc2_;
               }
               LogUtils.log("No followed physicsGameObject, falltrought",this,2,"Follower",false,false,true);
               break;
            case "Self":
               break;
            default:
               if(this._emitAt != null)
               {
                  LogUtils.log("EmitAt: " + this._emitAt + "not specified",this,2,"Follower",true,true,true);
               }
               return this;
         }
         return this;
      }
      
      private function applyColorTransform2() : void
      {
         if(this._colorTransformFollower)
         {
            this.followedObject.applyColorTransform(COLOR_TRANSFORM_RESET);
            this.followedObject.applyColorTransform(this._colorTransformFollower);
         }
      }
      
      private function removeColorTransform() : void
      {
         this.followedObject.applyColorTransform(COLOR_TRANSFORM_RESET);
      }
      
      override public function get linearVelocity() : Vec2
      {
         var _loc1_:PhysicsGameObject = this.followedObject;
         if(_loc1_ && _loc1_.body && _loc1_.body.velocity && _loc1_.body.velocity.length != 0)
         {
            return _loc1_.body.velocity.copy();
         }
         if(_loc1_ && _loc1_.lastLinearVelocity && _loc1_.lastLinearVelocity.length != 0)
         {
            return _loc1_.lastLinearVelocity;
         }
         return body.velocity.copy();
      }
      
      public function resetLifeTime() : void
      {
         if(this._activations != this._activationsOriginal || this._duration != this._durationOriginal)
         {
            LogUtils.log("Resetting follower: " + shortName + " activations: " + this._activations + " to " + this._activationsOriginal + " duration: " + this._duration + " to " + this._durationOriginal + ", stepCount: " + (this.game as TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
         }
         this._activations = this._activationsOriginal;
         this._duration = this._durationOriginal;
      }
   }
}

