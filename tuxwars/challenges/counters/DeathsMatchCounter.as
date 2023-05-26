package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class DeathsMatchCounter extends Counter
   {
       
      
      public function DeathsMatchCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handlePlayerDied(msg:ChallengePlayerDiedMessage) : void
      {
         var _loc2_:* = msg.player;
         if(_loc2_._id == playerId)
         {
            updateValue(1);
         }
      }
   }
}
