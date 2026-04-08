package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class ChallengePlayerScoreChangedMessage extends Message
   {
      private var _player:PlayerGameObject;
      
      private var _amount:int;
      
      private var _remaingingMatchTime:int;
      
      public function ChallengePlayerScoreChangedMessage(param1:PlayerGameObject, param2:int, param3:Array, param4:int)
      {
         this._player = param1;
         this._amount = param2;
         this._remaingingMatchTime = param4;
         super("ChallengeScoreChange",param3);
      }
      
      public function get players() : Array
      {
         return data;
      }
      
      public function get player() : PlayerGameObject
      {
         return this._player;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
      
      public function get remaingingMatchTime() : int
      {
         return this._remaingingMatchTime;
      }
   }
}

