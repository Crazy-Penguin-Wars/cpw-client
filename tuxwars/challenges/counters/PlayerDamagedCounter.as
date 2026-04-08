package tuxwars.challenges.counters
{
   import tuxwars.battle.gameobjects.player.*;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class PlayerDamagedCounter extends Counter
   {
      public function PlayerDamagedCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = param1.firingPlayer;
         if(playerId != _loc3_._id)
         {
            _loc2_ = int(this.calculateTotalDamage(param1));
            if(_loc2_ > 0)
            {
               updateValue(_loc2_);
            }
         }
      }
      
      private function calculateTotalDamage(param1:ChallengeAmmoHitMessage) : int
      {
         var _loc2_:int = 0;
         var _loc3_:PlayerGameObject = null;
         var _loc4_:int = 0;
         var _loc5_:int = int(param1.affectedGameObjects.length);
         _loc2_ = 0;
         while(_loc2_ < _loc5_)
         {
            _loc3_ = param1.affectedGameObjects[_loc2_] as PlayerGameObject;
            if(Boolean(_loc3_) && _loc6_._id == playerId)
            {
               return param1.damageToGameObjects[_loc2_];
            }
            _loc2_++;
         }
         return _loc4_;
      }
   }
}

