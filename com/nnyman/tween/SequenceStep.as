package com.nnyman.tween
{
   import flash.utils.getQualifiedClassName;
   
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
      
      public function SequenceStep(data:Object)
      {
         startValues = {};
         changeValues = {};
         destinationValues = {};
         super();
         if(data.hasOwnProperty("target"))
         {
            if(data.target == null)
            {
               throw new ArgumentError("Step target is null");
            }
         }
         else
         {
            if(!data.hasOwnProperty("call"))
            {
               throw new ArgumentError("Either target or function call must be specified when creating a sequence step");
            }
            if(data.call == null)
            {
               throw new ArgumentError("Step function call is null");
            }
         }
         for(var property in data)
         {
            if(property == "target")
            {
               target = data["target"];
            }
            else if(property == "easing")
            {
               easing = data["easing"];
            }
            else if(property == "delay")
            {
               delay = Math.max(0,data["delay"]) * 1000;
            }
            else if(property == "duration")
            {
               duration = Math.max(0,data["duration"]) * 1000;
            }
            else if(property == "stepDuration")
            {
               stepDuration = Math.max(0,data["stepDuration"]) * 1000;
            }
            else if(property == "call")
            {
               functionCall = data["call"];
            }
            else if(property == "parameters")
            {
               functionParameters = data["parameters"];
            }
            else
            {
               if(data.target == null)
               {
                  throw new ArgumentError("Property " + property + " can\'t be set without a target");
               }
               if(!data.target.hasOwnProperty(property))
               {
                  throw new ArgumentError("Property " + property + " not found on target " + getQualifiedClassName(data.target));
               }
               destinationValues[property] = data[property];
            }
         }
      }
      
      public function reset() : void
      {
         done = false;
         started = false;
      }
      
      public function start() : void
      {
         if(functionCall != null)
         {
            functionCall.apply(null,functionParameters);
         }
         if(target != null)
         {
            if(duration > 0)
            {
               for(var property in destinationValues)
               {
                  startValues[property] = target[property];
                  changeValues[property] = Number(destinationValues[property]) - Number(startValues[property]);
               }
               started = true;
            }
            else
            {
               for(var targetProperty in destinationValues)
               {
                  target[targetProperty] = destinationValues[targetProperty];
               }
               done = true;
            }
         }
         else
         {
            done = true;
         }
      }
      
      public function finish() : void
      {
         currentTime = duration;
         done = true;
      }
   }
}
