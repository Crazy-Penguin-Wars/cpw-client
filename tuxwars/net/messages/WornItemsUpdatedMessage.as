package tuxwars.net.messages
{
   import com.dchoc.messages.Message;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.player.TuxFriend;
   
   public class WornItemsUpdatedMessage extends Message
   {
       
      
      private var _player:TuxFriend;
      
      private var _clothingItem:ClothingItem;
      
      private var _shopItem:ShopItem;
      
      private var _wearEvent:String;
      
      private var _mouseEvent:String;
      
      public function WornItemsUpdatedMessage(player:TuxFriend, item:ClothingItem, inventoryEvent:String, mouseEvent:String = null, data:* = null)
      {
         super("WornItemsUpdated",data);
         _player = player;
         _clothingItem = item;
         _wearEvent = inventoryEvent;
         _shopItem = ShopItemManager.getShopItemWithId(item.id);
         _mouseEvent = mouseEvent;
      }
      
      public function get mouseEvent() : String
      {
         return _mouseEvent;
      }
      
      public function get player() : TuxFriend
      {
         return _player;
      }
      
      public function get item() : ClothingItem
      {
         return _clothingItem;
      }
      
      public function get shopItem() : ShopItem
      {
         return _shopItem;
      }
      
      public function get wearEvent() : String
      {
         return _wearEvent;
      }
   }
}
