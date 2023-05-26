package tuxwars.items.references
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   import no.olog.utilfunctions.assert;
   
   public class PriceInfoReference
   {
      
      private static const UNLOCK_PRICE_PREMIUM:String = "UnlockPricePremium";
      
      private static const INGAME:String = "InGame";
      
      private static const PREMIUM:String = "Premium";
      
      private static const SALE_PERCENTAGE:String = "SalePercentage";
      
      private static const POPULARITY_SORT_ORDER:String = "PopularitySortOrder";
       
      
      private var row:Row;
      
      public function PriceInfoReference(row:Row)
      {
         super();
         assert("Row is null.",true,row != null);
         this.row = row;
      }
      
      public function get priceObject() : PriceObject
      {
         return createPriceObject();
      }
      
      public function get unlockPricePremium() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["UnlockPricePremium"])
         {
            _loc2_._cache["UnlockPricePremium"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","UnlockPricePremium");
         }
         var _loc1_:Field = _loc2_._cache["UnlockPricePremium"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get popularitySortOrder() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["PopularitySortOrder"])
         {
            _loc2_._cache["PopularitySortOrder"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","PopularitySortOrder");
         }
         var _loc1_:Field = _loc2_._cache["PopularitySortOrder"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      private function createPriceObject() : PriceObject
      {
         var _loc1_:* = null;
         if(inGamePrice > 0 && premiumPrice > 0)
         {
            LogUtils.log("PriceReference has both currencies configured:" + toString(),"PriceInfoReference",3,"ErrorLogging",true,true);
            _loc1_ = new PriceObject(true,premiumPrice,salePercentage);
            _loc1_.markException();
            return _loc1_;
         }
         if(premiumPrice > 0)
         {
            return new PriceObject(true,premiumPrice,salePercentage);
         }
         if(inGamePrice > 0)
         {
            return new PriceObject(false,inGamePrice,salePercentage);
         }
         return new PriceObject(false,0,salePercentage);
      }
      
      private function get inGamePrice() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["InGame"])
         {
            _loc2_._cache["InGame"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","InGame");
         }
         var _loc1_:Field = _loc2_._cache["InGame"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      private function get premiumPrice() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Premium"])
         {
            _loc2_._cache["Premium"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Premium");
         }
         var _loc1_:Field = _loc2_._cache["Premium"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      private function get inGamePriceOriginal() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["InGame"])
         {
            _loc2_._cache["InGame"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","InGame");
         }
         var _loc1_:Field = _loc2_._cache["InGame"];
         return !!_loc1_ ? _loc1_.originalValue : 0;
      }
      
      private function get premiumPriceOriginal() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Premium"])
         {
            _loc2_._cache["Premium"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Premium");
         }
         var _loc1_:Field = _loc2_._cache["Premium"];
         return !!_loc1_ ? _loc1_.originalValue : 0;
      }
      
      private function get salePercentage() : int
      {
         if(premiumPrice > 0)
         {
            return premiumPrice != premiumPriceOriginal ? 100 - premiumPrice / premiumPriceOriginal * 100 : 0;
         }
         return inGamePrice != inGamePriceOriginal ? 100 - inGamePrice / inGamePriceOriginal * 100 : 0;
      }
      
      public function toString() : String
      {
         return "PriceInfoReference <price: id:" + row.id + " inGame:" + inGamePrice + " premium:" + premiumPrice + " salePercentage:" + salePercentage + ">";
      }
   }
}
