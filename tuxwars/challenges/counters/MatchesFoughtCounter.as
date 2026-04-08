package tuxwars.challenges.counters
{
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class MatchesFoughtCounter extends Counter
   {
      public function MatchesFoughtCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleMatchEnded(param1:MatchEndedMessage) : void
      {
         updateValue(1,false);
      }
   }
}

