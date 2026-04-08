package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeGainedCoinsMessage;
   
   public class GainedCoinsCounter extends Counter
   {
      public function GainedCoinsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleGainedCoins(param1:ChallengeGainedCoinsMessage) : void
      {
         if(playerId == param1.playerId)
         {
            if(param1.gainedCoins > 0)
            {
               updateValue(param1.gainedCoins,false);
            }
         }
      }
   }
}

