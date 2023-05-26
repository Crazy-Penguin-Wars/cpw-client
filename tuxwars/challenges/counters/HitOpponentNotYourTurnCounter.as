package tuxwars.challenges.counters
{
   import com.dchoc.utils.LogUtils;
   import tuxwars.battle.BattleManager;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitOpponentNotYourTurnCounter extends HitOpponentCounter
   {
       
      
      public function HitOpponentNotYourTurnCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         if(BattleManager.getCurrentActivePlayer() != null && _loc2_._id != _loc3_._id)
         {
            LogUtils.addDebugLine("Challenges",toString() + "Hit opponent not on your turn");
            super.handleAmmoHit(msg);
         }
      }
   }
}
