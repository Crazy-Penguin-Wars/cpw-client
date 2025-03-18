package tuxwars.tutorial
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
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
         var _loc3_:String = "Opponent";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
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
         var _loc3_:String = "Level";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getMatchTime() : int
      {
         var _loc3_:String = "MatchTime";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTurnTime() : int
      {
         var _loc3_:String = "TurnTime";
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
         if(!row)
         {
            var _loc3_:String = "Tutorial";
            var _loc1_:ProjectManager = ProjectManager;
            var _loc4_:String = "Default";
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc3_);
            if(!_loc2_._cache[_loc4_])
            {
               var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc2_.rows,"id",_loc4_);
               if(!_loc5_)
               {
                  com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc2_.name + "\'",_loc2_,3);
               }
               _loc2_._cache[_loc4_] = _loc5_;
            }
            row = _loc2_._cache[_loc4_];
         }
         return row;
      }
   }
}

