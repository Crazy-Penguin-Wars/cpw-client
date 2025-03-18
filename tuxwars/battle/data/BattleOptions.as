package tuxwars.battle.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
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
         var _loc3_:String = "TimeAfterFiring";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getNumberOfPlayers() : int
      {
         var _loc3_:String = "NumberOfPlayers";
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
      
      public static function getMinMatchTime() : int
      {
         var _loc3_:String = "MinMatchTime";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getMaxMatchTime() : int
      {
         var _loc3_:String = "MaxMatchTime";
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
      
      public static function getMinTurnTime() : int
      {
         var _loc3_:String = "MinTurnTime";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getMaxTurnTime() : int
      {
         var _loc3_:String = "MaxTurnTime";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTurnTimeIncrement() : int
      {
         var _loc3_:String = "TurnTimeIncrement";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get rankMultiplier1() : Number
      {
         var _loc3_:String = "RankMultiplier1";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get rankMultiplier2() : Number
      {
         var _loc3_:String = "RankMultiplier2";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get rankMultiplier3() : Number
      {
         var _loc3_:String = "RankMultiplier3";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get rankMultiplier4() : Number
      {
         var _loc3_:String = "RankMultiplier4";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get bonusExpModifier() : int
      {
         var _loc3_:String = "BonusExpModifier";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get bonusCoinsModifier() : int
      {
         var _loc3_:String = "BonusCoinsModifier";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get disableWorldSync() : Boolean
      {
         var _loc3_:String = "DisableWorldSync";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get boosterCooldown() : int
      {
         var _loc3_:String = "BoosterCooldown";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get timeToRespawn() : int
      {
         var _loc3_:String = "TimeToRespawn";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get timeToResume() : int
      {
         var _loc3_:String = "TimeToResume";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get worldUpdateTime() : int
      {
         var _loc3_:String = "WorldUpdateTime";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get timeToStartRematch() : int
      {
         var _loc3_:String = "TimeToStartRematch";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get scoreDamager() : Number
      {
         var _loc3_:String = "ScoreDamager";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function get messageQueue() : Boolean
      {
         var _loc3_:String = "MessageQueue";
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
            var _loc3_:String = "BattleOptions";
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

