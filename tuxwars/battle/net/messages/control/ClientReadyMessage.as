package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class ClientReadyMessage extends SocketMessage
   {
       
      
      public function ClientReadyMessage(id:String)
      {
         super({
            "t":15,
            "id":id
         });
      }
      
      override public function sendLocally() : Boolean
      {
         return BattleManager.isPracticeMode();
      }
   }
}
