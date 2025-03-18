package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   
   public class RewardConfig
   {
      private static const TABLE:String = "BattleRewardDropOption";
      
      private static const DEFAULT:String = "Default";
      
      private static const APPEAR_TIME:String = "AppearTime";
      
      private static const WAIT_TIME:String = "WaitTime";
      
      private static const FLY_TIME:String = "FlyTime";
      
      private static const DAMAGE_COLLECTION_TIME:String = "DamageCollectionTime";
      
      private static const DAMAGE_TO_GOLD:String = "DamageToGold";
      
      private static const DAMAGE_TO_EXPERIENCE:String = "DamageToExperience";
      
      private static const PROP_GOLD_EXP_MODIFIER:String = "PropGoldExpModifier";
      
      private static const PENGUIN_KILL_BONUS_GOLD_EXP:String = "PenguinKillBonusGoldExp";
      
      private static const CRAFTING_DEFAULT_DROP_CHANCE:String = "CraftingDefaultDropChance";
      
      private static const CRAFTING_PROP_DROP_CHANCE:String = "CraftingPropDropChance";
      
      private static const AMMUNITION_DEFAULT_DROP_CHANCE:String = "AmmunitionDefaultDropChance";
      
      private static const EQUIPMENT_DEFAULT_DROP_CHANCE:String = "EquipmentDefaultDropChance";
      
      private static const TAGGED_OBJECT_DAMAGE_THRESHOLD:String = "TaggedObjectThreshold";
      
      private static const TARGET_WORN_ITEM_DROP_RATIO_ADD:String = "TargetWornItemDropRatioAdd";
      
      private static const TARGET_WORN_ITEM_DROP_RATIO_MULTIPLY:String = "TargetWornItemDropRatioMultiply";
      
      private static const RECIPE_DROP_CHANCE:String = "RecipeDropChance";
      
      private static const COUPON_DROP_CHANCE:String = "CouponDropChance";
      
      private static const PREMIUM_DROP_CHANCE:String = "PremiumDropChance";
      
      private static const PREMIUM_DROP_CHANCE_ADD_ON_KILL:String = "PremiumDropChanceAddOnKill";
      
      private static const PREMOIM_DROP_CHANCE_EARLY:String = "PremiumDropChanceEarly";
      
      private static const PREMOIM_DROP_CHANCE_DECREASE:String = "PremiumDropChanceDecrease";
      
      private static const PREMOIM_CAHS_AMOUNT:String = "PremiumCashAmount";
      
      private static const ICON_TABLE:String = "BattleRewardIconDefault";
      
      private static const ROW_XP:String = "Exp";
      
      public static const ROW_COIN:String = "Coin";
      
      public static const ROW_CASH:String = "Cash";
      
      public static const ROW_ITEM:String = "Item";
      
      public static const ROW_COUPON:String = "Coupon";
      
      private static const SWF:String = "SWF";
      
      private static const EXPORT:String = "Export";
      
      private static var row:Row;
      
      public function RewardConfig()
      {
         super();
         throw new Error("BattleRewardConfig is a static class!");
      }
      
      public static function getDamageCollectionTime() : int
      {
         var _loc3_:String = "DamageCollectionTime";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getAppearTime() : int
      {
         var _loc3_:String = "AppearTime";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getWaitTime() : int
      {
         var _loc3_:String = "WaitTime";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getFlyTime() : int
      {
         var _loc3_:String = "FlyTime";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getDamageToGold() : Number
      {
         var _loc3_:String = "DamageToGold";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getDamageToExperience() : Number
      {
         var _loc3_:String = "DamageToExperience";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPropGoldExpModifier() : Number
      {
         var _loc3_:String = "PropGoldExpModifier";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPenguineKillBonusGoldExp() : int
      {
         var _loc3_:String = "PenguinKillBonusGoldExp";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getRecipeDropChance() : Number
      {
         var _loc3_:String = "RecipeDropChance";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getCouponDropChance() : Number
      {
         var _loc3_:String = "CouponDropChance";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getCraftingDefaultDropChance() : Number
      {
         var _loc3_:String = "CraftingDefaultDropChance";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getCraftingPropDropChance() : Number
      {
         var _loc3_:String = "CraftingPropDropChance";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getAmmunitionDefaultDropChance() : Number
      {
         var _loc3_:String = "AmmunitionDefaultDropChance";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getEquipmentDefaultDropChance() : Number
      {
         var _loc3_:String = "EquipmentDefaultDropChance";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTargetWornItemDropRatioAdd() : Number
      {
         var _loc3_:String = "TargetWornItemDropRatioAdd";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTargetWornItemDropRatioMultiply() : Number
      {
         var _loc3_:String = "TargetWornItemDropRatioMultiply";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTaggedObjectThreshold() : int
      {
         var _loc3_:String = "TaggedObjectThreshold";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumDropChance() : Number
      {
         var _loc3_:String = "PremiumDropChance";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumDropChanceAddOnKill() : Number
      {
         var _loc3_:String = "PremiumDropChanceAddOnKill";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumDropChanceEarly() : Number
      {
         var _loc3_:String = "PremiumDropChanceEarly";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumDropChanceDecrease() : Number
      {
         var _loc3_:String = "PremiumDropChanceDecrease";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumCashAmount() : Number
      {
         var _loc3_:String = "PremiumCashAmount";
         var _loc1_:* = getRow();
         if(!_loc1_._cache[_loc3_])
         {
            _loc1_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name",_loc3_);
         }
         var _loc2_:* = _loc1_._cache[_loc3_];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getRow() : Row
      {
         if(!row)
         {
            var _loc3_:String = "BattleRewardDropOption";
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
            if(!row)
            {
               LogUtils.log("Couldn\'t for default row for BattleRewardConfig.",3);
            }
         }
         return row;
      }
      
      public static function getExport(rowName:String) : String
      {
         var _loc3_:Row = getIconRow(rowName);
         if(_loc3_ != null)
         {
            var _loc6_:String = "Export";
            var _loc4_:* = _loc3_;
            if(!_loc4_._cache[_loc6_])
            {
               _loc4_._cache[_loc6_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc6_);
            }
            §§push(_loc4_._cache[_loc6_]);
         }
         else
         {
            §§push(null);
         }
         var _loc2_:Field = §§pop();
         var _loc5_:*;
         return _loc2_ != null ? (_loc5_ = _loc2_, _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) : null;
      }
      
      public static function getSWF(rowName:String) : String
      {
         var _loc3_:Row = getIconRow(rowName);
         if(_loc3_ != null)
         {
            var _loc6_:String = "SWF";
            var _loc4_:* = _loc3_;
            if(!_loc4_._cache[_loc6_])
            {
               _loc4_._cache[_loc6_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc6_);
            }
            §§push(_loc4_._cache[_loc6_]);
         }
         else
         {
            §§push(null);
         }
         var _loc2_:Field = §§pop();
         var _loc5_:*;
         return _loc2_ != null ? (_loc5_ = _loc2_, _loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value) : null;
      }
      
      private static function getIconRow(value:String) : Row
      {
         var _loc5_:String = "BattleRewardIconDefault";
         var _loc3_:ProjectManager = ProjectManager;
         var _loc6_:* = value;
         var _loc4_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable(_loc5_);
         if(!_loc4_._cache[_loc6_])
         {
            var _loc7_:Row = com.dchoc.utils.DCUtils.find(_loc4_.rows,"id",_loc6_);
            if(!_loc7_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc6_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_._cache[_loc6_] = _loc7_;
         }
         var row:Row = _loc4_._cache[_loc6_];
         if(!row)
         {
            LogUtils.log("Couldn\'t for " + value + " row for BattleRewardConfig.",3);
         }
         return row;
      }
   }
}

