package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.*;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   
   public class CollisionDamageUsingTagCounter extends Counter
   {
      public function CollisionDamageUsingTagCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleTakeCollisionDamage(param1:ChallengeTakeCollisionDamageMessage) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:PlayerGameObject = null;
         if(param1.playerTaggerOfObjectDoingDamage)
         {
            _loc3_ = param1.playerTaggerOfObjectDoingDamage;
            if(_loc3_._id == playerId)
            {
               _loc2_ = param1.damagedObject as PlayerGameObject;
               if(_loc2_)
               {
                  _loc4_ = _loc2_;
                  if(_loc4_._id != playerId)
                  {
                     if(ChallengeParamReference.getAffectsObject(param1.objectDoingDamage,params))
                     {
                        updateValue(param1.damageAmount);
                     }
                  }
                  else
                  {
                     _loc5_ = _loc2_;
                     LogUtils.log(toString() + " no damagedObject.id " + _loc5_._id + " is the player",this,0,"Challenges",false,false,false);
                  }
               }
               else
               {
                  LogUtils.log(toString() + " no damagedObject",this,0,"Challenges",false,false,false);
               }
            }
         }
      }
   }
}

