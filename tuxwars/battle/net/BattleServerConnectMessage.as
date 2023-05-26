package tuxwars.battle.net
{
   import com.dchoc.messages.Message;
   
   public class BattleServerConnectMessage extends Message
   {
      
      public static const CONNECT:String = "Connect";
       
      
      private var host:String;
      
      private var port:int;
      
      public function BattleServerConnectMessage(host:String, port:int)
      {
         super("Connect");
         this.host = host;
         this.port = port;
      }
      
      public function getHost() : String
      {
         return host;
      }
      
      public function getPort() : int
      {
         return port;
      }
   }
}
