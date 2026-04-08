package tuxwars.challenges.counters
{
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengePlayerDiedMessage;
   
   public class DeathsMatchCounter extends Counter
   {
      public function DeathsMatchCounter(param1:Challenge, param2:String, param3:int, param4:String, param5:ChallengeParamReference)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function handlePlayerDied(param1:ChallengePlayerDiedMessage) : void
      {
         var _loc2_:* = param1.player;
         if(_loc2_._id == playerId)
         {
            updateValue(1);
         }
      }
   }
}

