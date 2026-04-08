package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class ClothingData extends ItemData
   {
      private static const SET:String = "Set";
      
      private static const RIGHT_FOOT_EXPORT:String = "RightFootExport";
      
      private static const INCLUDED_FACIAL_EXPRESSION:String = "IncludedFacialExpression";
      
      public function ClothingData(param1:Row)
      {
         super(param1);
      }
      
      public function get setReference() : SetReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Set";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, new SetReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : null;
      }
      
      public function get rightFootExport() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "RightFootExport";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get includedFacialExpressionID() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "IncludedFacialExpression";
         var _loc2_:Row = row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return Boolean(_loc3_) && (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value).id : null;
      }
   }
}

