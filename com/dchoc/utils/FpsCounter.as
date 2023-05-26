package com.dchoc.utils
{
   import flash.display.MovieClip;
   import flash.utils.getTimer;
   import tuxwars.battle.world.PhysicsUpdater;
   
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
         reset();
      }
      
      public function reset() : void
      {
         mNumFrames = 0;
         mSecondNumFrames = 0;
         mNumLogicUpdated = 0;
         mHighestFps = 0;
         mLowestFps = 30;
         mStartTick = getTimer();
         mSecondTick = getTimer();
         mReadyStartedTime = -1;
         mTimeBetweenTurns = "";
         PhysicsUpdater.register(this,"ClientTracker");
      }
      
      public function dispose() : void
      {
         PhysicsUpdater.unregister(this,"ClientTracker");
      }
      
      public function logicUpdate(time:int) : void
      {
         mNumLogicUpdated++;
      }
      
      public function physicsUpdate(time:int) : void
      {
         numPhysUpdates++;
      }
      
      public function frameRendered() : int
      {
         var t:Number = NaN;
         var lastSecondFps:int = -1;
         mNumFrames++;
         mSecondNumFrames++;
         var now:Number = getTimer();
         if(now - mSecondTick >= 1000)
         {
            t = (now - mSecondTick) * 0.001;
            lastSecondFps = Math.round(mSecondNumFrames / t);
            if(lastSecondFps > mHighestFps)
            {
               mHighestFps = lastSecondFps;
            }
            if(lastSecondFps < mLowestFps)
            {
               mLowestFps = lastSecondFps;
            }
            mSecondTick = now;
            mSecondNumFrames = 0;
         }
         return lastSecondFps;
      }
      
      public function get frameRate() : int
      {
         var t:Number = (getTimer() - mStartTick) * 0.001;
         return Math.round(mNumFrames / t);
      }
      
      public function get logicUpdateRate() : int
      {
         var t:Number = (getTimer() - mStartTick) * 0.001;
         return Math.round(mNumLogicUpdated / t);
      }
      
      public function get physicsUpdateRate() : int
      {
         var t:Number = (getTimer() - mStartTick) * 0.001;
         return Math.round(numPhysUpdates / t);
      }
      
      public function get lowestFps() : int
      {
         return mLowestFps;
      }
      
      public function get highestFps() : int
      {
         return mHighestFps;
      }
      
      public function get levelName() : String
      {
         return mLevelname;
      }
      
      public function set levelName(name:String) : void
      {
         mLevelname = name;
      }
      
      public function clientReady() : void
      {
         mReadyStartedTime = getTimer();
      }
      
      public function startTurn() : void
      {
         if(mReadyStartedTime != -1)
         {
            mTimeBetweenTurns += (getTimer() - mReadyStartedTime) * 0.001 + ",";
         }
      }
      
      public function get timeBetweenTurns() : String
      {
         return mTimeBetweenTurns;
      }
   }
}
