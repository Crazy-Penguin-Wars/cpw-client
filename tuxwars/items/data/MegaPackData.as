package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
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
         var _loc5_:String = "ItemList";
         var _loc3_:Row = row;
         if(!_loc3_._cache[_loc5_])
         {
            _loc3_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc5_);
         }
         var _loc1_:Field = _loc3_._cache[_loc5_];
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
         var _loc5_:String = "ItemAmountList";
         var _loc3_:Row = row;
         if(!_loc3_._cache[_loc5_])
         {
            _loc3_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc5_);
         }
         var _loc1_:Field = _loc3_._cache[_loc5_];
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
         var _loc3_:ShopItem = null;
         var _loc2_:PriceObject = null;
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

