package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.PhysicsGameObject;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   
   public class CollisionDamageToSelfNotTaggedCounter extends Counter
   {
      public function CollisionDamageToSelfNotTaggedCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleTakeCollisionDamage(param1:ChallengeTakeCollisionDamageMessage) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:PhysicsGameObject = null;
         if(param1.damagedObject)
         {
            _loc3_ = param1.damagedObject;
            if(_loc3_._id == playerId)
            {
               _loc2_ = param1.objectDoingDamage;
               if(_loc2_)
               {
                  if(_loc2_.tag)
                  {
                     if(_loc2_.tag.findLatestPlayerTagger() == null)
                     {
                        if(ChallengeParamReference.getAffectsObject(_loc2_,params))
                        {
                           updateValue(param1.damageAmount);
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

