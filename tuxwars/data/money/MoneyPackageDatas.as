package tuxwars.data.money
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class MoneyPackageDatas
   {
      private static var cashTable:Table;
      
      private static var coinTable:Table;
      
      private static var cashPackages:Vector.<CashPackageData>;
      
      private static var coinPackages:Vector.<CoinPackageData>;
      
      private static const CASH_PACKAGEtable:String = "CashPackage";
      
      private static const COIN_PACKAGEtable:String = "CoinPackage";
      
      private static const MONEY_DATA_CACHE:Object = {};
      
      public function MoneyPackageDatas()
      {
         super();
         throw new Error("MoneyPackages is a static class!");
      }
      
      public static function getCashPackageDatas() : Vector.<CashPackageData>
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc1_:Table = null;
         var _loc2_:CashPackageData = null;
         if(!cashPackages)
         {
            cashPackages = new Vector.<CashPackageData>();
            _loc1_ = getCashPackageTable();
            _loc3_ = _loc1_;
            for each(_loc4_ in _loc3_._rows)
            {
               if(!MONEY_DATA_CACHE.hasOwnProperty(_loc4_.id))
               {
                  _loc2_ = new CashPackageData(_loc4_);
                  MONEY_DATA_CACHE[_loc4_.id] = _loc2_;
               }
               cashPackages.push(MONEY_DATA_CACHE[_loc4_.id]);
            }
         }
         return cashPackages;
      }
      
      public static function getCoinPackageDatas() : Vector.<CoinPackageData>
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc1_:Table = null;
         var _loc2_:CoinPackageData = null;
         if(!coinPackages)
         {
            coinPackages = new Vector.<CoinPackageData>();
            _loc1_ = getCoinPackageTable();
            _loc3_ = _loc1_;
            for each(_loc4_ in _loc3_._rows)
            {
               if(!MONEY_DATA_CACHE.hasOwnProperty(_loc4_.id))
               {
                  _loc2_ = new CoinPackageData(_loc4_);
                  MONEY_DATA_CACHE[_loc4_.id] = _loc2_;
               }
               coinPackages.push(MONEY_DATA_CACHE[_loc4_.id]);
            }
         }
         return coinPackages;
      }
      
      public static function getCashPackageData(param1:String) : CashPackageData
      {
         var _loc4_:Row = null;
         if(MONEY_DATA_CACHE.hasOwnProperty(param1))
         {
            return MONEY_DATA_CACHE[param1];
         }
         var _loc2_:Table = getCashPackageTable();
         if(!_loc2_.getCache[param1])
         {
            _loc4_ = DCUtils.find(_loc2_.rows,"id",param1);
            if(!_loc4_)
            {
               LogUtils.log("No row with name: \'" + param1 + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[param1] = _loc4_;
         }
         var _loc3_:CashPackageData = new CashPackageData(_loc2_.getCache[param1]);
         MONEY_DATA_CACHE[param1] = _loc3_;
         return _loc3_;
      }
      
      public static function getCoinPackageData(param1:String) : CoinPackageData
      {
         var _loc4_:Row = null;
         if(MONEY_DATA_CACHE.hasOwnProperty(param1))
         {
            return MONEY_DATA_CACHE[param1];
         }
         var _loc2_:Table = getCoinPackageTable();
         if(!_loc2_.getCache[param1])
         {
            _loc4_ = DCUtils.find(_loc2_.rows,"id",param1);
            if(!_loc4_)
            {
               LogUtils.log("No row with name: \'" + param1 + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[param1] = _loc4_;
         }
         var _loc3_:CoinPackageData = new CoinPackageData(_loc2_.getCache[param1]);
         MONEY_DATA_CACHE[param1] = _loc3_;
         return _loc3_;
      }
      
      private static function getCashPackageTable() : Table
      {
         var _loc1_:String = null;
         if(!cashTable)
         {
            _loc1_ = "CashPackage";
            cashTable = ProjectManager.findTable(_loc1_);
         }
         return cashTable;
      }
      
      private static function getCoinPackageTable() : Table
      {
         var _loc1_:String = null;
         if(!coinTable)
         {
            _loc1_ = "CoinPackage";
            coinTable = ProjectManager.findTable(_loc1_);
         }
         return coinTable;
      }
   }
}

