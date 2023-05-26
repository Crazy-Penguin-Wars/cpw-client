package tuxwars.net.messages
{
   import com.dchoc.messages.Message;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.data.CouponData;
   import tuxwars.net.CRMService;
   
   public class ShopItemCouponMessage extends Message
   {
       
      
      private var _sourceObject:TuxUIScreen;
      
      public function ShopItemCouponMessage(couponData:CouponData, sourceObject:TuxUIScreen)
      {
         super("BuyItemCouponSales",couponData);
         _sourceObject = sourceObject;
      }
      
      public function get sourceName() : String
      {
         return CRMService.classChecker(_sourceObject);
      }
      
      public function get couponData() : CouponData
      {
         return data;
      }
   }
}
