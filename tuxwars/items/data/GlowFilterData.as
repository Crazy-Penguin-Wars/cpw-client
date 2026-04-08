package tuxwars.items.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
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
      
      public function GlowFilterData(param1:Row)
      {
         super();
         this.row = param1;
      }
      
      public function get color() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Color";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get alpha() : Number
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Alpha";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Number(_loc4_.overrideValue) : Number(_loc4_._value)) : 0;
      }
      
      public function get blurX() : Number
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "BlurX";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Number(_loc4_.overrideValue) : Number(_loc4_._value)) : 0;
      }
      
      public function get blurY() : Number
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "BlurY";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Number(_loc4_.overrideValue) : Number(_loc4_._value)) : 0;
      }
      
      public function get strength() : Number
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Strength";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Number(_loc4_.overrideValue) : Number(_loc4_._value)) : 0;
      }
      
      public function get quality() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Quality";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get inner() : Boolean
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Inner";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Boolean(_loc4_.overrideValue) : Boolean(_loc4_._value)) : false;
      }
      
      public function get knockout() : Boolean
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Knockout";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Boolean(_loc4_.overrideValue) : Boolean(_loc4_._value)) : false;
      }
   }
}

