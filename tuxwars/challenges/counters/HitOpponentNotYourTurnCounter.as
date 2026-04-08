package tuxwars.challenges.counters
{
   import com.dchoc.utils.*;
   import tuxwars.battle.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitOpponentNotYourTurnCounter extends HitOpponentCounter
   {
      public function HitOpponentNotYourTurnCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         if(BattleManager.getCurrentActivePlayer() != null && _loc2_._id != _loc3_._id)
         {
            LogUtils.addDebugLine("Challenges",toString() + "Hit opponent not on your turn");
            super.handleAmmoHit(param1);
         }
      }
   }
}

