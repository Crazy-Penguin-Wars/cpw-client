package tuxwars.battle.gameobjects
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   
   public class ColorReference
   {
      private static const RED_MULTIPLIER:String = "RedMultiplier";
      
      private static const GREEN_MULTIPLIER:String = "GreenMultiplier";
      
      private static const BLUE_MULTIPLIER:String = "BlueMultiplier";
      
      private static const ALPHA_MULTIPLIER:String = "AlphaMultiplier";
      
      private static const RED_OFFSET:String = "RedOffset";
      
      private static const GREEN_OFFSET:String = "GreenOffset";
      
      private static const BLUE_OFFSET:String = "BlueOffset";
      
      private static const ALPHA_OFFSET:String = "AlphaOffset";
      
      private var _fieldCache:Object;
      
      private var _row:Row;
      
      public function ColorReference(param1:Row)
      {
         super();
         this._fieldCache = {};
         this._row = param1;
      }
      
      public function get id() : String
      {
         return !!this._row ? this._row.id : null;
      }
      
      public function get redMultiplier() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("RedMultiplier");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 1;
      }
      
      public function get greenMultiplier() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("GreenMultiplier");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 1;
      }
      
      public function get blueMultiplier() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("BlueMultiplier");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 1;
      }
      
      public function get alphaMultiplier() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("AlphaMultiplier");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 1;
      }
      
      public function get redOffset() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("RedOffset");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get greenOffset() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("GreenOffset");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get blueOffset() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("BlueOffset");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public function get alphaOffset() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = this.getField("AlphaOffset");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      private function getField(param1:String) : Field
      {
         var _loc3_:* = undefined;
         var _loc4_:Row = null;
         var _loc2_:Field = null;
         if(!this._fieldCache.hasOwnProperty(param1))
         {
            _loc3_ = param1;
            _loc4_ = this._row;
            if(!_loc4_.getCache[_loc3_])
            {
               _loc4_.getCache[_loc3_] = DCUtils.find(_loc4_.getFields(),"name",_loc3_);
            }
            _loc2_ = _loc4_.getCache[_loc3_];
            this._fieldCache[param1] = _loc2_;
         }
         return this._fieldCache[param1];
      }
      
      public function toString() : String
      {
         return "id:" + this.id;
      }
   }
}

