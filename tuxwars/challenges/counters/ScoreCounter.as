package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerScoreChangedMessage;
   
   public class ScoreCounter extends Counter
   {
       
      
      public function ScoreCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleScoreChanged(msg:ChallengePlayerScoreChangedMessage) : void
      {
         var _loc2_:* = msg.player;
         if(_loc2_._id == playerId)
         {
            updateValue(msg.amount);
         }
      }
   }
}
