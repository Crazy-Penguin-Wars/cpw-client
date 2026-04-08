package com.dchoc.utils
{
   import flash.display.MovieClip;
   import flash.utils.*;
   import tuxwars.battle.world.*;
   
   public class FpsCounter extends MovieClip
   {
      private var mStartTick:Number;
      
      private var mSecondTick:Number;
      
      private var mNumFrames:Number;
      
      private var mSecondNumFrames:Number;
      
      private var mNumLogicUpdated:int;
      
      private var mHighestFps:int;
      
      private var mLowestFps:int;
      
      private var mLevelname:String;
      
      private var numPhysUpdates:int;
      
      private var mReadyStartedTime:int;
      
      private var mTimeBetweenTurns:String;
      
      public function FpsCounter()
      {
         super();
         this.reset();
      }
      
      public function reset() : void
      {
         this.mNumFrames = 0;
         this.mSecondNumFrames = 0;
         this.mNumLogicUpdated = 0;
         this.mHighestFps = 0;
         this.mLowestFps = 30;
         this.mStartTick = getTimer();
         this.mSecondTick = getTimer();
         this.mReadyStartedTime = -1;
         this.mTimeBetweenTurns = "";
         PhysicsUpdater.register(this,"ClientTracker");
      }
      
      public function dispose() : void
      {
         PhysicsUpdater.unregister(this,"ClientTracker");
      }
      
      public function logicUpdate(param1:int) : void
      {
         ++this.mNumLogicUpdated;
      }
      
      public function physicsUpdate(param1:int) : void
      {
         ++this.numPhysUpdates;
      }
      
      public function frameRendered() : int
      {
         var _loc1_:Number = Number(NaN);
         var _loc2_:int = -1;
         ++this.mNumFrames;
         ++this.mSecondNumFrames;
         var _loc3_:Number = Number(getTimer());
         if(_loc3_ - this.mSecondTick >= 1000)
         {
            _loc1_ = (_loc3_ - this.mSecondTick) * 0.001;
            _loc2_ = Math.round(this.mSecondNumFrames / _loc1_);
            if(_loc2_ > this.mHighestFps)
            {
               this.mHighestFps = _loc2_;
            }
            if(_loc2_ < this.mLowestFps)
            {
               this.mLowestFps = _loc2_;
            }
            this.mSecondTick = _loc3_;
            this.mSecondNumFrames = 0;
         }
         return _loc2_;
      }
      
      public function get frameRate() : int
      {
         var _loc1_:Number = (getTimer() - this.mStartTick) * 0.001;
         return Math.round(this.mNumFrames / _loc1_);
      }
      
      public function get logicUpdateRate() : int
      {
         var _loc1_:Number = (getTimer() - this.mStartTick) * 0.001;
         return Math.round(this.mNumLogicUpdated / _loc1_);
      }
      
      public function get physicsUpdateRate() : int
      {
         var _loc1_:Number = (getTimer() - this.mStartTick) * 0.001;
         return Math.round(this.numPhysUpdates / _loc1_);
      }
      
      public function get lowestFps() : int
      {
         return this.mLowestFps;
      }
      
      public function get highestFps() : int
      {
         return this.mHighestFps;
      }
      
      public function get levelName() : String
      {
         return this.mLevelname;
      }
      
      public function set levelName(param1:String) : void
      {
         this.mLevelname = param1;
      }
      
      public function clientReady() : void
      {
         this.mReadyStartedTime = getTimer();
      }
      
      public function startTurn() : void
      {
         if(this.mReadyStartedTime != -1)
         {
            this.mTimeBetweenTurns += (getTimer() - this.mReadyStartedTime) * 0.001 + ",";
         }
      }
      
      public function get timeBetweenTurns() : String
      {
         return this.mTimeBetweenTurns;
      }
   }
}

