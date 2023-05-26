package tuxwars.challenges.counters
{
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   import tuxwars.challenges.Challenge;
   import tuxwars.challenges.ChallengeParamReference;
   import tuxwars.challenges.events.ChallengeEndGameConfirm;
   
   public class SameScoreCounter extends Counter
   {
       
      
      public function SameScoreCounter(challenge:Challenge, id:String, targetValue:int, playerId:String, params:ChallengeParamReference)
      {
         super(challenge,id,targetValue,playerId,params);
      }
      
      override public function handleEndGameConfirm(msg:ChallengeEndGameConfirm) : void
      {
         var playerScore:int = 0;
         for each(var player in msg.players)
         {
            var _loc6_:* = player;
            if(_loc6_._id == playerId)
            {
               var _loc12_:int = 0;
               var _loc11_:* = msg.players;
               for each(var checkPlayer in _loc11_)
               {
                  playerScore = checkPlayer.getScore();
                  if(playerScore > 0)
                  {
                     for each(var otherPlayer in msg.players)
                     {
                        var _loc7_:* = checkPlayer;
                        var _loc8_:* = otherPlayer;
                        if(_loc7_._id != _loc8_._id && playerScore == otherPlayer.getScore())
                        {
                           updateValue(1);
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
