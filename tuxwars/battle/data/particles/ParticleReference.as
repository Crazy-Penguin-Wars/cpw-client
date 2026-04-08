package tuxwars.battle.data.particles
{
   import no.olog.utilfunctions.*;
   
   public class ParticleReference
   {
      private static const PARTICLE_AMOUNT:String = "ParticleAmount";
      
      private static const PARTICLE_COLOR:String = "ParticleColor";
      
      private static const PARTICLE_SIZE:String = "ParticleSize";
      
      private static const PARTICLE_GRAPHIC_SWF:String = "ParticleGraphicSWF";
      
      private static const PARTICLE_GRAPHIC_EXPORT:String = "ParticleGraphicExport";
      
      private static const LIFE_TIME:String = "LifeTime";
      
      private static const SPEED_START:String = "SpeedStart";
      
      private static const SPEED_END:String = "SpeedEnd";
      
      private static const SPEED_TIME_PERCENTAGE:String = "SpeedTimePercentage";
      
      private static const SPEED_SMOOTH_CHANGE:String = "SpeedSmoothChange";
      
      private static const SECTOR_IN_DEGREES:String = "SectorInDegrees";
      
      private static const RANDOMIZE_SPEED:String = "RandomizeSpeed";
      
      private static const RANDOMIZE_LIFE_TIME:String = "RandomizeLifeTime";
      
      private static const START_ANGLE:String = "StartAngle";
      
      private static const RANDOMIZE_START_ANGLE:String = "RandomizeStartAngle";
      
      private static const FADE_PARTICLES:String = "FadeParticles";
      
      private static const SHRINK_PARTICLES:String = "ShrinkParticles";
      
      private static const MULTIPLY_SIZE:String = "MultiplySize";
      
      private static const COLOR_MOD_INDEX:String = "ColorModIndex";
      
      private static const COLOR_MOD_TINT_VALUE:String = "ColorModTint";
      
      private static const COLOR_MOD_FILTER_VALUE:String = "ColorModFilter";
      
      private static const COLOR_EFFECT_TIME_PERCENTAGE:String = "ColorEffectTimePercentage";
      
      private static const GRAVITY:String = "Gravity";
      
      private static const FRICTION:String = "Friction";
      
      private static const ROTATION_SPEED:String = "RotationSpeed";
      
      private static const SWING_SPEED:String = "SwingSpeed";
      
      private static const PARTICLE_SPAWN_AREA_RADIUS:String = "ParticleSpawnAreaRadius";
      
      private static const USE_ONLY_SPAWN_AREA_FRAME:String = "UseOnlySpawnAreaFrame";
      
      private static const LEAVE_TAIL:String = "LeaveTail";
      
      private static const CHILD_PARTICLES:String = "ChildParticles";
      
      private static const CHILD_PARTICLE_START_TIMES:String = "ChildParticleStartTimes";
      
      private var _amount:int;
      
      private var _color:uint;
      
      private var _size:int;
      
      private var _graphicSWF:String;
      
      private var _graphicExport:Array;
      
      private var _lifeTime:int;
      
      private var _speedStart:Number;
      
      private var _speedEnd:Number;
      
      private var _speedChangeTimePercentage:int;
      
      private var _speedSmoothChange:Boolean;
      
      private var _sector:int;
      
      private var _randomizeSpeed:Boolean;
      
      private var _randomizeLifeTime:Boolean;
      
      private var _startAngle:int;
      
      private var _randomizeAngle:Boolean;
      
      private var _fade:int;
      
      private var _shrink:Boolean;
      
      private var _multiplySize:Number;
      
      private var _colorModIndex:String;
      
      private var _colorModValue:uint;
      
      private var _colorEffectTimePercentage:int;
      
      private var _gravity:Number;
      
      private var _friction:Number;
      
      private var _rotationSpeed:Number;
      
      private var _swingSpeed:Number;
      
      private var _spawnAreaRadius:int;
      
      private var _useOnlySpawnAreaRadius:Boolean;
      
      private var _leaveTail:Boolean;
      
      private var _childParticles:Array;
      
      private var _childParticleStartTimes:Array;
      
      public function ParticleReference(param1:Object)
      {
         super();
         assert("Data is null.",true,param1 != null);
         this._amount = param1["ParticleAmount"];
         this._color = param1["ParticleColor"];
         this._size = param1["ParticleSize"];
         this._graphicSWF = param1["ParticleGraphicSWF"];
         if(param1["ParticleGraphicExport"])
         {
            this._graphicExport = (param1["ParticleGraphicExport"] as String).split(",");
         }
         else
         {
            this._graphicExport = null;
         }
         this._lifeTime = param1["LifeTime"];
         this._speedStart = param1["SpeedStart"];
         this._speedEnd = param1["SpeedEnd"];
         this._speedChangeTimePercentage = param1["SpeedTimePercentage"];
         this._speedSmoothChange = param1["SpeedSmoothChange"];
         this._sector = param1["SectorInDegrees"];
         this._randomizeSpeed = param1["RandomizeSpeed"];
         this._randomizeLifeTime = param1["RandomizeLifeTime"];
         this._startAngle = param1["StartAngle"];
         this._randomizeAngle = param1["RandomizeStartAngle"];
         this._fade = param1["FadeParticles"];
         this._shrink = param1["ShrinkParticles"];
         this._multiplySize = param1["MultiplySize"];
         this._colorModIndex = param1["ColorModIndex"];
         this._colorModValue = 0;
         if(this._colorModIndex)
         {
            if(this._colorModIndex == "tint")
            {
               this._colorModValue = param1["ColorModTint"];
            }
            else if(this._colorModIndex == "filter")
            {
               this._colorModValue = param1["ColorModFilter"];
            }
         }
         this._colorEffectTimePercentage = param1["ColorEffectTimePercentage"];
         this._gravity = param1["Gravity"];
         this._friction = param1["Friction"];
         this._rotationSpeed = param1["RotationSpeed"];
         this._swingSpeed = param1["SwingSpeed"];
         this._spawnAreaRadius = param1["ParticleSpawnAreaRadius"];
         this._useOnlySpawnAreaRadius = param1["UseOnlySpawnAreaFrame"];
         this._leaveTail = param1["LeaveTail"];
         if(param1["ChildParticles"])
         {
            this._childParticles = (param1["ChildParticles"] as String).split(",");
         }
         else
         {
            this._childParticles = null;
         }
         if(param1["ChildParticleStartTimes"])
         {
            this._childParticleStartTimes = (param1["ChildParticleStartTimes"] as String).split(",");
         }
         else
         {
            this._childParticleStartTimes = null;
         }
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function get size() : int
      {
         return this._size;
      }
      
      public function getParticleGraphicSWF() : String
      {
         return this._graphicSWF;
      }
      
      public function getParticleGraphicExport() : Array
      {
         return this._graphicExport;
      }
      
      public function get lifeTime() : int
      {
         return this._lifeTime;
      }
      
      public function get speedStart() : Number
      {
         return this._speedStart;
      }
      
      public function get speedEnd() : Number
      {
         return this._speedEnd;
      }
      
      public function get speedChangeTimePercentage() : int
      {
         return this._speedChangeTimePercentage;
      }
      
      public function get speedSmoothChange() : Boolean
      {
         return this._speedSmoothChange;
      }
      
      public function get sector() : int
      {
         return this._sector;
      }
      
      public function get randomizeSpeed() : Boolean
      {
         return this._randomizeSpeed;
      }
      
      public function get randomizeLifeTime() : Boolean
      {
         return this._randomizeLifeTime;
      }
      
      public function get fade() : int
      {
         return this._fade;
      }
      
      public function get startAngle() : int
      {
         return this._startAngle;
      }
      
      public function get randomizeAngle() : Boolean
      {
         return this._randomizeAngle;
      }
      
      public function get shrink() : Boolean
      {
         return this._shrink;
      }
      
      public function get multiplySize() : Number
      {
         return this._multiplySize;
      }
      
      public function get colorModIndex() : String
      {
         return this._colorModIndex;
      }
      
      public function get colorModValue() : uint
      {
         return this._colorModValue;
      }
      
      public function get colorEffectTimePercentage() : int
      {
         return this._colorEffectTimePercentage;
      }
      
      public function get gravity() : Number
      {
         return this._gravity;
      }
      
      public function get friction() : Number
      {
         return this._friction;
      }
      
      public function get rotationSpeed() : Number
      {
         return this._rotationSpeed;
      }
      
      public function get swingSpeed() : Number
      {
         return this._swingSpeed;
      }
      
      public function get spawnAreaRadius() : int
      {
         return this._spawnAreaRadius;
      }
      
      public function get useOnlySpawnAreaRadius() : Boolean
      {
         return this._useOnlySpawnAreaRadius;
      }
      
      public function get leaveTail() : Boolean
      {
         return this._leaveTail;
      }
      
      public function get childParticles() : Array
      {
         return this._childParticles;
      }
      
      public function get childParticleStartTimes() : Array
      {
         return this._childParticleStartTimes;
      }
   }
}

