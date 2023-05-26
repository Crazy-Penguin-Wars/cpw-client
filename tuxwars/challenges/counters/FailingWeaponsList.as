package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class FailingWeaponsList extends CounterLessThan
   {
       
      
      private var _invalidated:Boolean;
      
      public function FailingWeaponsList(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
         assert(toString() + " Params for counter is null.",true,params != null);
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = completed;
         super.reset();
         _invalidated = false;
         if(_loc1_ != completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function get value() : int
      {
         return _invalidated ? 0 : super.value;
      }
      
      override public function handleWeaponUsed(msg:ChallengeWeaponUsedMessage) : void
      {
         if(_invalidated)
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
                  invalidate();
                  challenge.notifyCounterStateChanged();
                  return;
               }
               updateValue(1);
            }
            else
            {
               LogUtils.addDebugLine("Challenges",toString() + " Params missing.","FailingWeaponsListCounter");
            }
         }
      }
      
      public function get invalidated() : Boolean
      {
         return _invalidated;
      }
      
      public function invalidate() : void
      {
         _invalidated = true;
      }
      
      override public function get completed() : Boolean
      {
         return value >= targetValue;
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         return true;
      }
   }
}
