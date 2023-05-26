package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeBoosterUsedMessage;
   
   public class RestrictedBoostersListCounter extends Counter
   {
       
      
      private var invalidated:Boolean;
      
      public function RestrictedBoostersListCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
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
      
      override public function handleBoosterUsed(msg:ChallengeBoosterUsedMessage) : void
      {
         if(invalidated)
         {
            return;
         }
         if(msg.playerId == playerId)
         {
            if(params)
            {
               if(params.boosterIDs && params.boosterIDs.indexOf(msg.boosterId) != -1)
               {
                  invalidated = true;
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
