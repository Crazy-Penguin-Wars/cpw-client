package tuxwars.battle.effects
{
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import tuxwars.battle.data.particles.ParticleReference;
   import tuxwars.battle.data.particles.Particles;
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
      
      public function ParticleSystem(world:TuxWorld)
      {
         super();
         particles = new Vector.<Particle>();
         childParticleArray = [];
         childParticlesToBeAdded = [];
         tuxWorldInstance = world;
         particleAmountReduction = 70;
      }
      
      private static function getCircleFrameCoordinates(locX:int, locY:int, radius:Number, startAngle:int, sector:int, n:Number) : Array
      {
         var _loc8_:Number = NaN;
         _loc8_ = 0.017453292519943295;
         var i:int = 0;
         var _loc7_:Number = NaN;
         var _loc9_:Number = 0.017453292519943295 * sector / n;
         var _loc10_:Array = new Array(n);
         for(i = 0; i < n; )
         {
            _loc7_ = 0.017453292519943295 * startAngle + (_loc9_ * i + (Math.random() * _loc9_ - (_loc9_ >> 1)));
            _loc10_[i] = new Point(locX + Math.cos(_loc7_) * radius,locY + Math.sin(_loc7_) * radius);
            i++;
         }
         return _loc10_;
      }
      
      public function dispose() : void
      {
         for each(var particle in particles)
         {
            particle.dispose();
         }
         particles.splice(0,particles.length);
         childParticleArray.splice(0,childParticleArray.length);
         childParticlesToBeAdded.splice(0,childParticlesToBeAdded.length);
         tuxWorldInstance = null;
      }
      
      public function addParticleEffect(particleRef:ParticleReference, locX:int, locY:int, graphicAngle:Number, parentMC:DisplayObjectContainer = null) : void
      {
         var i:int = 0;
         var _loc12_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var oppositeIndex:int = 0;
         var _loc18_:* = null;
         var _loc15_:* = null;
         var delay:* = 0;
         if(particleRef == null)
         {
            return;
         }
         if(particles.length >= 2000)
         {
            return;
         }
         this.parentMC = parentMC;
         var _loc17_:int = Math.max(particleRef.amount - particleRef.amount * particleAmountReduction / 100,1);
         var _loc13_:Number = particleRef.sector / _loc17_;
         var startAngle:int = particleRef.startAngle;
         if(particleRef.randomizeAngle)
         {
            startAngle = Math.random() * 360;
            if(startAngle + particleRef.sector > 360)
            {
               startAngle = 360 - particleRef.sector;
            }
         }
         var angle:Number = startAngle + Math.random() * _loc13_;
         var _loc6_:Array = getCircleFrameCoordinates(locX,locY,particleRef.spawnAreaRadius,startAngle,particleRef.sector,_loc17_);
         for(i = 0; i < _loc17_; )
         {
            _loc12_ = particleRef.randomizeSpeed ? Math.random() * 1 + 0.1 : 1;
            _loc8_ = particleRef.randomizeLifeTime ? particleRef.lifeTime * (Math.round(Math.random() * 1 * 10) / 10 + 0.1) : particleRef.lifeTime;
            _loc9_ = new Point(locX,locY);
            if(particleRef.useOnlySpawnAreaRadius)
            {
               _loc9_.x = _loc6_[i].x;
               _loc9_.y = _loc6_[i].y;
            }
            else
            {
               oppositeIndex = i + (_loc17_ >> 1);
               if(oppositeIndex >= _loc17_)
               {
                  oppositeIndex -= _loc17_;
               }
               locX = _loc6_[i].x + Math.random() * (Number(_loc6_[oppositeIndex].x) - Number(_loc6_[i].x));
               locY = _loc6_[i].y + Math.random() * (Number(_loc6_[oppositeIndex].y) - Number(_loc6_[i].y));
            }
            _loc18_ = new Point(Math.cos(angle * 3.141592653589793 / 180) * 3,Math.sin(angle * 3.141592653589793 / 180) * 3);
            _loc15_ = new Particle(_loc9_,_loc8_,_loc18_,graphicAngle,particleRef);
            addSingleParticle(_loc15_);
            angle += _loc13_;
            if(angle > startAngle + particleRef.sector)
            {
               angle -= particleRef.sector;
            }
            i++;
         }
         _loc6_.splice(0,_loc6_.length);
         if(particleRef.childParticles)
         {
            delay = 0;
            for(i = 0; i < particleRef.childParticles.length; )
            {
               if(particleRef.childParticleStartTimes)
               {
                  delay = uint(particleRef.childParticleStartTimes.length > i ? particleRef.childParticleStartTimes[i] : 0);
               }
               childParticlesToBeAdded.unshift(new Array(particleRef.childParticles[i],locX,locY,angle,delay));
               i++;
            }
         }
      }
      
      private function addSingleParticle(p:Particle) : void
      {
         p.mouseChildren = false;
         p.mouseEnabled = false;
         particles.push(p);
         if(parentMC)
         {
            parentMC.addChild(p);
         }
         else
         {
            var _loc2_:TuxWorld = tuxWorldInstance;
            _loc2_._objectContainer.addChild(p);
         }
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         var i:int = 0;
         for(i = particles.length - 1; i >= 0; )
         {
            if(particles[i].leaveParticleTail())
            {
               addSingleParticle(particles[i].createStationaryClone());
            }
            if(particles[i].update(deltaTime))
            {
               particles[i].dispose();
               particles[i] = null;
               particles.splice(i,1);
            }
            i--;
         }
         for(i = childParticleArray.length - 1; i >= 0; )
         {
            var _loc4_:* = Number(childParticleArray[i][4]) - deltaTime;
            childParticleArray[i][4] = _loc4_;
            if(childParticleArray[i][4] <= 0)
            {
               addParticleEffect(Particles.getParticlesReference(childParticleArray[i][0]),childParticleArray[i][1],childParticleArray[i][2],childParticleArray[i][3]);
               childParticleArray.splice(i,1);
            }
            i--;
         }
         if(childParticlesToBeAdded.length > 0)
         {
            for(i = 0; i < childParticlesToBeAdded.length; )
            {
               childParticleArray.push(childParticlesToBeAdded[i]);
               i++;
            }
            childParticlesToBeAdded.splice(0,childParticlesToBeAdded.length);
         }
      }
      
      public function reduceParticlesAmount(reduction:int) : void
      {
         particleAmountReduction = reduction;
      }
   }
}
