package tuxwars.battle.explosions
{
   import com.dchoc.gameobjects.stats.Stat;
   import com.dchoc.gameobjects.stats.Stats;
   import com.dchoc.gameobjects.stats.StatsInterface;
   import com.dchoc.messages.MessageCenter;
   import nape.geom.Vec2;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.data.explosions.ExplosionShapeReference;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.emitters.ExplosionPreCalculationsWrapper;
   import tuxwars.battle.gameobjects.Tagger;
   import tuxwars.battle.simplescript.SimpleScript;
   import tuxwars.data.SoundMessage;
   import tuxwars.items.references.EmissionReference;
   import tuxwars.utils.UniqueCounters;
   
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
      
      public function Explosion(id:String, attackerStat:Stat, impulse:Number, impulseRadius:int, damageRadius:int, location:Vec2, explosionShapeRef:ExplosionShapeReference, particleEffect:ParticleReference, tagger:Tagger, emissions:Array, playerAttackValue:Stat, originalPlayerBoosterStats:Stats, simpleScript:Array, simpleScriptEveryTarget:Boolean, shakeEffectTime:int, shakeEffectStrenth:Number, flash:Boolean)
      {
         super();
         _id = id;
         _uniqueId = "Explosion" + UniqueCounters.next(id,"Explosion");
         _impulse = impulse;
         _damageRadius = damageRadius;
         _impulseRadius = impulseRadius;
         _attackerStat = attackerStat;
         _location = location.copy();
         _locationOriginal = location.copy();
         _emitLocation = location.copy();
         _explosionShapeRef = explosionShapeRef;
         _particleEffect = particleEffect;
         _emissions = emissions;
         isDone = !readyToEmit();
         _playerAttackValue = playerAttackValue;
         _tagger = tagger;
         _simpleScript = simpleScript != null ? simpleScript : [];
         _simpleScriptEveryTarget = simpleScriptEveryTarget;
         _shakeEffectTime = shakeEffectTime;
         _shakeEffectStrength = shakeEffectStrenth;
         _flash = flash;
         _stats = new Stats();
         playerBoosterStats = originalPlayerBoosterStats;
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
         return _playerAttackValue;
      }
      
      public function set playerAttackValue(value:int) : void
      {
         _playerAttackValue = new Stat("Attackers_Stat",value);
      }
      
      public function get emissions() : Array
      {
         return _emissions;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get attackerStat() : Stat
      {
         return _attackerStat;
      }
      
      public function get impulse() : Number
      {
         return _impulse;
      }
      
      public function get damageRadius() : int
      {
         return _damageRadius;
      }
      
      public function get impulseRadius() : int
      {
         return _impulseRadius;
      }
      
      public function get terrainMaxRadius() : int
      {
         return _explosionShapeRef.getMaxRadius();
      }
      
      public function get explosionShape() : ExplosionShape
      {
         if(!_explosionShape)
         {
            _explosionShape = ExplosionShape.generate(_explosionShapeRef);
         }
         return _explosionShape;
      }
      
      public function get particleEffect() : ParticleReference
      {
         return _particleEffect;
      }
      
      public function isFinished() : Boolean
      {
         return isDone;
      }
      
      public function readyToEmit() : Boolean
      {
         return _emissions != null;
      }
      
      public function setEmittingDone() : void
      {
         _emissions = null;
         isDone = true;
      }
      
      public function isEmittingDone() : Boolean
      {
         return isDone;
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
         return _tagger;
      }
      
      public function get location() : Vec2
      {
         return _location;
      }
      
      public function set location(p:Vec2) : void
      {
         _location = p;
      }
      
      public function get emitLocation() : Vec2
      {
         return _emitLocation;
      }
      
      public function set emitLocation(value:Vec2) : void
      {
         _emitLocation = value;
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
      
      public function set groupIndexToFilter(value:int) : void
      {
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
      
      public function getShakeTime() : int
      {
         return _shakeEffectTime;
      }
      
      public function getShakeStrength() : Number
      {
         return _shakeEffectStrength;
      }
      
      public function get flash() : Boolean
      {
         return _flash;
      }
      
      public function get className() : String
      {
         if(_simpleScript.length > 0)
         {
            return _simpleScript[0];
         }
         return null;
      }
      
      public function get variables() : Array
      {
         return _simpleScript;
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
      
      public function get uniqueId() : String
      {
         return _uniqueId;
      }
      
      public function get shortName() : String
      {
         return "Explosion (id:" + id + ")(uid:" + uniqueId + ")";
      }
      
      public function get simpleScriptEveryTarget() : Boolean
      {
         return _simpleScriptEveryTarget;
      }
      
      public function toString() : String
      {
         return shortName;
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
