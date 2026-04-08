package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class DestroyAllLevelObjectsCounter extends Counter
   {
      public function DestroyAllLevelObjectsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleEndGameConfirm(param1:ChallengeEndGameConfirm) : void
      {
         if(param1.gameObjects)
         {
            if(param1.gameObjects.gameObjectsExist(LevelGameObject) <= 0)
            {
               updateValue(1);
            }
         }
         else
         {
            LogUtils.log(toString() + " no gameObjects array",this,0,"Challenges",false,false,false);
         }
      }
   }
}

