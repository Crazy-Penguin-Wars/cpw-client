package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class IngameBetMessage extends SocketMessage
   {
       
      
      public function IngameBetMessage(id:String)
      {
         super({
            "t":50,
            "id":id
         });
      }
   }
}
