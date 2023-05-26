package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class MatchesWonCounter extends Counter
   {
       
      
      public function MatchesWonCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleMatchEnded(msg:MatchEndedMessage) : void
      {
         if(msg.getPlayerWithHighestScore() && _loc2_._id == playerId)
         {
            updateValue(1,false);
         }
         else
         {
            LogUtils.log(toString() + " player did not win.",this,0,"Challenges",false,false,false);
         }
      }
   }
}
