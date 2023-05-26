package tuxwars.challenges.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class ChallengePlayerDiedMessage extends Message
   {
       
      
      private var _player:PlayerGameObject;
      
      private var _cause:String;
      
      public function ChallengePlayerDiedMessage(player:PlayerGameObject, cause:String)
      {
         super("ChallengePlayerDied");
         _player = player;
         _cause = cause;
      }
      
      public function get player() : PlayerGameObject
      {
         return _player;
      }
      
      public function get cause() : String
      {
         return _cause;
      }
   }
}
