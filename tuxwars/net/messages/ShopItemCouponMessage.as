package tuxwars.net.messages
{
   import com.dchoc.messages.Message;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.data.CouponData;
   import tuxwars.net.*;
   
   public class ShopItemCouponMessage extends Message
   {
      private var _sourceObject:TuxUIScreen;
      
      public function ShopItemCouponMessage(param1:CouponData, param2:TuxUIScreen)
      {
         super("BuyItemCouponSales",param1);
         this._sourceObject = param2;
      }
      
      public function get sourceName() : String
      {
         return CRMService.classChecker(this._sourceObject);
      }
      
      public function get couponData() : CouponData
      {
         return data;
      }
   }
}

