package tuxwars.battle.net
{
   import com.dchoc.messages.Message;
   
   public class UpdateGameWorldMessage extends Message
   {
       
      
      public function UpdateGameWorldMessage(responses:Vector.<BattleResponse>)
      {
         super("UpdateGameWorld",responses);
      }
      
      public function get responses() : Vector.<BattleResponse>
      {
         return data;
      }
   }
}
