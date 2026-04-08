package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.emitters.Emission;
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class DamageOpponentsUsingWeaponIds extends Counter
   {
      public function DamageOpponentsUsingWeaponIds(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:PlayerGameObject = null;
         var _loc6_:* = param1.firingPlayer;
         if(playerId == _loc6_._id)
         {
            if(this.checkIfEmissionIdMatchesIdsInParams(param1.emission))
            {
               _loc2_ = 0;
               _loc3_ = int(param1.affectedGameObjects.length);
               _loc4_ = 0;
               while(_loc4_ < _loc3_)
               {
                  _loc5_ = param1.affectedGameObjects[_loc4_] as PlayerGameObject;
                  if((Boolean(_loc5_)) && _loc7_._id != playerId)
                  {
                     _loc2_ += param1.damageToGameObjects[_loc4_];
                  }
                  _loc4_++;
               }
               if(_loc2_ > 0)
               {
                  updateValue(_loc2_);
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
               if(params.weaponIDs && params.weaponIDs.indexOf(param1.id) != -1 || params.boosterIDs && params.boosterIDs.indexOf(param1.id) != -1)
               {
                  return true;
               }
               LogUtils.log("EmissionId: " + param1.id + " match no ID in params: " + params.toString(),this,0,"Challenges",false);
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

