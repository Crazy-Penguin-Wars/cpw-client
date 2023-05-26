package tuxwars.battle.effects
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import tuxwars.battle.data.particles.ParticleReference;
   
   public class Particle extends Sprite
   {
       
      
      private const vector:Point = new Point();
      
      private var particleReference:ParticleReference;
      
      private var lifeTimeInTotal:int;
      
      private var lifeTimer:int;
      
      private var effectTimer:int;
      
      private var effectTimeInTotal:int;
      
      private var currentSpeed:Number;
      
      private var speedStart:Number;
      
      private var speedEnd:Number;
      
      private var speedChangePercentage:Number;
      
      private var fadePercentage:int;
      
      private const SWING_ANGLE_LIMIT:int = 60;
      
      private var swingAngle:Number;
      
      private var swingingForward:Boolean;
      
      private const previousTailPoint:Point = new Point();
      
      private var graphicExport:String;
      
      private var graphicMovieClip:MovieClip;
      
      private var graphicBitmapData:BitmapData;
      
      private var graphicAngle:Number;
      
      public function Particle(location:Point, lifeTime:int, vec:Point, graphicAngle:Number, particleRef:ParticleReference, isTail:Boolean = false)
      {
         super();
         particleReference = particleRef;
         lifeTimeInTotal = lifeTime > 0 ? lifeTime : 1;
         lifeTimer = lifeTime;
         effectTimer = lifeTime * particleRef.colorEffectTimePercentage / 100;
         effectTimeInTotal = effectTimer;
         if(vec)
         {
            vector.x = vec.x;
            vector.y = vec.y;
         }
         if(isTail)
         {
            speedStart = 0;
            speedEnd = 0;
            currentSpeed = 0;
            speedChangePercentage = 0;
         }
         else
         {
            speedStart = particleRef.speedStart / 100;
            speedEnd = particleRef.speedEnd / 100;
            currentSpeed = speedStart;
            speedChangePercentage = particleRef.speedChangeTimePercentage / 100;
         }
         fadePercentage = particleRef.fade / 100;
         if(particleReference.swingSpeed > 0)
         {
            swingAngle = -60 + Math.random() * (60 * 2);
            swingingForward = swingAngle > 0;
         }
         x = location.x;
         y = location.y;
         if(particleRef.getParticleGraphicSWF() && particleRef.getParticleGraphicExport())
         {
            this.graphicAngle = graphicAngle;
            graphicExport = particleRef.getParticleGraphicExport()[Math.random() * particleRef.getParticleGraphicExport().length];
            if(graphicExport.indexOf(".png") > -1)
            {
               graphicBitmapData = DCResourceManager.instance.getFromSWF(particleRef.getParticleGraphicSWF(),graphicExport,"BitmapData");
            }
            else
            {
               graphicMovieClip = DCResourceManager.instance.getFromSWF(particleRef.getParticleGraphicSWF(),graphicExport,"MovieClip");
            }
         }
         else
         {
            graphics.beginFill(particleRef.color);
            graphics.drawCircle(0,0,particleRef.size);
            graphics.endFill();
         }
         if(particleRef.leaveTail)
         {
            previousTailPoint.x = x;
            previousTailPoint.y = y;
         }
      }
      
      public function dispose() : void
      {
         if(parent && parent.contains(this))
         {
            parent.removeChild(this);
         }
         if(graphicBitmapData)
         {
            graphicBitmapData.dispose();
            graphicBitmapData = null;
         }
         if(graphicMovieClip)
         {
            DCUtils.stopMovieClip(graphicMovieClip);
            DCUtils.disposeAllBitmapData(graphicMovieClip);
            graphicMovieClip = null;
         }
      }
      
      public function update(dt:uint) : Boolean
      {
         var _loc16_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc10_:Number = NaN;
         var matrix:* = null;
         var _loc17_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc18_:* = null;
         lifeTimer -= dt;
         if(lifeTimer <= 0)
         {
            return true;
         }
         var _loc2_:Number = lifeTimer / lifeTimeInTotal;
         var _loc19_:Number = 1 - _loc2_;
         effectTimer -= dt;
         if(effectTimer <= 0)
         {
            effectTimer = 0;
         }
         if(_loc19_ <= speedChangePercentage)
         {
            if(particleReference.speedSmoothChange)
            {
               currentSpeed = speedEnd + (speedStart - speedEnd) * (1 - _loc19_ / speedChangePercentage);
            }
            else
            {
               currentSpeed = speedStart;
            }
         }
         else
         {
            currentSpeed = speedEnd;
         }
         var _loc13_:Number = vector.x * (currentSpeed * dt);
         var _loc4_:Number = vector.y * (currentSpeed * dt);
         var swingX:Number = 0;
         var swingY:Number = 0;
         if(particleReference.swingSpeed > 0)
         {
            if(swingingForward)
            {
               swingAngle += particleReference.swingSpeed * dt;
               if(swingAngle > 60)
               {
                  swingAngle = 60;
                  swingingForward = false;
               }
            }
            else
            {
               swingAngle -= particleReference.swingSpeed * dt;
               if(swingAngle < -60)
               {
                  swingAngle = -60;
                  swingingForward = true;
               }
            }
            swingX = Math.sin(swingAngle * 3.141592653589793 / 180) * _loc4_;
            swingY = -Math.sin(swingAngle * 3.141592653589793 / 180) * _loc13_;
         }
         x = x + _loc13_ + swingX;
         y = y + _loc4_ + swingY;
         vector.y += 0.002 * particleReference.gravity * dt;
         var _loc14_:Number = 0.002 * (vector.x * particleReference.friction) * dt;
         var _loc12_:Boolean = vector.x < 0;
         vector.x -= _loc14_;
         vector.x = vector.x < 0 == _loc12_ ? vector.x : 0;
         rotation += particleReference.rotationSpeed * dt / 100;
         var _loc15_:Number = effectTimer > 0 ? effectTimer / effectTimeInTotal : 0;
         var _loc7_:Number = 1 - _loc15_;
         if(particleReference.shrink)
         {
            scaleX = _loc2_;
            scaleY = _loc2_;
         }
         else if(particleReference.multiplySize > 0)
         {
            scaleX = 1 + _loc19_ * particleReference.multiplySize;
            scaleY = 1 + _loc19_ * particleReference.multiplySize;
         }
         var myColorTransform:ColorTransform = transform.colorTransform;
         if(_loc19_ > fadePercentage)
         {
            myColorTransform.alphaMultiplier = 1 - (_loc19_ - fadePercentage) / (1 - fadePercentage);
         }
         if(particleReference.colorModIndex && particleReference.colorModIndex != "none")
         {
            _loc16_ = (particleReference.colorModValue & 16711680) >>> 16;
            _loc20_ = (particleReference.colorModValue & 65280) >>> 8;
            _loc10_ = particleReference.colorModValue & 255;
            if(particleReference.colorModIndex == "tint")
            {
               myColorTransform.redMultiplier = _loc15_;
               myColorTransform.redOffset = _loc7_ * _loc16_;
               myColorTransform.blueMultiplier = _loc15_;
               myColorTransform.blueOffset = _loc7_ * _loc10_;
               myColorTransform.greenMultiplier = _loc15_;
               myColorTransform.greenOffset = _loc7_ * _loc20_;
            }
            else if(particleReference.colorModIndex == "filter")
            {
               matrix = [];
               _loc17_ = _loc16_ / 255;
               _loc3_ = _loc20_ / 255;
               _loc6_ = _loc10_ / 255;
               matrix = matrix.concat([1 - (1 - _loc17_) * _loc7_,0,0,0,0]);
               matrix = matrix.concat([0,1 - (1 - _loc3_) * _loc7_,0,0,0]);
               matrix = matrix.concat([0,0,1 - (1 - _loc6_) * _loc7_,0,0]);
               matrix = matrix.concat([0,0,0,1,0]);
               filters = [new ColorMatrixFilter(matrix)];
            }
         }
         transform.colorTransform = myColorTransform;
         if(graphicBitmapData || graphicMovieClip)
         {
            graphics.clear();
            while(numChildren > 0)
            {
               removeChildAt(0);
            }
            if(graphicBitmapData)
            {
               _loc18_ = new Bitmap(graphicBitmapData);
               _loc18_.rotation = graphicAngle;
               addChild(_loc18_);
            }
            else
            {
               graphicMovieClip.rotation = graphicAngle;
               addChild(graphicMovieClip);
            }
            graphicBitmapData = null;
            graphicMovieClip = null;
         }
         return false;
      }
      
      public function setGraphicExport(graphic:String) : void
      {
         graphicExport = graphic;
         if(particleReference.getParticleGraphicSWF())
         {
            if(graphicExport.indexOf(".png") > -1)
            {
               graphicBitmapData = DCResourceManager.instance.getFromSWF(particleReference.getParticleGraphicSWF(),graphicExport,"BitmapData");
            }
            else
            {
               graphicMovieClip = DCResourceManager.instance.getFromSWF(particleReference.getParticleGraphicSWF(),graphicExport,"MovieClip");
            }
         }
      }
      
      public function getGraphicExport() : String
      {
         return graphicExport;
      }
      
      public function leaveParticleTail() : Boolean
      {
         var _loc1_:* = null;
         if(particleReference.leaveTail && currentSpeed > 0)
         {
            _loc1_ = new Point(x,y);
            if(Math.abs(Point.distance(previousTailPoint,_loc1_)) >= 30)
            {
               previousTailPoint.x = x;
               previousTailPoint.y = y;
               return true;
            }
         }
         return false;
      }
      
      public function setLifeTimer(newLifeTimer:int) : void
      {
         lifeTimer = newLifeTimer;
      }
      
      public function createStationaryClone() : Particle
      {
         if(!particleReference.leaveTail)
         {
            return null;
         }
         var _loc1_:Particle = new Particle(previousTailPoint,lifeTimeInTotal,null,graphicAngle,particleReference,true);
         _loc1_.setLifeTimer(lifeTimer);
         setGraphicExport(_loc1_.getGraphicExport());
         return _loc1_;
      }
   }
}
