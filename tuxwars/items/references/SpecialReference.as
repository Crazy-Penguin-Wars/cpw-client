package tuxwars.items.references
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   import no.olog.utilfunctions.assert;
   
   public class SpecialReference
   {
      
      public static const TYPE_CUSTOMIZATION_VALUE_MULTIPLIER_R:String = "RedMultiplier";
      
      public static const TYPE_CUSTOMIZATION_VALUE_MULTIPLIER_G:String = "GreenMultiplier";
      
      public static const TYPE_CUSTOMIZATION_VALUE_MULTIPLIER_B:String = "BlueMultiplier";
       
      
      private var row:Row;
      
      public function SpecialReference(row:Row)
      {
         super();
         assert("SpecialReference row is null",true,row != null);
         this.row = row;
      }
      
      public function getID() : String
      {
         return row.id;
      }
      
      public function getValue(valueName:String) : *
      {
         var _loc5_:* = valueName;
         var _loc3_:Row = row;
         if(!_loc3_._cache[_loc5_])
         {
            _loc3_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc5_);
         }
         var _loc2_:Field = _loc3_._cache[_loc5_];
         var _loc4_:*;
         return !!_loc2_ ? (_loc4_ = _loc2_, _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
   }
}
