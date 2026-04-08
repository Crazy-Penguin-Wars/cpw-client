package tuxwars.items.references
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import no.olog.utilfunctions.*;
   
   public class PriceInfoReference
   {
      private static const UNLOCK_PRICE_PREMIUM:String = "UnlockPricePremium";
      
      private static const INGAME:String = "InGame";
      
      private static const PREMIUM:String = "Premium";
      
      private static const SALE_PERCENTAGE:String = "SalePercentage";
      
      private static const POPULARITY_SORT_ORDER:String = "PopularitySortOrder";
      
      private var row:Row;
      
      public function PriceInfoReference(param1:Row)
      {
         super();
         assert("Row is null.",true,param1 != null);
         this.row = param1;
      }
      
      public function get priceObject() : PriceObject
      {
         return this.createPriceObject();
      }
      
      public function get unlockPricePremium() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "UnlockPricePremium";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get popularitySortOrder() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "PopularitySortOrder";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      private function createPriceObject() : PriceObject
      {
         var _loc1_:PriceObject = null;
         if(this.inGamePrice > 0 && this.premiumPrice > 0)
         {
            LogUtils.log("PriceReference has both currencies configured:" + this.toString(),"PriceInfoReference",3,"ErrorLogging",true,true);
            _loc1_ = new PriceObject(true,this.premiumPrice,this.salePercentage);
            _loc1_.markException();
            return _loc1_;
         }
         if(this.premiumPrice > 0)
         {
            return new PriceObject(true,this.premiumPrice,this.salePercentage);
         }
         if(this.inGamePrice > 0)
         {
            return new PriceObject(false,this.inGamePrice,this.salePercentage);
         }
         return new PriceObject(false,0,this.salePercentage);
      }
      
      private function get inGamePrice() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "InGame";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      private function get premiumPrice() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Premium";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      private function get inGamePriceOriginal() : int
      {
         var _loc1_:String = "InGame";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? _loc3_.originalValue : 0;
      }
      
      private function get premiumPriceOriginal() : int
      {
         var _loc1_:String = "Premium";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? _loc3_.originalValue : 0;
      }
      
      private function get salePercentage() : int
      {
         if(this.premiumPrice > 0)
         {
            return this.premiumPrice != this.premiumPriceOriginal ? int(100 - this.premiumPrice / this.premiumPriceOriginal * 100) : 0;
         }
         return this.inGamePrice != this.inGamePriceOriginal ? int(100 - this.inGamePrice / this.inGamePriceOriginal * 100) : 0;
      }
      
      public function toString() : String
      {
         return "PriceInfoReference <price: id:" + this.row.id + " inGame:" + this.inGamePrice + " premium:" + this.premiumPrice + " salePercentage:" + this.salePercentage + ">";
      }
   }
}

