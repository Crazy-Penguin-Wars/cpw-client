package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class MatchesWonRowCounter extends Counter
   {
       
      
      public function MatchesWonRowCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleMatchEnded(msg:MatchEndedMessage) : void
      {
         if(msg.getPlayerWithHighestScore() && playerId == _loc2_._id)
         {
            updateValue(1,false);
         }
         else
         {
            reset();
            LogUtils.addDebugLine("Challenges",toString() + " Reset.",this);
         }
      }
   }
}
