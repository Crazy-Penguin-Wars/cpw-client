package tuxwars.events
{
   import com.dchoc.messages.Message;
   
   public class PremiumMoneyChangedMessage extends Message
   {
       
      
      private var _amount:int;
      
      private var _premiumMoney:int;
      
      public function PremiumMoneyChangedMessage(premiumMoney:int, amount:int)
      {
         super("PremiumMoneyChanged");
         _premiumMoney = premiumMoney;
         _amount = amount;
      }
      
      public function get premiumMoney() : int
      {
         return _premiumMoney;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
   }
}
