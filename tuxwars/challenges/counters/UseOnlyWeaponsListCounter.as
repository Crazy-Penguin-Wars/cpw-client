package tuxwars.challenges.counters
{
   import no.olog.utilfunctions.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeBoosterUsedMessage;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class UseOnlyWeaponsListCounter extends Counter
   {
      private var invalidated:Boolean;
      
      private var weaponsList:Array;
      
      public function UseOnlyWeaponsListCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
         this.weaponsList = [];
         assert(toString() + " Params for counter is null.",true,param5 != null);
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = completed;
         super.reset();
         this.invalidated = false;
         this.weaponsList = [];
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
         if(_loc2_._id == playerId && Boolean(params))
         {
            if(params.weaponIDs && params.weaponIDs.indexOf(param1.weapon.id) != -1 || params.boosterIDs && params.boosterIDs.indexOf(param1.weapon.id) != -1)
            {
               if(this.weaponsList.indexOf(param1.weapon.id) == -1)
               {
                  updateValue(1);
                  this.weaponsList.push(param1.weapon.id);
               }
            }
            else if(challenge.scope == "Match")
            {
               this.invalidated = true;
               challenge.notifyCounterStateChanged();
            }
         }
      }
      
      override public function handleBoosterUsed(param1:ChallengeBoosterUsedMessage) : void
      {
         if(this.invalidated)
         {
            return;
         }
         if(param1.playerId == playerId && Boolean(params.boosterIDs))
         {
            if(params.boosterIDs.indexOf(param1.boosterId) != -1)
            {
               updateValue(1);
            }
            else
            {
               this.invalidated = true;
               challenge.notifyCounterStateChanged();
            }
         }
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         return true;
      }
   }
}

