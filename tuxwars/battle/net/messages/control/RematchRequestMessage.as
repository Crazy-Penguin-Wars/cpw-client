package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class RematchRequestMessage extends SocketMessage
   {
      public function RematchRequestMessage(param1:String)
      {
         super({
            "t":40,
            "id":param1
         });
      }
   }
}

