package tuxwars.home.ui.logic
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.home.*;
   import tuxwars.home.ui.screen.TuxPageSubTabScreen;
   import tuxwars.home.ui.screen.shop.*;
   import tuxwars.items.*;
   import tuxwars.items.managers.*;
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
      
      public function TuxPageSubTabLogic(param1:TuxWarsGame, param2:TuxState)
      {
         var _loc4_:String = null;
         var _loc5_:Field = null;
         super(param1,param2);
         var _loc3_:Row = getCurrentPage();
         if(_loc3_)
         {
            _loc4_ = DEFAULT_TAB;
            if(!_loc3_.getCache[_loc4_])
            {
               _loc3_.getCache[_loc4_] = DCUtils.find(_loc3_.getFields(),"name",_loc4_);
            }
            _loc5_ = _loc3_.getCache[_loc4_];
            if(_loc5_)
            {
               this.setCurrentTab(_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value);
            }
         }
         this.moneyResourceElementLogic = new MoneyResourceElementLogic(param1);
         MessageCenter.addListener("ItemSelected",this.itemSelectedEvent);
         MessageCenter.addListener("ItemDetails",this.itemDetailsEvent);
      }
      
      private static function sortByPopularity(param1:ShopItem, param2:ShopItem) : int
      {
         return param1.popularitySortOrder - param2.popularitySortOrder;
      }
      
      private static function sortByLevel(param1:ShopItem, param2:ShopItem) : int
      {
         if(param1.requiredLevel == param2.requiredLevel)
         {
            return sortByPopularity(param1,param2);
         }
         return param1.requiredLevel - param2.requiredLevel;
      }
      
      private static function sortByPrice(param1:ShopItem, param2:ShopItem) : int
      {
         var _loc3_:PriceObject = null;
         var _loc4_:PriceObject = null;
         if(Boolean(param1.priceObject) && Boolean(param2.priceObject))
         {
            _loc3_ = param1.priceObject;
            _loc4_ = param2.priceObject;
            if(_loc3_.isPremium == _loc4_.isPremium)
            {
               if(_loc3_.priceValue != _loc4_.priceValue)
               {
                  return _loc3_.priceValue - _loc4_.priceValue;
               }
               return sortByPopularity(param1,param2);
            }
            if(_loc3_.isPremium)
            {
               return 1;
            }
            return -1;
         }
         return sortByPopularity(param1,param2);
      }
      
      public function get currentSort() : String
      {
         return this._currentSort;
      }
      
      public function set currentSort(param1:String) : void
      {
         this._currentSort = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.moneyResourceElementLogic.dispose();
         this.moneyResourceElementLogic = null;
         MessageCenter.removeListener("ItemSelected",this.itemSelectedEvent);
         MessageCenter.removeListener("ItemDetails",this.itemDetailsEvent);
         this._currentSort = null;
         if(this._bigItems)
         {
            this._bigItems.splice(0,this._bigItems.length);
            this._bigItems = null;
         }
      }
      
      public function getTabs() : Array
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Tab";
         var _loc2_:* = getCurrentPage();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         var _loc5_:* = !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
         return _loc5_ is Array ? _loc5_ : (!!_loc5_ ? [_loc5_] : null);
      }
      
      public function get tabSlotSize() : int
      {
         var _loc5_:* = undefined;
         var _loc1_:Array = this.getTabs();
         var _loc2_:String = "SlotSize";
         var _loc3_:* = getCurrentPage();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         _loc5_ = _loc4_;
         var _loc4_:Field = _loc3_.getCache[_loc2_];
         var _loc6_:* = !!_loc4_ ? (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) : null;
         var _loc7_:Array = _loc6_ is Array ? _loc6_ : (!!_loc6_ ? [_loc6_] : null);
         if(_loc1_ && this.currentTab && _loc1_.indexOf(this.currentTab) != -1 && Boolean(_loc7_))
         {
            return _loc7_[_loc1_.indexOf(this.currentTab)];
         }
         return 1;
      }
      
      public function getCurrentTabBigItems() : Vector.<BigShopItem>
      {
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc1_:Field = null;
         var _loc2_:Array = null;
         if(this._bigItems)
         {
            return this._bigItems;
         }
         if(this.getCurrentTab())
         {
            _loc3_ = "BigItems";
            _loc4_ = this.getCurrentTab();
            if(!_loc4_.getCache[_loc3_])
            {
               _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
            }
            _loc1_ = _loc4_.getCache[_loc3_];
            _loc5_ = _loc1_;
            _loc2_ = !!_loc1_ ? (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) as Array : null;
            for each(_loc6_ in _loc2_)
            {
               if(this._bigItems == null)
               {
                  this._bigItems = new Vector.<BigShopItem>();
               }
               this._bigItems.push(new BigShopItem(_loc6_));
            }
            return this._bigItems;
         }
         return null;
      }
      
      public function getCurrentTab() : Row
      {
         return !!this.currentTab ? this.currentTab : null;
      }
      
      public function getCurrentTabTID() : String
      {
         var _loc1_:Field = null;
         if(this.currentTab)
         {
            if(!this.currentTab.getCache[NAME])
            {
               this.currentTab.getCache[NAME] = DCUtils.find(this.currentTab.getFields(),"name",NAME);
            }
            _loc1_ = this.currentTab.getCache[NAME];
            return !!_loc1_ ? (_loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value) : null;
         }
         return null;
      }
      
      public function get sorting() : Array
      {
         var _loc2_:String = null;
         var _loc3_:Row = null;
         var _loc4_:* = undefined;
         var _loc1_:Field = null;
         if(this.currentTab)
         {
            _loc2_ = "Sorting";
            _loc3_ = this.currentTab;
            if(!_loc3_.getCache[_loc2_])
            {
               _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
            }
            _loc1_ = _loc3_.getCache[_loc2_];
            _loc4_ = _loc1_;
            return !!_loc1_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : ["Rating","Price"];
         }
         return null;
      }
      
      override public function setCurrentPage(param1:Row) : void
      {
         var _loc5_:* = undefined;
         super.setCurrentPage(param1);
         var _loc2_:String = "DefaultTab";
         var _loc3_:* = getCurrentPage();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:Field = _loc3_.getCache[_loc2_];
         _loc5_ = _loc4_;
         this.setCurrentTab(!!_loc4_ ? (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) : null);
      }
      
      public function setCurrentTab(param1:Row) : void
      {
         this._bigItems = null;
         this.currentTab = param1;
      }
      
      private function itemSelectedEvent(param1:Message) : void
      {
         this.itemSelected(param1.data as ShopItem);
      }
      
      public function itemSelected(param1:ShopItem) : void
      {
         LogUtils.log("OVERRIDE(selected) this method, item:" + (param1 != null ? param1.toString() : null),this,2,"Items",false);
      }
      
      private function itemDetailsEvent(param1:Message) : void
      {
         this.itemDetails(param1.data as ShopItem);
      }
      
      public function itemDetails(param1:ShopItem) : void
      {
         LogUtils.log("OVERRIDE(details) this method, item:" + (param1 != null ? param1.toString() : null),this,2,"Items",false);
      }
      
      public function getItems(param1:String, param2:Array = null, param3:Boolean = true) : Vector.<ShopItem>
      {
         var _loc4_:Vector.<ShopItem> = ShopItemManager.getShopItems(param1,param2,param3);
         switch(this.currentSort)
         {
            case "Level":
               _loc4_.sort(sortByLevel);
               break;
            case "Price":
               _loc4_.sort(sortByPrice);
               break;
            case "Rating":
            default:
               _loc4_.sort(sortByPopularity);
         }
         return _loc4_;
      }
      
      override public function set screen(param1:*) : void
      {
         super.screen = param1;
         this.moneyResourceElementLogic.screen = this.tuxPageSubTabScreen.moneyResourceElementScreen;
      }
      
      public function getMoneyResourceElementLogic() : MoneyResourceElementLogic
      {
         return this.moneyResourceElementLogic;
      }
      
      public function get tuxPageSubTabScreen() : TuxPageSubTabScreen
      {
         return screen;
      }
   }
}

