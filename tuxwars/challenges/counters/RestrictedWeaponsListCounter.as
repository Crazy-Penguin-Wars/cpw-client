package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class RestrictedWeaponsListCounter extends Counter
   {
      private var invalidated:Boolean;
      
      public function RestrictedWeaponsListCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
         assert(toString() + " Params for counter is null.",true,param5 != null);
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = completed;
         super.reset();
         this.invalidated = false;
         if(_loc1_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function get value() : int
      {
         return !!this.invalidated ? 0 : super.value;
      }
      
      override public function handleWeaponUsed(param1:ChallengeWeaponUsedMessage) : void
      {
         if(this.invalidated)
         {
            return;
         }
         var _loc2_:* = param1.weapon.player;
         if(_loc2_._id == playerId)
         {
            if(params)
            {
               if(Boolean(param1.weapon.id) && (params.weaponIDs && (params.weaponIDs.indexOf(param1.weapon.id) != -1 || params.weaponIDs.indexOf("all") != -1) || params.boosterIDs && (params.boosterIDs.indexOf(param1.weapon.id) != -1 || params.boosterIDs.indexOf("all") != -1)))
               {
                  if(challenge.scope == "Match")
                  {
                     this.invalidated = true;
                     value = 0;
                     challenge.notifyCounterStateChanged();
                  }
               }
               else if(this.value < targetValue)
               {
                  updateValue(1);
               }
            }
            else
            {
               LogUtils.addDebugLine("Challenges",toString() + " Params missing.","RestrictedWeaponsListCounter");
            }
         }
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         return true;
      }
   }
}

