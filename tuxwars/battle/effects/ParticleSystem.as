package tuxwars.battle.effects
{
   import flash.display.DisplayObjectContainer;
   import flash.geom.*;
   import tuxwars.battle.data.particles.*;
   import tuxwars.battle.world.TuxWorld;
   
   public class ParticleSystem
   {
      private static const MAX_PARTICLE_AMOUNT:int = 2000;
      
      public static const PARTICLE_TYPE_MISSILE_EXPLOSION:String = "MissileExplosion";
      
      public static const PARTICLE_TYPE_OBJECT_COLLISION:String = "ObjectCollision";
      
      public static const PARTICLE_TYPE_OBJECT_DESTROYED:String = "ObjectDestroyed";
      
      private static const CHILD_ARRAY_SET_INDEX_REFERENCE:int = 0;
      
      private static const CHILD_ARRAY_SET_INDEX_LOCATION_X:int = 1;
      
      private static const CHILD_ARRAY_SET_INDEX_LOCATION_Y:int = 2;
      
      private static const CHILD_ARRAY_SET_INDEX_ANGLE:int = 3;
      
      private static const CHILD_ARRAY_SET_INDEX_DELAY:int = 4;
      
      private var particles:Vector.<Particle>;
      
      private var tuxWorldInstance:TuxWorld;
      
      private var childParticleArray:Array;
      
      private var childParticlesToBeAdded:Array;
      
      private var parentMC:DisplayObjectContainer;
      
      private var particleAmountReduction:int;
      
      public function ParticleSystem(param1:TuxWorld)
      {
         super();
         this.particles = new Vector.<Particle>();
         this.childParticleArray = [];
         this.childParticlesToBeAdded = [];
         this.tuxWorldInstance = param1;
         this.particleAmountReduction = 70;
      }
      
      private static function getCircleFrameCoordinates(param1:int, param2:int, param3:Number, param4:int, param5:int, param6:Number) : Array
      {
         var _loc7_:Number = Number(NaN);
         _loc7_ = 0.017453292519943295;
         var _loc8_:int = 0;
         var _loc9_:Number = Number(NaN);
         var _loc10_:Number = 0.017453292519943295 * param5 / param6;
         var _loc11_:Array = new Array(param6);
         _loc8_ = 0;
         while(_loc8_ < param6)
         {
            _loc9_ = 0.017453292519943295 * param4 + (_loc10_ * _loc8_ + (Math.random() * _loc10_ - (_loc10_ >> 1)));
            _loc11_[_loc8_] = new Point(param1 + Math.cos(_loc9_) * param3,param2 + Math.sin(_loc9_) * param3);
            _loc8_++;
         }
         return _loc11_;
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.particles)
         {
            _loc1_.dispose();
         }
         this.particles.splice(0,this.particles.length);
         this.childParticleArray.splice(0,this.childParticleArray.length);
         this.childParticlesToBeAdded.splice(0,this.childParticlesToBeAdded.length);
         this.tuxWorldInstance = null;
      }
      
      public function addParticleEffect(param1:ParticleReference, param2:int, param3:int, param4:Number, param5:DisplayObjectContainer = null) : void
      {
         var _loc6_:int = 0;
         var _loc7_:Number = Number(NaN);
         var _loc8_:int = 0;
         var _loc9_:Point = null;
         var _loc10_:int = 0;
         var _loc11_:Point = null;
         var _loc12_:Particle = null;
         var _loc13_:* = 0;
         if(param1 == null)
         {
            return;
         }
         if(this.particles.length >= 2000)
         {
            return;
         }
         this.parentMC = param5;
         var _loc14_:int = Math.max(param1.amount - param1.amount * this.particleAmountReduction / 100,1);
         var _loc15_:Number = param1.sector / _loc14_;
         var _loc16_:int = param1.startAngle;
         if(param1.randomizeAngle)
         {
            _loc16_ = Math.random() * 360;
            if(_loc16_ + param1.sector > 360)
            {
               _loc16_ = 360 - param1.sector;
            }
         }
         var _loc17_:Number = _loc16_ + Math.random() * _loc15_;
         var _loc18_:Array = getCircleFrameCoordinates(param2,param3,param1.spawnAreaRadius,_loc16_,param1.sector,_loc14_);
         _loc6_ = 0;
         while(_loc6_ < _loc14_)
         {
            _loc7_ = param1.randomizeSpeed ? Math.random() * 1 + 0.1 : 1;
            _loc8_ = param1.randomizeLifeTime ? int(param1.lifeTime * (Math.round(Math.random() * 1 * 10) / 10 + 0.1)) : param1.lifeTime;
            _loc9_ = new Point(param2,param3);
            if(param1.useOnlySpawnAreaRadius)
            {
               _loc9_.x = _loc18_[_loc6_].x;
               _loc9_.y = _loc18_[_loc6_].y;
            }
            else
            {
               _loc10_ = _loc6_ + (_loc14_ >> 1);
               if(_loc10_ >= _loc14_)
               {
                  _loc10_ -= _loc14_;
               }
               param2 = _loc18_[_loc6_].x + Math.random() * (_loc18_[_loc10_].x - _loc18_[_loc6_].x);
               param3 = _loc18_[_loc6_].y + Math.random() * (_loc18_[_loc10_].y - _loc18_[_loc6_].y);
            }
            _loc11_ = new Point(Math.cos(_loc17_ * 3.141592653589793 / 180) * 3,Math.sin(_loc17_ * 3.141592653589793 / 180) * 3);
            _loc12_ = new Particle(_loc9_,_loc8_,_loc11_,param4,param1);
            this.addSingleParticle(_loc12_);
            _loc17_ += _loc15_;
            if(_loc17_ > _loc16_ + param1.sector)
            {
               _loc17_ -= param1.sector;
            }
            _loc6_++;
         }
         _loc18_.splice(0,_loc18_.length);
         if(param1.childParticles)
         {
            _loc13_ = 0;
            _loc6_ = 0;
            while(_loc6_ < param1.childParticles.length)
            {
               if(param1.childParticleStartTimes)
               {
                  _loc13_ = uint(param1.childParticleStartTimes.length > _loc6_ ? param1.childParticleStartTimes[_loc6_] : 0);
               }
               this.childParticlesToBeAdded.unshift(new Array(param1.childParticles[_loc6_],param2,param3,_loc17_,_loc13_));
               _loc6_++;
            }
         }
      }
      
      private function addSingleParticle(param1:Particle) : void
      {
         var _loc2_:TuxWorld = null;
         param1.mouseChildren = false;
         param1.mouseEnabled = false;
         this.particles.push(param1);
         if(this.parentMC)
         {
            this.parentMC.addChild(param1);
         }
         else
         {
            _loc2_ = this.tuxWorldInstance;
            _loc2_._objectContainer.addChild(param1);
         }
      }
      
      public function logicUpdate(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = undefined;
         var _loc2_:int = 0;
         _loc2_ = this.particles.length - 1;
         while(_loc2_ >= 0)
         {
            if(this.particles[_loc2_].leaveParticleTail())
            {
               this.addSingleParticle(this.particles[_loc2_].createStationaryClone());
            }
            if(this.particles[_loc2_].update(param1))
            {
               this.particles[_loc2_].dispose();
               this.particles[_loc2_] = null;
               this.particles.splice(_loc2_,1);
            }
            _loc2_--;
         }
         _loc2_ = this.childParticleArray.length - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = 4;
            _loc4_ = this.childParticleArray[_loc2_][_loc3_] - param1;
            this.childParticleArray[_loc2_][_loc3_] = _loc4_;
            if(this.childParticleArray[_loc2_][4] <= 0)
            {
               this.addParticleEffect(Particles.getParticlesReference(this.childParticleArray[_loc2_][0]),this.childParticleArray[_loc2_][1],this.childParticleArray[_loc2_][2],this.childParticleArray[_loc2_][3]);
               this.childParticleArray.splice(_loc2_,1);
            }
            _loc2_--;
         }
         if(this.childParticlesToBeAdded.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.childParticlesToBeAdded.length)
            {
               this.childParticleArray.push(this.childParticlesToBeAdded[_loc2_]);
               _loc2_++;
            }
            this.childParticlesToBeAdded.splice(0,this.childParticlesToBeAdded.length);
         }
      }
      
      public function reduceParticlesAmount(param1:int) : void
      {
         this.particleAmountReduction = param1;
      }
   }
}

