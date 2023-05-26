package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   
   public class CollisionDamageToSelfNotTaggedCounter extends Counter
   {
       
      
      public function CollisionDamageToSelfNotTaggedCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleTakeCollisionDamage(msg:ChallengeTakeCollisionDamageMessage) : void
      {
         var _loc2_:* = null;
         if(msg.damagedObject)
         {
            var _loc3_:* = msg.damagedObject;
            if(_loc3_._id == playerId)
            {
               _loc2_ = msg.objectDoingDamage;
               if(_loc2_)
               {
                  if(_loc2_.tag)
                  {
                     if(_loc2_.tag.findLatestPlayerTagger() == null)
                     {
                        if(ChallengeParamReference.getAffectsObject(_loc2_,params))
                        {
                           updateValue(msg.damageAmount);
                        }
                     }
                     else
                     {
                        LogUtils.log(toString() + " objectDoingDamage has no player tag",this,0,"Challenges",false,false,false);
                     }
                  }
                  else
                  {
                     LogUtils.log(toString() + " objectDoingDamage has no tag",this,0,"Challenges",false,false,false);
                  }
               }
               else
               {
                  LogUtils.log(toString() + " no objectDoingDamage",this,0,"Challenges",false,false,false);
               }
            }
         }
      }
   }
}
