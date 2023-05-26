package tuxwars.items.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.ShopItemManager;
   import tuxwars.items.references.PriceObject;
   
   public class MegaPackData extends ItemData
   {
      
      private static const ITEM_LIST:String = "ItemList";
      
      private static const ITEM_AMOUNT_LIST:String = "ItemAmountList";
       
      
      public function MegaPackData(row:Row)
      {
         super(row);
      }
      
      public function get itemList() : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:Row = row;
         if(!_loc3_._cache["ItemList"])
         {
            _loc3_._cache["ItemList"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","ItemList");
         }
         var _loc1_:Field = _loc3_._cache["ItemList"];
         if(_loc1_)
         {
            var _loc4_:* = _loc1_;
            _loc2_ = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
            return _loc2_ is Array ? _loc2_ : [_loc2_];
         }
         return null;
      }
      
      public function get itemAmountList() : Array
      {
         var _loc2_:* = undefined;
         var _loc3_:Row = row;
         if(!_loc3_._cache["ItemAmountList"])
         {
            _loc3_._cache["ItemAmountList"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","ItemAmountList");
         }
         var _loc1_:Field = _loc3_._cache["ItemAmountList"];
         if(_loc1_)
         {
            var _loc4_:* = _loc1_;
            _loc2_ = _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
            return _loc2_ is Array ? _loc2_ : [_loc2_];
         }
         return null;
      }
      
      public function get normalCoinsCost() : int
      {
         return cost(false);
      }
      
      public function get normalCashCost() : int
      {
         return cost(true);
      }
      
      private function cost(isPremium:Boolean) : int
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var cost:int = 0;
         for each(var row in itemList)
         {
            _loc3_ = ShopItemManager.getShopItemWithId(row.id);
            _loc2_ = _loc3_.priceObject;
            if(_loc2_.isPremium == isPremium)
            {
               cost += _loc2_.priceValue;
            }
         }
         return cost;
      }
   }
}
