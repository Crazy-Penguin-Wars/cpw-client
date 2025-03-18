package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
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
         var _loc3_:String = "ExpMultiplier";
         var _loc1_:* = getVIPRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getIngameMoneyMultiplier() : Number
      {
         var _loc3_:String = "IngameMoneyMultiplier";
         var _loc1_:* = getVIPRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getVIPPrice(id:String) : VIPPriceData
      {
         var _loc5_:String = "VIPPrice";
         var _loc3_:ProjectManager = ProjectManager;
         var _loc2_:Table = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc5_);
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
            var _loc3_:String = "VIP";
            var _loc1_:ProjectManager = ProjectManager;
            var _loc4_:String = "Default";
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc3_);
            if(!_loc2_._cache[_loc4_])
            {
               var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc4_);
               if(!_loc5_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_._cache[_loc4_] = _loc5_;
            }
            vipRow = _loc2_._cache[_loc4_];
         }
         return vipRow;
      }
   }
}

