package tuxwars.data
{
   import com.dchoc.projectdata.Row;
   
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
         var _loc1_:Row = row;
         if(!_loc1_._cache["DataField"])
         {
            _loc1_._cache["DataField"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","DataField");
         }
         var _loc2_:* = _loc1_._cache["DataField"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get order() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["Order"])
         {
            _loc1_._cache["Order"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Order");
         }
         var _loc2_:* = _loc1_._cache["Order"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get description() : String
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["Description"])
         {
            _loc1_._cache["Description"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Description");
         }
         var _loc2_:* = _loc1_._cache["Description"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
   }
}
