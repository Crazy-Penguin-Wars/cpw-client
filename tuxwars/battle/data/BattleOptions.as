package tuxwars.battle.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class BattleOptions
   {
      private static var row:Row;
      
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
      
      public function BattleOptions()
      {
         super();
         throw new Error("BattleOptions is a static class!");
      }
      
      public static function getTimeAfterFiring() : int
      {
         var _loc1_:String = "TimeAfterFiring";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getNumberOfPlayers() : int
      {
         var _loc1_:String = "NumberOfPlayers";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
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
      
      public static function getMinMatchTime() : int
      {
         var _loc1_:String = "MinMatchTime";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getMaxMatchTime() : int
      {
         var _loc1_:String = "MaxMatchTime";
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
      
      public static function getMinTurnTime() : int
      {
         var _loc1_:String = "MinTurnTime";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getMaxTurnTime() : int
      {
         var _loc1_:String = "MaxTurnTime";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getTurnTimeIncrement() : int
      {
         var _loc1_:String = "TurnTimeIncrement";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get rankMultiplier1() : Number
      {
         var _loc1_:String = "RankMultiplier1";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function get rankMultiplier2() : Number
      {
         var _loc1_:String = "RankMultiplier2";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function get rankMultiplier3() : Number
      {
         var _loc1_:String = "RankMultiplier3";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function get rankMultiplier4() : Number
      {
         var _loc1_:String = "RankMultiplier4";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function get bonusExpModifier() : int
      {
         var _loc1_:String = "BonusExpModifier";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get bonusCoinsModifier() : int
      {
         var _loc1_:String = "BonusCoinsModifier";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get disableWorldSync() : Boolean
      {
         var _loc1_:String = "DisableWorldSync";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Boolean(_loc3_.overrideValue) : Boolean(_loc3_._value);
      }
      
      public static function get boosterCooldown() : int
      {
         var _loc1_:String = "BoosterCooldown";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get timeToRespawn() : int
      {
         var _loc1_:String = "TimeToRespawn";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get timeToResume() : int
      {
         var _loc1_:String = "TimeToResume";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get worldUpdateTime() : int
      {
         var _loc1_:String = "WorldUpdateTime";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get timeToStartRematch() : int
      {
         var _loc1_:String = "TimeToStartRematch";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function get scoreDamager() : Number
      {
         var _loc1_:String = "ScoreDamager";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function get messageQueue() : Boolean
      {
         var _loc1_:String = "MessageQueue";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Boolean(_loc3_.overrideValue) : Boolean(_loc3_._value);
      }
      
      public static function getRow() : Row
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:Row = null;
         if(!row)
         {
            _loc1_ = "BattleOptions";
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

