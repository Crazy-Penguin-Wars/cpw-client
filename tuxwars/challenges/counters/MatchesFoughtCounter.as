package tuxwars.challenges.counters
{
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class MatchesFoughtCounter extends Counter
   {
       
      
      public function MatchesFoughtCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleMatchEnded(msg:MatchEndedMessage) : void
      {
         updateValue(1,false);
      }
   }
}
