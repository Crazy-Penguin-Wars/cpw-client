package tuxwars.data.practice
{
   import com.dchoc.projectdata.Row;
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
         var _loc1_:Row = row;
         if(!_loc1_._cache["LevelFile"])
         {
            _loc1_._cache["LevelFile"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","LevelFile");
         }
         var _loc2_:* = _loc1_._cache["LevelFile"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public function get minLevel() : int
      {
         var _loc1_:Row = row;
         if(!_loc1_._cache["MinLevel"])
         {
            _loc1_._cache["MinLevel"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MinLevel");
         }
         var _loc2_:* = _loc1_._cache["MinLevel"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
   }
}
