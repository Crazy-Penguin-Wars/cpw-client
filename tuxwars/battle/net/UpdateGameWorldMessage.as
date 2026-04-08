package tuxwars.battle.net
{
   import com.dchoc.messages.Message;
   
   public class UpdateGameWorldMessage extends Message
   {
      public function UpdateGameWorldMessage(param1:Vector.<BattleResponse>)
      {
         super("UpdateGameWorld",param1);
      }
      
      public function get responses() : Vector.<BattleResponse>
      {
         return data;
      }
   }
}

