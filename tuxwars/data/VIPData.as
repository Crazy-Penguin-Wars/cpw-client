package tuxwars.data
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
   public class VIPData
   {
      
      private static const VIP_TABLE:String = "VIP";
      
      private static const VIP_PRICE_TABLE:String = "VIPPrice";
      
      private static const DEFAULT_ROW:String = "Default";
      
      private static const EXP_MULTIPLIER:String = "ExpMultiplier";
      
      private static const INGAME_MONEY_MULTIPLIER:String = "IngameMoneyMultiplier";
      
      private static var vipRow:Row;
       
      
      public function VIPData()
      {
         super();
         throw new Error("VIPData is a static class!");
      }
      
      public static function getExpMultiplier() : Number
      {
         var _loc1_:* = getVIPRow();
         if(!_loc1_._cache["ExpMultiplier"])
         {
            _loc1_._cache["ExpMultiplier"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","ExpMultiplier");
         }
         var _loc2_:* = _loc1_._cache["ExpMultiplier"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getIngameMoneyMultiplier() : Number
      {
         var _loc1_:* = getVIPRow();
         if(!_loc1_._cache["IngameMoneyMultiplier"])
         {
            _loc1_._cache["IngameMoneyMultiplier"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","IngameMoneyMultiplier");
         }
         var _loc2_:* = _loc1_._cache["IngameMoneyMultiplier"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getVIPPrice(id:String) : VIPPriceData
      {
         var _loc3_:ProjectManager = ProjectManager;
         var _loc2_:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable("VIPPrice");
         var _loc6_:* = id;
         var _loc4_:* = _loc2_;
         §§push(§§findproperty(VIPPriceData));
         if(!_loc4_._cache[_loc6_])
         {
            var _loc7_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc6_);
            if(!_loc7_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc6_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc6_] = _loc7_;
         }
         return new §§pop().VIPPriceData(_loc4_._cache[_loc6_]);
      }
      
      private static function getVIPRow() : Row
      {
         if(!vipRow)
         {
            var _loc1_:ProjectManager = ProjectManager;
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("VIP");
            if(!_loc2_._cache["Default"])
            {
               var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id","Default");
               if(!_loc5_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_._cache["Default"] = _loc5_;
            }
            vipRow = _loc2_._cache["Default"];
         }
         return vipRow;
      }
   }
}
