package com.nnyman.tween
{
   import fl.motion.easing.Quartic;
   import flash.errors.IllegalOperationError;
   
   public class Sequence
   {
      
      private static var sequencePlayer:SequencePlayer;
       
      
      private var steps:Array;
      
      private var defaultEasing:Function;
      
      private var playing:Boolean = false;
      
      private var startTime:uint;
      
      private var stepTimeAccumulator:uint = 0;
      
      public function Sequence()
      {
         steps = [];
         defaultEasing = Quartic.easeOut;
         super();
      }
      
      public static function createAndStart(data:Object) : Sequence
      {
         var sequence:* = null;
         if(data != null)
         {
            sequence = new Sequence();
            sequence.add(data);
            sequence.start();
            return sequence;
         }
         return null;
      }
      
      public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         if(sequencePlayer == null)
         {
            sequencePlayer = new SequencePlayer();
         }
         sequencePlayer.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         if(sequencePlayer == null)
         {
            sequencePlayer = new SequencePlayer();
         }
         sequencePlayer.removeEventListener(type,listener,useCapture);
      }
      
      public function setDefaultEasing(defaultEasing:Function) : void
      {
         this.defaultEasing = defaultEasing;
      }
      
      public function add(data:Object) : void
      {
         var n:int = 0;
         var step:* = null;
         if(!playing)
         {
            if(data is Array)
            {
               for(n = 0; n < data.length; )
               {
                  add(data[n]);
                  n++;
               }
            }
            else
            {
               step = new SequenceStep(data);
               if(step.duration > 0 && step.easing == null)
               {
                  step.easing = defaultEasing;
               }
               step.startTime = stepTimeAccumulator + step.delay;
               if(step.stepDuration >= 0)
               {
                  stepTimeAccumulator += step.stepDuration;
               }
               else
               {
                  stepTimeAccumulator += step.delay + step.duration;
               }
               steps.push(step);
            }
            return;
         }
         throw new IllegalOperationError("Unable to add new steps while the sequence is being played");
      }
      
      public function addDelay(delay:Number) : void
      {
         stepTimeAccumulator += delay * 1000;
      }
      
      public function start() : void
      {
         var n:int = 0;
         if(sequencePlayer == null)
         {
            sequencePlayer = new SequencePlayer();
         }
         if(!playing)
         {
            for(n = 0; n < steps.length; )
            {
               steps[n].reset();
               n++;
            }
            sequencePlayer.addSequence(this);
            startTime = sequencePlayer.getLastUpdateTime();
            playing = true;
            return;
         }
         throw new IllegalOperationError("Unable to start the sequence while it is being played");
      }
      
      public function stop() : void
      {
         if(sequencePlayer == null)
         {
            sequencePlayer = new SequencePlayer();
         }
         if(playing)
         {
            sequencePlayer.removeSequence(this);
            playing = false;
         }
      }
      
      public function isPlaying() : Boolean
      {
         return playing;
      }
      
      public function getStartTime() : uint
      {
         return startTime;
      }
      
      public function getSteps() : Array
      {
         return steps;
      }
   }
}
