package tuxwars.home.ui.logic
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.home.MoneyResourceElementLogic;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.shop.IShopLogic;
   import tuxwars.items.BigShopItem;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.items.references.PriceObject;
   import tuxwars.states.TuxState;
   
   public class TuxPageSubTabLogic extends TuxPageContentLogic implements IShopLogic
   {
      
      private static const SUB_TAB:String = "SubTab";
      
      private static const TAB:String = "Tab";
      
      private static const SLOT_SIZE:String = "SlotSize";
      
      public static const CATEGORYS:String = "Categorys";
      
      private static const BIG_ITEMS:String = "BigItems";
      
      public static const NAME:String = "Name";
      
      private static const SORTING:String = "Sorting";
      
      private static const DEFAULT_TAB:String = "DefaultTab";
      
      public static const SORT_POPULARITY:String = "Rating";
      
      private static const SORT_LEVEL:String = "Level";
      
      private static const SORT_PRICE:String = "Price";
       
      
      private var currentTab:Row;
      
      private var moneyResourceElementLogic:MoneyResourceElementLogic;
      
      private var _bigItems:Vector.<BigShopItem>;
      
      private var _currentSort:String;
      
      public function TuxPageSubTabLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
         var _loc4_:* = getCurrentPage();
         if(!_loc4_._cache["DefaultTab"])
         {
            _loc4_._cache["DefaultTab"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","DefaultTab");
         }
         var _loc3_:Field = _loc4_._cache["DefaultTab"];
         if(_loc3_)
         {
            var _loc5_:* = _loc3_;
            setCurrentTab(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value);
         }
         moneyResourceElementLogic = new MoneyResourceElementLogic(game);
         MessageCenter.addListener("ItemSelected",itemSelectedEvent);
         MessageCenter.addListener("ItemDetails",itemDetailsEvent);
      }
      
      private static function sortByPopularity(item1:ShopItem, item2:ShopItem) : int
      {
         return item1.popularitySortOrder - item2.popularitySortOrder;
      }
      
      private static function sortByLevel(item1:ShopItem, item2:ShopItem) : int
      {
         if(item1.requiredLevel == item2.requiredLevel)
         {
            return sortByPopularity(item1,item2);
         }
         return item1.requiredLevel - item2.requiredLevel;
      }
      
      private static function sortByPrice(item1:ShopItem, item2:ShopItem) : int
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(item1.priceObject && item2.priceObject)
         {
            _loc4_ = item1.priceObject;
            _loc3_ = item2.priceObject;
            if(_loc4_.isPremium == _loc3_.isPremium)
            {
               if(_loc4_.priceValue != _loc3_.priceValue)
               {
                  return _loc4_.priceValue - _loc3_.priceValue;
               }
               return sortByPopularity(item1,item2);
            }
            if(_loc4_.isPremium)
            {
               return 1;
            }
            return -1;
         }
         return sortByPopularity(item1,item2);
      }
      
      public function get currentSort() : String
      {
         return _currentSort;
      }
      
      public function set currentSort(value:String) : void
      {
         _currentSort = value;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         moneyResourceElementLogic.dispose();
         moneyResourceElementLogic = null;
         MessageCenter.removeListener("ItemSelected",itemSelectedEvent);
         MessageCenter.removeListener("ItemDetails",itemDetailsEvent);
         _currentSort = null;
         if(_bigItems)
         {
            _bigItems.splice(0,_bigItems.length);
            _bigItems = null;
         }
      }
      
      public function getTabs() : Array
      {
         var _loc3_:* = getCurrentPage();
         if(!_loc3_._cache["Tab"])
         {
            _loc3_._cache["Tab"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","Tab");
         }
         var _loc1_:Field = _loc3_._cache["Tab"];
         return null is Array ? null : null;
      }
      
      public function get tabSlotSize() : int
      {
         var _loc4_:Array = getTabs();
         var _loc5_:* = getCurrentPage();
         if(!_loc5_._cache["SlotSize"])
         {
            _loc5_._cache["SlotSize"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","SlotSize");
         }
         var _loc1_:Field = _loc5_._cache["SlotSize"];
         var _loc2_:Array = null is Array ? null : null;
         if(_loc4_ && currentTab && _loc4_.indexOf(currentTab) != -1 && _loc2_)
         {
            return _loc2_[_loc4_.indexOf(currentTab)];
         }
         return 1;
      }
      
      public function getCurrentTabBigItems() : Vector.<BigShopItem>
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_bigItems)
         {
            return _bigItems;
         }
         if(getCurrentTab())
         {
            var _loc4_:* = getCurrentTab();
            if(!_loc4_._cache["BigItems"])
            {
               _loc4_._cache["BigItems"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","BigItems");
            }
            _loc2_ = _loc4_._cache["BigItems"];
            var _loc5_:*;
            _loc1_ = !!_loc2_ ? (_loc5_ = _loc2_, (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) as Array) : null;
            for each(var row in _loc1_)
            {
               if(_bigItems == null)
               {
                  _bigItems = new Vector.<BigShopItem>();
               }
               _bigItems.push(new BigShopItem(row));
            }
            return _bigItems;
         }
         return null;
      }
      
      public function getCurrentTab() : Row
      {
         return !!currentTab ? currentTab : null;
      }
      
      public function getCurrentTabTID() : String
      {
         if(currentTab && _loc1_._cache["Name"] != null)
         {
            var _loc2_:Row = currentTab;
            if(!_loc2_._cache["Name"])
            {
               _loc2_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Name");
            }
            var _loc3_:* = _loc2_._cache["Name"];
            §§push(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value);
         }
         else
         {
            §§push(null);
         }
         return §§pop();
      }
      
      public function get sorting() : Array
      {
         var _loc1_:* = null;
         if(currentTab)
         {
            var _loc2_:Row = currentTab;
            if(!_loc2_._cache["Sorting"])
            {
               _loc2_._cache["Sorting"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Sorting");
            }
            _loc1_ = _loc2_._cache["Sorting"];
            var _loc3_:*;
            return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : ["Rating","Price"];
         }
         return null;
      }
      
      override public function setCurrentPage(value:Row) : void
      {
         super.setCurrentPage(value);
         var _loc3_:* = getCurrentPage();
         if(!_loc3_._cache["DefaultTab"])
         {
            _loc3_._cache["DefaultTab"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","DefaultTab");
         }
         var _loc2_:Field = _loc3_._cache["DefaultTab"];
         var _loc4_:*;
         setCurrentTab(!!_loc2_ ? (_loc4_ = _loc2_, _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null);
      }
      
      public function setCurrentTab(value:Row) : void
      {
         _bigItems = null;
         currentTab = value;
      }
      
      private function itemSelectedEvent(msg:Message) : void
      {
         itemSelected(msg.data as ShopItem);
      }
      
      public function itemSelected(shopItem:ShopItem) : void
      {
         LogUtils.log("OVERRIDE(selected) this method, item:" + (shopItem != null ? shopItem.toString() : null),this,2,"Items",false);
      }
      
      private function itemDetailsEvent(msg:Message) : void
      {
         itemDetails(msg.data as ShopItem);
      }
      
      public function itemDetails(shopItem:ShopItem) : void
      {
         LogUtils.log("OVERRIDE(details) this method, item:" + (shopItem != null ? shopItem.toString() : null),this,2,"Items",false);
      }
      
      public function getItems(type:String, categories:Array = null, includeVIP:Boolean = true) : Vector.<ShopItem>
      {
         var items:Vector.<ShopItem> = ShopItemManager.getShopItems(type,categories,includeVIP);
         switch(currentSort)
         {
            case "Level":
               items.sort(sortByLevel);
               break;
            case "Price":
               items.sort(sortByPrice);
               break;
            case "Rating":
            default:
               items.sort(sortByPopularity);
         }
         return items;
      }
      
      override public function set screen(screen:*) : void
      {
         super.screen = screen;
         moneyResourceElementLogic.screen = tuxPageSubTabScreen.moneyResourceElementScreen;
      }
      
      public function getMoneyResourceElementLogic() : MoneyResourceElementLogic
      {
         return moneyResourceElementLogic;
      }
      
      public function get tuxPageSubTabScreen() : TuxPageSubTabScreen
      {
         return screen;
      }
   }
}
