package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class PlayerDamagedWithoutDying extends Counter
   {
      public function PlayerDamagedWithoutDying(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc7_:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:PlayerGameObject = null;
         var _loc5_:* = false;
         var _loc6_:* = param1.firingPlayer;
         if(playerId != _loc6_._id)
         {
            if(this.checkIfEmissionIdMatchesIdsInParams(param1.emission))
            {
               _loc2_ = int(param1.affectedGameObjects.length);
               _loc3_ = 0;
               while(_loc3_ < _loc2_)
               {
                  _loc4_ = param1.affectedGameObjects[_loc3_] as PlayerGameObject;
                  if((Boolean(_loc4_)) && _loc7_._id == playerId)
                  {
                     _loc7_ = _loc4_;
                     _loc5_ = _loc7_.cahcedHP - param1.damageToGameObjects[_loc3_] <= 0;
                     if(!_loc5_)
                     {
                        updateValue(param1.damageToGameObjects[_loc3_]);
                     }
                     return;
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      public function checkIfEmissionIdMatchesIdsInParams(param1:Emission) : Boolean
      {
         if(params)
         {
            if(param1)
            {
               if(Boolean(param1.id) && (params.weaponIDs && (params.weaponIDs.indexOf(param1.id) != -1 || params.weaponIDs.indexOf("all") != -1) || (params.boosterIDs && params.boosterIDs.indexOf(param1.id) != -1 || params.boosterIDs.indexOf("all") != -1)))
               {
                  return true;
               }
               LogUtils.log(toString() + " EmissionId: " + param1.id + " not found in params weaponIDs: " + params.weaponIDs.toString(),"PlayerDamagedUsingWeaponIds",0,"Challenges",false);
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

