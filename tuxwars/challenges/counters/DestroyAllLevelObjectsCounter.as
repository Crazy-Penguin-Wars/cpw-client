package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.LevelGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class DestroyAllLevelObjectsCounter extends Counter
   {
       
      
      public function DestroyAllLevelObjectsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleEndGameConfirm(msg:ChallengeEndGameConfirm) : void
      {
         if(msg.gameObjects)
         {
            if(msg.gameObjects.gameObjectsExist(LevelGameObject) <= 0)
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
