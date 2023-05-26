package tuxwars.data.practice
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   
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
         var _loc1_:* = getRow();
         if(!_loc1_._cache["Weapons"])
         {
            _loc1_._cache["Weapons"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Weapons");
         }
         var _loc2_:* = _loc1_._cache["Weapons"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getMatchDuration() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["MatchDuration"])
         {
            _loc1_._cache["MatchDuration"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MatchDuration");
         }
         var _loc2_:* = _loc1_._cache["MatchDuration"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTurnDuration() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TurnDuration"])
         {
            _loc1_._cache["TurnDuration"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TurnDuration");
         }
         var _loc2_:* = _loc1_._cache["TurnDuration"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getOpponentAmount() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["OpponentAmount"])
         {
            _loc1_._cache["OpponentAmount"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","OpponentAmount");
         }
         var _loc2_:* = _loc1_._cache["OpponentAmount"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      private static function getRow() : Row
      {
         var _loc1_:* = getTable();
         if(!_loc1_._cache["Default"])
         {
            var _loc3_:Row = com.dchoc.utils.DCUtils.find(_loc1_.rows,"id","Default");
            if(!_loc3_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc1_.name + "\'",_loc1_,3);
            }
            _loc1_._cache["Default"] = _loc3_;
         }
         return _loc1_._cache["Default"];
      }
      
      private static function getTable() : Table
      {
         var _loc1_:ProjectManager = ProjectManager;
         return com.dchoc.projectdata.ProjectManager.projectData.findTable("Practice");
      }
   }
}
