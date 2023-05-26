package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class DamageOpponentsWeaponIdsAndTagged extends Counter
   {
       
      
      public function DamageOpponentsWeaponIdsAndTagged(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var cumulativeDamage:int = 0;
         var _loc4_:int = 0;
         var i:int = 0;
         var _loc2_:* = null;
         if(checkIfEmissionIdMatchesIdsInParams(msg.emission))
         {
            cumulativeDamage = 0;
            _loc4_ = msg.affectedGameObjects.length;
            for(i = 0; i < _loc4_; )
            {
               _loc2_ = msg.affectedGameObjects[i] as PlayerGameObject;
               if(_loc2_ && _loc6_._id != playerId)
               {
                  if(_loc2_.tag.hasPlayerIDInTag(playerId))
                  {
                     cumulativeDamage += msg.damageToGameObjects[i];
                  }
               }
               i++;
            }
            if(cumulativeDamage > 0)
            {
               updateValue(cumulativeDamage);
            }
         }
      }
      
      public function checkIfEmissionIdMatchesIdsInParams(emission:Emission) : Boolean
      {
         if(params)
         {
            if(params.weaponIDs && params.weaponIDs.indexOf(emission.id) != -1 || params.boosterIDs && params.boosterIDs.indexOf(emission.id) != -1 || params.damageIDs && params.damageIDs.indexOf(emission.id) != -1)
            {
               return true;
            }
            LogUtils.log(toString() + " EmissionId: " + emission.id + " match no ID in params: " + params.toString(),"DamageOpponentUsingWeaponIds",0,"Challenges",false);
         }
         else
         {
            LogUtils.log(toString() + " No Params configured!","DamageOpponentUsingWeaponIds",2,"Challenges");
         }
         return false;
      }
   }
}
