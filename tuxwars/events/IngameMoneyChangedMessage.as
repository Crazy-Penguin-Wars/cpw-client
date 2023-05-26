package tuxwars.events
{
   import com.dchoc.messages.Message;
   
   public class IngameMoneyChangedMessage extends Message
   {
       
      
      private var _amount:int;
      
      private var _ingameMoney:int;
      
      public function IngameMoneyChangedMessage(ingameMoney:int, amount:int)
      {
         super("IngameMoneyChanged");
         _ingameMoney = ingameMoney;
         _amount = amount;
      }
      
      public function get ingameMoney() : int
      {
         return _ingameMoney;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}
