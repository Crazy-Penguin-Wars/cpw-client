package tuxwars.battle.gameobjects
{
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.missiles.*;
   import tuxwars.battle.weapons.*;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.utils.*;
   
   public class EmissionSpawn implements Emission, FiringDirection
   {
      private static const SPAWN:String = "_Spawn";
      
      private var _id:String;
      
      private var _uniqueId:String;
      
      private var _emissions:Array;
      
      private var _emissionData:Object;
      
      private var _emitLocation:Vec2;
      
      private var _location:Vec2;
      
      private var _locationOriginal:Vec2;
      
      private var _missileBoostingEmissions:Array;
      
      private var _explosionBoostingEmissions:Array;
      
      private var _playerBoosterStats:Stats;
      
      private var _tagger:Tagger;
      
      private var _playerAttackStat:Stat;
      
      private var _playerDefenceStat:Stat;
      
      private var _groupIndex:int;
      
      private var _explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper;
      
      private var _stats:Stats;
      
      private var _lastContactLocations:Vec2;
      
      private var _lastBodyLocation:Vec2;
      
      private var _lastLinearDirection:Vec2;
      
      private var _linearVelocity:Vec2;
      
      private var _lastLinearVelocity:Vec2;
      
      private var _explosionDirection:Vec2;
      
      private var _weapon:Weapon;
      
      private var emittingDone:Boolean;
      
      public function EmissionSpawn(param1:Emission, param2:Vec2, param3:Tagger)
      {
         var _loc4_:Missile = null;
         this._emissionData = {};
         super();
         if(param1.emissions == null)
         {
            LogUtils.log("No emissions in emission: " + param1.shortName,this,2,"Emission",true,false,false);
            return;
         }
         if(param2 == null)
         {
            LogUtils.log("No location for emission: " + param1.shortName,this,2,"Emission",true,false,false);
            return;
         }
         this._id = param1.id + "_Spawn";
         this._uniqueId = param1.uniqueId + "_Spawn" + UniqueCounters.next(this._id,"EmissionSpawn");
         this._emissions = param1.emissions.slice();
         this._location = param2.copy();
         this._locationOriginal = param2.copy();
         this._emitLocation = param1.emitLocation;
         EmitterUtils.copyParams(param1,this);
         if(param1 is Missile)
         {
            _loc4_ = param1 as Missile;
            if(_loc4_.lastContactLocations)
            {
               this._lastContactLocations = _loc4_.lastContactLocations.copy();
            }
            if(_loc4_.lastBodyLocations)
            {
               this._lastBodyLocation = _loc4_.lastBodyLocations.copy();
            }
            if(_loc4_.lastLinearDirection)
            {
               this._lastLinearDirection = _loc4_.lastLinearDirection.copy();
            }
            if(Boolean(_loc4_.body) && Boolean(_loc4_.linearVelocity))
            {
               this._linearVelocity = _loc4_.linearVelocity.copy();
            }
            if(_loc4_.lastLinearVelocity)
            {
               this._lastLinearVelocity = _loc4_.lastLinearVelocity.copy();
            }
            if(_loc4_.explosionDirection)
            {
               this._explosionDirection = _loc4_.explosionDirection.copy();
            }
         }
         else if(param1 is Weapon)
         {
            this._weapon = param1 as Weapon;
         }
         if(param1.getBoosterMissileEmissions())
         {
            this._missileBoostingEmissions = param1.getBoosterMissileEmissions().slice(0,param1.getBoosterMissileEmissions().length);
         }
         if(param1.getBoosterExplosionEmissions())
         {
            this._explosionBoostingEmissions = param1.getBoosterExplosionEmissions().slice(0,param1.getBoosterExplosionEmissions().length);
         }
         this.playerBoosterStats = param1.playerBoosterStats;
         this._playerAttackStat = !!param1.playerAttackValueStat ? param1.playerAttackValueStat.clone() : null;
         this._tagger = param3;
         this._stats = new Stats();
      }
      
      public function dispose() : void
      {
         if(this._stats)
         {
            this._stats.dispose();
         }
         this._stats = null;
         if(this._explosionPreCalculationsWrapper)
         {
            this._explosionPreCalculationsWrapper.dispose();
         }
         this._explosionPreCalculationsWrapper = null;
         this._playerAttackStat = null;
         this._playerDefenceStat = null;
         this._tagger = null;
         this._emissions = null;
         this._emissionData = {};
         this._location = null;
         this._missileBoostingEmissions = null;
         this._explosionBoostingEmissions = null;
         this._lastContactLocations = null;
         this._lastBodyLocation = null;
         this._lastLinearDirection = null;
         this._linearVelocity = null;
         this._lastLinearVelocity = null;
         this._explosionDirection = null;
         if(this._playerBoosterStats)
         {
            this._playerBoosterStats.dispose();
            this._playerBoosterStats = null;
         }
      }
      
      public function triggerEmission() : void
      {
         var _loc1_:* = undefined;
         MessageCenter.sendEvent(new EmissionMessage(this,this.tagger != null && this.tagger.gameObject != null ? (_loc1_ = this.tagger.gameObject, _loc1_._id) : null));
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get uniqueId() : String
      {
         return this._uniqueId;
      }
      
      public function get shortName() : String
      {
         return "(id:" + this.id + ")(uid:" + this.uniqueId + ")";
      }
      
      public function get emissions() : Array
      {
         return this._emissions;
      }
      
      public function setEmissionsParams(param1:String, param2:*) : void
      {
         this._emissionData[param1] = param2;
      }
      
      public function getEmissionsParams(param1:String) : *
      {
         return this._emissionData[param1];
      }
      
      public function hasEmissionsParams(param1:String) : Boolean
      {
         return Boolean(this._emissionData) && Boolean(this._emissionData.hasOwnProperty(param1));
      }
      
      public function setEmissionData(param1:EmissionReference, param2:String, param3:*) : void
      {
         if(this._emissionData[param1.id] == null)
         {
            this._emissionData[param1.id] = {};
         }
         this._emissionData[param1.id][param2] = param3;
      }
      
      public function getEmissionData(param1:EmissionReference, param2:String) : *
      {
         if(!this._emissionData || this._emissionData[param1.id] == null)
         {
            return null;
         }
         return this._emissionData[param1.id][param2];
      }
      
      public function hasEmissionData(param1:EmissionReference, param2:String) : Boolean
      {
         return this.hasEmissionsParams(param1.id) && Boolean(this._emissionData[param1.id].hasOwnProperty(param2));
      }
      
      public function setExplosionPrecalculationsWrapper(param1:ExplosionPreCalculationsWrapper) : void
      {
         this._explosionPreCalculationsWrapper = param1;
      }
      
      public function getExplosionPrecalculationsWrapper() : ExplosionPreCalculationsWrapper
      {
         return this._explosionPreCalculationsWrapper;
      }
      
      public function get tagger() : Tagger
      {
         return this._tagger;
      }
      
      public function set location(param1:Vec2) : void
      {
         this._location = param1;
      }
      
      public function get location() : Vec2
      {
         return this._location;
      }
      
      public function get emitLocation() : Vec2
      {
         return this._emitLocation;
      }
      
      public function set emitLocation(param1:Vec2) : void
      {
         this._emitLocation = param1;
      }
      
      public function updateEmitLocation() : void
      {
         if(this._weapon)
         {
            this._emitLocation = this._weapon.player.bodyLocation;
         }
      }
      
      public function get radius() : Number
      {
         return 0;
      }
      
      public function set playerAttackValueStat(param1:Stat) : void
      {
         this._playerAttackStat = param1;
      }
      
      public function get playerAttackValueStat() : Stat
      {
         return this._playerAttackStat;
      }
      
      public function set playerAttackValue(param1:int) : void
      {
         this._playerAttackStat = new Stat("Attackers_Stat",param1);
      }
      
      public function findStat(param1:String) : Stat
      {
         return this._stats.getStat(param1);
      }
      
      public function get groupIndex() : int
      {
         return this._groupIndex;
      }
      
      public function set groupIndexToFilter(param1:int) : void
      {
         this._groupIndex = param1;
      }
      
      public function set soundId(param1:String) : void
      {
      }
      
      public function playSound() : void
      {
      }
      
      public function playEndSound(param1:String) : void
      {
      }
      
      public function playLoopSound() : void
      {
      }
      
      public function readyToEmit() : Boolean
      {
         return this._emissions != null && this.emitLocation != null;
      }
      
      public function setEmittingDone() : void
      {
         this.dispose();
         if(this._explosionPreCalculationsWrapper)
         {
            this._explosionPreCalculationsWrapper.dispose();
            this._explosionPreCalculationsWrapper = null;
         }
         this._location = null;
         this.emittingDone = true;
         if(this._weapon)
         {
            this._weapon.setEmittingDone();
         }
      }
      
      public function isEmittingDone() : Boolean
      {
         return this.emittingDone;
      }
      
      public function isFinished() : Boolean
      {
         return this._emissions == null || this._location == null;
      }
      
      public function getBoosterMissileEmissions() : Array
      {
         return this._missileBoostingEmissions;
      }
      
      public function getBoosterExplosionEmissions() : Array
      {
         return this._explosionBoostingEmissions;
      }
      
      public function get lastContactLocations() : Vec2
      {
         return this._lastContactLocations;
      }
      
      public function toString() : String
      {
         return this.shortName;
      }
      
      public function get lastBodyLocations() : Vec2
      {
         return this._lastBodyLocation;
      }
      
      public function get lastLinearDirection() : Vec2
      {
         return this._lastLinearDirection;
      }
      
      public function get linearVelocity() : Vec2
      {
         return this._linearVelocity;
      }
      
      public function get lastLinearVelocity() : Vec2
      {
         return this._lastLinearVelocity;
      }
      
      public function get explosionDirection() : Vec2
      {
         return this._explosionDirection;
      }
      
      public function get locationOriginal() : Vec2
      {
         return this._locationOriginal;
      }
      
      public function set locationOriginal(param1:Vec2) : void
      {
         this._locationOriginal = param1;
      }
      
      public function getBody() : Body
      {
         return null;
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

