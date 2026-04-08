package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class MatchesWonCounter extends Counter
   {
      public function MatchesWonCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleMatchEnded(param1:MatchEndedMessage) : void
      {
         if(Boolean(param1.getPlayerWithHighestScore()) && _loc2_._id == playerId)
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

