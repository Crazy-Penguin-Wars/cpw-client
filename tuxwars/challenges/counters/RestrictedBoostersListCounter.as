package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeBoosterUsedMessage;
   
   public class RestrictedBoostersListCounter extends Counter
   {
      private var invalidated:Boolean;
      
      public function RestrictedBoostersListCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
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
      
      override public function handleBoosterUsed(param1:ChallengeBoosterUsedMessage) : void
      {
         if(this.invalidated)
         {
            return;
         }
         if(param1.playerId == playerId)
         {
            if(params)
            {
               if(Boolean(params.boosterIDs) && params.boosterIDs.indexOf(param1.boosterId) != -1)
               {
                  this.invalidated = true;
                  challenge.notifyCounterStateChanged();
                  return;
               }
               updateValue(1);
            }
            else
            {
               LogUtils.addDebugLine("Challenges",toString() + " Params missing.","RestrictedBoostersListCounter");
            }
         }
      }
   }
}

