package tuxwars.items.references
{
   public class PriceObject
   {
       
      
      private var _isPremiumCurrency:Boolean;
      
      private var _priceValue:int;
      
      private var _hasException:Boolean;
      
      private var _salePercentage:int;
      
      public function PriceObject(isPremium:Boolean, priceValue:int, salePercentage:int)
      {
         super();
         _isPremiumCurrency = isPremium;
         _priceValue = priceValue;
         _salePercentage = salePercentage;
      }
      
      public function get isSale() : Boolean
      {
         return _salePercentage != 0;
      }
      
      public function get salePercentage() : int
      {
         return _salePercentage;
      }
      
      public function get isPremium() : Boolean
      {
         return _isPremiumCurrency;
      }
      
      public function get priceValue() : int
      {
         return _priceValue;
      }
      
      public function setExceptionPrice() : void
      {
         _isPremiumCurrency = true;
         _priceValue = 999;
         markException();
      }
      
      public function markException() : void
      {
         _hasException = true;
      }
      
      public function get isExceptionPrice() : Boolean
      {
         return _hasException;
      }
   }
}
