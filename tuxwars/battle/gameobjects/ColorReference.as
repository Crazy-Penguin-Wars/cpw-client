package tuxwars.battle.gameobjects
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.Row;
   
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
      
      public function ColorReference(row:Row)
      {
         super();
         _fieldCache = {};
         _row = row;
      }
      
      public function get id() : String
      {
         return !!_row ? _row.id : null;
      }
      
      public function get redMultiplier() : int
      {
         var _loc1_:Field = getField("RedMultiplier");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 1;
      }
      
      public function get greenMultiplier() : int
      {
         var _loc1_:Field = getField("GreenMultiplier");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 1;
      }
      
      public function get blueMultiplier() : int
      {
         var _loc1_:Field = getField("BlueMultiplier");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 1;
      }
      
      public function get alphaMultiplier() : int
      {
         var _loc1_:Field = getField("AlphaMultiplier");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 1;
      }
      
      public function get redOffset() : int
      {
         var _loc1_:Field = getField("RedOffset");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get greenOffset() : int
      {
         var _loc1_:Field = getField("GreenOffset");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get blueOffset() : int
      {
         var _loc1_:Field = getField("BlueOffset");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public function get alphaOffset() : int
      {
         var _loc1_:Field = getField("AlphaOffset");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      private function getField(name:String) : Field
      {
         var _loc2_:* = null;
         if(!_fieldCache.hasOwnProperty(name))
         {
            var _loc4_:* = name;
            var _loc3_:Row = _row;
            if(!_loc3_._cache[_loc4_])
            {
               _loc3_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name",_loc4_);
            }
            _loc2_ = _loc3_._cache[_loc4_];
            _fieldCache[name] = _loc2_;
         }
         return _fieldCache[name];
      }
      
      public function toString() : String
      {
         return "id:" + id;
      }
   }
}
