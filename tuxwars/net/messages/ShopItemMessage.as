package tuxwars.net.messages
{
   import com.dchoc.messages.Message;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.net.CRMService;
   
   public class ShopItemMessage extends Message
   {
       
      
      private var _sourceObject:TuxUIScreen;
      
      public function ShopItemMessage(shopItem:ShopItem, sourceObject:TuxUIScreen)
      {
         super("BuyItem",shopItem);
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
