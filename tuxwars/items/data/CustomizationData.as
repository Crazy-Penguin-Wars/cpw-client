package tuxwars.items.data
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   
   public class CustomizationData extends ClothingData
   {
      
      private static const GRAPHICS:String = "Graphics";
       
      
      public function CustomizationData(row:Row)
      {
         super(row);
      }
      
      override public function get graphics() : GraphicsReference
      {
         var _loc1_:* = null;
         if(!_graphics)
         {
            var _loc2_:Row = row;
            if(!_loc2_._cache["Graphics"])
            {
               _loc2_._cache["Graphics"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Graphics");
            }
            _loc1_ = _loc2_._cache["Graphics"];
            if(_loc1_ != null)
            {
               var _loc3_:Row = row;
               §§push(§§findproperty(GraphicsReference));
               if(!_loc3_._cache["Graphics"])
               {
                  _loc3_._cache["Graphics"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","Graphics");
               }
               var _loc4_:* = _loc3_._cache["Graphics"];
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
