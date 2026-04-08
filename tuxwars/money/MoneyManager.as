package tuxwars.money
{
   import tuxwars.data.money.*;
   
   public class MoneyManager
   {
      private static const MONEY_CACHE:Object = {};
      
      public function MoneyManager()
      {
         super();
      }
      
      public static function getCashPackages() : Vector.<CashPackage>
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<CashPackage> = new Vector.<CashPackage>();
         var _loc3_:Vector.<CashPackageData> = MoneyPackageDatas.getCashPackageDatas();
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_.push(createCashPackageFromData(_loc3_[_loc1_]));
            _loc1_++;
         }
         _loc2_.sort(sortCashInOrder);
         return _loc2_;
      }
      
      private static function sortCashInOrder(param1:CashPackage, param2:CashPackage) : int
      {
         if(param1.sortPriority < param2.sortPriority)
         {
            return 0;
         }
         if(param1.sortPriority > param2.sortPriority)
         {
            return 1;
         }
         return -1;
      }
      
      public static function getCoinPackages() : Vector.<CoinPackage>
      {
         var _loc1_:int = 0;
         var _loc2_:Vector.<CoinPackage> = new Vector.<CoinPackage>();
         var _loc3_:Vector.<CoinPackageData> = MoneyPackageDatas.getCoinPackageDatas();
         _loc1_ = 0;
         while(_loc1_ < _loc3_.length)
         {
            _loc2_.push(createCoinPackageFromData(_loc3_[_loc1_]));
            _loc1_++;
         }
         _loc2_.sort(sortCoinsInOrder);
         return _loc2_;
      }
      
      private static function sortCoinsInOrder(param1:CoinPackage, param2:CoinPackage) : int
      {
         if(param1.sortPriority < param2.sortPriority)
         {
            return -1;
         }
         if(param1.sortPriority > param2.sortPriority)
         {
            return 1;
         }
         return 0;
      }
      
      public static function getCashPackage(param1:String) : CashPackage
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<CashPackage> = getCashPackages();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public static function getCoinPackage(param1:String) : CoinPackage
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<CoinPackage> = getCoinPackages();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private static function createCashPackageFromName(param1:String) : CashPackage
      {
         var _loc2_:CashPackageData = MoneyPackageDatas.getCashPackageData(param1);
         var _loc3_:CashPackage = new CashPackage();
         _loc3_.loadDataConf(_loc2_);
         return _loc3_;
      }
      
      private static function createCoinPackageFromName(param1:String) : CoinPackage
      {
         var _loc2_:CoinPackageData = MoneyPackageDatas.getCoinPackageData(param1);
         var _loc3_:CoinPackage = new CoinPackage();
         _loc3_.loadDataConf(_loc2_);
         return _loc3_;
      }
      
      private static function createCashPackageFromData(param1:CashPackageData) : CashPackage
      {
         if(MONEY_CACHE.hasOwnProperty(param1.id))
         {
            return MONEY_CACHE[param1.id];
         }
         var _loc2_:CashPackage = new CashPackage();
         _loc2_.loadDataConf(param1);
         MONEY_CACHE[_loc2_.id] = _loc2_;
         return _loc2_;
      }
      
      private static function createCoinPackageFromData(param1:CoinPackageData) : CoinPackage
      {
         if(MONEY_CACHE.hasOwnProperty(param1.id))
         {
            return MONEY_CACHE[param1.id];
         }
         var _loc2_:CoinPackage = new CoinPackage();
         _loc2_.loadDataConf(param1);
         MONEY_CACHE[_loc2_.id] = _loc2_;
         return _loc2_;
      }
   }
}

