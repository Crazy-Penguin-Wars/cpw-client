package tuxwars.battle.net
{
   import com.dchoc.messages.Message;
   
   public class BattleServerConnectMessage extends Message
   {
      public static const CONNECT:String = "Connect";
      
      private var host:String;
      
      private var port:int;
      
      public function BattleServerConnectMessage(param1:String, param2:int)
      {
         super("Connect");
         this.host = param1;
         this.port = param2;
      }
      
      public function getHost() : String
      {
         return this.host;
      }
      
      public function getPort() : int
      {
         return this.port;
      }
   }
}

