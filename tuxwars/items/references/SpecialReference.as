package tuxwars.items.references
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import no.olog.utilfunctions.*;
   
   public class SpecialReference
   {
      public static const TYPE_CUSTOMIZATION_VALUE_MULTIPLIER_R:String = "RedMultiplier";
      
      public static const TYPE_CUSTOMIZATION_VALUE_MULTIPLIER_G:String = "GreenMultiplier";
      
      public static const TYPE_CUSTOMIZATION_VALUE_MULTIPLIER_B:String = "BlueMultiplier";
      
      private var row:Row;
      
      public function SpecialReference(param1:Row)
      {
         super();
         assert("SpecialReference row is null",true,param1 != null);
         this.row = param1;
      }
      
      public function getID() : String
      {
         return this.row.id;
      }
      
      public function getValue(param1:String) : *
      {
         var _loc5_:* = undefined;
         var _loc2_:* = param1;
         var _loc3_:Row = this.row;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         _loc5_ = _loc4_;
         var _loc4_:Field = _loc3_.getCache[_loc2_];
         return !!_loc4_ ? (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) : null;
      }
   }
}

