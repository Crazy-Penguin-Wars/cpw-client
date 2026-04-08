package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeWeaponUsedMessage;
   
   public class FailingWeaponsList extends CounterLessThan
   {
      private var _invalidated:Boolean;
      
      public function FailingWeaponsList(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
         assert(toString() + " Params for counter is null.",true,param5 != null);
      }
      
      override public function reset() : void
      {
         var _loc1_:Boolean = this.completed;
         super.reset();
         this._invalidated = false;
         if(_loc1_ != this.completed)
         {
            challenge.notifyCounterStateChanged();
         }
      }
      
      override public function get value() : int
      {
         return !!this._invalidated ? 0 : super.value;
      }
      
      override public function handleWeaponUsed(param1:ChallengeWeaponUsedMessage) : void
      {
         if(this._invalidated)
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
                  this.invalidate();
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
         return this._invalidated;
      }
      
      public function invalidate() : void
      {
         this._invalidated = true;
      }
      
      override public function get completed() : Boolean
      {
         return this.value >= targetValue;
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         return true;
      }
   }
}

