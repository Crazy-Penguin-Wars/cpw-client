package tuxwars.battle.events
{
   import com.dchoc.messages.Message;
   import tuxwars.battle.gameobjects.player.PlayerGameObject;
   
   public class MatchEndedMessage extends Message
   {
      private static var _reason:String;
      
      public static const NORMAL_EXIT:String = "NormalExit";
      
      public static const SYNC_ERROR:String = "sync_error";
      
      public static const TIMEOUT:String = "time_out";
      
      public static const UNEXPECTED_MESSAGE:String = "unexpected_message";
      
      public function MatchEndedMessage(param1:Array, param2:String = "NormalExit")
      {
         super("MatchEnded",param1);
         if(param1)
         {
            param1.sort(this.sorter);
         }
         _reason = param2;
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
         return this.getPlayers() != null ? this.getPlayers()[0] : null;
      }
      
      private function sorter(param1:PlayerGameObject, param2:PlayerGameObject) : int
      {
         return param1.getScore() - param2.getScore();
      }
   }
}

