package tuxwars.battle.explosions
{
   import com.dchoc.gameobjects.stats.*;
   import com.dchoc.messages.*;
   import nape.geom.Vec2;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.explosions.ExplosionShapeReference;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.emitters.*;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.simplescript.*;
   import tuxwars.data.*;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.utils.*;
   
   public class Explosion implements Emission, SimpleScript, StatsInterface
   {
      private const emissionData:Object = {};
      
      private var _id:String;
      
      private var _uniqueId:String;
      
      private var _particleEffect:ParticleReference;
      
      private var _impulse:Number;
      
      private var _emitLocation:Vec2;
      
      private var _location:Vec2;
      
      private var _locationOriginal:Vec2;
      
      private var _damageRadius:int;
      
      private var _impulseRadius:int;
      
      private var _attackerStat:Stat;
      
      private var _explosionShapeRef:ExplosionShapeReference;
      
      private var _explosionShape:ExplosionShape;
      
      private var _emissions:Array;
      
      private var _playerAttackValue:Stat;
      
      private var _tagger:Tagger;
      
      private var isDone:Boolean;
      
      private var _soundID:String;
      
      private var _simpleScript:Array;
      
      private var _simpleScriptEveryTarget:Boolean;
      
      private var _playerBoosterStats:Stats;
      
      private var _shakeEffectTime:int;
      
      private var _shakeEffectStrength:Number;
      
      private var _flash:Boolean;
      
      private var _explosionPreCalculationsWrapper:ExplosionPreCalculationsWrapper;
      
      private var _stats:Stats;
      
      public function Explosion(param1:String, param2:Stat, param3:Number, param4:int, param5:int, param6:Vec2, param7:ExplosionShapeReference, param8:ParticleReference, param9:Tagger, param10:Array, param11:Stat, param12:Stats, param13:Array, param14:Boolean, param15:int, param16:Number, param17:Boolean)
      {
         super();
         this._id = param1;
         this._uniqueId = "Explosion" + UniqueCounters.next(param1,"Explosion");
         this._impulse = param3;
         this._damageRadius = param5;
         this._impulseRadius = param4;
         this._attackerStat = param2;
         this._location = param6.copy();
         this._locationOriginal = param6.copy();
         this._emitLocation = param6.copy();
         this._explosionShapeRef = param7;
         this._particleEffect = param8;
         this._emissions = param10;
         this.isDone = !this.readyToEmit();
         this._playerAttackValue = param11;
         this._tagger = param9;
         this._simpleScript = param13 != null ? param13 : [];
         this._simpleScriptEveryTarget = param14;
         this._shakeEffectTime = param15;
         this._shakeEffectStrength = param16;
         this._flash = param17;
         this._stats = new Stats();
         this.playerBoosterStats = param12;
      }
      
      public function triggerEmission() : void
      {
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return null;
      }
      
      public function get playerAttackValueStat() : Stat
      {
         return this._playerAttackValue;
      }
      
      public function set playerAttackValue(param1:int) : void
      {
         this._playerAttackValue = new Stat("Attackers_Stat",param1);
      }
      
      public function get emissions() : Array
      {
         return this._emissions;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get attackerStat() : Stat
      {
         return this._attackerStat;
      }
      
      public function get impulse() : Number
      {
         return this._impulse;
      }
      
      public function get damageRadius() : int
      {
         return this._damageRadius;
      }
      
      public function get impulseRadius() : int
      {
         return this._impulseRadius;
      }
      
      public function get terrainMaxRadius() : int
      {
         return this._explosionShapeRef.getMaxRadius();
      }
      
      public function get explosionShape() : ExplosionShape
      {
         if(!this._explosionShape)
         {
            this._explosionShape = ExplosionShape.generate(this._explosionShapeRef);
         }
         return this._explosionShape;
      }
      
      public function get particleEffect() : ParticleReference
      {
         return this._particleEffect;
      }
      
      public function isFinished() : Boolean
      {
         return this.isDone;
      }
      
      public function readyToEmit() : Boolean
      {
         return this._emissions != null;
      }
      
      public function setEmittingDone() : void
      {
         this._emissions = null;
         this.isDone = true;
      }
      
      public function isEmittingDone() : Boolean
      {
         return this.isDone;
      }
      
      public function getBoosterMissileEmissions() : Array
      {
         return null;
      }
      
      public function getBoosterExplosionEmissions() : Array
      {
         return null;
      }
      
      public function get radius() : Number
      {
         return 0;
      }
      
      public function get tagger() : Tagger
      {
         return this._tagger;
      }
      
      public function get location() : Vec2
      {
         return this._location;
      }
      
      public function set location(param1:Vec2) : void
      {
         this._location = param1;
      }
      
      public function get emitLocation() : Vec2
      {
         return this._emitLocation;
      }
      
      public function set emitLocation(param1:Vec2) : void
      {
         this._emitLocation = param1;
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
      
      public function set groupIndexToFilter(param1:int) : void
      {
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
      
      public function getShakeTime() : int
      {
         return this._shakeEffectTime;
      }
      
      public function getShakeStrength() : Number
      {
         return this._shakeEffectStrength;
      }
      
      public function get flash() : Boolean
      {
         return this._flash;
      }
      
      public function get className() : String
      {
         var _loc1_:String = null;
         if(this._simpleScript.length > 0)
         {
            return this._simpleScript[0];
         }
         return null;
      }
      
      public function get variables() : Array
      {
         return this._simpleScript;
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
      
      public function get uniqueId() : String
      {
         return this._uniqueId;
      }
      
      public function get shortName() : String
      {
         return "Explosion (id:" + this.id + ")(uid:" + this.uniqueId + ")";
      }
      
      public function get simpleScriptEveryTarget() : Boolean
      {
         return this._simpleScriptEveryTarget;
      }
      
      public function toString() : String
      {
         return this.shortName;
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

