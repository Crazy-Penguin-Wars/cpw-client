package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class Tuner
   {
      private static var _fieldCache:Object;
      
      private static var row:Row;
      
      private static const TABLE:String = "Tuner";
      
      private static const DEFAULT:String = "Default";
      
      private static const MINIMUM_AMMO_FOR_MATCH:String = "MinimumAmmoForMatch";
      
      private static const FIRST_CHALLENGES:String = "FirstChallenges";
      
      private static const KILL_OPPONENT_BONUS:String = "KillOpponentBonus";
      
      private static const SUICIDE_PENALTY:String = "SuicidePenalty";
      
      private static const RESEARCH_DURATION:String = "ResearchDuration";
      
      private static const RESEARCH_INSTANT_COMPLETE_COST:String = "ResearchInstantCompleteCost";
      
      private static const DAMAGE_MIN_SCALING_OTHER:String = "DamageMinScalingOther";
      
      private static const DAMAGE_MIN_SCALING_PLAYER:String = "DamageMinScalingPlayer";
      
      private static const IMPULSE_MIN_SCALING_OTHER:String = "ImpulseMinScalingOther";
      
      private static const IMPULSE_MIN_SCALING_PLAYER:String = "ImpulseMinScalingPlayer";
      
      private static const MIN_EXPLOSION_RADIUS_FOR_EFFECTS:String = "MinExplosionRadiusForEffects";
      
      private static const ATTACK_STAT_MIN:String = "AttackStatMin";
      
      private static const DEFENCE_STAT_MIN:String = "DefenceStatMin";
      
      private static const LUCK_STAT_MIN:String = "LuckStatMin";
      
      private static const DAMAGE_SINGLE_HIT_MAX:String = "DamageSingleHitMax";
      
      private static const CHAT_COLORS:String = "ChatColors";
      
      private static const CHAT_HTML_TAGS:String = "ChatHtmlTags";
      
      private static const SLOW_CONNECTION_TRESHOLD:String = "SlowConnectionTreshold";
      
      private static const NOT_TOOLTIP_TYPE:String = "NotTooltipType";
      
      public function Tuner()
      {
         super();
         throw new Error("Tuner is a static class!");
      }
      
      public static function get minimumAmmoForMatch() : int
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("MinimumAmmoForMatch");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? int(_loc2_.overrideValue) : int(_loc2_._value)) : 0;
      }
      
      public static function get firstChallenges() : Array
      {
         var _loc2_:* = undefined;
         var _loc1_:Field = getField("FirstChallenges");
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : [];
      }
      
      public static function get damageMinScalingOther() : Number
      {
         var _loc1_:* = getField("DamageMinScalingOther");
         return _loc1_.overrideValue != null ? Number(_loc1_.overrideValue) : Number(_loc1_._value);
      }
      
      public static function get damageMinScalingPlayer() : Number
      {
         var _loc1_:* = getField("DamageMinScalingPlayer");
         return _loc1_.overrideValue != null ? Number(_loc1_.overrideValue) : Number(_loc1_._value);
      }
      
      public static function get impulseMinScalingOther() : Number
      {
         var _loc1_:* = getField("ImpulseMinScalingOther");
         return _loc1_.overrideValue != null ? Number(_loc1_.overrideValue) : Number(_loc1_._value);
      }
      
      public static function get impulseMinScalingPlayer() : Number
      {
         var _loc1_:* = getField("ImpulseMinScalingPlayer");
         return _loc1_.overrideValue != null ? Number(_loc1_.overrideValue) : Number(_loc1_._value);
      }
      
      public static function get killOpponentBonus() : int
      {
         var _loc1_:* = getField("KillOpponentBonus");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get researchDuration() : int
      {
         var _loc1_:* = getField("ResearchDuration");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get researchInstantCompleteCost() : int
      {
         var _loc1_:* = getField("ResearchInstantCompleteCost");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get minExplosionRadiusForEffects() : int
      {
         var _loc1_:* = getField("MinExplosionRadiusForEffects");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get attackStatMin() : int
      {
         var _loc1_:* = getField("AttackStatMin");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get defenceStatMin() : int
      {
         var _loc1_:* = getField("DefenceStatMin");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get luckStatMin() : int
      {
         var _loc1_:* = getField("LuckStatMin");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get damageSingleHitMax() : int
      {
         var _loc1_:* = getField("DamageSingleHitMax");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get suicidePenalty() : int
      {
         var _loc1_:* = getField("SuicidePenalty");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get slowConnectionTreshold() : int
      {
         var _loc1_:* = getField("SlowConnectionTreshold");
         return _loc1_.overrideValue != null ? int(_loc1_.overrideValue) : int(_loc1_._value);
      }
      
      public static function get chatColors() : Array
      {
         var _loc1_:* = getField("ChatColors");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get chatHtmlTags() : Array
      {
         var _loc1_:* = getField("ChatHtmlTags");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get notTooltipType() : Array
      {
         var _loc1_:* = getField("NotTooltipType");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function getField(param1:String) : Field
      {
         var _loc2_:Row = null;
         if(!_fieldCache)
         {
            _fieldCache = {};
         }
         if(!_fieldCache.hasOwnProperty(param1))
         {
            _loc2_ = getRow();
            if(!_loc2_.getCache[param1])
            {
               _loc2_.getCache[param1] = DCUtils.find(_loc2_.getFields(),"name",param1);
            }
            _fieldCache[param1] = _loc2_.getCache[param1];
         }
         return _fieldCache[param1];
      }
      
      public static function getRow() : Row
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:Row = null;
         if(!row)
         {
            _loc1_ = "Tuner";
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
            if(!row)
            {
               LogUtils.log("Couldn\'t for default row for Tuner.",3);
            }
         }
         return row;
      }
   }
}

