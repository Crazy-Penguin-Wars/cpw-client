package tuxwars.items.data
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class CustomizationData extends ClothingData
   {
      private static const GRAPHICS:String = "Graphics";
      
      public function CustomizationData(row:Row)
      {
         super(row);
      }
      
      override public function get graphics() : GraphicsReference
      {
         var _loc1_:Field = null;
         if(!_graphics)
         {
            var _loc5_:String = "Graphics";
            var _loc2_:Row = row;
            if(!_loc2_._cache[_loc5_])
            {
               _loc2_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc5_);
            }
            _loc1_ = _loc2_._cache[_loc5_];
            if(_loc1_ != null)
            {
               var _loc6_:String = "Graphics";
               var _loc3_:Row = row;
               §§push(§§findproperty(GraphicsReference));
               if(!_loc3_._cache[_loc6_])
               {
                  _loc3_._cache[_loc6_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc6_);
               }
               var _loc4_:* = _loc3_._cache[_loc6_];
               _graphics = new §§pop().GraphicsReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
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

