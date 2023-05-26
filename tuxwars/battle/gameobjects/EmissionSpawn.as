package tuxwars.battle.gameobjects
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.LogUtils;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.emitters.EmitterUtils;
   import tuxwars.battle.emitters.ExplosionPreCalculationsWrapper;
   import tuxwars.battle.emitters.FiringDirection;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.missiles.Missile;
   import tuxwars.battle.weapons.Weapon;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.utils.UniqueCounters;
   
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
      
      public function EmissionSpawn(emission:Emission, location:Vec2, tagger:Tagger)
      {
         var _loc4_:* = null;
         _emissionData = {};
         super();
         if(emission.emissions == null)
         {
            LogUtils.log("No emissions in emission: " + emission.shortName,this,2,"Emission",true,false,false);
            return;
         }
         if(location == null)
         {
            LogUtils.log("No location for emission: " + emission.shortName,this,2,"Emission",true,false,false);
            return;
         }
         _id = emission.id + "_Spawn";
         _uniqueId = emission.uniqueId + "_Spawn" + UniqueCounters.next(_id,"EmissionSpawn");
         _emissions = emission.emissions.slice();
         _location = location.copy();
         _locationOriginal = location.copy();
         _emitLocation = emission.emitLocation;
         EmitterUtils.copyParams(emission,this);
         if(emission is Missile)
         {
            _loc4_ = emission as Missile;
            if(_loc4_.lastContactLocations)
            {
               _lastContactLocations = _loc4_.lastContactLocations.copy();
            }
            if(_loc4_.lastBodyLocations)
            {
               _lastBodyLocation = _loc4_.lastBodyLocations.copy();
            }
            if(_loc4_.lastLinearDirection)
            {
               _lastLinearDirection = _loc4_.lastLinearDirection.copy();
            }
            if(_loc4_.body && _loc4_.linearVelocity)
            {
               _linearVelocity = _loc4_.linearVelocity.copy();
            }
            if(_loc4_.lastLinearVelocity)
            {
               _lastLinearVelocity = _loc4_.lastLinearVelocity.copy();
            }
            if(_loc4_.explosionDirection)
            {
               _explosionDirection = _loc4_.explosionDirection.copy();
            }
         }
         else if(emission is Weapon)
         {
            _weapon = emission as Weapon;
         }
         if(emission.getBoosterMissileEmissions())
         {
            _missileBoostingEmissions = emission.getBoosterMissileEmissions().slice(0,emission.getBoosterMissileEmissions().length);
         }
         if(emission.getBoosterExplosionEmissions())
         {
            _explosionBoostingEmissions = emission.getBoosterExplosionEmissions().slice(0,emission.getBoosterExplosionEmissions().length);
         }
         playerBoosterStats = emission.playerBoosterStats;
         _playerAttackStat = !!emission.playerAttackValueStat ? emission.playerAttackValueStat.clone() : null;
         _tagger = tagger;
         _stats = new Stats();
      }
      
      public function dispose() : void
      {
         if(_stats)
         {
            _stats.dispose();
         }
         _stats = null;
         if(_explosionPreCalculationsWrapper)
         {
            _explosionPreCalculationsWrapper.dispose();
         }
         _explosionPreCalculationsWrapper = null;
         _playerAttackStat = null;
         _playerDefenceStat = null;
         _tagger = null;
         _emissions = null;
         _emissionData = {};
         _location = null;
         _missileBoostingEmissions = null;
         _explosionBoostingEmissions = null;
         _lastContactLocations = null;
         _lastBodyLocation = null;
         _lastLinearDirection = null;
         _linearVelocity = null;
         _lastLinearVelocity = null;
         _explosionDirection = null;
         if(_playerBoosterStats)
         {
            _playerBoosterStats.dispose();
            _playerBoosterStats = null;
         }
      }
      
      public function triggerEmission() : void
      {
         var _loc1_:*;
         MessageCenter.sendEvent(new EmissionMessage(this,tagger != null && tagger.gameObject != null ? (_loc1_ = tagger.gameObject, _loc1_._id) : null));
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get uniqueId() : String
      {
         return _uniqueId;
      }
      
      public function get shortName() : String
      {
         return "(id:" + id + ")(uid:" + uniqueId + ")";
      }
      
      public function get emissions() : Array
      {
         return _emissions;
      }
      
      public function setEmissionsParams(key:String, value:*) : void
      {
         _emissionData[key] = value;
      }
      
      public function getEmissionsParams(key:String) : *
      {
         return _emissionData[key];
      }
      
      public function hasEmissionsParams(key:String) : Boolean
      {
         return _emissionData && _emissionData.hasOwnProperty(key);
      }
      
      public function setEmissionData(emit:EmissionReference, key:String, value:*) : void
      {
         if(_emissionData[emit.id] == null)
         {
            _emissionData[emit.id] = {};
         }
         _emissionData[emit.id][key] = value;
      }
      
      public function getEmissionData(emit:EmissionReference, key:String) : *
      {
         if(!_emissionData || _emissionData[emit.id] == null)
         {
            return null;
         }
         return _emissionData[emit.id][key];
      }
      
      public function hasEmissionData(emit:EmissionReference, key:String) : Boolean
      {
         return hasEmissionsParams(emit.id) && _emissionData[emit.id].hasOwnProperty(key);
      }
      
      public function setExplosionPrecalculationsWrapper(explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper) : void
      {
         _explosionPreCalculationsWrapper = explosionPreCalculationsWrapper;
      }
      
      public function getExplosionPrecalculationsWrapper() : ExplosionPreCalculationsWrapper
      {
         return _explosionPreCalculationsWrapper;
      }
      
      public function get tagger() : Tagger
      {
         return _tagger;
      }
      
      public function set location(p:Vec2) : void
      {
         _location = p;
      }
      
      public function get location() : Vec2
      {
         return _location;
      }
      
      public function get emitLocation() : Vec2
      {
         return _emitLocation;
      }
      
      public function set emitLocation(value:Vec2) : void
      {
         _emitLocation = value;
      }
      
      public function updateEmitLocation() : void
      {
         if(_weapon)
         {
            _emitLocation = _weapon.player.bodyLocation;
         }
      }
      
      public function get radius() : Number
      {
         return 0;
      }
      
      public function set playerAttackValueStat(stat:Stat) : void
      {
         _playerAttackStat = stat;
      }
      
      public function get playerAttackValueStat() : Stat
      {
         return _playerAttackStat;
      }
      
      public function set playerAttackValue(value:int) : void
      {
         _playerAttackStat = new Stat("Attackers_Stat",value);
      }
      
      public function findStat(name:String) : Stat
      {
         return _stats.getStat(name);
      }
      
      public function get groupIndex() : int
      {
         return _groupIndex;
      }
      
      public function set groupIndexToFilter(value:int) : void
      {
         _groupIndex = value;
      }
      
      public function set soundId(value:String) : void
      {
      }
      
      public function playSound() : void
      {
      }
      
      public function playEndSound(value:String) : void
      {
      }
      
      public function playLoopSound() : void
      {
      }
      
      public function readyToEmit() : Boolean
      {
         return _emissions != null && emitLocation != null;
      }
      
      public function setEmittingDone() : void
      {
         dispose();
         if(_explosionPreCalculationsWrapper)
         {
            _explosionPreCalculationsWrapper.dispose();
            _explosionPreCalculationsWrapper = null;
         }
         _location = null;
         emittingDone = true;
         if(_weapon)
         {
            _weapon.setEmittingDone();
         }
      }
      
      public function isEmittingDone() : Boolean
      {
         return emittingDone;
      }
      
      public function isFinished() : Boolean
      {
         return _emissions == null || _location == null;
      }
      
      public function getBoosterMissileEmissions() : Array
      {
         return _missileBoostingEmissions;
      }
      
      public function getBoosterExplosionEmissions() : Array
      {
         return _explosionBoostingEmissions;
      }
      
      public function get lastContactLocations() : Vec2
      {
         return _lastContactLocations;
      }
      
      public function toString() : String
      {
         return shortName;
      }
      
      public function get lastBodyLocations() : Vec2
      {
         return _lastBodyLocation;
      }
      
      public function get lastLinearDirection() : Vec2
      {
         return _lastLinearDirection;
      }
      
      public function get linearVelocity() : Vec2
      {
         return _linearVelocity;
      }
      
      public function get lastLinearVelocity() : Vec2
      {
         return _lastLinearVelocity;
      }
      
      public function get explosionDirection() : Vec2
      {
         return _explosionDirection;
      }
      
      public function get locationOriginal() : Vec2
      {
         return _locationOriginal;
      }
      
      public function set locationOriginal(value:Vec2) : void
      {
         _locationOriginal = value;
      }
      
      public function getBody() : Body
      {
         return null;
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
