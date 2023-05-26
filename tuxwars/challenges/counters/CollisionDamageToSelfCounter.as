package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   
   public class CollisionDamageToSelfCounter extends Counter
   {
       
      
      public function CollisionDamageToSelfCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleTakeCollisionDamage(msg:ChallengeTakeCollisionDamageMessage) : void
      {
         if(msg.damagedObject)
         {
            var _loc2_:* = msg.damagedObject;
            if(_loc2_._id == playerId)
            {
               if(ChallengeParamReference.getAffectsObject(msg.objectDoingDamage,params))
               {
                  updateValue(msg.damageAmount);
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
