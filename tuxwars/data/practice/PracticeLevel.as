package tuxwars.data.practice
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import tuxwars.data.TuxGameData;
   
   public class PracticeLevel extends TuxGameData
   {
      private static const LEVEL_FILE:String = "LevelFile";
      
      private static const MIN_LEVEL:String = "MinLevel";
      
      public function PracticeLevel(row:Row)
      {
         super(row);
      }
      
      public function get levelFile() : String
      {
         var _loc3_:String = "LevelFile";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get minLevel() : int
      {
         var _loc3_:String = "MinLevel";
         var _loc1_:Row = row;
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
   }
}

