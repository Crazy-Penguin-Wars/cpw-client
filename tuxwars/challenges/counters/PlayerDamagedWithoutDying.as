package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class PlayerDamagedWithoutDying extends Counter
   {
       
      
      public function PlayerDamagedWithoutDying(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var _loc4_:int = 0;
         var i:int = 0;
         var playerGameObject:* = null;
         var goingToDie:Boolean = false;
         var _loc6_:* = msg.firingPlayer;
         if(playerId != _loc6_._id)
         {
            if(checkIfEmissionIdMatchesIdsInParams(msg.emission))
            {
               _loc4_ = msg.affectedGameObjects.length;
               for(i = 0; i < _loc4_; )
               {
                  playerGameObject = msg.affectedGameObjects[i] as PlayerGameObject;
                  if(playerGameObject && _loc7_._id == playerId)
                  {
                     var _loc8_:* = playerGameObject;
                     goingToDie = Number(_loc8_.cahcedHP) - msg.damageToGameObjects[i] <= 0;
                     if(!goingToDie)
                     {
                        updateValue(msg.damageToGameObjects[i]);
                     }
                     return;
                  }
                  i++;
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
               if(emission.id && (params.weaponIDs && (params.weaponIDs.indexOf(emission.id) != -1 || params.weaponIDs.indexOf("all") != -1) || (params.boosterIDs && params.boosterIDs.indexOf(emission.id) != -1 || params.boosterIDs.indexOf("all") != -1)))
               {
                  return true;
               }
               LogUtils.log(toString() + " EmissionId: " + emission.id + " not found in params weaponIDs: " + params.weaponIDs.toString(),"PlayerDamagedUsingWeaponIds",0,"Challenges",false);
            }
            else
            {
               LogUtils.log(toString() + " Emission null","PlayerDamagedUsingWeaponIds",2,"Challenges");
            }
         }
         else
         {
            LogUtils.log(toString() + " No Params configured!","PlayerDamagedUsingWeaponIds",2,"Challenges");
         }
         return false;
      }
   }
}
