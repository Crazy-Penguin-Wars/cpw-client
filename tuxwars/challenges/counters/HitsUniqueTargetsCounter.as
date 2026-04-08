package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitsUniqueTargetsCounter extends Counter
   {
      private const playerList:Array = [];
      
      public function HitsUniqueTargetsCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handleAmmoHit(param1:ChallengeAmmoHitMessage) : void
      {
         var _loc4_:* = undefined;
         var _loc2_:* = undefined;
         var _loc3_:* = param1.firingPlayer;
         if(playerId == _loc3_._id)
         {
            _loc2_ = param1.affectedPlayers;
            for each(_loc4_ in _loc2_)
            {
               if(this.playerList.indexOf(_loc4_) == -1 && _loc5_._id != _loc6_._id)
               {
                  this.playerList.push(_loc4_);
                  updateValue(1);
               }
            }
         }
      }
      
      override public function reset() : void
      {
         this.playerList.splice(0,this.playerList.length);
         super.reset();
      }
   }
}

