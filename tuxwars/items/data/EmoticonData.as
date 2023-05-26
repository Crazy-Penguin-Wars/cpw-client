package tuxwars.items.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   
   public class EmoticonData extends ItemData
   {
      
      private static const DURATION:String = "Duration";
       
      
      public function EmoticonData(row:Row)
      {
         super(row);
      }
      
      public function get duration() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Duration"])
         {
            _loc2_._cache["Duration"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Duration");
         }
         var _loc1_:Field = _loc2_._cache["Duration"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
   }
}
