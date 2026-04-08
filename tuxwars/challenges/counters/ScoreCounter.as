package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerScoreChangedMessage;
   
   public class ScoreCounter extends Counter
   {
      public function ScoreCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleScoreChanged(param1:ChallengePlayerScoreChangedMessage) : void
      {
         var _loc2_:* = param1.player;
         if(_loc2_._id == playerId)
         {
            updateValue(param1.amount);
         }
      }
   }
}

