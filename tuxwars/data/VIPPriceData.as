package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class VIPPriceData
   {
      private static const PRICE:String = "Price";
      
      private static const DURATION:String = "Duration";
      
      private var row:Row;
      
      public function VIPPriceData(row:Row)
      {
         super();
         this.row = row;
      }
      
      public function get id() : String
      {
         return row.id;
      }
      
      public function get price() : int
      {
         var _loc3_:String = "Price";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get duration() : int
      {
         var _loc3_:String = "Duration";
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

