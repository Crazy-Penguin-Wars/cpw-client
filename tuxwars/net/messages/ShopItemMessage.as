package tuxwars.net.messages
{
   import com.dchoc.messages.Message;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.ShopItem;
   import tuxwars.net.*;
   
   public class ShopItemMessage extends Message
   {
      private var _sourceObject:TuxUIScreen;
      
      public function ShopItemMessage(param1:ShopItem, param2:TuxUIScreen)
      {
         super("BuyItem",param1);
         this._sourceObject = param2;
      }
      
      public function get sourceName() : String
      {
         return CRMService.classChecker(this._sourceObject);
      }
      
      public function get shopItem() : ShopItem
      {
         return data;
      }
   }
}

