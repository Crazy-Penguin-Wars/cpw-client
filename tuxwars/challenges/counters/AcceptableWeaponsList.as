package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class AcceptableWeaponsList extends FailingWeaponsList
   {
      public function AcceptableWeaponsList(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleWeaponUsed(param1:ChallengeWeaponUsedMessage) : void
      {
         if(invalidated)
         {
            return;
         }
         var _loc2_:* = param1.weapon.player;
         if(_loc2_._id == playerId)
         {
            if(params)
            {
               if(param1.weapon.id)
               {
                  if(params.weaponIDs)
                  {
                     if(params.weaponIDs && (params.weaponIDs.indexOf("all") != -1 || params.weaponIDs.indexOf(param1.weapon.id) != -1) || params.boosterIDs && (params.boosterIDs.indexOf("all") != -1 || params.boosterIDs.indexOf(param1.weapon.id) != -1))
                     {
                        updateValue(1);
                        return;
                     }
                  }
                  invalidate();
                  challenge.notifyCounterStateChanged();
               }
            }
            else
            {
               LogUtils.addDebugLine("Challenges",toString() + " Params missing.","AcceptableWeaponsListCounter");
            }
         }
      }
   }
}

