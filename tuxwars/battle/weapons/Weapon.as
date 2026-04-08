package tuxwars.battle.weapons
{
   import com.dchoc.avatar.WearableItem;
   import com.dchoc.avatar.paperdoll.*;
   import com.dchoc.events.DCLoadingEvent;
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.messages.*;
   import com.dchoc.states.*;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import nape.geom.*;
   import nape.shape.*;
   import tuxwars.battle.avatar.TuxAvatar;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.input.*;
   import tuxwars.battle.states.weapon.*;
   import tuxwars.data.*;
   import tuxwars.items.definitions.WeaponDef;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.utils.*;
   
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
      
      public function Weapon(param1:WeaponDef)
      {
         super({
            "swf":param1.graphics.swf,
            "export":param1.graphics.export,
            "wearableSlot":8,
            "id":param1.id,
            "name":param1.name
         });
         this._uniqueId = "W" + UniqueCounters.next(id,"Weapon");
         this._animationType = param1.animationType;
         this._emissions = param1.emissions.slice();
         this._targeting = param1.targeting;
         this._allowRotation = param1.allowRotation;
         this._bodyPart = new BodyPart("tool",export);
         this._weaponControls = new WeaponControls(this);
         this._emittingDone = false;
         this._stats = new Stats();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._bodyPart = null;
         this._weaponControls.dispose();
         this._weaponControls = null;
         if(this._playerBoosterStats)
         {
            this._playerBoosterStats.dispose();
            this._playerBoosterStats = null;
         }
         this.stateMachine.dispose();
      }
      
      public function get bodyPart() : BodyPart
      {
         return this._bodyPart;
      }
      
      public function get controls() : WeaponControls
      {
         return this._weaponControls;
      }
      
      public function get allowRotation() : Boolean
      {
         return this._allowRotation;
      }
      
      public function get animationType() : String
      {
         return this._animationType;
      }
      
      public function get state() : State
      {
         return this.stateMachine.state;
      }
      
      public function changeState(param1:State, param2:Boolean = false) : void
      {
         this.stateMachine.changeState(param1,param2);
      }
      
      public function exitCurrentState(param1:Boolean = false) : void
      {
         this.stateMachine.exitCurrentState(param1);
      }
      
      public function get player() : PlayerGameObject
      {
         return this._player;
      }
      
      public function set player(param1:PlayerGameObject) : void
      {
         this._player = param1;
      }
      
      public function get emissions() : Array
      {
         return this._emissions;
      }
      
      public function setEmission(param1:EmissionReference) : void
      {
         this._emissions.push(param1);
      }
      
      public function setBoosterMissileEmissions(param1:EmissionReference) : void
      {
         if(!this._boosterMissileEmissions)
         {
            this._boosterMissileEmissions = [];
         }
         this._boosterMissileEmissions.push(param1);
      }
      
      public function setBoosterExplosionEmissions(param1:EmissionReference) : void
      {
         if(!this._boosterExplosionEmissions)
         {
            this._boosterExplosionEmissions = [];
         }
         this._boosterExplosionEmissions.push(param1);
      }
      
      public function getBoosterMissileEmissions() : Array
      {
         return this._boosterMissileEmissions;
      }
      
      public function getBoosterExplosionEmissions() : Array
      {
         return this._boosterExplosionEmissions;
      }
      
      public function get tagger() : Tagger
      {
         return new Tagger(this.player);
      }
      
      public function get location() : Vec2
      {
         return this._fireLocation != null ? this._fireLocation : this.player.bodyLocation;
      }
      
      public function set location(param1:Vec2) : void
      {
         if(this.locationOriginal == null && param1 != null)
         {
            this.locationOriginal = param1.copy();
         }
         this._fireLocation = param1;
      }
      
      public function hasEmitLocation() : Boolean
      {
         return this._emitLocation != null;
      }
      
      public function get emitLocation() : Vec2
      {
         var _loc1_:PlayerGameObject = null;
         var _loc2_:PlayerGameObject = null;
         if(this._emitLocation)
         {
            return this._emitLocation;
         }
         if(this.player != null)
         {
            if(this.player.body != null)
            {
               return this.player.bodyLocation.copy();
            }
            _loc1_ = this.player;
            _loc2_ = this.player;
            return new Vec2((!!_loc1_.graphics ? _loc1_._displayObject.getChildByName(_loc1_.graphics.export) : null).x,(!!_loc2_.graphics ? _loc2_._displayObject.getChildByName(_loc2_.graphics.export) : null).y);
         }
         return null;
      }
      
      public function set emitLocation(param1:Vec2) : void
      {
         this._emitLocation = param1;
      }
      
      public function get playerAttackValueStat() : Stat
      {
         if(this.player)
         {
            return this.player.attack.clone();
         }
         if(!this._stats.hasStat("Attackers_Stat"))
         {
            this._stats.create("Attackers_Stat",null,0);
         }
         return this._stats.getStat("Attackers_Stat");
      }
      
      public function set playerAttackValue(param1:int) : void
      {
         if(this._stats.hasStat("Attackers_Stat"))
         {
            this._stats.removeStat("Attackers_Stat",this._stats.getStat("Attackers_Stat"));
         }
         this._stats.create("Attackers_Stat",null,param1);
      }
      
      public function get radius() : Number
      {
         return Circle(this.player.body.shapes.at(0)).radius;
      }
      
      public function get weaponAngle() : Number
      {
         return this._weaponAngle;
      }
      
      public function isDrawingWeapon() : Boolean
      {
         return this.state is WeaponDrawState;
      }
      
      public function isAiming() : Boolean
      {
         return this.state is WeaponAimState;
      }
      
      public function logicUpdate(param1:int) : void
      {
         this.stateMachine.logicUpdate(param1);
      }
      
      public function aim(param1:Vec2) : void
      {
         var _loc5_:Config = null;
         var _loc6_:Config = null;
         var _loc2_:Vec2 = null;
         var _loc3_:Vec2 = null;
         var _loc4_:Number = Number(NaN);
         if(!this.isDrawingWeapon())
         {
            if(this.weaponClip)
            {
               this._weaponControls.updateAiming(param1.copy());
               _loc2_ = this.player.direction == 1 ? (_loc5_ = Config, Config.VEC_RIGHT.copy()) : (_loc6_ = Config, Config.VEC_LEFT.copy());
               _loc3_ = param1.copy();
               if(_loc3_.length != 0)
               {
                  _loc3_.normalise();
               }
               _loc4_ = Number(MathUtils.radiansToDegrees(Math.acos(_loc3_.dot(_loc2_))));
               this._weaponAngle = _loc3_.y >= 0 ? _loc4_ : -_loc4_;
               if(this._allowRotation)
               {
                  this.weaponClip.rotation = this._weaponAngle;
               }
            }
         }
      }
      
      public function get weaponClip() : MovieClip
      {
         var _loc1_:Array = this.getWeaponClipFromAvatar();
         if(!_loc1_ || _loc1_.length == 0)
         {
            LogUtils.log("Player doesn\'t have a weapon in tools layer.","Weapon",3,"Weapon",false);
         }
         var _loc2_:MovieClip = Boolean(_loc1_) && _loc1_.length > 0 ? _loc1_[0] : null;
         if(!_loc2_)
         {
            LogUtils.log("Weapon Clip is null for weapon fired!",this,3,"Weapon",false);
         }
         return _loc2_;
      }
      
      private function getWeaponClipFromAvatar() : Array
      {
         var _loc1_:TuxAvatar = null;
         var _loc2_:PaperDoll = null;
         if(this.player)
         {
            _loc1_ = this.player.avatar;
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
      
      override protected function displayObjectLoaded(param1:DCLoadingEvent) : void
      {
         super.displayObjectLoaded(param1);
         this._weaponAngle = this.weaponClip.rotation;
      }
      
      public function get targeting() : String
      {
         return this._targeting;
      }
      
      public function get uniqueId() : String
      {
         return this._uniqueId;
      }
      
      public function readyToEmit() : Boolean
      {
         return true;
      }
      
      public function setEmittingDone() : void
      {
         LogUtils.log("Setting emitting done for weapon: " + this.shortName,this,1,"Emission",false,false,false);
         if(this._explosionPreCalculationsWrapper)
         {
            this._explosionPreCalculationsWrapper.dispose();
            this._explosionPreCalculationsWrapper = null;
         }
         this._emittingDone = true;
      }
      
      public function isEmittingDone() : Boolean
      {
         return this._emittingDone;
      }
      
      public function isFinished() : Boolean
      {
         return this._emittingDone;
      }
      
      public function setEmissionsParams(param1:String, param2:*) : void
      {
         this.emissionData[param1] = param2;
      }
      
      public function getEmissionsParams(param1:String) : *
      {
         return this.emissionData[param1];
      }
      
      public function hasEmissionsParams(param1:String) : Boolean
      {
         return Boolean(this.emissionData) && Boolean(this.emissionData.hasOwnProperty(param1));
      }
      
      public function setEmissionData(param1:EmissionReference, param2:String, param3:*) : void
      {
         if(this.emissionData[param1.id] == null)
         {
            this.emissionData[param1.id] = {};
         }
         this.emissionData[param1.id][param2] = param3;
      }
      
      public function getEmissionData(param1:EmissionReference, param2:String) : *
      {
         if(!this.emissionData || this.emissionData[param1.id] == null)
         {
            return null;
         }
         return this.emissionData[param1.id][param2];
      }
      
      public function hasEmissionData(param1:EmissionReference, param2:String) : Boolean
      {
         return this.hasEmissionsParams(param1.id) && Boolean(this.emissionData[param1.id].hasOwnProperty(param2));
      }
      
      public function setExplosionPrecalculationsWrapper(param1:ExplosionPreCalculationsWrapper) : void
      {
         this._explosionPreCalculationsWrapper = param1;
      }
      
      public function getExplosionPrecalculationsWrapper() : ExplosionPreCalculationsWrapper
      {
         return this._explosionPreCalculationsWrapper;
      }
      
      public function get stats() : Stats
      {
         return this._stats;
      }
      
      public function findStat(param1:String) : Stat
      {
         return this._stats.getStat(param1);
      }
      
      public function set soundId(param1:String) : void
      {
         this._soundId = param1;
         this.playSound();
      }
      
      public function playSound() : void
      {
         MessageCenter.sendEvent(new SoundMessage("PlaySound",this._soundId));
      }
      
      public function playEndSound(param1:String) : void
      {
         MessageCenter.sendEvent(new SoundMessage("EndSound",param1));
      }
      
      public function playLoopSound() : void
      {
         MessageCenter.sendEvent(new SoundMessage("LoopSound",this._soundId));
      }
      
      public function triggerEmission() : void
      {
         var _loc1_:PlayerGameObject = this.player;
         MessageCenter.sendEvent(new EmissionMessage(this,_loc1_._id));
      }
      
      public function get shortName() : String
      {
         return name + " (id:" + id + ")(uid:" + this.uniqueId + ")";
      }
      
      public function toString() : String
      {
         return this.shortName;
      }
      
      public function get locationOriginal() : Vec2
      {
         return this._fireLocationOriginal;
      }
      
      public function set locationOriginal(param1:Vec2) : void
      {
         this._fireLocationOriginal = param1;
      }
      
      public function set playerBoosterStats(param1:Stats) : void
      {
         this._playerBoosterStats = Stats.copyStats(param1,this._playerBoosterStats);
      }
      
      public function get playerBoosterStats() : Stats
      {
         return this._playerBoosterStats;
      }
   }
}

