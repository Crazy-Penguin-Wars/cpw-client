package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeBoosterUsedMessage;
   
   public class BoostersUsedCounter extends DynamicCounter
   {
      public function BoostersUsedCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleBoosterUsed(param1:ChallengeBoosterUsedMessage) : void
      {
         if(param1.playerId == playerId)
         {
            updateValue(1);
         }
      }
   }
}

