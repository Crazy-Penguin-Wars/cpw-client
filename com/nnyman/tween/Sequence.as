package com.nnyman.tween
{
   import fl.motion.easing.*;
   import flash.errors.*;
   
   public class Sequence
   {
      private static var sequencePlayer:SequencePlayer;
      
      private var steps:Array = [];
      
      private var defaultEasing:Function = Quartic.easeOut;
      
      private var playing:Boolean = false;
      
      private var startTime:uint;
      
      private var stepTimeAccumulator:uint = 0;
      
      public function Sequence()
      {
         super();
      }
      
      public static function createAndStart(param1:Object) : Sequence
      {
         var _loc2_:Sequence = null;
         if(param1 != null)
         {
            _loc2_ = new Sequence();
            _loc2_.add(param1);
            _loc2_.start();
            return _loc2_;
         }
         return null;
      }
      
      public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(sequencePlayer == null)
         {
            sequencePlayer = new SequencePlayer();
         }
         sequencePlayer.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(sequencePlayer == null)
         {
            sequencePlayer = new SequencePlayer();
         }
         sequencePlayer.removeEventListener(param1,param2,param3);
      }
      
      public function setDefaultEasing(param1:Function) : void
      {
         this.defaultEasing = param1;
      }
      
      public function add(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:SequenceStep = null;
         if(!this.playing)
         {
            if(param1 is Array)
            {
               _loc2_ = 0;
               while(_loc2_ < param1.length)
               {
                  this.add(param1[_loc2_]);
                  _loc2_++;
               }
            }
            else
            {
               _loc3_ = new SequenceStep(param1);
               if(_loc3_.duration > 0 && _loc3_.easing == null)
               {
                  _loc3_.easing = this.defaultEasing;
               }
               _loc3_.startTime = this.stepTimeAccumulator + _loc3_.delay;
               if(_loc3_.stepDuration >= 0)
               {
                  this.stepTimeAccumulator += _loc3_.stepDuration;
               }
               else
               {
                  this.stepTimeAccumulator += _loc3_.delay + _loc3_.duration;
               }
               this.steps.push(_loc3_);
            }
            return;
         }
         throw new IllegalOperationError("Unable to add new steps while the sequence is being played");
      }
      
      public function addDelay(param1:Number) : void
      {
         this.stepTimeAccumulator += param1 * 1000;
      }
      
      public function start() : void
      {
         var _loc1_:int = 0;
         if(sequencePlayer == null)
         {
            sequencePlayer = new SequencePlayer();
         }
         if(!this.playing)
         {
            _loc1_ = 0;
            while(_loc1_ < this.steps.length)
            {
               this.steps[_loc1_].reset();
               _loc1_++;
            }
            sequencePlayer.addSequence(this);
            this.startTime = sequencePlayer.getLastUpdateTime();
            this.playing = true;
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
         if(this.playing)
         {
            sequencePlayer.removeSequence(this);
            this.playing = false;
         }
      }
      
      public function isPlaying() : Boolean
      {
         return this.playing;
      }
      
      public function getStartTime() : uint
      {
         return this.startTime;
      }
      
      public function getSteps() : Array
      {
         return this.steps;
      }
   }
}

