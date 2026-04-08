package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class SameScoreCounter extends Counter
   {
      public function SameScoreCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleEndGameConfirm(param1:ChallengeEndGameConfirm) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:int = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc2_:int = 0;
         for each(_loc3_ in param1.players)
         {
            _loc4_ = _loc3_;
            if(_loc4_._id == playerId)
            {
               _loc5_ = 0;
               _loc6_ = param1.players;
               for each(_loc7_ in _loc6_)
               {
                  _loc2_ = int(_loc7_.getScore());
                  if(_loc2_ > 0)
                  {
                     for each(_loc8_ in param1.players)
                     {
                        _loc9_ = _loc7_;
                        _loc10_ = _loc8_;
                        if(_loc9_._id != _loc10_._id && _loc2_ == _loc8_.getScore())
                        {
                           updateValue(1);
                        }
                     }
                  }
               }
            }
         }
      }
   }
}

