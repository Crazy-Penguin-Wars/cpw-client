package tuxwars.items.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   
   public class GlowFilterData
   {
      
      private static const COLOR:String = "Color";
      
      private static const ALPHA:String = "Alpha";
      
      private static const BLUR_X:String = "BlurX";
      
      private static const BLUR_Y:String = "BlurY";
      
      private static const STRENGTH:String = "Strength";
      
      private static const QUALITY:String = "Quality";
      
      private static const INNER:String = "Inner";
      
      private static const KNOCKOUT:String = "Knockout";
       
      
      private var row:Row;
      
      public function GlowFilterData(row:Row)
      {
         super();
         this.row = row;
      }
      
      public function get color() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Color"])
         {
            _loc2_._cache["Color"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Color");
         }
         var _loc1_:Field = _loc2_._cache["Color"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get alpha() : Number
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Alpha"])
         {
            _loc2_._cache["Alpha"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Alpha");
         }
         var _loc1_:Field = _loc2_._cache["Alpha"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get blurX() : Number
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["BlurX"])
         {
            _loc2_._cache["BlurX"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","BlurX");
         }
         var _loc1_:Field = _loc2_._cache["BlurX"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get blurY() : Number
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["BlurY"])
         {
            _loc2_._cache["BlurY"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","BlurY");
         }
         var _loc1_:Field = _loc2_._cache["BlurY"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get strength() : Number
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Strength"])
         {
            _loc2_._cache["Strength"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Strength");
         }
         var _loc1_:Field = _loc2_._cache["Strength"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get quality() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Quality"])
         {
            _loc2_._cache["Quality"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Quality");
         }
         var _loc1_:Field = _loc2_._cache["Quality"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get inner() : Boolean
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Inner"])
         {
            _loc2_._cache["Inner"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Inner");
         }
         var _loc1_:Field = _loc2_._cache["Inner"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : false;
      }
      
      public function get knockout() : Boolean
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Knockout"])
         {
            _loc2_._cache["Knockout"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Knockout");
         }
         var _loc1_:Field = _loc2_._cache["Knockout"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : false;
      }
   }
}
