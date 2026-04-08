package tuxwars.challenges.counters
{
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitsCounter extends Counter
   {
      private var waitingForMatchToEnd:Boolean;
      
      public function HitsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
         this.waitingForMatchToEnd = param1.scope == "Match";
      }
      
      override public function handleMatchEnded(param1:MatchEndedMessage) : void
      {
         this.waitingForMatchToEnd = false;
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:* = undefined;
         var _loc3_:int = 0;
         var _loc4_:* = param1.firingPlayer;
         if(playerId == _loc4_._id)
         {
            _loc2_ = param1.affectedPlayers;
            _loc3_ = int(_loc2_.indexOf(param1.firingPlayer));
            updateValue(_loc3_ == -1 ? int(_loc2_.length) : int(_loc2_.length - 1));
         }
      }
      
      override public function get completed() : Boolean
      {
         if(targetValue == 0)
         {
            if(this.waitingForMatchToEnd)
            {
               return false;
            }
            return value == 0;
         }
         return super.completed;
      }
      
      override public function get forceCounterUpdate() : Boolean
      {
         if(targetValue == 0)
         {
            return value == 0;
         }
         return false;
      }
   }
}

