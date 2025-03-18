package tuxwars.items.references
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
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
         var _loc4_:String = "UnlockPricePremium";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get popularitySortOrder() : int
      {
         var _loc4_:String = "PopularitySortOrder";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      private function createPriceObject() : PriceObject
      {
         var _loc1_:PriceObject = null;
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
         var _loc4_:String = "InGame";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      private function get premiumPrice() : int
      {
         var _loc4_:String = "Premium";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      private function get inGamePriceOriginal() : int
      {
         var _loc3_:String = "InGame";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc3_])
         {
            _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
         }
         var _loc1_:Field = _loc2_._cache[_loc3_];
         return !!_loc1_ ? _loc1_.originalValue : 0;
      }
      
      private function get premiumPriceOriginal() : int
      {
         var _loc3_:String = "Premium";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc3_])
         {
            _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
         }
         var _loc1_:Field = _loc2_._cache[_loc3_];
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

