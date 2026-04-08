package com.nnyman.tween
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.*;
   
   public class SequencePlayer extends Sprite
   {
      private var sequences:Array = [];
      
      private var lastUpdateTime:uint;
      
      public function SequencePlayer()
      {
         super();
      }
      
      public function addSequence(param1:Sequence) : void
      {
         this.sequences.push(param1);
         if(this.sequences.length == 1)
         {
            addEventListener("enterFrame",this.run);
         }
      }
      
      public function removeSequence(param1:Sequence) : void
      {
         this.sequences.splice(this.sequences.indexOf(param1),1);
         if(this.sequences.length == 0)
         {
            removeEventListener("enterFrame",this.run);
            this.lastUpdateTime = 0;
         }
      }
      
      public function getLastUpdateTime() : uint
      {
         if(this.lastUpdateTime == 0)
         {
            this.lastUpdateTime = getTimer();
         }
         return this.lastUpdateTime;
      }
      
      public function run(param1:Event) : void
      {
         var _loc9_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:Sequence = null;
         var _loc4_:Array = null;
         var _loc5_:* = 0;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:SequenceStep = null;
         this.lastUpdateTime = getTimer();
         _loc2_ = 0;
         while(_loc2_ < this.sequences.length)
         {
            _loc3_ = this.sequences[_loc2_];
            _loc4_ = _loc3_.getSteps();
            _loc5_ = uint(this.lastUpdateTime - _loc3_.getStartTime());
            _loc6_ = true;
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length)
            {
               _loc8_ = _loc4_[_loc7_];
               if(_loc8_.done == false)
               {
                  _loc8_.currentTime = _loc5_ - _loc8_.startTime;
                  if(_loc8_.currentTime > 0)
                  {
                     if(!_loc8_.started)
                     {
                        _loc8_.start();
                     }
                     if(_loc8_.currentTime > _loc8_.duration)
                     {
                        _loc8_.finish();
                     }
                     else
                     {
                        _loc6_ = false;
                     }
                     for(_loc9_ in _loc8_.startValues)
                     {
                        _loc8_.target[_loc9_] = _loc8_.easing.apply(null,[_loc8_.currentTime,_loc8_.startValues[_loc9_],_loc8_.changeValues[_loc9_],_loc8_.duration]);
                     }
                  }
                  else
                  {
                     _loc6_ = false;
                  }
               }
               _loc7_++;
            }
            if(_loc6_)
            {
               _loc3_.stop();
               _loc2_--;
            }
            _loc2_++;
         }
      }
   }
}

