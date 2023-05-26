package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class UseOnlyWeaponCounter extends DynamicCounter
   {
       
      
      private var invalidated:Boolean;
      
      public function UseOnlyWeaponCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = completed;
         super.reset();
         invalidated = false;
         if(_loc1_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function get value() : int
      {
         return invalidated ? 0 : super.value;
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
            if(msg.weapon.id == targetId)
            {
               if(value < targetValue)
               {
                  updateValue(1);
               }
            }
            else if(challenge.scope == "Match")
            {
               invalidated = true;
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
