package tuxwars.events
{
   import com.dchoc.messages.Message;
   
   public class IngameMoneyChangedMessage extends Message
   {
      private var _amount:int;
      
      private var _ingameMoney:int;
      
      public function IngameMoneyChangedMessage(param1:int, param2:int)
      {
         super("IngameMoneyChanged");
         this._ingameMoney = param1;
         this._amount = param2;
      }
      
      public function get ingameMoney() : int
      {
         return this._ingameMoney;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
   }
}

