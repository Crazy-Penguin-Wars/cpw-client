package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.items.managers.*;
   
   public class CouponData extends ItemData
   {
      private static const SALE_ITEM_ID:String = "SaleItemId";
      
      private static const SALE_INGAME:String = "SaleInGame";
      
      private static const SALE_PREMIUM:String = "SalePremium";
      
      public function CouponData(param1:Row)
      {
         super(param1);
      }
      
      public function get couponItemId() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SaleItemId";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get itemData() : ItemData
      {
         return ItemManager.getItemData(this.couponItemId);
      }
      
      public function get couponInGamePrice() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SaleInGame";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get couponPremiumPrice() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SalePremium";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
   }
}

