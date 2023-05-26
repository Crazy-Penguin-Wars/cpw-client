package tuxwars.battle.weapons
{
   import com.dchoc.avatar.WearableItem;
   import com.dchoc.avatar.paperdoll.BodyPart;
   import com.dchoc.avatar.paperdoll.ClothesSlot;
   import com.dchoc.avatar.paperdoll.PaperDoll;
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.states.IStateMachine;
   import com.dchoc.states.State;
   import com.dchoc.states.StateMachine;
   import com.dchoc.utils.LogUtils;
   import com.dchoc.utils.MathUtils;
   import flash.display.MovieClip;
   import nape.geom.Vec2;
   import nape.shape.Circle;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.emitters.ExplosionPreCalculationsWrapper;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.input.WeaponControls;
   import tuxwars.battle.states.weapon.WeaponAimState;
   import tuxwars.battle.states.weapon.WeaponDrawState;
   import tuxwars.data.SoundMessage;
   import tuxwars.items.definitions.WeaponDef;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.utils.UniqueCounters;
   
   public class Weapon extends WearableItem implements IStateMachine, Emission
   {
      
      public static const DRAW_LABEL:String = "draw";
      
      public static const AIM_LABEL:String = "aim";
      
      public static const FIRE_LABEL:String = "fire";
      
      public static const OUT_LABEL:String = "out";
       
      
      private const stateMachine:StateMachine = new StateMachine();
      
      private const emissionData:Object = {};
      
      private var _player:PlayerGameObject;
      
      private var _weaponAngle:Number = 0;
      
      private var _weaponControls:WeaponControls;
      
      private var _animationType:String;
      
      private var _emissions:Array;
      
      private var _boosterMissileEmissions:Array;
      
      private var _boosterExplosionEmissions:Array;
      
      private var _playerBoosterStats:Stats;
      
      private var _targeting:String;
      
      private var _bodyPart:BodyPart;
      
      private var _allowRotation:Boolean;
      
      private var _emittingDone:Boolean;
      
      private var _soundId:String;
      
      private var _explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper;
      
      private var _stats:Stats;
      
      private var _fireLocation:Vec2;
      
      private var _fireLocationOriginal:Vec2;
      
      private var _emitLocation:Vec2;
      
      private var _uniqueId:String;
      
      public function Weapon(weaponData:WeaponDef)
      {
         super({
            "swf":weaponData.graphics.swf,
            "export":weaponData.graphics.export,
            "wearableSlot":8,
            "id":weaponData.id,
            "name":weaponData.name
         });
         _uniqueId = "W" + UniqueCounters.next(id,"Weapon");
         _animationType = weaponData.animationType;
         _emissions = weaponData.emissions.slice();
         _targeting = weaponData.targeting;
         _allowRotation = weaponData.allowRotation;
         _bodyPart = new BodyPart("tool",export);
         _weaponControls = new WeaponControls(this);
         _emittingDone = false;
         _stats = new Stats();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _bodyPart = null;
         _weaponControls.dispose();
         _weaponControls = null;
         if(_playerBoosterStats)
         {
            _playerBoosterStats.dispose();
            _playerBoosterStats = null;
         }
         stateMachine.dispose();
      }
      
      public function get bodyPart() : BodyPart
      {
         return _bodyPart;
      }
      
      public function get controls() : WeaponControls
      {
         return _weaponControls;
      }
      
      public function get allowRotation() : Boolean
      {
         return _allowRotation;
      }
      
      public function get animationType() : String
      {
         return _animationType;
      }
      
      public function get state() : State
      {
         return stateMachine.state;
      }
      
      public function changeState(state:State, immediately:Boolean = false) : void
      {
         stateMachine.changeState(state,immediately);
      }
      
      public function exitCurrentState(clearQueue:Boolean = false) : void
      {
         stateMachine.exitCurrentState(clearQueue);
      }
      
      public function get player() : PlayerGameObject
      {
         return _player;
      }
      
      public function set player(value:PlayerGameObject) : void
      {
         _player = value;
      }
      
      public function get emissions() : Array
      {
         return _emissions;
      }
      
      public function setEmission(newEmission:EmissionReference) : void
      {
         _emissions.push(newEmission);
      }
      
      public function setBoosterMissileEmissions(emissionRef:EmissionReference) : void
      {
         if(!_boosterMissileEmissions)
         {
            _boosterMissileEmissions = [];
         }
         _boosterMissileEmissions.push(emissionRef);
      }
      
      public function setBoosterExplosionEmissions(emissionRef:EmissionReference) : void
      {
         if(!_boosterExplosionEmissions)
         {
            _boosterExplosionEmissions = [];
         }
         _boosterExplosionEmissions.push(emissionRef);
      }
      
      public function getBoosterMissileEmissions() : Array
      {
         return _boosterMissileEmissions;
      }
      
      public function getBoosterExplosionEmissions() : Array
      {
         return _boosterExplosionEmissions;
      }
      
      public function get tagger() : Tagger
      {
         return new Tagger(player);
      }
      
      public function get location() : Vec2
      {
         return _fireLocation != null ? _fireLocation : player.bodyLocation;
      }
      
      public function set location(p:Vec2) : void
      {
         if(locationOriginal == null && p != null)
         {
            locationOriginal = p.copy();
         }
         _fireLocation = p;
      }
      
      public function hasEmitLocation() : Boolean
      {
         return _emitLocation != null;
      }
      
      public function get emitLocation() : Vec2
      {
         if(_emitLocation)
         {
            return _emitLocation;
         }
         if(player != null)
         {
            if(player.body != null)
            {
               return player.bodyLocation.copy();
            }
            var _loc1_:PlayerGameObject = player;
            var _loc2_:PlayerGameObject = player;
            return new Vec2((!!_loc1_.graphics ? _loc1_._displayObject.getChildByName(_loc1_.graphics.export) : null).x,(!!_loc2_.graphics ? _loc2_._displayObject.getChildByName(_loc2_.graphics.export) : null).y);
         }
         return null;
      }
      
      public function set emitLocation(value:Vec2) : void
      {
         _emitLocation = value;
      }
      
      public function get playerAttackValueStat() : Stat
      {
         if(player)
         {
            return player.attack.clone();
         }
         if(!_stats.hasStat("Attackers_Stat"))
         {
            _stats.create("Attackers_Stat",null,0);
         }
         return _stats.getStat("Attackers_Stat");
      }
      
      public function set playerAttackValue(value:int) : void
      {
         if(_stats.hasStat("Attackers_Stat"))
         {
            _stats.removeStat("Attackers_Stat",_stats.getStat("Attackers_Stat"));
         }
         _stats.create("Attackers_Stat",null,value);
      }
      
      public function get radius() : Number
      {
         return Circle(player.body.shapes.at(0)).radius;
      }
      
      public function get weaponAngle() : Number
      {
         return _weaponAngle;
      }
      
      public function isDrawingWeapon() : Boolean
      {
         return state is WeaponDrawState;
      }
      
      public function isAiming() : Boolean
      {
         return state is WeaponAimState;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         stateMachine.logicUpdate(deltaTime);
      }
      
      public function aim(vec:Vec2) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         if(!isDrawingWeapon())
         {
            if(weaponClip)
            {
               _weaponControls.updateAiming(vec.copy());
               var _loc5_:Config;
               var _loc6_:Config;
               _loc2_ = player.direction == 1 ? (_loc5_ = Config, Config.VEC_RIGHT.copy()) : (_loc6_ = Config, Config.VEC_LEFT.copy());
               _loc3_ = vec.copy();
               if(_loc3_.length != 0)
               {
                  _loc3_.normalise();
               }
               _loc4_ = MathUtils.radiansToDegrees(Math.acos(_loc3_.dot(_loc2_)));
               _weaponAngle = _loc3_.y >= 0 ? _loc4_ : -_loc4_;
               if(_allowRotation)
               {
                  weaponClip.rotation = _weaponAngle;
               }
            }
         }
      }
      
      public function get weaponClip() : MovieClip
      {
         var _loc2_:Array = getWeaponClipFromAvatar();
         if(!_loc2_ || _loc2_.length == 0)
         {
            LogUtils.log("Player doesn\'t have a weapon in tools layer.","Weapon",3,"Weapon",false);
         }
         var _loc1_:MovieClip = _loc2_ && _loc2_.length > 0 ? _loc2_[0] : null;
         if(!_loc1_)
         {
            LogUtils.log("Weapon Clip is null for weapon fired!",this,3,"Weapon",false);
         }
         return _loc1_;
      }
      
      private function getWeaponClipFromAvatar() : Array
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         if(player)
         {
            _loc1_ = player.avatar;
            if(_loc1_)
            {
               _loc2_ = _loc1_.paperDoll;
               if(_loc2_)
               {
                  return _loc2_.getClothesInSlot(ClothesSlot.TOOL);
               }
               LogUtils.log("Avatar doesn\'t have paperdoll.","Weapon",3,"Weapon",false);
            }
            else
            {
               LogUtils.log("Player doesn\'t have avatar.","Weapon",3,"Weapon",false);
            }
         }
         else
         {
            LogUtils.log("Weapon doesn\'t have reference to player.","Weapon",3,"Weapon",false);
         }
         return null;
      }
      
      override protected function displayObjectLoaded(event:DCLoadingEvent) : void
      {
         super.displayObjectLoaded(event);
         _weaponAngle = weaponClip.rotation;
      }
      
      public function get targeting() : String
      {
         return _targeting;
      }
      
      public function get uniqueId() : String
      {
         return _uniqueId;
      }
      
      public function readyToEmit() : Boolean
      {
         return true;
      }
      
      public function setEmittingDone() : void
      {
         LogUtils.log("Setting emitting done for weapon: " + shortName,this,1,"Emission",false,false,false);
         if(_explosionPreCalculationsWrapper)
         {
            _explosionPreCalculationsWrapper.dispose();
            _explosionPreCalculationsWrapper = null;
         }
         _emittingDone = true;
      }
      
      public function isEmittingDone() : Boolean
      {
         return _emittingDone;
      }
      
      public function isFinished() : Boolean
      {
         return _emittingDone;
      }
      
      public function setEmissionsParams(key:String, value:*) : void
      {
         emissionData[key] = value;
      }
      
      public function getEmissionsParams(key:String) : *
      {
         return emissionData[key];
      }
      
      public function hasEmissionsParams(key:String) : Boolean
      {
         return emissionData && emissionData.hasOwnProperty(key);
      }
      
      public function setEmissionData(emit:EmissionReference, key:String, value:*) : void
      {
         if(emissionData[emit.id] == null)
         {
            emissionData[emit.id] = {};
         }
         emissionData[emit.id][key] = value;
      }
      
      public function getEmissionData(emit:EmissionReference, key:String) : *
      {
         if(!emissionData || emissionData[emit.id] == null)
         {
            return null;
         }
         return emissionData[emit.id][key];
      }
      
      public function hasEmissionData(emit:EmissionReference, key:String) : Boolean
      {
         return hasEmissionsParams(emit.id) && emissionData[emit.id].hasOwnProperty(key);
      }
      
      public function setExplosionPrecalculationsWrapper(explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper) : void
      {
         _explosionPreCalculationsWrapper = explosionPreCalculationsWrapper;
      }
      
      public function getExplosionPrecalculationsWrapper() : ExplosionPreCalculationsWrapper
      {
         return _explosionPreCalculationsWrapper;
      }
      
      public function get stats() : Stats
      {
         return _stats;
      }
      
      public function findStat(name:String) : Stat
      {
         return _stats.getStat(name);
      }
      
      public function set soundId(value:String) : void
      {
         _soundId = value;
         playSound();
      }
      
      public function playSound() : void
      {
         MessageCenter.sendEvent(new SoundMessage("PlaySound",_soundId));
      }
      
      public function playEndSound(value:String) : void
      {
         MessageCenter.sendEvent(new SoundMessage("EndSound",value));
      }
      
      public function playLoopSound() : void
      {
         MessageCenter.sendEvent(new SoundMessage("LoopSound",_soundId));
      }
      
      public function triggerEmission() : void
      {
         var _loc1_:PlayerGameObject = player;
         MessageCenter.sendEvent(new EmissionMessage(this,_loc1_._id));
      }
      
      public function get shortName() : String
      {
         return name + " (id:" + id + ")(uid:" + uniqueId + ")";
      }
      
      public function toString() : String
      {
         return shortName;
      }
      
      public function get locationOriginal() : Vec2
      {
         return _fireLocationOriginal;
      }
      
      public function set locationOriginal(value:Vec2) : void
      {
         _fireLocationOriginal = value;
      }
      
      public function set playerBoosterStats(stats:Stats) : void
      {
         _playerBoosterStats = Stats.copyStats(stats,_playerBoosterStats);
      }
      
      public function get playerBoosterStats() : Stats
      {
         return _playerBoosterStats;
      }
   }
}
