package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class VIPData
   {
      private static var vipRow:Row;
      
      private static const VIPtable:String = "VIP";
      
      private static const VIP_PRICEtable:String = "VIPPrice";
      
      private static const DEFAULT_ROW:String = "Default";
      
      private static const EXP_MULTIPLIER:String = "ExpMultiplier";
      
      private static const INGAME_MONEY_MULTIPLIER:String = "IngameMoneyMultiplier";
      
      public function VIPData()
      {
         super();
         throw new Error("VIPData is a static class!");
      }
      
      public static function getExpMultiplier() : Number
      {
         var _loc1_:String = "ExpMultiplier";
         var _loc2_:* = getVIPRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getIngameMoneyMultiplier() : Number
      {
         var _loc1_:String = "IngameMoneyMultiplier";
         var _loc2_:* = getVIPRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getVIPPrice(param1:String) : VIPPriceData
      {
         var _loc3_:Row = null;
         var _loc2_:Table = ProjectManager.findTable("VIPPrice");
         if(!_loc2_.getCache[param1])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",param1);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + param1 + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[param1] = _loc3_;
         }
         return new VIPPriceData(_loc2_.getCache[param1]);
      }
      
      private static function getVIPRow() : Row
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:Row = null;
         if(!vipRow)
         {
            _loc1_ = "VIP";
            _loc2_ = "Default";
            _loc3_ = ProjectManager.findTable(_loc1_);
            if(!_loc3_.getCache[_loc2_])
            {
               _loc4_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
               if(!_loc4_)
               {
                  LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
               }
               _loc3_.getCache[_loc2_] = _loc4_;
            }
            vipRow = _loc3_.getCache[_loc2_];
         }
         return vipRow;
      }
   }
}

