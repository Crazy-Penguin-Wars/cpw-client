package tuxwars.challenges.counters
{
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeAmmoHitMessage;
   
   public class HitsUniqueTargetsCounter extends Counter
   {
       
      
      private const playerList:Array = [];
      
      public function HitsUniqueTargetsCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleAmmoHit(msg:ChallengeAmmoHitMessage) : void
      {
         var _loc3_:* = undefined;
         var _loc4_:* = msg.firingPlayer;
         if(playerId == _loc4_._id)
         {
            _loc3_ = msg.affectedPlayers;
            for each(var player in _loc3_)
            {
               if(playerList.indexOf(player) == -1 && _loc5_._id != _loc6_._id)
               {
                  playerList.push(player);
                  updateValue(1);
               }
            }
         }
      }
      
      override public function reset() : void
      {
         playerList.splice(0,playerList.length);
         super.reset();
      }
   }
}
