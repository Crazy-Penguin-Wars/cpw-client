package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class VIPPriceData
   {
      private static const PRICE:String = "Price";
      
      private static const DURATION:String = "Duration";
      
      private var row:Row;
      
      public function VIPPriceData(param1:Row)
      {
         super();
         this.row = param1;
      }
      
      public function get id() : String
      {
         return this.row.id;
      }
      
      public function get price() : int
      {
         var _loc1_:String = "Price";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public function get duration() : int
      {
         var _loc1_:String = "Duration";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
   }
}

