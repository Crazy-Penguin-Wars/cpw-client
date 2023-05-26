package tuxwars.items.managers
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.ShopItem;
   import tuxwars.items.data.ItemData;
   
   public class ShopItemManager
   {
      
      private static const CACHE:Object = {};
      
      private static var game:TuxWarsGame;
       
      
      public function ShopItemManager()
      {
         super();
         throw new Error("ShopItemManager is a static class!");
      }
      
      private static function initGame() : void
      {
         MessageCenter.addListener("SendGame",getGameCallback);
         MessageCenter.sendMessage("GetGame");
      }
      
      private static function getGameCallback(msg:Message) : void
      {
         MessageCenter.removeListener("SendGame",getGameCallback);
         game = msg.data;
      }
      
      public static function getShopItems(type:String, categories:Array = null, includeVIP:Boolean = true) : Vector.<ShopItem>
      {
         var item:* = null;
         if(game == null)
         {
            initGame();
         }
         var _loc7_:Vector.<ShopItem> = new Vector.<ShopItem>();
         var _loc6_:Vector.<ItemData> = type != null ? ItemManager.findItemDatas(type) : ItemManager.findAllItems();
         loop0:
         for each(var itemData in _loc6_)
         {
            if(includeVIP == false && !game.player.vipMembership.vip)
            {
               if(itemData.isVip && !game.player.inventory.hasItem(itemData.id))
               {
                  continue;
               }
            }
            if(categories)
            {
               for each(var category in categories)
               {
                  if(category == "IsUnlockedCODE")
                  {
                     item = getShopItem(itemData);
                     if(!item.isLevelLocked(game.player.level))
                     {
                        _loc7_.push(getShopItem(itemData));
                        continue loop0;
                     }
                  }
                  else if(category == "IsAvailableCODE")
                  {
                     if(game.player.inventory.hasItem(itemData.id))
                     {
                        _loc7_.push(getShopItem(itemData));
                        continue loop0;
                     }
                  }
                  else if(itemData.categories && itemData.categories.indexOf(category) != -1)
                  {
                     _loc7_.push(getShopItem(itemData));
                     continue loop0;
                  }
               }
            }
            else
            {
               _loc7_.push(getShopItem(itemData));
            }
         }
         _loc7_.sort(sortShopItems);
         return _loc7_;
      }
      
      public static function sortShopItems(item1:ShopItem, item2:ShopItem) : int
      {
         if(item1.requiredLevel == item2.requiredLevel)
         {
            return item1.sortPriority - item2.sortPriority;
         }
         return item1.requiredLevel - item2.requiredLevel;
      }
      
      public static function getShopItem(itemData:ItemData) : ShopItem
      {
         if(!CACHE.hasOwnProperty(itemData.id))
         {
            CACHE[itemData.id] = new ShopItem(itemData);
         }
         return CACHE[itemData.id];
      }
      
      public static function getShopItemWithId(id:String) : ShopItem
      {
         return getShopItem(ItemManager.getItemData(id));
      }
   }
}
