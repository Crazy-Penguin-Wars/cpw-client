package tuxwars.battle.data.missiles
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import tuxwars.battle.data.TuxEmissionGameObjectData;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.data.particles.Particles;
   
   public class MissileData extends TuxEmissionGameObjectData
   {
      
      private static const TYPE:String = "Type";
      
      private static const TIMER:String = "Timer";
      
      private static const DURATION:String = "Duration";
      
      private static const RANDOM_INTERVAL_START:String = "RandomIntervalStart";
      
      private static const INTERVAL:String = "Interval";
      
      private static const FIRING_IMPULSE_MAX:String = "FiringImpulseMax";
      
      private static const FIRING_IMPULSE_MIN:String = "FiringImpulseMin";
      
      private static const PARTICLE_EFFECT:String = "ParticleEffect";
      
      private static const PARTICLE_STREAM_SPAWN_DISTANCE:String = "ParticleStreamSpawnDistance";
      
      private static const PARTICLE_STREAM_SPAWN_TIME:String = "ParticleStreamSpawnTime";
      
      private static const AT_SLEEP_TO_STATIC_AND_SENSOR:String = "AtSleepToStaticAndSensor";
       
      
      public function MissileData(row:Row)
      {
         super(row);
      }
      
      public function get type() : String
      {
         var _loc1_:* = getField("Type");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public function get timer() : int
      {
         var _loc1_:Field = getField("Timer");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get duration() : int
      {
         var _loc1_:Field = getField("Duration");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get randomIntervalStart() : Boolean
      {
         var _loc1_:Field = getField("RandomIntervalStart");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : true;
      }
      
      public function get atSleepToStaticAndSensor() : Boolean
      {
         var _loc1_:Field = getField("AtSleepToStaticAndSensor");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : true;
      }
      
      public function get interval() : int
      {
         var _loc1_:Field = getField("Interval");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get firingImpulseMax() : int
      {
         var _loc1_:Field = getField("FiringImpulseMax");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get firingImpulseMin() : int
      {
         var _loc1_:Field = getField("FiringImpulseMin");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get particleStreamSpawnDistance() : int
      {
         var _loc1_:Field = getField("ParticleStreamSpawnDistance");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get particleStreamSpawnTime() : int
      {
         var _loc1_:Field = getField("ParticleStreamSpawnTime");
         var _loc2_:*;
         return _loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get particleEffect() : ParticleReference
      {
         var _loc1_:Field = getField("ParticleEffect");
         var _loc2_:*;
         return Particles.getParticlesReference(_loc1_ != null ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : null);
      }
   }
}
