package tuxwars.challenges.events
{
   import com.dchoc.gameobjects.GameObjects;
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class ChallengeEndGameConfirm extends Message
   {
       
      
      private var _players:Array;
      
      private var _playersSortedScore:Array;
      
      public function ChallengeEndGameConfirm(gameObjects:GameObjects, players:Array)
      {
         _players = players;
         _playersSortedScore = players.slice();
         _playersSortedScore.sort(sorter);
         super("ChallengeEndGameConfirm",gameObjects);
      }
      
      public function get gameObjects() : GameObjects
      {
         return data;
      }
      
      public function get players() : Array
      {
         return _players;
      }
      
      public function getPlayerWithHighestScore() : PlayerGameObject
      {
         return _playersSortedScore[0];
      }
      
      private function sorter(player1:PlayerGameObject, player2:PlayerGameObject) : int
      {
         return player2.getScore() - player1.getScore();
      }
   }
}
