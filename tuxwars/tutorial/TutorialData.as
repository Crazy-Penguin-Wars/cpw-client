package tuxwars.tutorial
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
   public class TutorialData
   {
      
      private static const TABLE:String = "Tutorial";
      
      private static const LEVEL:String = "Level";
      
      private static const MATCH_TIME:String = "MatchTime";
      
      private static const TURN_TIME:String = "TurnTime";
      
      private static const OPPONENT:String = "Opponent";
      
      private static var row:Row;
       
      
      public function TutorialData()
      {
         super();
         throw new Error("Tutorial is a static class!");
      }
      
      public static function getOpponent() : String
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["Opponent"])
         {
            _loc1_._cache["Opponent"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Opponent");
         }
         var _loc2_:* = _loc1_._cache["Opponent"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTutorialMatchData() : Object
      {
         return {
            "map":getLevel(),
            "num_players":2,
            "match_time":getMatchTime(),
            "turn_time":getTurnTime(),
            "opponent":getOpponent()
         };
      }
      
      public static function getLevel() : String
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["Level"])
         {
            _loc1_._cache["Level"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","Level");
         }
         var _loc2_:* = _loc1_._cache["Level"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getMatchTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["MatchTime"])
         {
            _loc1_._cache["MatchTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MatchTime");
         }
         var _loc2_:* = _loc1_._cache["MatchTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTurnTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TurnTime"])
         {
            _loc1_._cache["TurnTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TurnTime");
         }
         var _loc2_:* = _loc1_._cache["TurnTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      private static function getRow() : Row
      {
         if(!row)
         {
            var _loc1_:ProjectManager = ProjectManager;
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Tutorial");
            if(!_loc2_._cache["Default"])
            {
               var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id","Default");
               if(!_loc5_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + "Default" + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_._cache["Default"] = _loc5_;
            }
            row = _loc2_._cache["Default"];
         }
         return row;
      }
   }
}
