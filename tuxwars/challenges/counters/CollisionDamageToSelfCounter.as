package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   
   public class CollisionDamageToSelfCounter extends Counter
   {
      public function CollisionDamageToSelfCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleTakeCollisionDamage(param1:ChallengeTakeCollisionDamageMessage) : void
      {
         var _loc2_:* = undefined;
         if(param1.damagedObject)
         {
            _loc2_ = param1.damagedObject;
            if(_loc2_._id == playerId)
            {
               if(ChallengeParamReference.getAffectsObject(param1.objectDoingDamage,params))
               {
                  updateValue(param1.damageAmount);
               }
            }
         }
         else
         {
            LogUtils.log(toString() + " no damagedObject",this,0,"Challenges",false,false,false);
         }
      }
   }
}

