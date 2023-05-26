package tuxwars.battle.gameobjects
{
   import com.citrusengine.physics.PhysicsCollisionCategories;
   import com.dchoc.game.DCGame;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   import nape.constraint.Constraint;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.InteractionFilter;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.emitters.EmitterUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.net.responses.ActionResponse;
   import tuxwars.battle.net.responses.SimpleScriptResponse;
   import tuxwars.battle.simplescript.SimpleScriptManager;
   import tuxwars.battle.simplescript.SimpleScriptParams;
   import tuxwars.items.Equippable;
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
      
      private const _activationCooldownList:Dictionary = new Dictionary(true);
      
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
      
      private const _scriptUniqueIds:Array = [];
      
      public function Follower(def:FollowerDef, game:DCGame)
      {
         super(def,game);
         _type = def.type;
         _emitAt = def.emitAt;
         _activations = def.activations;
         _activationsOriginal = def.activations;
         _isActivationsUnlimited = _activations == 0;
         _duration = def.duration;
         _durationOriginal = def.duration;
         _activateIn = def.activateIn;
         _multipleEmissions = def.multipleEmissions;
         _isDurationUnlimited = _duration == 0;
         _activationCooldownOriginal = def.activationCooldown;
         _affectedObjects = def.affectedObjects;
         _applyToObjects = def.applyToObjects;
         _triggers = !!def.triggers ? def.triggers : [];
         _target = def.target;
         _targetSelection = def.targetSelection;
         allowDisplayObjectRotation = false;
         playCollisionSounds = false;
         setCollisionFilterValues(PhysicsCollisionCategories.Get("FOLLOWER"),EmitterUtils.getBitsFor(def.affectedObjects));
         var _loc4_:StatBonusReference = def.statBonuses;
         if(_loc4_ != null)
         {
            _statBonuses = new Stats();
            for each(var s in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               if(_loc4_.getStat(s))
               {
                  _statBonuses.setStat(s,_loc4_.getStat(s));
               }
            }
         }
         _colorReference = def.colorReference;
         if(_colorReference)
         {
            _colorTransformFollower = new ColorTransform(_colorReference.redMultiplier,_colorReference.greenMultiplier,_colorReference.blueMultiplier,_colorReference.alphaMultiplier,_colorReference.redOffset,_colorReference.greenOffset,_colorReference.blueOffset,_colorReference.alphaOffset);
         }
         body.mass = 1e-28;
      }
      
      public function init(followedObject:PhysicsGameObject, tagger:Tagger) : void
      {
         LogUtils.log("Setting follower: " + shortName + " on followed object: " + followedObject.shortName + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
         if(_statBonuses != null)
         {
            for each(var s in Equippable.EQUIPPABLE_BONUS_STATS)
            {
               followedObject.stats.addStat(s,_statBonuses.getStat(s),body);
            }
         }
         if(followedObject.followers)
         {
            followedObject.followers.push(this);
         }
         _followedObjectReal = followedObject;
         var _loc4_:InteractionFilter = followedObject.body.shapes.at(0).filter.copy();
         body.setShapeFilters(_loc4_);
         tag.add(tagger.gameObject);
         applyColorTransform();
         var _loc7_:SimpleScriptManager = SimpleScriptManager;
         if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
         {
            new tuxwars.battle.simplescript.SimpleScriptManager();
         }
         _joint = tuxwars.battle.simplescript.SimpleScriptManager._instance.runWithName(false,"AddJoint",[this,followedObject],new SimpleScriptParams());
         _joint.space = body.space;
      }
      
      override public function dispose() : void
      {
         LogUtils.log("Disposing follower: " + shortName + " on followed object: " + (!!followedObject ? followedObject.shortName : null) + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
         if(_joint)
         {
            _joint.active = false;
            _joint.space = null;
            _joint = null;
         }
         super.dispose();
         removeEffectsOnFollowedObject();
         _colorReference = null;
         if(_statBonuses != null)
         {
            _statBonuses.dispose();
         }
         _statBonuses = null;
         _followedObjectReal = null;
         _affectedObjects = null;
         _applyToObjects = null;
         _selectedTarget = null;
         _duration = 0;
         MessageCenter.removeListener("ActionResponse",actionHandler);
      }
      
      public function removeEffectsOnFollowedObject() : void
      {
         var _loc1_:int = 0;
         if(followedObject)
         {
            if(_statBonuses != null)
            {
               LogUtils.log("Removing follower: " + shortName + " stats from object: " + (!!followedObject ? followedObject.shortName : null) + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
               for each(var s in Equippable.EQUIPPABLE_BONUS_STATS)
               {
                  if(followedObject.stats)
                  {
                     followedObject.stats.removeStat(s,_statBonuses.getStat(s));
                  }
               }
            }
            removeColorTransform();
            if(followedObject.followers)
            {
               _loc1_ = followedObject.followers.indexOf(this);
               if(_loc1_ != -1)
               {
                  LogUtils.log("Remove follower: " + shortName + " from object: " + (!!followedObject ? followedObject.shortName : null) + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  followedObject.followers.splice(_loc1_,1);
               }
            }
         }
      }
      
      override public function markForRemoval() : void
      {
         if(_scriptUniqueIds.length > 0)
         {
            LogUtils.log("Waiting for server responses for scripts: " + _scriptUniqueIds.toString() + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
            return;
         }
         super.markForRemoval();
      }
      
      override public function physicsUpdate(deltaTime:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = undefined;
         super.physicsUpdate(deltaTime);
         if(!body)
         {
            return;
         }
         if(!this._markedForRemoval)
         {
            _loc3_ = followedObject;
            if(_loc3_ == null || !_loc3_.body)
            {
               LogUtils.log("Removing follower: " + shortName + " because nothing to follow, stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
               super.markForRemoval();
            }
            else if(_loc3_._hasHPs && _loc3_.isDeadHP() || _loc3_ is PlayerGameObject && ((_loc3_ as PlayerGameObject).isDead() || (_loc3_ as PlayerGameObject).isSpawning()))
            {
               if(_type != "StatusPermanent")
               {
                  if(_loc3_ is PlayerGameObject)
                  {
                     if(_scriptUniqueIds.length > 0)
                     {
                        return;
                     }
                     removeEffectsOnFollowedObject();
                  }
                  LogUtils.log("Removing follower: " + shortName + ", player: " + (_loc3_ as PlayerGameObject).shortName + " is dead, stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  super.markForRemoval();
               }
               if(_loc3_ is PlayerGameObject)
               {
                  (_loc3_ as PlayerGameObject).followerIdsAtDeath.push(this._id);
               }
            }
            if(this._markedForRemoval)
            {
               return;
            }
         }
         _activateIn -= deltaTime;
         if(_activationCooldownOriginal > 0)
         {
            for(var key in _activationCooldownList)
            {
               if(_activationCooldownList[key] >= 0)
               {
                  LogUtils.log("Updating follower: " + shortName + " activationCooldownList[ " + key + " ] from " + _activationCooldownList[key] + " by deltaTime: " + -deltaTime + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  _activationCooldownList[key] -= deltaTime;
               }
            }
         }
         if(triggerAt("Update"))
         {
            _loc4_ = getTargets();
            for each(var target in _loc4_)
            {
               possibleActivate(target);
            }
         }
         updateDuration(deltaTime);
         if(!this._markedForRemoval)
         {
            if(_scriptUniqueIds.length <= 0)
            {
               if(!hasDuration)
               {
                  LogUtils.log("Follower: " + shortName + " marked for removal, reason: Duration ended, stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  markForRemoval();
               }
               else if(!hasActivations)
               {
                  LogUtils.log("Follower: " + shortName + " marked for removal, reason: No more activations left, stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  markForRemoval();
               }
               else if(!hasFollowedObject)
               {
                  LogUtils.log("Follower: " + shortName + " marked for removal, reason: No object to follow, stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
                  markForRemoval();
               }
            }
         }
      }
      
      private function updateDuration(deltaTime:int) : void
      {
         if(!_isDurationUnlimited && _duration > 0)
         {
            _duration -= deltaTime;
            if(_duration <= 0)
            {
               LogUtils.log("Duration: " + _duration + ") elapsed follower: " + shortName + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
            }
         }
      }
      
      private function get hasDuration() : Boolean
      {
         return _duration > 0 || _isDurationUnlimited;
      }
      
      private function updateActivations() : void
      {
         if(!_isActivationsUnlimited && _activations > 0)
         {
            _activations -= 1;
            if(_activations <= 0)
            {
               if(_joint)
               {
                  _joint.active = false;
                  _joint.space = null;
                  _joint = null;
               }
               LogUtils.log("Activations: " + _activations + "  elapsed for follower: " + shortName + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
            }
         }
      }
      
      private function get hasActivations() : Boolean
      {
         return _activations > 0 || _isActivationsUnlimited;
      }
      
      private function getTargets() : Vector.<PhysicsGameObject>
      {
         var foundSelectedTarget:Boolean;
         var i:int;
         var target:PhysicsGameObject;
         var player:PlayerGameObject;
         var fo:PhysicsGameObject;
         var origin:Vec2;
         var d1:Vec2;
         var d2:Vec2;
         var str:String;
         var t:PhysicsGameObject;
         var random:int;
         var targets:Vector.<PhysicsGameObject> = new Vector.<PhysicsGameObject>();
         var bodyList:BodyList = body.interactingBodies();
         for(i = 0; i < bodyList.length; i++)
         {
            target = bodyList.at(i).userData.gameObject as PhysicsGameObject;
            if(target && target != this)
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
                  if((_selectedTarget == null || _selectedTarget == target) && targets.indexOf(target) == -1)
                  {
                     targets.push(target);
                  }
                  if(_selectedTarget == target)
                  {
                     foundSelectedTarget = true;
                     break;
                  }
               }
            }
         }
         if((_type == "Status" || _type == "StatusPermanent") && hasFollowedObject)
         {
            fo = followedObject;
            if(targets.indexOf(fo) == -1)
            {
               targets.push(fo);
            }
         }
         if(!foundSelectedTarget && _selectedTarget != null || _target == "SingleRandom")
         {
            _selectedTarget = null;
         }
         if(targets.length == 0)
         {
            return targets;
         }
         origin = this.body.position;
         d1 = Vec2.get();
         d2 = Vec2.get();
         targets.sort(function(obj1:PhysicsGameObject, obj2:PhysicsGameObject):int
         {
            var _loc4_:Vec2 = obj1.bodyLocation;
            var _loc3_:Vec2 = obj2.bodyLocation;
            d1.x = origin.x - _loc4_.x;
            d1.y = origin.y - _loc4_.y;
            d2.x = origin.x - _loc3_.x;
            d2.y = origin.y - _loc3_.y;
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
         if(singleTarget && targets.length > 1)
         {
            switch(_targetSelection)
            {
               case "Closest":
                  targets.splice(0,targets.length - 1);
                  break;
               case "Farthest":
                  targets.splice(1,targets.length - 1);
                  break;
               case "Random":
               default:
                  if(_targetSelection != "Random")
                  {
                     LogUtils.log("Follower with singleTarget has a targeting of :" + _targetSelection + " that is not specified, using random",this,0,"Follower",true,true,false);
                  }
                  LogUtils.log("Call to random getTargets()",this,0,"Random",false,false,false);
                  random = BattleManager.getRandom().integer(0,targets.length);
                  targets.splice(0,random);
                  targets.splice(random,targets.length - 1);
            }
         }
         return targets;
      }
      
      private function isActivated() : Boolean
      {
         return _activateIn <= 0;
      }
      
      private function triggerAt(value:String) : Boolean
      {
         return _triggers.indexOf(value) != -1 && isActivated();
      }
      
      public function get hasFollowedObject() : Boolean
      {
         var _loc1_:PhysicsGameObject = followedObject;
         return _loc1_ != null && !_loc2_._markedForRemoval;
      }
      
      public function get followedObject() : PhysicsGameObject
      {
         if(followedObjectReal is Follower)
         {
            return (followedObjectReal as Follower).followedObject;
         }
         return followedObjectReal;
      }
      
      public function get followedObjectReal() : PhysicsGameObject
      {
         if(_followedObjectReal != null && _loc1_._markedForRemoval)
         {
            return null;
         }
         return _followedObjectReal;
      }
      
      override public function handleBeginContact(otherBody:Body, arbiterList:ArbiterList) : void
      {
         if(!body || otherBody.userData.gameObject.isSensorEnabled)
         {
            return;
         }
         if(triggerAt("Enter"))
         {
            possibleActivate(otherBody.userData.gameObject as PhysicsGameObject);
         }
      }
      
      override public function handleEndContact(otherBody:Body, arbiterList:ArbiterList) : void
      {
         if(!body || otherBody.userData.gameObject.isSensorEnabled)
         {
            return;
         }
         if(triggerAt("Exit"))
         {
            possibleActivate(otherBody.userData.gameObject as PhysicsGameObject);
         }
      }
      
      private function get singleTarget() : Boolean
      {
         switch(_target)
         {
            case "Single":
               break;
            case "SingleRandom":
               break;
            case "All":
               return false;
            default:
               LogUtils.log("Unspecified target: " + _target,this,2,"Follower",true,true,false);
               return false;
         }
         return true;
      }
      
      private function possibleActivate(physicsGameObject:PhysicsGameObject) : void
      {
         if(physicsGameObject && isActivated() && hasDuration && hasActivations)
         {
            if(EmitterUtils.affectsObject(_affectedObjects,!!this.tag.findLatestPlayerTagger() ? this.tag.findLatestPlayerTagger().gameObject : null,physicsGameObject))
            {
               var _loc2_:* = physicsGameObject;
               if(!_activationCooldownList[_loc2_._uniqueId])
               {
                  selectTargetAndActivate(physicsGameObject);
               }
               else if(_activationCooldownOriginal == -1)
               {
                  var _loc3_:* = physicsGameObject;
                  if(_activationCooldownList[_loc3_._uniqueId] != -1)
                  {
                     selectTargetAndActivate(physicsGameObject);
                  }
               }
               else
               {
                  var _loc4_:* = physicsGameObject;
                  if(_activationCooldownList[_loc4_._uniqueId] <= 0)
                  {
                     selectTargetAndActivate(physicsGameObject);
                  }
               }
            }
         }
      }
      
      private function selectTargetAndActivate(physicsGameObject:PhysicsGameObject) : void
      {
         switch(_type)
         {
            case "Agressive":
               activate(physicsGameObject,physicsGameObject);
               break;
            case "Defencive":
            case "Status":
            case "StatusPermanent":
               activate(physicsGameObject,followedObject);
               break;
            case "Self":
               activate(physicsGameObject,this);
               break;
            default:
               if(_type != null)
               {
                  LogUtils.log("Type: " + _type + " not specified",this,2,"Follower",true,true,true);
               }
               activate(physicsGameObject,this);
         }
      }
      
      private function activate(originalTarget:PhysicsGameObject, target:PhysicsGameObject) : void
      {
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc6_:Boolean = false;
         var _loc8_:* = null;
         var _loc3_:* = null;
         if(target && target.body && (_selectedTarget == null || _selectedTarget == target) && isActivated())
         {
            _loc5_ = getEmitAt(target);
            if(_loc5_ && _loc5_.body)
            {
               LogUtils.log("Activated: " + shortName + " target: " + target + " emitAt: " + _loc5_,this,2,"Follower",false,false,false);
               _loc7_ = new SimpleScriptParams(target,_loc5_);
               _loc4_ = getActivationLocation(target);
               if(_loc4_)
               {
                  _loc6_ = emissions && emissions.length > 0 && emissions[0] != null;
                  switch(_emitAt)
                  {
                     case "Target":
                        if(!_loc6_ && target is PhysicsEmissionGameObject)
                        {
                           _loc7_.emission = multipleEmissions(target as PhysicsEmissionGameObject,_loc4_);
                           break;
                        }
                     case "Followed":
                        _loc8_ = followedObject;
                        if(!_loc6_ && _loc8_ is PhysicsEmissionGameObject)
                        {
                           _loc7_.emission = multipleEmissions(_loc8_ as PhysicsEmissionGameObject,_loc4_);
                           break;
                        }
                     case "Self":
                     default:
                        _loc7_.emission = multipleEmissions(this,_loc4_);
                  }
               }
            }
            setEmissionsParams("SimpleScriptCompleted",true);
            MessageCenter.addListener("ActionResponse",actionHandler);
            var _loc10_:SimpleScriptManager = SimpleScriptManager;
            if(!tuxwars.battle.simplescript.SimpleScriptManager._instance)
            {
               new tuxwars.battle.simplescript.SimpleScriptManager();
            }
            _loc3_ = tuxwars.battle.simplescript.SimpleScriptManager._instance.run(true,this,_loc7_);
            if(_loc3_)
            {
               _scriptUniqueIds.push(_loc3_);
            }
            if(singleTarget && _selectedTarget == null)
            {
               _selectedTarget = target;
            }
            LogUtils.log("Activated follower: " + shortName + " against target: " + originalTarget.shortName + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
            var _loc11_:* = originalTarget;
            _activationCooldownList[_loc11_._uniqueId] = _activationCooldownOriginal;
            updateActivations();
         }
      }
      
      private function getActivationLocation(target:PhysicsGameObject) : Vec2
      {
         var _loc2_:* = null;
         switch(_emitAt)
         {
            case "Target":
               if(target && target.body)
               {
                  return target.body.position.copy();
               }
            case "Followed":
               _loc2_ = followedObject;
               if(_loc2_ && _loc2_.body)
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
      
      private function actionHandler(response:ActionResponse) : void
      {
         var _loc2_:int = 0;
         if(response.responseType == 55)
         {
            _loc2_ = _scriptUniqueIds.indexOf((response as SimpleScriptResponse).scriptId);
            if(_loc2_ != -1)
            {
               _scriptUniqueIds.splice(_loc2_,1);
               if(_scriptUniqueIds.length <= 0)
               {
                  MessageCenter.addListener("ActionResponse",actionHandler);
               }
            }
         }
      }
      
      private function multipleEmissions(target:PhysicsEmissionGameObject, location:Vec2) : *
      {
         if(_multipleEmissions)
         {
            return new EmissionSpawn(target,location,tag.findLatestPlayerTagger());
         }
         return target;
      }
      
      private function getEmitAt(physicsGameObject:PhysicsGameObject) : PhysicsGameObject
      {
         var _loc2_:* = null;
         switch(_emitAt)
         {
            case "Target":
               if(physicsGameObject)
               {
                  return physicsGameObject;
               }
               LogUtils.log("No target physicsGameObject, falltrought",this,2,"Follower",false,false,true);
            case "Followed":
               _loc2_ = followedObject;
               if(_loc2_)
               {
                  return _loc2_;
               }
               LogUtils.log("No followed physicsGameObject, falltrought",this,2,"Follower",false,false,true);
               break;
            case "Self":
               break;
            default:
               if(_emitAt != null)
               {
                  LogUtils.log("EmitAt: " + _emitAt + "not specified",this,2,"Follower",true,true,true);
               }
               return this;
         }
         return this;
      }
      
      private function applyColorTransform() : void
      {
         if(_colorTransformFollower)
         {
            followedObject.applyColorTransform(COLOR_TRANSFORM_RESET);
            followedObject.applyColorTransform(_colorTransformFollower);
         }
      }
      
      private function removeColorTransform() : void
      {
         followedObject.applyColorTransform(COLOR_TRANSFORM_RESET);
      }
      
      override public function get linearVelocity() : Vec2
      {
         var _loc1_:PhysicsGameObject = followedObject;
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
         if(_activations != _activationsOriginal || _duration != _durationOriginal)
         {
            LogUtils.log("Resetting follower: " + shortName + " activations: " + _activations + " to " + _activationsOriginal + " duration: " + _duration + " to " + _durationOriginal + ", stepCount: " + (this.game as tuxwars.TuxWarsGame).tuxWorld.physicsWorld.stepCount,this,0,"Follower",false,false,false);
         }
         _activations = _activationsOriginal;
         _duration = _durationOriginal;
      }
   }
}
