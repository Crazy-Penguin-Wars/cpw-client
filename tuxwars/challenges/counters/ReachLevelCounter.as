package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeReachLevelMessage;
   
   public class ReachLevelCounter extends Counter
   {
       
      
      public function ReachLevelCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleReachedLevel(msg:ChallengeReachLevelMessage) : void
      {
         var _loc2_:int = 0;
         if(playerId == msg.playerId)
         {
            if(msg.reachedLevel >= value)
            {
               _loc2_ = msg.reachedLevel - value;
               updateValue(_loc2_ > 0 ? _loc2_ : 0,false);
            }
         }
         else
         {
            LogUtils.log(toString() + " WRONG PLAYER! " + msg.playerId + " != " + playerId,this,2,"Challenges",false,false,false);
         }
      }
   }
}
