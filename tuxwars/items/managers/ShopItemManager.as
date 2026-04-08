package tuxwars.items.managers
{
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.*;
   import tuxwars.items.data.ItemData;
   
   public class ShopItemManager
   {
      private static var game:TuxWarsGame;
      
      private static const CACHE:Object = {};
      
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
      
      private static function getGameCallback(param1:Message) : void
      {
         MessageCenter.removeListener("SendGame",getGameCallback);
         game = param1.data;
      }
      
      public static function getShopItems(param1:String, param2:Array = null, param3:Boolean = true) : Vector.<ShopItem>
      {
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc4_:ShopItem = null;
         if(game == null)
         {
            initGame();
         }
         var _loc5_:Vector.<ShopItem> = new Vector.<ShopItem>();
         var _loc6_:Vector.<ItemData> = param1 != null ? ItemManager.findItemDatas(param1) : ItemManager.findAllItems();
         for each(_loc7_ in _loc6_)
         {
            if(param3 == false && !game.player.vipMembership.vip)
            {
               if(Boolean(_loc7_.isVip) && !game.player.inventory.hasItem(_loc7_.id))
               {
                  continue;
               }
            }
            if(param2)
            {
               for each(_loc8_ in param2)
               {
                  if(_loc8_ == "IsUnlockedCODE")
                  {
                     _loc4_ = getShopItem(_loc7_);
                     if(!_loc4_.isLevelLocked(game.player.level))
                     {
                        _loc5_.push(getShopItem(_loc7_));
                        break;
                     }
                  }
                  else if(_loc8_ == "IsAvailableCODE")
                  {
                     if(game.player.inventory.hasItem(_loc7_.id))
                     {
                        _loc5_.push(getShopItem(_loc7_));
                        break;
                     }
                  }
                  else if(Boolean(_loc7_.categories) && _loc7_.categories.indexOf(_loc8_) != -1)
                  {
                     _loc5_.push(getShopItem(_loc7_));
                     break;
                  }
               }
            }
            else
            {
               _loc5_.push(getShopItem(_loc7_));
            }
         }
         _loc5_.sort(sortShopItems);
         return _loc5_;
      }
      
      public static function sortShopItems(param1:ShopItem, param2:ShopItem) : int
      {
         if(param1.requiredLevel == param2.requiredLevel)
         {
            return param1.sortPriority - param2.sortPriority;
         }
         return param1.requiredLevel - param2.requiredLevel;
      }
      
      public static function getShopItem(param1:ItemData) : ShopItem
      {
         if(!CACHE.hasOwnProperty(param1.id))
         {
            CACHE[param1.id] = new ShopItem(param1);
         }
         return CACHE[param1.id];
      }
      
      public static function getShopItemWithId(param1:String) : ShopItem
      {
         return getShopItem(ItemManager.getItemData(param1));
      }
   }
}

