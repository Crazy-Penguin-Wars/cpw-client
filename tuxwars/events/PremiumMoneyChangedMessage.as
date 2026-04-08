package tuxwars.events
{
   import com.dchoc.messages.Message;
   
   public class PremiumMoneyChangedMessage extends Message
   {
      private var _amount:int;
      
      private var _premiumMoney:int;
      
      public function PremiumMoneyChangedMessage(param1:int, param2:int)
      {
         super("PremiumMoneyChanged");
         this._premiumMoney = param1;
         this._amount = param2;
      }
      
      public function get premiumMoney() : int
      {
         return this._premiumMoney;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
   }
}

