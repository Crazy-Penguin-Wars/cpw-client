package tuxwars.items
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.utils.DCUtils;
   import flash.filters.GlowFilter;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.emitters.ExplosionPreCalculationsWrapper;
   import tuxwars.battle.events.EmissionMessage;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.data.SoundMessage;
   import tuxwars.items.definitions.BoosterDef;
   import tuxwars.items.definitions.EquippableDef;
   import tuxwars.items.references.EmissionReference;
   
   public class BoosterItem extends Item implements Emission, SimpleScript
   {
       
      
      private var _uniqueId:String;
      
      private var _durationType:String;
      
      private var _durationInTotal:int;
      
      private var _duration:int;
      
      private var _glowFilter:GlowFilter;
      
      private const _emissionData:Object = {};
      
      private var _emitLocation:Vec2;
      
      private var _location:Vec2;
      
      private var _locationOriginal:Vec2;
      
      private var _emissions:Array;
      
      private var _missileBoostingEmissions:Array;
      
      private var _explosionBoostingEmissions:Array;
      
      private var _playerBoosterStats:Stats;
      
      private var _tagger:Tagger;
      
      private var _playerAttackStat:Stat;
      
      private var _playerDefenceStat:Stat;
      
      private var _soundID:String;
      
      private var _groupIndex:int;
      
      private var _explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper;
      
      private var _stats:Stats;
      
      private var _simpleScript:Array;
      
      private var emittingDone:Boolean;
      
      public function BoosterItem()
      {
         super();
      }
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not BoosterDef",true,data is BoosterDef);
         var _loc2_:BoosterDef = data as BoosterDef;
         _durationType = _loc2_.durationType;
         _durationInTotal = _loc2_.durationAmount;
         _duration = _durationInTotal;
         _glowFilter = _loc2_.glowFilter;
         _emissions = _loc2_.emissions;
         _missileBoostingEmissions = _loc2_.missileBoostingEmissions;
         _explosionBoostingEmissions = _loc2_.explosionBoostingEmissions;
         _playerAttackStat = new Stat(id,0);
         _playerDefenceStat = new Stat(id,0);
         _stats = new Stats();
         _simpleScript = _loc2_.simpleScript;
      }
      
      public function reset() : void
      {
         _duration = _durationInTotal;
         DCUtils.deleteProperties(_emissionData);
      }
      
      public function reduceBoosterDuration(type:String, amount:int) : void
      {
         if(type == _durationType)
         {
            _duration -= amount;
         }
      }
      
      public function isBoosterEffectUsed() : Boolean
      {
         return _duration <= 0;
      }
      
      public function get emissions() : Array
      {
         return _emissions;
      }
      
      public function set tagger(tagger:Tagger) : void
      {
         _tagger = tagger;
      }
      
      public function get tagger() : Tagger
      {
         return _tagger;
      }
      
      public function isFinished() : Boolean
      {
         return true;
      }
      
      public function readyToEmit() : Boolean
      {
         return _emissions != null && _location != null;
      }
      
      public function setEmittingDone() : void
      {
         if(_explosionPreCalculationsWrapper)
         {
            _explosionPreCalculationsWrapper.dispose();
            _explosionPreCalculationsWrapper = null;
         }
         emittingDone = true;
      }
      
      public function isEmittingDone() : Boolean
      {
         return emittingDone;
      }
      
      public function getBoosterMissileEmissions() : Array
      {
         return _missileBoostingEmissions;
      }
      
      public function getBoosterExplosionEmissions() : Array
      {
         return _explosionBoostingEmissions;
      }
      
      public function get radius() : Number
      {
         return 0;
      }
      
      public function set location(location:Vec2) : void
      {
         if(locationOriginal == null && location != null)
         {
            locationOriginal = location.copy();
         }
         _location = location;
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
      
      public function set playerDefenceValue(stat:Stat) : void
      {
         _playerDefenceStat = stat;
      }
      
      public function get playerDefenceValue() : Stat
      {
         return _playerDefenceStat;
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
      
      public function set groupIndex(value:int) : void
      {
         _groupIndex = value;
      }
      
      public function set groupIndexToFilter(value:int) : void
      {
      }
      
      public function get groupIndex() : int
      {
         return _groupIndex;
      }
      
      public function get stats() : Stats
      {
         return _stats;
      }
      
      public function findStat(name:String) : Stat
      {
         return _stats.getStat(name);
      }
      
      public function setExplosionPrecalculationsWrapper(explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper) : void
      {
         _explosionPreCalculationsWrapper = explosionPreCalculationsWrapper;
      }
      
      public function getExplosionPrecalculationsWrapper() : ExplosionPreCalculationsWrapper
      {
         return _explosionPreCalculationsWrapper;
      }
      
      public function set soundId(value:String) : void
      {
         _soundID = value;
         playSound();
      }
      
      public function playSound() : void
      {
         MessageCenter.sendEvent(new SoundMessage("PlaySound",_soundID));
      }
      
      public function playEndSound(value:String) : void
      {
         MessageCenter.sendEvent(new SoundMessage("EndSound",value));
      }
      
      public function playLoopSound() : void
      {
         MessageCenter.sendEvent(new SoundMessage("LoopSound",_soundID));
      }
      
      public function get glowFilter() : GlowFilter
      {
         return _glowFilter;
      }
      
      public function get uniqueId() : String
      {
         return _uniqueId;
      }
      
      public function set uniqueId(value:String) : void
      {
         _uniqueId = value;
      }
      
      public function triggerEmission() : void
      {
         var _loc1_:*;
         MessageCenter.sendEvent(new EmissionMessage(this,!!tagger ? (_loc1_ = tagger.gameObject, _loc1_._id) : null));
      }
      
      public function get shortName() : String
      {
         return name + " (id:" + id + ")(uid:" + uniqueId + ")";
      }
      
      public function get className() : String
      {
         if(_simpleScript && _simpleScript.length > 0)
         {
            return _simpleScript[0];
         }
         return null;
      }
      
      public function toString() : String
      {
         return shortName;
      }
      
      public function get variables() : Array
      {
         return _simpleScript;
      }
      
      public function get locationOriginal() : Vec2
      {
         return _locationOriginal;
      }
      
      public function set locationOriginal(value:Vec2) : void
      {
         _locationOriginal = value;
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
