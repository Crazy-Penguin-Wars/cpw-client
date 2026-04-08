package tuxwars.net.messages
{
   import com.dchoc.messages.Message;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.*;
   import tuxwars.player.TuxFriend;
   
   public class WornItemsUpdatedMessage extends Message
   {
      private var _player:TuxFriend;
      
      private var _clothingItem:ClothingItem;
      
      private var _shopItem:ShopItem;
      
      private var _wearEvent:String;
      
      private var _mouseEvent:String;
      
      public function WornItemsUpdatedMessage(param1:TuxFriend, param2:ClothingItem, param3:String, param4:String = null, param5:* = null)
      {
         super("WornItemsUpdated",param5);
         this._player = param1;
         this._clothingItem = param2;
         this._wearEvent = param3;
         this._shopItem = ShopItemManager.getShopItemWithId(param2.id);
         this._mouseEvent = param4;
      }
      
      public function get mouseEvent() : String
      {
         return this._mouseEvent;
      }
      
      public function get player() : TuxFriend
      {
         return this._player;
      }
      
      public function get item() : ClothingItem
      {
         return this._clothingItem;
      }
      
      public function get shopItem() : ShopItem
      {
         return this._shopItem;
      }
      
      public function get wearEvent() : String
      {
         return this._wearEvent;
      }
   }
}

