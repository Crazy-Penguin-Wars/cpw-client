package tuxwars.items.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   
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
         var _loc2_:Row = row;
         if(!_loc2_._cache["Set"])
         {
            _loc2_._cache["Set"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Set");
         }
         var _loc1_:Field = _loc2_._cache["Set"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, new SetReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : null;
      }
      
      public function get rightFootExport() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RightFootExport"])
         {
            _loc2_._cache["RightFootExport"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RightFootExport");
         }
         var _loc1_:Field = _loc2_._cache["RightFootExport"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get includedFacialExpressionID() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["IncludedFacialExpression"])
         {
            _loc2_._cache["IncludedFacialExpression"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","IncludedFacialExpression");
         }
         var _loc1_:Field = _loc2_._cache["IncludedFacialExpression"];
         var _loc4_:*;
         return _loc1_ && (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) ? (_loc4_ = _loc1_, (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value).id) : null;
      }
   }
}
