package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   
   public class MatchesWonRowCounter extends Counter
   {
      public function MatchesWonRowCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleMatchEnded(param1:MatchEndedMessage) : void
      {
         if(Boolean(param1.getPlayerWithHighestScore()) && playerId == _loc2_._id)
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

