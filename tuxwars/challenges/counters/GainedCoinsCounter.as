package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeGainedCoinsMessage;
   
   public class GainedCoinsCounter extends Counter
   {
       
      
      public function GainedCoinsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleGainedCoins(msg:ChallengeGainedCoinsMessage) : void
      {
         if(playerId == msg.playerId)
         {
            if(msg.gainedCoins > 0)
            {
               updateValue(msg.gainedCoins,false);
            }
         }
      }
   }
}
