package com.nnyman.tween
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class SequencePlayer extends Sprite
   {
       
      
      private var sequences:Array;
      
      private var lastUpdateTime:uint;
      
      public function SequencePlayer()
      {
         sequences = [];
         super();
      }
      
      public function addSequence(sequence:Sequence) : void
      {
         sequences.push(sequence);
         if(sequences.length == 1)
         {
            addEventListener("enterFrame",run);
         }
      }
      
      public function removeSequence(sequence:Sequence) : void
      {
         sequences.splice(sequences.indexOf(sequence),1);
         if(sequences.length == 0)
         {
            removeEventListener("enterFrame",run);
            lastUpdateTime = 0;
         }
      }
      
      public function getLastUpdateTime() : uint
      {
         if(lastUpdateTime == 0)
         {
            lastUpdateTime = getTimer();
         }
         return lastUpdateTime;
      }
      
      public function run(event:Event) : void
      {
         var i:int = 0;
         var sequence:* = null;
         var sequenceSteps:* = null;
         var sequenceTime:* = 0;
         var sequenceDone:Boolean = false;
         var n:int = 0;
         var step:* = null;
         lastUpdateTime = getTimer();
         for(i = 0; i < sequences.length; )
         {
            sequence = sequences[i];
            sequenceSteps = sequence.getSteps();
            sequenceTime = lastUpdateTime - sequence.getStartTime();
            sequenceDone = true;
            for(n = 0; n < sequenceSteps.length; )
            {
               step = sequenceSteps[n];
               if(step.done == false)
               {
                  step.currentTime = sequenceTime - step.startTime;
                  if(step.currentTime > 0)
                  {
                     if(!step.started)
                     {
                        step.start();
                     }
                     if(step.currentTime > step.duration)
                     {
                        step.finish();
                     }
                     else
                     {
                        sequenceDone = false;
                     }
                     for(var property in step.startValues)
                     {
                        step.target[property] = step.easing.apply(null,[step.currentTime,step.startValues[property],step.changeValues[property],step.duration]);
                     }
                  }
                  else
                  {
                     sequenceDone = false;
                  }
               }
               n++;
            }
            if(sequenceDone)
            {
               sequence.stop();
               i--;
            }
            i++;
         }
      }
   }
}
