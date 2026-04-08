package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class MatchEndHitpointsCounter extends Counter
   {
      public function MatchEndHitpointsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleEndGameConfirm(param1:ChallengeEndGameConfirm) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:int = 0;
         for each(_loc3_ in param1.players)
         {
            _loc4_ = _loc3_;
            if(_loc4_._id == playerId)
            {
               _loc2_ = int(_loc3_.calculateHitPoints());
               if(_loc2_ >= targetValue)
               {
                  updateValue(_loc2_);
               }
               else
               {
                  LogUtils.log(toString() + " players hiptoins less than target value",this,0,"Challenges",false,false,false);
               }
               return;
            }
         }
         LogUtils.log(toString() + " player not found",this,0,"Challenges",false,false,false);
      }
   }
}

