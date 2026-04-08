package com.nnyman.tween
{
   import flash.utils.*;
   
   public class SequenceStep
   {
      public var target:Object;
      
      public var easing:Function;
      
      public var functionCall:Function;
      
      public var functionParameters:Array;
      
      public var delay:int = 0;
      
      public var duration:int = 0;
      
      public var stepDuration:int = -1;
      
      public var startTime:int = 0;
      
      public var currentTime:int = 0;
      
      public var startValues:Object;
      
      public var changeValues:Object;
      
      public var destinationValues:Object;
      
      public var started:Boolean;
      
      public var done:Boolean;
      
      public function SequenceStep(param1:Object)
      {
         var _loc2_:* = undefined;
         this.startValues = {};
         this.changeValues = {};
         this.destinationValues = {};
         super();
         if(param1.hasOwnProperty("target"))
         {
            if(param1.target == null)
            {
               throw new ArgumentError("Step target is null");
            }
         }
         else
         {
            if(!param1.hasOwnProperty("call"))
            {
               throw new ArgumentError("Either target or function call must be specified when creating a sequence step");
            }
            if(param1.call == null)
            {
               throw new ArgumentError("Step function call is null");
            }
         }
         for(_loc2_ in param1)
         {
            if(_loc2_ == "target")
            {
               this.target = param1["target"];
            }
            else if(_loc2_ == "easing")
            {
               this.easing = param1["easing"];
            }
            else if(_loc2_ == "delay")
            {
               this.delay = Math.max(0,param1["delay"]) * 1000;
            }
            else if(_loc2_ == "duration")
            {
               this.duration = Math.max(0,param1["duration"]) * 1000;
            }
            else if(_loc2_ == "stepDuration")
            {
               this.stepDuration = Math.max(0,param1["stepDuration"]) * 1000;
            }
            else if(_loc2_ == "call")
            {
               this.functionCall = param1["call"];
            }
            else if(_loc2_ == "parameters")
            {
               this.functionParameters = param1["parameters"];
            }
            else
            {
               if(param1.target == null)
               {
                  throw new ArgumentError("Property " + _loc2_ + " can\'t be set without a target");
               }
               if(!param1.target.hasOwnProperty(_loc2_))
               {
                  throw new ArgumentError("Property " + _loc2_ + " not found on target " + getQualifiedClassName(param1.target));
               }
               this.destinationValues[_loc2_] = param1[_loc2_];
            }
         }
      }
      
      public function reset() : void
      {
         this.done = false;
         this.started = false;
      }
      
      public function start() : void
      {
         var _loc1_:* = undefined;
         var _loc2_:* = undefined;
         if(this.functionCall != null)
         {
            this.functionCall.apply(null,this.functionParameters);
         }
         if(this.target != null)
         {
            if(this.duration > 0)
            {
               for(_loc1_ in this.destinationValues)
               {
                  this.startValues[_loc1_] = this.target[_loc1_];
                  this.changeValues[_loc1_] = this.destinationValues[_loc1_] - this.startValues[_loc1_];
               }
               this.started = true;
            }
            else
            {
               for(_loc2_ in this.destinationValues)
               {
                  this.target[_loc2_] = this.destinationValues[_loc2_];
               }
               this.done = true;
            }
         }
         else
         {
            this.done = true;
         }
      }
      
      public function finish() : void
      {
         this.currentTime = this.duration;
         this.done = true;
      }
   }
}

