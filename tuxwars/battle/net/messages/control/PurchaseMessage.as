package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class PurchaseMessage extends SocketMessage
   {
       
      
      public function PurchaseMessage()
      {
         super({"t":18});
      }
   }
}
