package tuxwars.net.messages
{
   import com.dchoc.messages.Message;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.net.CRMService;
   
   public class ShopItemLevelUpSalesMessage extends Message
   {
       
      
      private var _sourceObject:TuxUIScreen;
      
      public function ShopItemLevelUpSalesMessage(shopItem:ShopItem, sourceObject:TuxUIScreen)
      {
         super("BuyItemLevelUpSales",shopItem);
         _sourceObject = sourceObject;
      }
      
      public function get sourceName() : String
      {
         return CRMService.classChecker(_sourceObject);
      }
      
      public function get shopItem() : ShopItem
      {
         return data;
      }
   }
}
