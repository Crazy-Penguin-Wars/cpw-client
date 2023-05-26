package tuxwars.battle.net.messages.chat
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ChatMessage extends SocketMessage
   {
       
      
      public function ChatMessage(id:String, text:String, tid:String = null)
      {
         super({
            "t":33,
            "id":id,
            "text":text,
            "tid":tid
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
