package tuxwars.money
{
   import tuxwars.data.money.CashPackageData;
   import tuxwars.data.money.CoinPackageData;
   import tuxwars.data.money.MoneyPackageDatas;
   
   public class MoneyManager
   {
      
      private static const MONEY_CACHE:Object = {};
       
      
      public function MoneyManager()
      {
         super();
      }
      
      public static function getCashPackages() : Vector.<CashPackage>
      {
         var i:int = 0;
         var cashPackages:Vector.<CashPackage> = new Vector.<CashPackage>();
         var cashPackageDatas:Vector.<CashPackageData> = MoneyPackageDatas.getCashPackageDatas();
         for(i = 0; i < cashPackageDatas.length; )
         {
            cashPackages.push(createCashPackageFromData(cashPackageDatas[i]));
            i++;
         }
         cashPackages.sort(sortCashInOrder);
         return cashPackages;
      }
      
      private static function sortCashInOrder(cash1:CashPackage, cash2:CashPackage) : int
      {
         if(cash1.sortPriority < cash2.sortPriority)
         {
            return 0;
         }
         if(cash1.sortPriority > cash2.sortPriority)
         {
            return 1;
         }
         return -1;
      }
      
      public static function getCoinPackages() : Vector.<CoinPackage>
      {
         var i:int = 0;
         var coinPackages:Vector.<CoinPackage> = new Vector.<CoinPackage>();
         var coinPackageDatas:Vector.<CoinPackageData> = MoneyPackageDatas.getCoinPackageDatas();
         for(i = 0; i < coinPackageDatas.length; )
         {
            coinPackages.push(createCoinPackageFromData(coinPackageDatas[i]));
            i++;
         }
         coinPackages.sort(sortCoinsInOrder);
         return coinPackages;
      }
      
      private static function sortCoinsInOrder(coin1:CoinPackage, coin2:CoinPackage) : int
      {
         if(coin1.sortPriority < coin2.sortPriority)
         {
            return -1;
         }
         if(coin1.sortPriority > coin2.sortPriority)
         {
            return 1;
         }
         return 0;
      }
      
      public static function getCashPackage(id:String) : CashPackage
      {
         var _loc3_:Vector.<CashPackage> = getCashPackages();
         for each(var cp in _loc3_)
         {
            if(cp.id == id)
            {
               return cp;
            }
         }
         return null;
      }
      
      public static function getCoinPackage(id:String) : CoinPackage
      {
         var _loc3_:Vector.<CoinPackage> = getCoinPackages();
         for each(var cp in _loc3_)
         {
            if(cp.id == id)
            {
               return cp;
            }
         }
         return null;
      }
      
      private static function createCashPackageFromName(type:String) : CashPackage
      {
         var _loc2_:CashPackageData = MoneyPackageDatas.getCashPackageData(type);
         var _loc3_:CashPackage = new CashPackage();
         _loc3_.loadDataConf(_loc2_);
         return _loc3_;
      }
      
      private static function createCoinPackageFromName(type:String) : CoinPackage
      {
         var _loc3_:CoinPackageData = MoneyPackageDatas.getCoinPackageData(type);
         var _loc2_:CoinPackage = new CoinPackage();
         _loc2_.loadDataConf(_loc3_);
         return _loc2_;
      }
      
      private static function createCashPackageFromData(cpd:CashPackageData) : CashPackage
      {
         if(MONEY_CACHE.hasOwnProperty(cpd.id))
         {
            return MONEY_CACHE[cpd.id];
         }
         var _loc2_:CashPackage = new CashPackage();
         _loc2_.loadDataConf(cpd);
         MONEY_CACHE[_loc2_.id] = _loc2_;
         return _loc2_;
      }
      
      private static function createCoinPackageFromData(cpd:CoinPackageData) : CoinPackage
      {
         if(MONEY_CACHE.hasOwnProperty(cpd.id))
         {
            return MONEY_CACHE[cpd.id];
         }
         var _loc2_:CoinPackage = new CoinPackage();
         _loc2_.loadDataConf(cpd);
         MONEY_CACHE[_loc2_.id] = _loc2_;
         return _loc2_;
      }
   }
}
