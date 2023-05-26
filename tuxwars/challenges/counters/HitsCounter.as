package tuxwars.challenges.counters
{
   import tuxwars.battle.events.MatchEndedMessage;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitsCounter extends Counter
   {
       
      
      private var waitingForMatchToEnd:Boolean;
      
      public function HitsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
         waitingForMatchToEnd = challenge.scope == "Match";
      }
      
      override public function handleMatchEnded(msg:MatchEndedMessage) : void
      {
         waitingForMatchToEnd = false;
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         var _loc4_:* = msg.firingPlayer;
         if(playerId == _loc4_._id)
         {
            _loc3_ = msg.affectedPlayers;
            _loc2_ = _loc3_.indexOf(msg.firingPlayer);
            updateValue(_loc2_ == -1 ? _loc3_.length : _loc3_.length - 1);
         }
      }
      
      override public function get completed() : Boolean
      {
         if(targetValue == 0)
         {
            if(waitingForMatchToEnd)
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
