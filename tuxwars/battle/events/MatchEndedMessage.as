package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class MatchEndedMessage extends Message
   {
      
      public static const NORMAL_EXIT:String = "NormalExit";
      
      public static const SYNC_ERROR:String = "sync_error";
      
      public static const TIMEOUT:String = "time_out";
      
      public static const UNEXPECTED_MESSAGE:String = "unexpected_message";
      
      private static var _reason:String;
       
      
      public function MatchEndedMessage(players:Array, reason:String = "NormalExit")
      {
         super("MatchEnded",players);
         if(players)
         {
            players.sort(sorter);
         }
         _reason = reason;
      }
      
      public function getPlayers() : Array
      {
         return data;
      }
      
      public function get reason() : String
      {
         return _reason;
      }
      
      public function get isNormalExit() : Boolean
      {
         return _reason == "NormalExit";
      }
      
      public function getPlayerWithHighestScore() : PlayerGameObject
      {
         return getPlayers() != null ? getPlayers()[0] : null;
      }
      
      private function sorter(player1:PlayerGameObject, player2:PlayerGameObject) : int
      {
         return player1.getScore() - player2.getScore();
      }
   }
}
