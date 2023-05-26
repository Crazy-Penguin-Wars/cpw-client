package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class AcceptableWeaponsList extends FailingWeaponsList
   {
       
      
      public function AcceptableWeaponsList(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleWeaponUsed(msg:ChallengeWeaponUsedMessage) : void
      {
         if(invalidated)
         {
            return;
         }
         var _loc2_:* = msg.weapon.player;
         if(_loc2_._id == playerId)
         {
            if(params)
            {
               if(msg.weapon.id)
               {
                  if(params.weaponIDs)
                  {
                     if(params.weaponIDs && (params.weaponIDs.indexOf("all") != -1 || params.weaponIDs.indexOf(msg.weapon.id) != -1) || params.boosterIDs && (params.boosterIDs.indexOf("all") != -1 || params.boosterIDs.indexOf(msg.weapon.id) != -1))
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
