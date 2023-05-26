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
      
      public function UIProgressIndicator(design:MovieClip, min:int, max:int)
      {
         super(design);
         fillAnim = design.Fill;
         setValues(min,min,max);
         addedValue = 0;
         timeRemaining = 0;
      }
      
      public function getCurrentValue() : int
      {
         return value;
      }
      
      public function getMaxValue() : int
      {
         return maxValue;
      }
      
      public function setValues(v:int, min:int, max:int) : void
      {
         v = Math.min(Math.max(v,min),max);
         setMinValue(min);
         setMaxValue(max);
         setValue(v);
      }
      
      public function setMinValue(min:int) : void
      {
         if(min != minValue)
         {
            minValuePrevious = minValue;
         }
         minValue = min;
      }
      
      public function setMaxValue(max:int) : void
      {
         if(max != maxValue)
         {
            maxValuePrevious = maxValue;
         }
         maxValue = max;
      }
      
      public function setValue(newValue:int) : void
      {
         if(!LINER_PROGRESS && addedValue != 0)
         {
            this.value += addedValue;
         }
         addedValue = newValue - this.value;
         addedValueSpeed = addedValue / 500;
         addedValueRemainder = 0;
         timeRemaining = 500;
         setFrameForCurrentValue();
      }
      
      public function setValueWithoutBarAnimation(value:int) : void
      {
         setValue(value);
         this.value = value;
         addedValue = 0;
         timeRemaining = 0;
         setFrameForCurrentValue();
      }
      
      public function getFrameForCurrentValue() : int
      {
         return getFrameForGivenValue(value);
      }
      
      private function setFrameForCurrentValue() : void
      {
         fillAnim.gotoAndStop(getFrameForCurrentValue());
      }
      
      public function getFrameForGivenValue(value:Number) : int
      {
         var max:int = 0;
         var min:int = 0;
         if(value >= minValue)
         {
            max = maxValue;
            min = minValue;
         }
         else
         {
            max = maxValuePrevious;
            min = minValuePrevious;
         }
         var v:Number = value - min;
         var frame:int = fillAnim.totalFrames * v / (max - min);
         return Math.max(0,Math.min(frame,fillAnim.totalFrames));
      }
      
      private function setFrameForGivenValue(value:Number) : void
      {
         fillAnim.gotoAndStop(getFrameForGivenValue(value));
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         var deltaValue:int = 0;
         var t:Number = NaN;
         if(LINER_PROGRESS)
         {
            if(addedValue != 0)
            {
               deltaValue = 0;
               if(addedValue > 0)
               {
                  addedValueRemainder += Math.min(addedValue,addedValueSpeed * deltaTime);
               }
               else if(addedValue < 0)
               {
                  addedValueRemainder += Math.max(addedValue,addedValueSpeed * deltaTime);
               }
               deltaValue = addedValueRemainder;
               addedValueRemainder -= deltaValue;
               value += deltaValue;
               addedValue -= deltaValue;
               timeRemaining -= deltaTime;
               if(timeRemaining <= 0 && addedValue != 0)
               {
                  value += addedValue;
                  addedValue = 0;
                  timeRemaining = 0;
               }
               setFrameForCurrentValue();
            }
         }
         else if(timeRemaining > 0)
         {
            timeRemaining = Math.max(0,timeRemaining - deltaTime);
            t = timeRemaining / 500;
            t *= t;
            t = 1 - t;
            setFrameForGivenValue(value + addedValue * t);
            if(timeRemaining == 0)
            {
               value += addedValue;
               setFrameForCurrentValue();
               addedValue = 0;
            }
         }
      }
   }
}
