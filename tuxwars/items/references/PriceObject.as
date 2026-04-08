package tuxwars.items.references
{
   public class PriceObject
   {
      private var _isPremiumCurrency:Boolean;
      
      private var _priceValue:int;
      
      private var _hasException:Boolean;
      
      private var _salePercentage:int;
      
      public function PriceObject(param1:Boolean, param2:int, param3:int)
      {
         super();
         this._isPremiumCurrency = param1;
         this._priceValue = param2;
         this._salePercentage = param3;
      }
      
      public function get isSale() : Boolean
      {
         return this._salePercentage != 0;
      }
      
      public function get salePercentage() : int
      {
         return this._salePercentage;
      }
      
      public function get isPremium() : Boolean
      {
         return this._isPremiumCurrency;
      }
      
      public function get priceValue() : int
      {
         return this._priceValue;
      }
      
      public function setExceptionPrice() : void
      {
         this._isPremiumCurrency = true;
         this._priceValue = 999;
         this.markException();
      }
      
      public function markException() : void
      {
         this._hasException = true;
      }
      
      public function get isExceptionPrice() : Boolean
      {
         return this._hasException;
      }
   }
}

