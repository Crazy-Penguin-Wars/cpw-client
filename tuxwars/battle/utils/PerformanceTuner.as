package tuxwars.battle.utils
{
   import com.dchoc.game.DCGame;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.battle.world.TuxWorld;
   
   public class PerformanceTuner
   {
      
      private static const WAIT_X_SECONDS_FOR_1ST_CHECK:int = 10;
      
      private static const CHECK_EVERY_X_SECONDS:int = 5;
      
      private static const ACTION_STOP_IDLE_ANIM:int = 0;
      
      private static const ACTION_STOP_RAIN:int = 1;
      
      private static const ACTION_STOP_WATER_FX:int = 3;
      
      private static const ACTION_REDUCE_PARTICLES_AMOUNT:int = 4;
      
      private static const ACTION_AUGMENT_MISSILES_SPAWN_DISTANCE:int = 5;
      
      private static const ACTION_AUGMENT_MISSILES_SPAWN_TIME:int = 6;
      
      private static const CONFIG:Array = [15,1,0,15,3,0,14,4,30,13,0,0,13,4,50,13,5,100,13,6,100,10,4,80,10,5,200,10,6,200,8,5,300,8,6,300];
      
      public static var _particleStreamSpawnDistanceAugmentationPercentage:int;
      
      public static var _particleStreamSpawnTimeAugmentationPercentage:int;
       
      
      private var mFrameRateAverage:int;
      
      private var mLowestFrameRate:int;
      
      private var mFirstCheckDone:Boolean;
      
      private var mSecondsSinceLastPerformanceCheck:int;
      
      protected var mGame:DCGame;
      
      private var mLevelsFrameRate:Array;
      
      private var mLevelId:String;
      
      public function PerformanceTuner(game:DCGame)
      {
         super();
         mGame = game;
         mLevelsFrameRate = [];
      }
      
      public function resetFrameRate(levelId:String = null) : void
      {
         mLevelId = levelId;
         mLowestFrameRate = 30;
         if(levelId && mLevelsFrameRate[levelId])
         {
            mFrameRateAverage = mLevelsFrameRate[levelId];
            checkPerformance();
         }
         else
         {
            mFrameRateAverage = 30;
         }
         mSecondsSinceLastPerformanceCheck = 0;
         mFirstCheckDone = false;
         _particleStreamSpawnDistanceAugmentationPercentage = 0;
         _particleStreamSpawnTimeAugmentationPercentage = 0;
      }
      
      public function setFrameRate(rate:int) : void
      {
         mFrameRateAverage = mFrameRateAverage + rate >> 1;
         mSecondsSinceLastPerformanceCheck++;
         var time:int = mFirstCheckDone ? 5 : 10;
         if(mSecondsSinceLastPerformanceCheck >= time)
         {
            checkPerformance();
         }
      }
      
      public function checkPerformance() : void
      {
         var i:int = 0;
         var frameRate:int = 0;
         mFirstCheckDone = true;
         var n:int = CONFIG.length;
         for(i = 0; i < n; )
         {
            frameRate = int(CONFIG[i]);
            if(mFrameRateAverage <= frameRate && mLowestFrameRate > frameRate)
            {
               turnOnOff(CONFIG[i + 1],CONFIG[i + 2]);
            }
            i += 3;
         }
         if(mFrameRateAverage < mLowestFrameRate)
         {
            mLowestFrameRate = mFrameRateAverage;
            mLevelsFrameRate[mLevelId] = mLowestFrameRate;
         }
         mSecondsSinceLastPerformanceCheck = 0;
      }
      
      public function turnOnOff(type:int, param:int) : void
      {
         var players:* = null;
         switch(type)
         {
            case 0:
               players = TuxWorld(mGame.world).players;
               for each(var player in players)
               {
                  player.noMoreIdleAnim();
               }
               break;
            case 1:
               TuxWorld(mGame.world).turnOffRain();
               break;
            case 3:
               TuxWorld(mGame.world).turnOffWaterFx();
               break;
            case 4:
               TuxWorld(mGame.world).reduceParticlesAmount(param);
               break;
            case 5:
               _particleStreamSpawnDistanceAugmentationPercentage = param;
               break;
            case 6:
               _particleStreamSpawnTimeAugmentationPercentage = param;
         }
      }
   }
}
