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
         var _loc1_:String = "Weapons";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public static function getMatchDuration() : int
      {
         var _loc1_:String = "MatchDuration";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getTurnDuration() : int
      {
         var _loc1_:String = "TurnDuration";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getOpponentAmount() : int
      {
         var _loc1_:String = "OpponentAmount";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      private static function getRow() : Row
      {
         var _loc3_:Row = null;
         var _loc1_:String = "Default";
         var _loc2_:* = getTable();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc3_ = DCUtils.find(_loc2_.rows,"id",_loc1_);
            if(!_loc3_)
            {
               LogUtils.log("No row with name: \'" + _loc1_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
            }
            _loc2_.getCache[_loc1_] = _loc3_;
         }
         return _loc2_.getCache[_loc1_];
      }
      
      private static function getTable() : Table
      {
         var _loc1_:String = "Practice";
         return ProjectManager.findTable(_loc1_);
      }
   }
}

