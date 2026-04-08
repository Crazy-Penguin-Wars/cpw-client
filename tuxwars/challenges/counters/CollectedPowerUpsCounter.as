package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePhysicsObjectContactMessage;
   
   public class CollectedPowerUpsCounter extends Counter
   {
      public function CollectedPowerUpsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handlePhysicsObjectContact(param1:ChallengePhysicsObjectContactMessage) : void
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc2_:PlayerGameObject = param1.object as PlayerGameObject;
         var _loc3_:PowerUpGameObject = param1.objectHit as PowerUpGameObject;
         if(Boolean(_loc2_) && Boolean(_loc3_))
         {
            _loc4_ = _loc2_;
            if(_loc4_._id == playerId)
            {
               if(params == null || params.powerUpIDs == null || params.powerUpIDs && params.powerUpIDs.indexOf("all") != -1)
               {
                  updateValue(1);
                  return;
               }
               _loc5_ = _loc3_;
               if(params.powerUpIDs.indexOf(_loc5_._id) != -1)
               {
                  updateValue(1);
                  return;
               }
               _loc6_ = _loc3_;
               LogUtils.log(toString() + " Not updated because PowerUpID: " + _loc6_._id + " not found in params.",this,0,"Challenges",false,false,false);
            }
         }
      }
   }
}

