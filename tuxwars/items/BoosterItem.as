package tuxwars.items
{
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import flash.filters.GlowFilter;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.events.*;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.simplescript.*;
   import tuxwars.data.*;
   import tuxwars.items.definitions.*;
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
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not BoosterDef",true,param1 is BoosterDef);
         var _loc2_:BoosterDef = param1 as BoosterDef;
         this._durationType = _loc2_.durationType;
         this._durationInTotal = _loc2_.durationAmount;
         this._duration = this._durationInTotal;
         this._glowFilter = _loc2_.glowFilter;
         this._emissions = _loc2_.emissions;
         this._missileBoostingEmissions = _loc2_.missileBoostingEmissions;
         this._explosionBoostingEmissions = _loc2_.explosionBoostingEmissions;
         this._playerAttackStat = new Stat(id,0);
         this._playerDefenceStat = new Stat(id,0);
         this._stats = new Stats();
         this._simpleScript = _loc2_.simpleScript;
      }
      
      public function reset() : void
      {
         this._duration = this._durationInTotal;
         DCUtils.deleteProperties(this._emissionData);
      }
      
      public function reduceBoosterDuration(param1:String, param2:int) : void
      {
         if(param1 == this._durationType)
         {
            this._duration -= param2;
         }
      }
      
      public function isBoosterEffectUsed() : Boolean
      {
         return this._duration <= 0;
      }
      
      public function get emissions() : Array
      {
         return this._emissions;
      }
      
      public function set tagger(param1:Tagger) : void
      {
         this._tagger = param1;
      }
      
      public function get tagger() : Tagger
      {
         return this._tagger;
      }
      
      public function isFinished() : Boolean
      {
         return true;
      }
      
      public function readyToEmit() : Boolean
      {
         return this._emissions != null && this._location != null;
      }
      
      public function setEmittingDone() : void
      {
         if(this._explosionPreCalculationsWrapper)
         {
            this._explosionPreCalculationsWrapper.dispose();
            this._explosionPreCalculationsWrapper = null;
         }
         this.emittingDone = true;
      }
      
      public function isEmittingDone() : Boolean
      {
         return this.emittingDone;
      }
      
      public function getBoosterMissileEmissions() : Array
      {
         return this._missileBoostingEmissions;
      }
      
      public function getBoosterExplosionEmissions() : Array
      {
         return this._explosionBoostingEmissions;
      }
      
      public function get radius() : Number
      {
         return 0;
      }
      
      public function set location(param1:Vec2) : void
      {
         if(this.locationOriginal == null && param1 != null)
         {
            this.locationOriginal = param1.copy();
         }
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
      
      public function set playerDefenceValue(param1:Stat) : void
      {
         this._playerDefenceStat = param1;
      }
      
      public function get playerDefenceValue() : Stat
      {
         return this._playerDefenceStat;
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
      
      public function set groupIndex(param1:int) : void
      {
         this._groupIndex = param1;
      }
      
      public function set groupIndexToFilter(param1:int) : void
      {
      }
      
      public function get groupIndex() : int
      {
         return this._groupIndex;
      }
      
      public function get stats() : Stats
      {
         return this._stats;
      }
      
      public function findStat(param1:String) : Stat
      {
         return this._stats.getStat(param1);
      }
      
      public function setExplosionPrecalculationsWrapper(param1:ExplosionPreCalculationsWrapper) : void
      {
         this._explosionPreCalculationsWrapper = param1;
      }
      
      public function getExplosionPrecalculationsWrapper() : ExplosionPreCalculationsWrapper
      {
         return this._explosionPreCalculationsWrapper;
      }
      
      public function set soundId(param1:String) : void
      {
         this._soundID = param1;
         this.playSound();
      }
      
      public function playSound() : void
      {
         MessageCenter.sendEvent(new SoundMessage("PlaySound",this._soundID));
      }
      
      public function playEndSound(param1:String) : void
      {
         MessageCenter.sendEvent(new SoundMessage("EndSound",param1));
      }
      
      public function playLoopSound() : void
      {
         MessageCenter.sendEvent(new SoundMessage("LoopSound",this._soundID));
      }
      
      public function get glowFilter() : GlowFilter
      {
         return this._glowFilter;
      }
      
      public function get uniqueId() : String
      {
         return this._uniqueId;
      }
      
      public function set uniqueId(param1:String) : void
      {
         this._uniqueId = param1;
      }
      
      public function triggerEmission() : void
      {
         var _loc1_:* = undefined;
         MessageCenter.sendEvent(new EmissionMessage(this,!!this.tagger ? (_loc1_ = this.tagger.gameObject, _loc1_._id) : null));
      }
      
      public function get shortName() : String
      {
         return name + " (id:" + id + ")(uid:" + this.uniqueId + ")";
      }
      
      public function get className() : String
      {
         if(Boolean(this._simpleScript) && this._simpleScript.length > 0)
         {
            return this._simpleScript[0];
         }
         return null;
      }
      
      public function toString() : String
      {
         return this.shortName;
      }
      
      public function get variables() : Array
      {
         return this._simpleScript;
      }
      
      public function get locationOriginal() : Vec2
      {
         return this._locationOriginal;
      }
      
      public function set locationOriginal(param1:Vec2) : void
      {
         this._locationOriginal = param1;
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

