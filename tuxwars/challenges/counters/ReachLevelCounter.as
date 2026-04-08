package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeReachLevelMessage;
   
   public class ReachLevelCounter extends Counter
   {
      public function ReachLevelCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleReachedLevel(param1:ChallengeReachLevelMessage) : void
      {
         var _loc2_:int = 0;
         if(playerId == param1.playerId)
         {
            if(param1.reachedLevel >= value)
            {
               _loc2_ = param1.reachedLevel - value;
               updateValue(_loc2_ > 0 ? _loc2_ : 0,false);
            }
         }
         else
         {
            LogUtils.log(toString() + " WRONG PLAYER! " + param1.playerId + " != " + playerId,this,2,"Challenges",false,false,false);
         }
      }
   }
}

