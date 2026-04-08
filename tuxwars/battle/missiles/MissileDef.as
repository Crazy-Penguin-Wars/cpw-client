package tuxwars.battle.missiles
{
   import com.dchoc.data.GameData;
   import com.dchoc.utils.*;
   import nape.space.Space;
   import tuxwars.battle.data.BodyDef;
   import tuxwars.battle.data.missiles.*;
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
      
      public function MissileDef(param1:Space)
      {
         super(param1);
      }
      
      public function get timer() : int
      {
         return this._timer;
      }
      
      public function get duration() : int
      {
         return this._duration;
      }
      
      public function get randomIntervalStart() : Boolean
      {
         return this._randomIntervalStart;
      }
      
      public function get interval() : int
      {
         return this._interval;
      }
      
      public function get particleEffect() : ParticleReference
      {
         return this._particeRef;
      }
      
      public function get particleStreamSpawnDistance() : int
      {
         return this._particleStreamSpawnDistance;
      }
      
      public function get particleStreamSpawnTime() : int
      {
         return this._particleStreamSpawnTime;
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         var _loc2_:MissileData = param1 as MissileData;
         this._timer = _loc2_.timer;
         this._duration = _loc2_.duration;
         this._interval = _loc2_.interval;
         this._randomIntervalStart = _loc2_.randomIntervalStart;
         this._particeRef = _loc2_.particleEffect;
         this._particleStreamSpawnDistance = _loc2_.particleStreamSpawnDistance;
         this._particleStreamSpawnTime = _loc2_.particleStreamSpawnTime;
         this._atSleepToStaticAndSensor = _loc2_.atSleepToStaticAndSensor;
         objClass = DCUtils.getClassDefinitionByName("tuxwars.battle.missiles." + _loc2_.type);
      }
      
      override protected function setupBodyDef(param1:BodyDef) : void
      {
         super.setupBodyDef(param1);
      }
      
      public function get atSleepToStaticAndSensor() : Boolean
      {
         return this._atSleepToStaticAndSensor;
      }
   }
}

