package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.items.ShopItem;
   import tuxwars.items.managers.*;
   import tuxwars.items.references.PriceObject;
   
   public class MegaPackData extends ItemData
   {
      private static const ITEM_LIST:String = "ItemList";
      
      private static const ITEM_AMOUNT_LIST:String = "ItemAmountList";
      
      public function MegaPackData(param1:Row)
      {
         super(param1);
      }
      
      public function get itemList() : Array
      {
         var _loc5_:* = undefined;
         var _loc1_:* = undefined;
         var _loc2_:String = "ItemList";
         var _loc3_:Row = row;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:Field = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            _loc5_ = _loc4_;
            _loc1_ = _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
            return _loc1_ is Array ? _loc1_ : [_loc1_];
         }
         return null;
      }
      
      public function get itemAmountList() : Array
      {
         var _loc5_:* = undefined;
         var _loc1_:* = undefined;
         var _loc2_:String = "ItemAmountList";
         var _loc3_:Row = row;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:Field = _loc3_.getCache[_loc2_];
         if(_loc4_)
         {
            _loc5_ = _loc4_;
            _loc1_ = _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value;
            return _loc1_ is Array ? _loc1_ : [_loc1_];
         }
         return null;
      }
      
      public function get normalCoinsCost() : int
      {
         return this.cost(false);
      }
      
      public function get normalCashCost() : int
      {
         return this.cost(true);
      }
      
      private function cost(param1:Boolean) : int
      {
         var _loc5_:* = undefined;
         var _loc2_:ShopItem = null;
         var _loc3_:PriceObject = null;
         var _loc4_:int = 0;
         for each(_loc5_ in this.itemList)
         {
            _loc2_ = ShopItemManager.getShopItemWithId(_loc5_.id);
            _loc3_ = _loc2_.priceObject;
            if(_loc3_.isPremium == param1)
            {
               _loc4_ += _loc3_.priceValue;
            }
         }
         return _loc4_;
      }
   }
}

