package tuxwars.battle.missiles
{
   import com.dchoc.data.GameData;
   import com.dchoc.utils.DCUtils;
   import nape.space.Space;
   import tuxwars.battle.data.BodyDef;
   import tuxwars.battle.data.missiles.MissileData;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.gameobjects.PhysicsEmissionGameObjectDef;
   
   public class MissileDef extends PhysicsEmissionGameObjectDef
   {
      
      private static const PACKAGE:String = "tuxwars.battle.missiles.";
       
      
      private var _timer:int;
      
      private var _duration:int;
      
      private var _randomIntervalStart:Boolean;
      
      private var _atSleepToStaticAndSensor:Boolean;
      
      private var _interval:int;
      
      private var _particeRef:ParticleReference;
      
      private var _particleStreamSpawnDistance:int;
      
      private var _particleStreamSpawnTime:int;
      
      public function MissileDef(space:Space)
      {
         super(space);
      }
      
      public function get timer() : int
      {
         return _timer;
      }
      
      public function get duration() : int
      {
         return _duration;
      }
      
      public function get randomIntervalStart() : Boolean
      {
         return _randomIntervalStart;
      }
      
      public function get interval() : int
      {
         return _interval;
      }
      
      public function get particleEffect() : ParticleReference
      {
         return _particeRef;
      }
      
      public function get particleStreamSpawnDistance() : int
      {
         return _particleStreamSpawnDistance;
      }
      
      public function get particleStreamSpawnTime() : int
      {
         return _particleStreamSpawnTime;
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         var _loc2_:MissileData = data as MissileData;
         _timer = _loc2_.timer;
         _duration = _loc2_.duration;
         _interval = _loc2_.interval;
         _randomIntervalStart = _loc2_.randomIntervalStart;
         _particeRef = _loc2_.particleEffect;
         _particleStreamSpawnDistance = _loc2_.particleStreamSpawnDistance;
         _particleStreamSpawnTime = _loc2_.particleStreamSpawnTime;
         _atSleepToStaticAndSensor = _loc2_.atSleepToStaticAndSensor;
         objClass = DCUtils.getClassDefinitionByName("tuxwars.battle.missiles." + _loc2_.type);
      }
      
      override protected function setupBodyDef(def:BodyDef) : void
      {
         super.setupBodyDef(def);
      }
      
      public function get atSleepToStaticAndSensor() : Boolean
      {
         return _atSleepToStaticAndSensor;
      }
   }
}
