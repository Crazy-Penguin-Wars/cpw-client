package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class ScoreHighestCounter extends Counter
   {
      public function ScoreHighestCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleEndGameConfirm(param1:ChallengeEndGameConfirm) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:* = param1.getPlayerWithHighestScore();
         if(_loc4_._id == playerId)
         {
            updateValue(1);
         }
         else
         {
            _loc2_ = param1.getPlayerWithHighestScore().getScore();
            for each(_loc5_ in param1.players)
            {
               _loc6_ = _loc5_;
               if(_loc6_._id == playerId)
               {
                  _loc3_ = int(_loc5_.getScore());
                  if(_loc3_ == _loc2_)
                  {
                     updateValue(1);
                  }
                  else if(_loc3_ > _loc2_)
                  {
                     updateValue(1);
                     LogUtils.log(toString() + " player had a higher score than the highest score, sort not work!!!",this,3,"Challenges",false,false,false);
                  }
                  else
                  {
                     LogUtils.log(toString() + " player did not have the highest score",this,0,"Challenges",false,false,false);
                  }
                  return;
               }
            }
         }
      }
   }
}

