package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class AddedStatusToOpponentCounter extends Counter
   {
      public function AddedStatusToOpponentCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = param1.firingPlayer;
         if(_loc3_._id == playerId)
         {
            if(params)
            {
               if(param1.emissionExplosionRef)
               {
                  _loc2_ = param1.emissionReference.followers;
                  if(_loc2_)
                  {
                     for each(_loc4_ in params.statusIDs)
                     {
                        for each(_loc5_ in _loc2_)
                        {
                           if(_loc5_ && _loc5_.id == _loc4_)
                           {
                              for each(_loc6_ in param1.affectedPlayers)
                              {
                                 _loc7_ = _loc6_;
                                 if(_loc7_._id != playerId && _loc6_.getFollower(_loc4_) != null)
                                 {
                                    updateValue(1);
                                    return;
                                 }
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     LogUtils.log(toString() + " EmissionReference has no followers",this,0,"Challenges",false,false,false);
                  }
               }
               else
               {
                  LogUtils.log(toString() + "EmissionReference is null",this,0,"Challenges",false,false,false);
               }
            }
            else
            {
               LogUtils.log(toString() + " params null",this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}

