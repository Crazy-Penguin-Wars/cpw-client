package tuxwars.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.utils.LogUtils;
   
   public class Tuner
   {
      
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
      
      private static var _fieldCache:Object;
      
      private static var row:Row;
       
      
      public function Tuner()
      {
         super();
         throw new Error("Tuner is a static class!");
      }
      
      public static function get minimumAmmoForMatch() : int
      {
         var _loc1_:Field = getField("MinimumAmmoForMatch");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : 0;
      }
      
      public static function get firstChallenges() : Array
      {
         var _loc1_:Field = getField("FirstChallenges");
         var _loc2_:*;
         return !!_loc1_ ? (_loc2_ = _loc1_, _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) : [];
      }
      
      public static function get damageMinScalingOther() : Number
      {
         var _loc1_:* = getField("DamageMinScalingOther");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get damageMinScalingPlayer() : Number
      {
         var _loc1_:* = getField("DamageMinScalingPlayer");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get impulseMinScalingOther() : Number
      {
         var _loc1_:* = getField("ImpulseMinScalingOther");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get impulseMinScalingPlayer() : Number
      {
         var _loc1_:* = getField("ImpulseMinScalingPlayer");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get killOpponentBonus() : int
      {
         var _loc1_:* = getField("KillOpponentBonus");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get researchDuration() : int
      {
         var _loc1_:* = getField("ResearchDuration");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get researchInstantCompleteCost() : int
      {
         var _loc1_:* = getField("ResearchInstantCompleteCost");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get minExplosionRadiusForEffects() : int
      {
         var _loc1_:* = getField("MinExplosionRadiusForEffects");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get attackStatMin() : int
      {
         var _loc1_:* = getField("AttackStatMin");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get defenceStatMin() : int
      {
         var _loc1_:* = getField("DefenceStatMin");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get luckStatMin() : int
      {
         var _loc1_:* = getField("LuckStatMin");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get damageSingleHitMax() : int
      {
         var _loc1_:* = getField("DamageSingleHitMax");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get suicidePenalty() : int
      {
         var _loc1_:* = getField("SuicidePenalty");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
      }
      
      public static function get slowConnectionTreshold() : int
      {
         var _loc1_:* = getField("SlowConnectionTreshold");
         return _loc1_.overrideValue != null ? _loc1_.overrideValue : _loc1_._value;
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
      
      private static function getField(name:String) : Field
      {
         if(!_fieldCache)
         {
            _fieldCache = {};
         }
         if(!_fieldCache.hasOwnProperty(name))
         {
            var _loc3_:* = name;
            var _loc2_:* = getRow();
            §§push(_fieldCache);
            §§push(name);
            if(!_loc2_._cache[_loc3_])
            {
               _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
            }
            §§pop()[§§pop()] = _loc2_._cache[_loc3_];
         }
         return _fieldCache[name];
      }
      
      public static function getRow() : Row
      {
         if(!row)
         {
            var _loc1_:ProjectManager = ProjectManager;
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("Tuner");
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
            if(!row)
            {
               LogUtils.log("Couldn\'t for default row for Tuner.",3);
            }
         }
         return row;
      }
   }
}
