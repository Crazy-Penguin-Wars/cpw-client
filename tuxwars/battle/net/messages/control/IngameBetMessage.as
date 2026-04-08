package tuxwars.battle.net.messages.control
{
   import tuxwars.battle.net.messages.SocketMessage;
   
   public class IngameBetMessage extends SocketMessage
   {
      public function IngameBetMessage(param1:String)
      {
         super({
            "t":50,
            "id":param1
         });
      }
   }
}

