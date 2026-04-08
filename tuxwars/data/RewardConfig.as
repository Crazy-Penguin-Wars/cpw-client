package tuxwars.data
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   
   public class RewardConfig
   {
      private static var row:Row;
      
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
      
      private static const ICONtable:String = "BattleRewardIconDefault";
      
      private static const ROW_XP:String = "Exp";
      
      public static const ROW_COIN:String = "Coin";
      
      public static const ROW_CASH:String = "Cash";
      
      public static const ROW_ITEM:String = "Item";
      
      public static const ROW_COUPON:String = "Coupon";
      
      private static const SWF:String = "SWF";
      
      private static const EXPORT:String = "Export";
      
      public function RewardConfig()
      {
         super();
         throw new Error("BattleRewardConfig is a static class!");
      }
      
      public static function getDamageCollectionTime() : int
      {
         var _loc1_:String = "DamageCollectionTime";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getAppearTime() : int
      {
         var _loc1_:String = "AppearTime";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getWaitTime() : int
      {
         var _loc1_:String = "WaitTime";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getFlyTime() : int
      {
         var _loc1_:String = "FlyTime";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getDamageToGold() : Number
      {
         var _loc1_:String = "DamageToGold";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getDamageToExperience() : Number
      {
         var _loc1_:String = "DamageToExperience";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getPropGoldExpModifier() : Number
      {
         var _loc1_:String = "PropGoldExpModifier";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getPenguineKillBonusGoldExp() : int
      {
         var _loc1_:String = "PenguinKillBonusGoldExp";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getRecipeDropChance() : Number
      {
         var _loc1_:String = "RecipeDropChance";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getCouponDropChance() : Number
      {
         var _loc1_:String = "CouponDropChance";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getCraftingDefaultDropChance() : Number
      {
         var _loc1_:String = "CraftingDefaultDropChance";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getCraftingPropDropChance() : Number
      {
         var _loc1_:String = "CraftingPropDropChance";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getAmmunitionDefaultDropChance() : Number
      {
         var _loc1_:String = "AmmunitionDefaultDropChance";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getEquipmentDefaultDropChance() : Number
      {
         var _loc1_:String = "EquipmentDefaultDropChance";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getTargetWornItemDropRatioAdd() : Number
      {
         var _loc1_:String = "TargetWornItemDropRatioAdd";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getTargetWornItemDropRatioMultiply() : Number
      {
         var _loc1_:String = "TargetWornItemDropRatioMultiply";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getTaggedObjectThreshold() : int
      {
         var _loc1_:String = "TaggedObjectThreshold";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? int(_loc3_.overrideValue) : int(_loc3_._value);
      }
      
      public static function getPremiumDropChance() : Number
      {
         var _loc1_:String = "PremiumDropChance";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getPremiumDropChanceAddOnKill() : Number
      {
         var _loc1_:String = "PremiumDropChanceAddOnKill";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getPremiumDropChanceEarly() : Number
      {
         var _loc1_:String = "PremiumDropChanceEarly";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getPremiumDropChanceDecrease() : Number
      {
         var _loc1_:String = "PremiumDropChanceDecrease";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getPremiumCashAmount() : Number
      {
         var _loc1_:String = "PremiumCashAmount";
         var _loc2_:* = getRow();
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:* = _loc2_.getCache[_loc1_];
         return _loc3_.overrideValue != null ? Number(_loc3_.overrideValue) : Number(_loc3_._value);
      }
      
      public static function getRow() : Row
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:* = undefined;
         var _loc4_:Row = null;
         if(!row)
         {
            _loc1_ = "BattleRewardDropOption";
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
               LogUtils.log("Couldn\'t for default row for BattleRewardConfig.",3);
            }
         }
         return row;
      }
      
      public static function getExport(param1:String) : String
      {
         var _loc2_:Row = getIconRow(param1);
         if(!_loc2_)
         {
            return null;
         }
         if(!_loc2_.getCache[EXPORT])
         {
            _loc2_.getCache[EXPORT] = DCUtils.find(_loc2_.getFields(),"name",EXPORT);
         }
         var _loc3_:Field = _loc2_.getCache[EXPORT];
         return !!_loc3_ ? (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public static function getSWF(param1:String) : String
      {
         var _loc2_:Row = getIconRow(param1);
         if(!_loc2_)
         {
            return null;
         }
         if(!_loc2_.getCache[SWF])
         {
            _loc2_.getCache[SWF] = DCUtils.find(_loc2_.getFields(),"name",SWF);
         }
         var _loc3_:Field = _loc2_.getCache[SWF];
         return !!_loc3_ ? (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      private static function getIconRow(param1:String) : Row
      {
         var _loc6_:Row = null;
         var _loc2_:String = "BattleRewardIconDefault";
         var _loc3_:* = param1;
         var _loc4_:* = ProjectManager.findTable(_loc2_);
         if(!_loc4_.getCache[_loc3_])
         {
            _loc6_ = DCUtils.find(_loc4_.rows,"id",_loc3_);
            if(!_loc6_)
            {
               LogUtils.log("No row with name: \'" + _loc3_ + "\' was found in table: \'" + _loc4_.name + "\'",_loc4_,3);
            }
            _loc4_.getCache[_loc3_] = _loc6_;
         }
         var _loc5_:Row = _loc4_.getCache[_loc3_];
         if(!_loc5_)
         {
            LogUtils.log("Couldn\'t for " + param1 + " row for BattleRewardConfig.",3);
         }
         return _loc5_;
      }
   }
}

