package tuxwars.battle.net
{
   import com.dchoc.messages.Message;
   
   public class BattleServerDisconnectMessage extends Message
   {
      
      public static const DISCONNECT:String = "BattleServerDisconnect";
       
      
      public function BattleServerDisconnectMessage()
      {
         super("BattleServerDisconnect");
      }
   }
}
