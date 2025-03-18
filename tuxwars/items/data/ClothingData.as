package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class ClothingData extends ItemData
   {
      private static const SET:String = "Set";
      
      private static const RIGHT_FOOT_EXPORT:String = "RightFootExport";
      
      private static const INCLUDED_FACIAL_EXPRESSION:String = "IncludedFacialExpression";
      
      public function ClothingData(row:Row)
      {
         super(row);
      }
      
      public function get setReference() : SetReference
      {
         var _loc4_:String = "Set";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new SetReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get rightFootExport() : String
      {
         var _loc4_:String = "RightFootExport";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get includedFacialExpressionID() : String
      {
         var _loc5_:String = "IncludedFacialExpression";
         var _loc2_:Row = row;
         if(!_loc2_._cache[_loc5_])
         {
            _loc2_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc5_);
         }
         var _loc1_:Field = _loc2_._cache[_loc5_];
         var _loc4_:*;
         return _loc1_ && (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) ? (_loc4_ = _loc1_, (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value).id) : null;
      }
   }
}

