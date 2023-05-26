package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class ChallengePlayerScoreChangedMessage extends Message
   {
       
      
      private var _player:PlayerGameObject;
      
      private var _amount:int;
      
      private var _remaingingMatchTime:int;
      
      public function ChallengePlayerScoreChangedMessage(player:PlayerGameObject, amount:int, players:Array, remaingingMatchTime:int)
      {
         _player = player;
         _amount = amount;
         _remaingingMatchTime = remaingingMatchTime;
         super("ChallengeScoreChange",players);
      }
      
      public function get players() : Array
      {
         return data;
      }
      
      public function get player() : PlayerGameObject
      {
         return _player;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function get remaingingMatchTime() : int
      {
         return _remaingingMatchTime;
      }
   }
}
