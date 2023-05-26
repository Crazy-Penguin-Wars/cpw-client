package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeTakeCollisionDamageMessage;
   
   public class CollisionDamageUsingTagCounter extends Counter
   {
       
      
      public function CollisionDamageUsingTagCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleTakeCollisionDamage(msg:ChallengeTakeCollisionDamageMessage) : void
      {
         var _loc2_:* = null;
         if(msg.playerTaggerOfObjectDoingDamage)
         {
            var _loc3_:* = msg.playerTaggerOfObjectDoingDamage;
            if(_loc3_._id == playerId)
            {
               _loc2_ = msg.damagedObject as PlayerGameObject;
               if(_loc2_)
               {
                  var _loc4_:* = _loc2_;
                  if(_loc4_._id != playerId)
                  {
                     if(ChallengeParamReference.getAffectsObject(msg.objectDoingDamage,params))
                     {
                        updateValue(msg.damageAmount);
                     }
                  }
                  else
                  {
                     var _loc5_:* = _loc2_;
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
