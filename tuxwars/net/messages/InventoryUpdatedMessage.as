package tuxwars.net.messages
{
   import com.dchoc.messages.Message;
   import tuxwars.items.Item;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.player.TuxFriend;
   
   public class InventoryUpdatedMessage extends Message
   {
       
      
      private var _player:TuxFriend;
      
      private var _item:Item;
      
      private var _shopItem:ShopItem;
      
      private var _inventoryEvent:String;
      
      public function InventoryUpdatedMessage(player:TuxFriend, item:Item, inventoryEvent:String, data:* = null)
      {
         super("InventoryUpdated",data);
         _player = player;
         _item = item;
         _inventoryEvent = inventoryEvent;
         _shopItem = ShopItemManager.getShopItemWithId(item.id);
      }
      
      public function get player() : TuxFriend
      {
         return _player;
      }
      
      public function get item() : Item
      {
         return _item;
      }
      
      public function get shopItem() : ShopItem
      {
         return _shopItem;
      }
      
      public function get inventoryEvent() : String
      {
         return _inventoryEvent;
      }
   }
}
