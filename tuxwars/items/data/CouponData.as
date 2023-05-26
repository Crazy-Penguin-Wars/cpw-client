package tuxwars.items.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import tuxwars.items.managers.ItemManager;
   
   public class CouponData extends ItemData
   {
      
      private static const SALE_ITEM_ID:String = "SaleItemId";
      
      private static const SALE_INGAME:String = "SaleInGame";
      
      private static const SALE_PREMIUM:String = "SalePremium";
       
      
      public function CouponData(row:Row)
      {
         super(row);
      }
      
      public function get couponItemId() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["SaleItemId"])
         {
            _loc2_._cache["SaleItemId"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SaleItemId");
         }
         var _loc1_:Field = _loc2_._cache["SaleItemId"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get itemData() : ItemData
      {
         return ItemManager.getItemData(couponItemId);
      }
      
      public function get couponInGamePrice() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["SaleInGame"])
         {
            _loc2_._cache["SaleInGame"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SaleInGame");
         }
         var _loc1_:Field = _loc2_._cache["SaleInGame"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get couponPremiumPrice() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["SalePremium"])
         {
            _loc2_._cache["SalePremium"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SalePremium");
         }
         var _loc1_:Field = _loc2_._cache["SalePremium"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
   }
}
