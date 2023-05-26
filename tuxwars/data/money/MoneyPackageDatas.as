package tuxwars.data.money
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class MoneyPackageDatas
   {
      
      private static const CASH_PACKAGE_TABLE:String = "CashPackage";
      
      private static const COIN_PACKAGE_TABLE:String = "CoinPackage";
      
      private static const MONEY_DATA_CACHE:Object = {};
      
      private static var cashTable:Table;
      
      private static var coinTable:Table;
      
      private static var cashPackages:Vector.<CashPackageData>;
      
      private static var coinPackages:Vector.<CoinPackageData>;
       
      
      public function MoneyPackageDatas()
      {
         super();
         throw new Error("MoneyPackages is a static class!");
      }
      
      public static function getCashPackageDatas() : Vector.<CashPackageData>
      {
         var cashTable:* = null;
         var _loc1_:* = null;
         if(!cashPackages)
         {
            cashPackages = new Vector.<CashPackageData>();
            cashTable = getCashPackageTable();
            var _loc4_:* = cashTable;
            for each(var row in _loc4_._rows)
            {
               if(!MONEY_DATA_CACHE.hasOwnProperty(row.id))
               {
                  _loc1_ = new CashPackageData(row);
                  MONEY_DATA_CACHE[row.id] = _loc1_;
               }
               cashPackages.push(MONEY_DATA_CACHE[row.id]);
            }
         }
         return cashPackages;
      }
      
      public static function getCoinPackageDatas() : Vector.<CoinPackageData>
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(!coinPackages)
         {
            coinPackages = new Vector.<CoinPackageData>();
            _loc2_ = getCoinPackageTable();
            var _loc4_:* = _loc2_;
            for each(var row in _loc4_._rows)
            {
               if(!MONEY_DATA_CACHE.hasOwnProperty(row.id))
               {
                  _loc1_ = new CoinPackageData(row);
                  MONEY_DATA_CACHE[row.id] = _loc1_;
               }
               coinPackages.push(MONEY_DATA_CACHE[row.id]);
            }
         }
         return coinPackages;
      }
      
      public static function getCashPackageData(name:String) : CashPackageData
      {
         if(MONEY_DATA_CACHE.hasOwnProperty(name))
         {
            return MONEY_DATA_CACHE[name];
         }
         var _loc4_:* = name;
         var _loc3_:* = getCashPackageTable();
         §§push(§§findproperty(CashPackageData));
         if(!_loc3_._cache[_loc4_])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc4_);
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc4_] = _loc5_;
         }
         var _loc2_:CashPackageData = new §§pop().CashPackageData(_loc3_._cache[_loc4_]);
         MONEY_DATA_CACHE[name] = _loc2_;
         return _loc2_;
      }
      
      public static function getCoinPackageData(name:String) : CoinPackageData
      {
         if(MONEY_DATA_CACHE.hasOwnProperty(name))
         {
            return MONEY_DATA_CACHE[name];
         }
         var _loc4_:* = name;
         var _loc3_:* = getCoinPackageTable();
         §§push(§§findproperty(CoinPackageData));
         if(!_loc3_._cache[_loc4_])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc4_);
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc4_] = _loc5_;
         }
         var _loc2_:CoinPackageData = new §§pop().CoinPackageData(_loc3_._cache[_loc4_]);
         MONEY_DATA_CACHE[name] = _loc2_;
         return _loc2_;
      }
      
      private static function getCashPackageTable() : Table
      {
         if(!cashTable)
         {
            var _loc1_:ProjectManager = ProjectManager;
            cashTable = com.dchoc.projectdata.ProjectManager.projectData.findTable("CashPackage");
         }
         return cashTable;
      }
      
      private static function getCoinPackageTable() : Table
      {
         if(!coinTable)
         {
            var _loc1_:ProjectManager = ProjectManager;
            coinTable = com.dchoc.projectdata.ProjectManager.projectData.findTable("CoinPackage");
         }
         return coinTable;
      }
   }
}
