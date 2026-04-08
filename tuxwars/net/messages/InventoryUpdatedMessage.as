package tuxwars.net.messages
{
   import com.dchoc.messages.Message;
   import tuxwars.items.Item;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.*;
   import tuxwars.player.TuxFriend;
   
   public class InventoryUpdatedMessage extends Message
   {
      private var _player:TuxFriend;
      
      private var _item:Item;
      
      private var _shopItem:ShopItem;
      
      private var _inventoryEvent:String;
      
      public function InventoryUpdatedMessage(param1:TuxFriend, param2:Item, param3:String, param4:* = null)
      {
         super("InventoryUpdated",param4);
         this._player = param1;
         this._item = param2;
         this._inventoryEvent = param3;
         this._shopItem = ShopItemManager.getShopItemWithId(param2.id);
      }
      
      public function get player() : TuxFriend
      {
         return this._player;
      }
      
      public function get item() : Item
      {
         return this._item;
      }
      
      public function get shopItem() : ShopItem
      {
         return this._shopItem;
      }
      
      public function get inventoryEvent() : String
      {
         return this._inventoryEvent;
      }
   }
}

