package tuxwars.challenges.counters
{
   import no.olog.utilfunctions.assert;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeBoosterUsedMessage;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class UseOnlyWeaponsListCounter extends Counter
   {
       
      
      private var invalidated:Boolean;
      
      private var weaponsList:Array;
      
      public function UseOnlyWeaponsListCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
         weaponsList = [];
         assert(toString() + " Params for counter is null.",true,params != null);
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = completed;
         super.reset();
         invalidated = false;
         weaponsList = [];
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
         if(_loc2_._id == playerId && params)
         {
            if(params.weaponIDs && params.weaponIDs.indexOf(msg.weapon.id) != -1 || params.boosterIDs && params.boosterIDs.indexOf(msg.weapon.id) != -1)
            {
               if(weaponsList.indexOf(msg.weapon.id) == -1)
               {
                  updateValue(1);
                  weaponsList.push(msg.weapon.id);
               }
            }
            else if(challenge.scope == "Match")
            {
               invalidated = true;
               challenge.notifyCounterStateChanged();
            }
         }
      }
      
      override public function handleBoosterUsed(msg:ChallengeBoosterUsedMessage) : void
      {
         if(invalidated)
         {
            return;
         }
         if(msg.playerId == playerId && params.boosterIDs)
         {
            if(params.boosterIDs.indexOf(msg.boosterId) != -1)
            {
               updateValue(1);
            }
            else
            {
               invalidated = true;
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
