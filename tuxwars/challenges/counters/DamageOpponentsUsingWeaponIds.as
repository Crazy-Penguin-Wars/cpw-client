package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class DamageOpponentsUsingWeaponIds extends Counter
   {
       
      
      public function DamageOpponentsUsingWeaponIds(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var cumulativeDamage:int = 0;
         var _loc4_:int = 0;
         var i:int = 0;
         var _loc2_:* = null;
         var _loc6_:* = msg.firingPlayer;
         if(playerId == _loc6_._id)
         {
            if(checkIfEmissionIdMatchesIdsInParams(msg.emission))
            {
               cumulativeDamage = 0;
               _loc4_ = msg.affectedGameObjects.length;
               for(i = 0; i < _loc4_; )
               {
                  _loc2_ = msg.affectedGameObjects[i] as PlayerGameObject;
                  if(_loc2_ && _loc7_._id != playerId)
                  {
                     cumulativeDamage += msg.damageToGameObjects[i];
                  }
                  i++;
               }
               if(cumulativeDamage > 0)
               {
                  updateValue(cumulativeDamage);
               }
            }
         }
      }
      
      public function checkIfEmissionIdMatchesIdsInParams(emission:Emission) : Boolean
      {
         if(params)
         {
            if(emission)
            {
               if(params.weaponIDs && params.weaponIDs.indexOf(emission.id) != -1 || params.boosterIDs && params.boosterIDs.indexOf(emission.id) != -1)
               {
                  return true;
               }
               LogUtils.log("EmissionId: " + emission.id + " match no ID in params: " + params.toString(),this,0,"Challenges",false);
            }
            else
            {
               LogUtils.log("Emission null",this,2,"Challenges",false);
            }
         }
         else
         {
            LogUtils.log("No Params configured!",this,2,"Challenges");
         }
         return false;
      }
   }
}
