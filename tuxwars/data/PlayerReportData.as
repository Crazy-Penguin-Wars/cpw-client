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
      
      public function PlayerReportData(param1:Row)
      {
         super();
         this.row = param1;
      }
      
      public function get id() : String
      {
         return this.row.id;
      }
      
      public function get dataField() : String
      {
         var _loc1_:String = "DataField";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public function get order() : int
      {
         var _loc1_:String = "Order";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public function get description() : String
      {
         var _loc1_:String = "Description";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
   }
}

