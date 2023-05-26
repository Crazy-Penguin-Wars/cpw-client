package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class RematchRequestMessage extends SocketMessage
   {
       
      
      public function RematchRequestMessage(id:String)
      {
         super({
            "t":40,
            "id":id
         });
      }
   }
}
