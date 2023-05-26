package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class RestrictedWeaponsListCounter extends Counter
   {
       
      
      private var invalidated:Boolean;
      
      public function RestrictedWeaponsListCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
         assert(toString() + " Params for counter is null.",true,params != null);
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
            if(params)
            {
               if(msg.weapon.id && (params.weaponIDs && (params.weaponIDs.indexOf(msg.weapon.id) != -1 || params.weaponIDs.indexOf("all") != -1) || params.boosterIDs && (params.boosterIDs.indexOf(msg.weapon.id) != -1 || params.boosterIDs.indexOf("all") != -1)))
               {
                  if(challenge.scope == "Match")
                  {
                     invalidated = true;
                     value = 0;
                     challenge.notifyCounterStateChanged();
                  }
               }
               else if(value < targetValue)
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
