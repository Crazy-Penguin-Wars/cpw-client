package tuxwars.challenges.events
{
   import com.dchoc.gameobjects.GameObjects;
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class ChallengeEndGameConfirm extends Message
   {
      private var _players:Array;
      
      private var _playersSortedScore:Array;
      
      public function ChallengeEndGameConfirm(param1:GameObjects, param2:Array)
      {
         this._players = param2;
         this._playersSortedScore = param2.slice();
         this._playersSortedScore.sort(this.sorter);
         super("ChallengeEndGameConfirm",param1);
      }
      
      public function get gameObjects() : GameObjects
      {
         return data;
      }
      
      public function get players() : Array
      {
         return this._players;
      }
      
      public function getPlayerWithHighestScore() : PlayerGameObject
      {
         return this._playersSortedScore[0];
      }
      
      private function sorter(param1:PlayerGameObject, param2:PlayerGameObject) : int
      {
         return param2.getScore() - param1.getScore();
      }
   }
}

