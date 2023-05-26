package tuxwars.battle.data
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   
   public class BattleOptions
   {
      
      private static const TABLE_NAME:String = "BattleOptions";
      
      private static const TIME_AFTER_FIRING:String = "TimeAfterFiring";
      
      private static const NUMBER_OF_PLAYERS:String = "NumberOfPlayers";
      
      private static const MATCH_TIME:String = "MatchTime";
      
      private static const MIN_MATCH_TIME:String = "MinMatchTime";
      
      private static const MAX_MATCH_TIME:String = "MaxMatchTime";
      
      private static const TURN_TIME:String = "TurnTime";
      
      private static const MIN_TURN_TIME:String = "MinTurnTime";
      
      private static const MAX_TURN_TIME:String = "MaxTurnTime";
      
      private static const TURN_TIME_INCREMENT:String = "TurnTimeIncrement";
      
      private static const RANK_MULTIPLER_1:String = "RankMultiplier1";
      
      private static const RANK_MULTIPLER_2:String = "RankMultiplier2";
      
      private static const RANK_MULTIPLER_3:String = "RankMultiplier3";
      
      private static const RANK_MULTIPLER_4:String = "RankMultiplier4";
      
      private static const BONUS_EXP_MODIFIER:String = "BonusExpModifier";
      
      private static const BONUS_COINS_MODIFIER:String = "BonusCoinsModifier";
      
      private static const DISABLE_WORLD_SYNC:String = "DisableWorldSync";
      
      private static const BOOSTER_COOLDOWN:String = "BoosterCooldown";
      
      private static const TIME_TO_RESPAWN:String = "TimeToRespawn";
      
      private static const TIME_TO_RESUME:String = "TimeToResume";
      
      private static const WORLD_UPDATE_TIME:String = "WorldUpdateTime";
      
      private static const TIME_TO_START_REMATCH:String = "TimeToStartRematch";
      
      private static const SCORE_DAMAGER:String = "ScoreDamager";
      
      private static const MESSAGE_QUEUE:String = "MessageQueue";
      
      private static var row:Row;
       
      
      public function BattleOptions()
      {
         super();
         throw new Error("BattleOptions is a static class!");
      }
      
      public static function getTimeAfterFiring() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TimeAfterFiring"])
         {
            _loc1_._cache["TimeAfterFiring"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TimeAfterFiring");
         }
         var _loc2_:* = _loc1_._cache["TimeAfterFiring"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getNumberOfPlayers() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["NumberOfPlayers"])
         {
            _loc1_._cache["NumberOfPlayers"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","NumberOfPlayers");
         }
         var _loc2_:* = _loc1_._cache["NumberOfPlayers"];
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
      
      public static function getMinMatchTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["MinMatchTime"])
         {
            _loc1_._cache["MinMatchTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MinMatchTime");
         }
         var _loc2_:* = _loc1_._cache["MinMatchTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getMaxMatchTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["MaxMatchTime"])
         {
            _loc1_._cache["MaxMatchTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MaxMatchTime");
         }
         var _loc2_:* = _loc1_._cache["MaxMatchTime"];
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
      
      public static function getMinTurnTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["MinTurnTime"])
         {
            _loc1_._cache["MinTurnTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MinTurnTime");
         }
         var _loc2_:* = _loc1_._cache["MinTurnTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getMaxTurnTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["MaxTurnTime"])
         {
            _loc1_._cache["MaxTurnTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MaxTurnTime");
         }
         var _loc2_:* = _loc1_._cache["MaxTurnTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTurnTimeIncrement() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TurnTimeIncrement"])
         {
            _loc1_._cache["TurnTimeIncrement"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TurnTimeIncrement");
         }
         var _loc2_:* = _loc1_._cache["TurnTimeIncrement"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get rankMultiplier1() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["RankMultiplier1"])
         {
            _loc1_._cache["RankMultiplier1"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","RankMultiplier1");
         }
         var _loc2_:* = _loc1_._cache["RankMultiplier1"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get rankMultiplier2() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["RankMultiplier2"])
         {
            _loc1_._cache["RankMultiplier2"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","RankMultiplier2");
         }
         var _loc2_:* = _loc1_._cache["RankMultiplier2"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get rankMultiplier3() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["RankMultiplier3"])
         {
            _loc1_._cache["RankMultiplier3"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","RankMultiplier3");
         }
         var _loc2_:* = _loc1_._cache["RankMultiplier3"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get rankMultiplier4() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["RankMultiplier4"])
         {
            _loc1_._cache["RankMultiplier4"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","RankMultiplier4");
         }
         var _loc2_:* = _loc1_._cache["RankMultiplier4"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get bonusExpModifier() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["BonusExpModifier"])
         {
            _loc1_._cache["BonusExpModifier"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","BonusExpModifier");
         }
         var _loc2_:* = _loc1_._cache["BonusExpModifier"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get bonusCoinsModifier() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["BonusCoinsModifier"])
         {
            _loc1_._cache["BonusCoinsModifier"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","BonusCoinsModifier");
         }
         var _loc2_:* = _loc1_._cache["BonusCoinsModifier"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get disableWorldSync() : Boolean
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["DisableWorldSync"])
         {
            _loc1_._cache["DisableWorldSync"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","DisableWorldSync");
         }
         var _loc2_:* = _loc1_._cache["DisableWorldSync"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get boosterCooldown() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["BoosterCooldown"])
         {
            _loc1_._cache["BoosterCooldown"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","BoosterCooldown");
         }
         var _loc2_:* = _loc1_._cache["BoosterCooldown"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get timeToRespawn() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TimeToRespawn"])
         {
            _loc1_._cache["TimeToRespawn"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TimeToRespawn");
         }
         var _loc2_:* = _loc1_._cache["TimeToRespawn"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get timeToResume() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TimeToResume"])
         {
            _loc1_._cache["TimeToResume"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TimeToResume");
         }
         var _loc2_:* = _loc1_._cache["TimeToResume"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get worldUpdateTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["WorldUpdateTime"])
         {
            _loc1_._cache["WorldUpdateTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","WorldUpdateTime");
         }
         var _loc2_:* = _loc1_._cache["WorldUpdateTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get timeToStartRematch() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TimeToStartRematch"])
         {
            _loc1_._cache["TimeToStartRematch"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TimeToStartRematch");
         }
         var _loc2_:* = _loc1_._cache["TimeToStartRematch"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get scoreDamager() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["ScoreDamager"])
         {
            _loc1_._cache["ScoreDamager"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","ScoreDamager");
         }
         var _loc2_:* = _loc1_._cache["ScoreDamager"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get messageQueue() : Boolean
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["MessageQueue"])
         {
            _loc1_._cache["MessageQueue"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","MessageQueue");
         }
         var _loc2_:* = _loc1_._cache["MessageQueue"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      private static function getRow() : Row
      {
         if(!row)
         {
            var _loc1_:ProjectManager = ProjectManager;
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("BattleOptions");
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
