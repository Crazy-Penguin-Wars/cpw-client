package tuxwars.battle.effects
{
   import com.dchoc.resources.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.filters.*;
   import flash.geom.*;
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
      
      public function Particle(param1:Point, param2:int, param3:Point, param4:Number, param5:ParticleReference, param6:Boolean = false)
      {
         super();
         this.particleReference = param5;
         this.lifeTimeInTotal = param2 > 0 ? param2 : 1;
         this.lifeTimer = param2;
         this.effectTimer = param2 * param5.colorEffectTimePercentage / 100;
         this.effectTimeInTotal = this.effectTimer;
         if(param3)
         {
            this.vector.x = param3.x;
            this.vector.y = param3.y;
         }
         if(param6)
         {
            this.speedStart = 0;
            this.speedEnd = 0;
            this.currentSpeed = 0;
            this.speedChangePercentage = 0;
         }
         else
         {
            this.speedStart = param5.speedStart / 100;
            this.speedEnd = param5.speedEnd / 100;
            this.currentSpeed = this.speedStart;
            this.speedChangePercentage = param5.speedChangeTimePercentage / 100;
         }
         this.fadePercentage = param5.fade / 100;
         if(this.particleReference.swingSpeed > 0)
         {
            this.swingAngle = -60 + Math.random() * (60 * 2);
            this.swingingForward = this.swingAngle > 0;
         }
         x = param1.x;
         y = param1.y;
         if(Boolean(param5.getParticleGraphicSWF()) && Boolean(param5.getParticleGraphicExport()))
         {
            this.graphicAngle = param4;
            this.graphicExport = param5.getParticleGraphicExport()[int(Math.random() * param5.getParticleGraphicExport().length)];
            if(this.graphicExport.indexOf(".png") > -1)
            {
               this.graphicBitmapData = DCResourceManager.instance.getFromSWF(param5.getParticleGraphicSWF(),this.graphicExport,"BitmapData");
            }
            else
            {
               this.graphicMovieClip = DCResourceManager.instance.getFromSWF(param5.getParticleGraphicSWF(),this.graphicExport,"MovieClip");
            }
         }
         else
         {
            graphics.beginFill(param5.color);
            graphics.drawCircle(0,0,param5.size);
            graphics.endFill();
         }
         if(param5.leaveTail)
         {
            this.previousTailPoint.x = x;
            this.previousTailPoint.y = y;
         }
      }
      
      public function dispose() : void
      {
         if(Boolean(parent) && parent.contains(this))
         {
            parent.removeChild(this);
         }
         if(this.graphicBitmapData)
         {
            this.graphicBitmapData.dispose();
            this.graphicBitmapData = null;
         }
         if(this.graphicMovieClip)
         {
            DCUtils.stopMovieClip(this.graphicMovieClip);
            DCUtils.disposeAllBitmapData(this.graphicMovieClip);
            this.graphicMovieClip = null;
         }
      }
      
      public function update(param1:uint) : Boolean
      {
         var _loc2_:Number = Number(NaN);
         var _loc3_:Number = Number(NaN);
         var _loc4_:Number = Number(NaN);
         var _loc5_:Array = null;
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Bitmap = null;
         this.lifeTimer -= param1;
         if(this.lifeTimer <= 0)
         {
            return true;
         }
         var _loc10_:Number = this.lifeTimer / this.lifeTimeInTotal;
         var _loc11_:Number = 1 - _loc10_;
         this.effectTimer -= param1;
         if(this.effectTimer <= 0)
         {
            this.effectTimer = 0;
         }
         if(_loc11_ <= this.speedChangePercentage)
         {
            if(this.particleReference.speedSmoothChange)
            {
               this.currentSpeed = this.speedEnd + (this.speedStart - this.speedEnd) * (1 - _loc11_ / this.speedChangePercentage);
            }
            else
            {
               this.currentSpeed = this.speedStart;
            }
         }
         else
         {
            this.currentSpeed = this.speedEnd;
         }
         var _loc12_:Number = this.vector.x * (this.currentSpeed * param1);
         var _loc13_:Number = this.vector.y * (this.currentSpeed * param1);
         var _loc14_:Number = 0;
         var _loc15_:Number = 0;
         if(this.particleReference.swingSpeed > 0)
         {
            if(this.swingingForward)
            {
               this.swingAngle += this.particleReference.swingSpeed * param1;
               if(this.swingAngle > 60)
               {
                  this.swingAngle = 60;
                  this.swingingForward = false;
               }
            }
            else
            {
               this.swingAngle -= this.particleReference.swingSpeed * param1;
               if(this.swingAngle < -60)
               {
                  this.swingAngle = -60;
                  this.swingingForward = true;
               }
            }
            _loc14_ = Math.sin(this.swingAngle * 3.141592653589793 / 180) * _loc13_;
            _loc15_ = -Math.sin(this.swingAngle * 3.141592653589793 / 180) * _loc12_;
         }
         x = x + _loc12_ + _loc14_;
         y = y + _loc13_ + _loc15_;
         this.vector.y += 0.002 * this.particleReference.gravity * param1;
         var _loc16_:Number = 0.002 * (this.vector.x * this.particleReference.friction) * param1;
         var _loc17_:* = this.vector.x < 0;
         this.vector.x -= _loc16_;
         this.vector.x = this.vector.x < 0 == _loc17_ ? Number(this.vector.x) : 0;
         rotation += this.particleReference.rotationSpeed * param1 / 100;
         var _loc18_:Number = this.effectTimer > 0 ? this.effectTimer / this.effectTimeInTotal : 0;
         var _loc19_:Number = 1 - _loc18_;
         if(this.particleReference.shrink)
         {
            scaleX = _loc10_;
            scaleY = _loc10_;
         }
         else if(this.particleReference.multiplySize > 0)
         {
            scaleX = 1 + _loc11_ * this.particleReference.multiplySize;
            scaleY = 1 + _loc11_ * this.particleReference.multiplySize;
         }
         var _loc20_:ColorTransform = transform.colorTransform;
         if(_loc11_ > this.fadePercentage)
         {
            _loc20_.alphaMultiplier = 1 - (_loc11_ - this.fadePercentage) / (1 - this.fadePercentage);
         }
         if(Boolean(this.particleReference.colorModIndex) && this.particleReference.colorModIndex != "none")
         {
            _loc2_ = (this.particleReference.colorModValue & 0xFF0000) >>> 16;
            _loc3_ = (this.particleReference.colorModValue & 0xFF00) >>> 8;
            _loc4_ = this.particleReference.colorModValue & 0xFF;
            if(this.particleReference.colorModIndex == "tint")
            {
               _loc20_.redMultiplier = _loc18_;
               _loc20_.redOffset = _loc19_ * _loc2_;
               _loc20_.blueMultiplier = _loc18_;
               _loc20_.blueOffset = _loc19_ * _loc4_;
               _loc20_.greenMultiplier = _loc18_;
               _loc20_.greenOffset = _loc19_ * _loc3_;
            }
            else if(this.particleReference.colorModIndex == "filter")
            {
               _loc5_ = [];
               _loc6_ = _loc2_ / 255;
               _loc7_ = _loc3_ / 255;
               _loc8_ = _loc4_ / 255;
               _loc5_ = _loc5_.concat([1 - (1 - _loc6_) * _loc19_,0,0,0,0]);
               _loc5_ = _loc5_.concat([0,1 - (1 - _loc7_) * _loc19_,0,0,0]);
               _loc5_ = _loc5_.concat([0,0,1 - (1 - _loc8_) * _loc19_,0,0]);
               _loc5_ = _loc5_.concat([0,0,0,1,0]);
               filters = [new ColorMatrixFilter(_loc5_)];
            }
         }
         transform.colorTransform = _loc20_;
         if(Boolean(this.graphicBitmapData) || Boolean(this.graphicMovieClip))
         {
            graphics.clear();
            while(numChildren > 0)
            {
               removeChildAt(0);
            }
            if(this.graphicBitmapData)
            {
               _loc9_ = new Bitmap(this.graphicBitmapData);
               _loc9_.rotation = this.graphicAngle;
               addChild(_loc9_);
            }
            else
            {
               this.graphicMovieClip.rotation = this.graphicAngle;
               addChild(this.graphicMovieClip);
            }
            this.graphicBitmapData = null;
            this.graphicMovieClip = null;
         }
         return false;
      }
      
      public function setGraphicExport(param1:String) : void
      {
         this.graphicExport = param1;
         if(this.particleReference.getParticleGraphicSWF())
         {
            if(this.graphicExport.indexOf(".png") > -1)
            {
               this.graphicBitmapData = DCResourceManager.instance.getFromSWF(this.particleReference.getParticleGraphicSWF(),this.graphicExport,"BitmapData");
            }
            else
            {
               this.graphicMovieClip = DCResourceManager.instance.getFromSWF(this.particleReference.getParticleGraphicSWF(),this.graphicExport,"MovieClip");
            }
         }
      }
      
      public function getGraphicExport() : String
      {
         return this.graphicExport;
      }
      
      public function leaveParticleTail() : Boolean
      {
         var _loc1_:Point = null;
         if(Boolean(this.particleReference.leaveTail) && this.currentSpeed > 0)
         {
            _loc1_ = new Point(x,y);
            if(Math.abs(Point.distance(this.previousTailPoint,_loc1_)) >= 30)
            {
               this.previousTailPoint.x = x;
               this.previousTailPoint.y = y;
               return true;
            }
         }
         return false;
      }
      
      public function setLifeTimer(param1:int) : void
      {
         this.lifeTimer = param1;
      }
      
      public function createStationaryClone() : Particle
      {
         if(!this.particleReference.leaveTail)
         {
            return null;
         }
         var _loc1_:Particle = new Particle(this.previousTailPoint,this.lifeTimeInTotal,null,this.graphicAngle,this.particleReference,true);
         _loc1_.setLifeTimer(this.lifeTimer);
         this.setGraphicExport(_loc1_.getGraphicExport());
         return _loc1_;
      }
   }
}

