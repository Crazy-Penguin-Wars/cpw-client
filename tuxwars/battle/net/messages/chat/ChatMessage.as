package tuxwars.battle.net.messages.chat
{
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ChatMessage extends SocketMessage
   {
      public function ChatMessage(param1:String, param2:String, param3:String = null)
      {
         super({
            "t":33,
            "id":param1,
            "text":param2,
            "tid":param3
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

