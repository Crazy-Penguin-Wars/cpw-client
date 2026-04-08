package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class UseOnlyWeaponCounter extends DynamicCounter
   {
      private var invalidated:Boolean;
      
      public function UseOnlyWeaponCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
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
            if(param1.weapon.id == targetId)
            {
               if(this.value < targetValue)
               {
                  updateValue(1);
               }
            }
            else if(challenge.scope == "Match")
            {
               this.invalidated = true;
               challenge.notifyCounterStateChanged();
               return;
            }
         }
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         return true;
      }
   }
}

