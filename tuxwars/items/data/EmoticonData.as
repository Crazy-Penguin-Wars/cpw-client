package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class EmoticonData extends ItemData
   {
      private static const DURATION:String = "Duration";
      
      public function EmoticonData(param1:Row)
      {
         super(param1);
      }
      
      public function get duration() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Duration";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
   }
}

