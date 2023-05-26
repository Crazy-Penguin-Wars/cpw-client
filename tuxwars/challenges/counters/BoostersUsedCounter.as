package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeBoosterUsedMessage;
   
   public class BoostersUsedCounter extends DynamicCounter
   {
       
      
      public function BoostersUsedCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleBoosterUsed(msg:ChallengeBoosterUsedMessage) : void
      {
         if(msg.playerId == playerId)
         {
            updateValue(1);
         }
      }
   }
}
