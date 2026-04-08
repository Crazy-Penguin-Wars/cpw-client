package tuxwars.battle.utils
{
   import com.dchoc.game.DCGame;
   import tuxwars.battle.world.*;
   
   public class PerformanceTuner
   {
      public static var _particleStreamSpawnDistanceAugmentationPercentage:int;
      
      public static var _particleStreamSpawnTimeAugmentationPercentage:int;
      
      private static const WAIT_X_SECONDS_FOR_1ST_CHECK:int = 10;
      
      private static const CHECK_EVERY_X_SECONDS:int = 5;
      
      private static const ACTION_STOP_IDLE_ANIM:int = 0;
      
      private static const ACTION_STOP_RAIN:int = 1;
      
      private static const ACTION_STOP_WATER_FX:int = 3;
      
      private static const ACTION_REDUCE_PARTICLES_AMOUNT:int = 4;
      
      private static const ACTION_AUGMENT_MISSILES_SPAWN_DISTANCE:int = 5;
      
      private static const ACTION_AUGMENT_MISSILES_SPAWN_TIME:int = 6;
      
      private static const CONFIG:Array = [15,1,0,15,3,0,14,4,30,13,0,0,13,4,50,13,5,100,13,6,100,10,4,80,10,5,200,10,6,200,8,5,300,8,6,300];
      
      private var mFrameRateAverage:int;
      
      private var mLowestFrameRate:int;
      
      private var mFirstCheckDone:Boolean;
      
      private var mSecondsSinceLastPerformanceCheck:int;
      
      protected var mGame:DCGame;
      
      private var mLevelsFrameRate:Array;
      
      private var mLevelId:String;
      
      public function PerformanceTuner(param1:DCGame)
      {
         super();
         this.mGame = param1;
         this.mLevelsFrameRate = [];
      }
      
      public function resetFrameRate(param1:String = null) : void
      {
         this.mLevelId = param1;
         this.mLowestFrameRate = 30;
         if(Boolean(param1) && Boolean(this.mLevelsFrameRate[param1]))
         {
            this.mFrameRateAverage = this.mLevelsFrameRate[param1];
            this.checkPerformance();
         }
         else
         {
            this.mFrameRateAverage = 30;
         }
         this.mSecondsSinceLastPerformanceCheck = 0;
         this.mFirstCheckDone = false;
         _particleStreamSpawnDistanceAugmentationPercentage = 0;
         _particleStreamSpawnTimeAugmentationPercentage = 0;
      }
      
      public function setFrameRate(param1:int) : void
      {
         this.mFrameRateAverage = this.mFrameRateAverage + param1 >> 1;
         ++this.mSecondsSinceLastPerformanceCheck;
         var _loc2_:int = !!this.mFirstCheckDone ? 5 : 10;
         if(this.mSecondsSinceLastPerformanceCheck >= _loc2_)
         {
            this.checkPerformance();
         }
      }
      
      public function checkPerformance() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.mFirstCheckDone = true;
         var _loc3_:int = int(CONFIG.length);
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = int(CONFIG[_loc1_]);
            if(this.mFrameRateAverage <= _loc2_ && this.mLowestFrameRate > _loc2_)
            {
               this.turnOnOff(CONFIG[_loc1_ + 1],CONFIG[_loc1_ + 2]);
            }
            _loc1_ += 3;
         }
         if(this.mFrameRateAverage < this.mLowestFrameRate)
         {
            this.mLowestFrameRate = this.mFrameRateAverage;
            this.mLevelsFrameRate[this.mLevelId] = this.mLowestFrameRate;
         }
         this.mSecondsSinceLastPerformanceCheck = 0;
      }
      
      public function turnOnOff(param1:int, param2:int) : void
      {
         var _loc4_:* = undefined;
         var _loc3_:Array = null;
         switch(param1)
         {
            case 0:
               _loc3_ = TuxWorld(this.mGame.world).players;
               for each(_loc4_ in _loc3_)
               {
                  _loc4_.noMoreIdleAnim();
               }
               break;
            case 1:
               TuxWorld(this.mGame.world).turnOffRain();
               break;
            case 3:
               TuxWorld(this.mGame.world).turnOffWaterFx();
               break;
            case 4:
               TuxWorld(this.mGame.world).reduceParticlesAmount(param2);
               break;
            case 5:
               _particleStreamSpawnDistanceAugmentationPercentage = param2;
               break;
            case 6:
               _particleStreamSpawnTimeAugmentationPercentage = param2;
         }
      }
   }
}

