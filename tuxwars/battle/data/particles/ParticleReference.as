package tuxwars.battle.data.particles
{
   import no.olog.utilfunctions.assert;
   
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
      
      public function ParticleReference(data:Object)
      {
         super();
         assert("Data is null.",true,data != null);
         _amount = data["ParticleAmount"];
         _color = data["ParticleColor"];
         _size = data["ParticleSize"];
         _graphicSWF = data["ParticleGraphicSWF"];
         if(data["ParticleGraphicExport"])
         {
            _graphicExport = (data["ParticleGraphicExport"] as String).split(",");
         }
         else
         {
            _graphicExport = null;
         }
         _lifeTime = data["LifeTime"];
         _speedStart = data["SpeedStart"];
         _speedEnd = data["SpeedEnd"];
         _speedChangeTimePercentage = data["SpeedTimePercentage"];
         _speedSmoothChange = data["SpeedSmoothChange"];
         _sector = data["SectorInDegrees"];
         _randomizeSpeed = data["RandomizeSpeed"];
         _randomizeLifeTime = data["RandomizeLifeTime"];
         _startAngle = data["StartAngle"];
         _randomizeAngle = data["RandomizeStartAngle"];
         _fade = data["FadeParticles"];
         _shrink = data["ShrinkParticles"];
         _multiplySize = data["MultiplySize"];
         _colorModIndex = data["ColorModIndex"];
         _colorModValue = 0;
         if(_colorModIndex)
         {
            if(_colorModIndex == "tint")
            {
               _colorModValue = data["ColorModTint"];
            }
            else if(_colorModIndex == "filter")
            {
               _colorModValue = data["ColorModFilter"];
            }
         }
         _colorEffectTimePercentage = data["ColorEffectTimePercentage"];
         _gravity = data["Gravity"];
         _friction = data["Friction"];
         _rotationSpeed = data["RotationSpeed"];
         _swingSpeed = data["SwingSpeed"];
         _spawnAreaRadius = data["ParticleSpawnAreaRadius"];
         _useOnlySpawnAreaRadius = data["UseOnlySpawnAreaFrame"];
         _leaveTail = data["LeaveTail"];
         if(data["ChildParticles"])
         {
            _childParticles = (data["ChildParticles"] as String).split(",");
         }
         else
         {
            _childParticles = null;
         }
         if(data["ChildParticleStartTimes"])
         {
            _childParticleStartTimes = (data["ChildParticleStartTimes"] as String).split(",");
         }
         else
         {
            _childParticleStartTimes = null;
         }
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get color() : uint
      {
         return _color;
      }
      
      public function get size() : int
      {
         return _size;
      }
      
      public function getParticleGraphicSWF() : String
      {
         return _graphicSWF;
      }
      
      public function getParticleGraphicExport() : Array
      {
         return _graphicExport;
      }
      
      public function get lifeTime() : int
      {
         return _lifeTime;
      }
      
      public function get speedStart() : Number
      {
         return _speedStart;
      }
      
      public function get speedEnd() : Number
      {
         return _speedEnd;
      }
      
      public function get speedChangeTimePercentage() : int
      {
         return _speedChangeTimePercentage;
      }
      
      public function get speedSmoothChange() : Boolean
      {
         return _speedSmoothChange;
      }
      
      public function get sector() : int
      {
         return _sector;
      }
      
      public function get randomizeSpeed() : Boolean
      {
         return _randomizeSpeed;
      }
      
      public function get randomizeLifeTime() : Boolean
      {
         return _randomizeLifeTime;
      }
      
      public function get fade() : int
      {
         return _fade;
      }
      
      public function get startAngle() : int
      {
         return _startAngle;
      }
      
      public function get randomizeAngle() : Boolean
      {
         return _randomizeAngle;
      }
      
      public function get shrink() : Boolean
      {
         return _shrink;
      }
      
      public function get multiplySize() : Number
      {
         return _multiplySize;
      }
      
      public function get colorModIndex() : String
      {
         return _colorModIndex;
      }
      
      public function get colorModValue() : uint
      {
         return _colorModValue;
      }
      
      public function get colorEffectTimePercentage() : int
      {
         return _colorEffectTimePercentage;
      }
      
      public function get gravity() : Number
      {
         return _gravity;
      }
      
      public function get friction() : Number
      {
         return _friction;
      }
      
      public function get rotationSpeed() : Number
      {
         return _rotationSpeed;
      }
      
      public function get swingSpeed() : Number
      {
         return _swingSpeed;
      }
      
      public function get spawnAreaRadius() : int
      {
         return _spawnAreaRadius;
      }
      
      public function get useOnlySpawnAreaRadius() : Boolean
      {
         return _useOnlySpawnAreaRadius;
      }
      
      public function get leaveTail() : Boolean
      {
         return _leaveTail;
      }
      
      public function get childParticles() : Array
      {
         return _childParticles;
      }
      
      public function get childParticleStartTimes() : Array
      {
         return _childParticleStartTimes;
      }
   }
}
