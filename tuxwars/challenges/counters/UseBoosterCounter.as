package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeBoosterUsedMessage;
   
   public class UseBoosterCounter extends DynamicCounter
   {
       
      
      public function UseBoosterCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleBoosterUsed(msg:ChallengeBoosterUsedMessage) : void
      {
         if(msg.boosterId == targetId && msg.playerId == playerId)
         {
            updateValue(1,false);
         }
      }
   }
}
