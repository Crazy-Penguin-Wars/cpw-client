package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ClientReadyMessage extends SocketMessage
   {
      public function ClientReadyMessage(param1:String)
      {
         super({
            "t":15,
            "id":param1
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}

