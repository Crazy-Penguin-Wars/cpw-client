package tuxwars.tutorial
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class TutorialData
   {
      private static var row:Row;
      
      private static const TABLE:String = "Tutorial";
      
      private static const LEVEL:String = "Level";
      
      private static const MATCH_TIME:String = "MatchTime";
      
      private static const TURN_TIME:String = "TurnTime";
      
      private static const OPPONENT:String = "Opponent";
      
      public function TutorialData()
      {
         super();
         throw new Error("Tutorial is a static class!");
      }
      
      public static function getOpponent() : String
      {
         var _loc1_:String = "Opponent";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
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
         var _loc1_:String = "Level";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public static function getMatchTime() : int
      {
         var _loc1_:String = "MatchTime";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getTurnTime() : int
      {
         var _loc1_:String = "TurnTime";
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
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:Row = null;
         if(!row)
         {
            _loc1_ = "Tutorial";
            _loc2_ = "Default";
            _loc3_ = ProjectManager.findTable(_loc1_);
            if(!_loc3_.getCache[_loc2_])
            {
               _loc4_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
               if(!_loc4_)
               {
                  LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
               }
               _loc3_.getCache[_loc2_] = _loc4_;
            }
            row = _loc3_.getCache[_loc2_];
         }
         return row;
      }
   }
}

