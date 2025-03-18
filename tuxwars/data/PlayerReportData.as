package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class PlayerReportData
   {
      private static const ID:String = "ID";
      
      private static const DATA_FIELD:String = "DataField";
      
      private static const ORDER:String = "Order";
      
      private static const DESCRIPTION:String = "Description";
      
      private var row:Row;
      
      public function PlayerReportData(row:Row)
      {
         super();
         this.row = row;
      }
      
      public function get id() : String
      {
         return row.id;
      }
      
      public function get dataField() : String
      {
         var _loc3_:String = "DataField";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get order() : int
      {
         var _loc3_:String = "Order";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get description() : String
      {
         var _loc3_:String = "Description";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
   }
}

