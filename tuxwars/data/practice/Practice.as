package tuxwars.data.practice
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class Practice
   {
      private static const TABLE:String = "Practice";
      
      private static const DEFAULT_ROW:String = "Default";
      
      private static const WEAPONS:String = "Weapons";
      
      private static const MATCH_DURATION:String = "MatchDuration";
      
      private static const TURN_DURATION:String = "TurnDuration";
      
      private static const OPPONENT_AMOUNT:String = "OpponentAmount";
      
      public function Practice()
      {
         super();
      }
      
      public static function getPracticeMatchData() : Object
      {
         return {
            "map":PracticeLevels.getRandomLevel(),
            "num_players":getOpponentAmount() + 1,
            "match_time":getMatchDuration(),
            "turn_time":getTurnDuration()
         };
      }
      
      public static function getWeapons() : Array
      {
         var _loc3_:String = "Weapons";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getMatchDuration() : int
      {
         var _loc3_:String = "MatchDuration";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTurnDuration() : int
      {
         var _loc3_:String = "TurnDuration";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getOpponentAmount() : int
      {
         var _loc3_:String = "OpponentAmount";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      private static function getRow() : Row
      {
         var _loc2_:String = "Default";
         var _loc1_:* = getTable();
         if(!_loc1_._cache[_loc2_])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id",_loc2_);
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache[_loc2_] = _loc3_;
         }
         return _loc1_._cache[_loc2_];
      }
      
      private static function getTable() : Table
      {
         var _loc2_:String = "Practice";
         var _loc1_:ProjectManager = ProjectManager;
         return com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc2_);
      }
   }
}

