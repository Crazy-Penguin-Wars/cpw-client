package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class ChallengePlayerDiedMessage extends Message
   {
      private var _player:PlayerGameObject;
      
      private var _cause:String;
      
      public function ChallengePlayerDiedMessage(param1:PlayerGameObject, param2:String)
      {
         super("ChallengePlayerDied");
         this._player = param1;
         this._cause = param2;
      }
      
      public function get player() : PlayerGameObject
      {
         return this._player;
      }
      
      public function get cause() : String
      {
         return this._cause;
      }
   }
}

