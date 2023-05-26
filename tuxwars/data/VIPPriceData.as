package tuxwars.data
{
   import com.dchoc.projectdata.Row;
   
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
         var _loc1_:Row = row;
         if(!_loc1_._cache["Price"])
         {
            _loc1_._cache["Price"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Price");
         }
         var _loc2_:* = _loc1_._cache["Price"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get duration() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["Duration"])
         {
            _loc1_._cache["Duration"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Duration");
         }
         var _loc2_:* = _loc1_._cache["Duration"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
   }
}
