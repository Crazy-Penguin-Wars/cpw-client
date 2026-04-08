package com.dchoc.ui.progress
{
   import com.dchoc.ui.base.UIComponent;
   import flash.display.MovieClip;
   
   public class UIProgressIndicator extends UIComponent
   {
      public static const ANIMATION_TIME:int = 500;
      
      private var fillAnim:MovieClip;
      
      private var minValue:int;
      
      private var maxValue:int;
      
      private var minValuePrevious:int;
      
      private var maxValuePrevious:int;
      
      private var addedValue:int;
      
      private var addedValueSpeed:Number;
      
      private var addedValueRemainder:Number;
      
      private var value:int;
      
      private var timeRemaining:int;
      
      private var LINER_PROGRESS:Boolean = true;
      
      public function UIProgressIndicator(param1:MovieClip, param2:int, param3:int)
      {
         super(param1);
         this.fillAnim = param1.Fill;
         this.setValues(param2,param2,param3);
         this.addedValue = 0;
         this.timeRemaining = 0;
      }
      
      public function getCurrentValue() : int
      {
         return this.value;
      }
      
      public function getMaxValue() : int
      {
         return this.maxValue;
      }
      
      public function setValues(param1:int, param2:int, param3:int) : void
      {
         param1 = Math.min(Math.max(param1,param2),param3);
         this.setMinValue(param2);
         this.setMaxValue(param3);
         this.setValue(param1);
      }
      
      public function setMinValue(param1:int) : void
      {
         if(param1 != this.minValue)
         {
            this.minValuePrevious = this.minValue;
         }
         this.minValue = param1;
      }
      
      public function setMaxValue(param1:int) : void
      {
         if(param1 != this.maxValue)
         {
            this.maxValuePrevious = this.maxValue;
         }
         this.maxValue = param1;
      }
      
      public function setValue(param1:int) : void
      {
         if(!this.LINER_PROGRESS && this.addedValue != 0)
         {
            this.value += this.addedValue;
         }
         this.addedValue = param1 - this.value;
         this.addedValueSpeed = this.addedValue / 500;
         this.addedValueRemainder = 0;
         this.timeRemaining = 500;
         this.setFrameForCurrentValue();
      }
      
      public function setValueWithoutBarAnimation(param1:int) : void
      {
         this.setValue(param1);
         this.value = param1;
         this.addedValue = 0;
         this.timeRemaining = 0;
         this.setFrameForCurrentValue();
      }
      
      public function getFrameForCurrentValue() : int
      {
         return this.getFrameForGivenValue(this.value);
      }
      
      private function setFrameForCurrentValue() : void
      {
         this.fillAnim.gotoAndStop(this.getFrameForCurrentValue());
      }
      
      public function getFrameForGivenValue(param1:Number) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 >= this.minValue)
         {
            _loc2_ = int(this.maxValue);
            _loc3_ = int(this.minValue);
         }
         else
         {
            _loc2_ = int(this.maxValuePrevious);
            _loc3_ = int(this.minValuePrevious);
         }
         var _loc4_:Number = param1 - _loc3_;
         var _loc5_:int = this.fillAnim.totalFrames * _loc4_ / (_loc2_ - _loc3_);
         return int(Math.max(0,Math.min(_loc5_,this.fillAnim.totalFrames)));
      }
      
      private function setFrameForGivenValue(param1:Number) : void
      {
         this.fillAnim.gotoAndStop(this.getFrameForGivenValue(param1));
      }
      
      public function logicUpdate(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Number = Number(NaN);
         if(this.LINER_PROGRESS)
         {
            if(this.addedValue != 0)
            {
               _loc2_ = 0;
               if(this.addedValue > 0)
               {
                  this.addedValueRemainder += Math.min(this.addedValue,this.addedValueSpeed * param1);
               }
               else if(this.addedValue < 0)
               {
                  this.addedValueRemainder += Math.max(this.addedValue,this.addedValueSpeed * param1);
               }
               _loc2_ = int(this.addedValueRemainder);
               this.addedValueRemainder -= _loc2_;
               this.value += _loc2_;
               this.addedValue -= _loc2_;
               this.timeRemaining -= param1;
               if(this.timeRemaining <= 0 && this.addedValue != 0)
               {
                  this.value += this.addedValue;
                  this.addedValue = 0;
                  this.timeRemaining = 0;
               }
               this.setFrameForCurrentValue();
            }
         }
         else if(this.timeRemaining > 0)
         {
            this.timeRemaining = Math.max(0,this.timeRemaining - param1);
            _loc3_ = this.timeRemaining / 500;
            _loc3_ *= _loc3_;
            _loc3_ = 1 - _loc3_;
            this.setFrameForGivenValue(this.value + this.addedValue * _loc3_);
            if(this.timeRemaining == 0)
            {
               this.value += this.addedValue;
               this.setFrameForCurrentValue();
               this.addedValue = 0;
            }
         }
      }
   }
}

