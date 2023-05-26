package tuxwars.challenges.counters
{
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class PlayerDamagedCounter extends Counter
   {
       
      
      public function PlayerDamagedCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = msg.firingPlayer;
         if(playerId != _loc3_._id)
         {
            _loc2_ = calculateTotalDamage(msg);
            if(_loc2_ > 0)
            {
               updateValue(_loc2_);
            }
         }
      }
      
      private function calculateTotalDamage(msg:ChallengeAmmoHitMessage) : int
      {
         var i:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = msg.affectedGameObjects.length;
         for(i = 0; i < _loc4_; )
         {
            _loc2_ = msg.affectedGameObjects[i] as PlayerGameObject;
            if(_loc2_ && _loc6_._id == playerId)
            {
               return msg.damageToGameObjects[i];
            }
            i++;
         }
         return 0;
      }
   }
}
