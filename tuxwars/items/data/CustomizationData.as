package tuxwars.items.data
{
   import com.dchoc.data.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class CustomizationData extends ClothingData
   {
      private static const GRAPHICS:String = "Graphics";
      
      public function CustomizationData(param1:Row)
      {
         super(param1);
      }
      
      override public function get graphics() : GraphicsReference
      {
         var _loc1_:String = null;
         var _loc2_:Row = null;
         var _loc3_:Field = null;
         var _loc4_:Row = null;
         if(!_graphics)
         {
            _loc1_ = "Graphics";
            _loc2_ = row;
            if(!_loc2_.getCache[_loc1_])
            {
               _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
            }
            _loc3_ = _loc2_.getCache[_loc1_];
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
               _graphics = new GraphicsReference(_loc4_);
            }
            else
            {
               _graphics = null;
            }
         }
         return _graphics;
      }
   }
}

