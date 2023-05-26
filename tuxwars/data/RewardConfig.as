package tuxwars.data
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
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
         var _loc1_:* = getRow();
         if(!_loc1_._cache["DamageCollectionTime"])
         {
            _loc1_._cache["DamageCollectionTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","DamageCollectionTime");
         }
         var _loc2_:* = _loc1_._cache["DamageCollectionTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getAppearTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["AppearTime"])
         {
            _loc1_._cache["AppearTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","AppearTime");
         }
         var _loc2_:* = _loc1_._cache["AppearTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getWaitTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["WaitTime"])
         {
            _loc1_._cache["WaitTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","WaitTime");
         }
         var _loc2_:* = _loc1_._cache["WaitTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getFlyTime() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["FlyTime"])
         {
            _loc1_._cache["FlyTime"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","FlyTime");
         }
         var _loc2_:* = _loc1_._cache["FlyTime"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getDamageToGold() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["DamageToGold"])
         {
            _loc1_._cache["DamageToGold"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","DamageToGold");
         }
         var _loc2_:* = _loc1_._cache["DamageToGold"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getDamageToExperience() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["DamageToExperience"])
         {
            _loc1_._cache["DamageToExperience"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","DamageToExperience");
         }
         var _loc2_:* = _loc1_._cache["DamageToExperience"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPropGoldExpModifier() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["PropGoldExpModifier"])
         {
            _loc1_._cache["PropGoldExpModifier"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","PropGoldExpModifier");
         }
         var _loc2_:* = _loc1_._cache["PropGoldExpModifier"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPenguineKillBonusGoldExp() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["PenguinKillBonusGoldExp"])
         {
            _loc1_._cache["PenguinKillBonusGoldExp"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","PenguinKillBonusGoldExp");
         }
         var _loc2_:* = _loc1_._cache["PenguinKillBonusGoldExp"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getRecipeDropChance() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["RecipeDropChance"])
         {
            _loc1_._cache["RecipeDropChance"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","RecipeDropChance");
         }
         var _loc2_:* = _loc1_._cache["RecipeDropChance"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getCouponDropChance() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["CouponDropChance"])
         {
            _loc1_._cache["CouponDropChance"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","CouponDropChance");
         }
         var _loc2_:* = _loc1_._cache["CouponDropChance"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getCraftingDefaultDropChance() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["CraftingDefaultDropChance"])
         {
            _loc1_._cache["CraftingDefaultDropChance"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","CraftingDefaultDropChance");
         }
         var _loc2_:* = _loc1_._cache["CraftingDefaultDropChance"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getCraftingPropDropChance() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["CraftingPropDropChance"])
         {
            _loc1_._cache["CraftingPropDropChance"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","CraftingPropDropChance");
         }
         var _loc2_:* = _loc1_._cache["CraftingPropDropChance"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getAmmunitionDefaultDropChance() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["AmmunitionDefaultDropChance"])
         {
            _loc1_._cache["AmmunitionDefaultDropChance"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","AmmunitionDefaultDropChance");
         }
         var _loc2_:* = _loc1_._cache["AmmunitionDefaultDropChance"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getEquipmentDefaultDropChance() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["EquipmentDefaultDropChance"])
         {
            _loc1_._cache["EquipmentDefaultDropChance"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","EquipmentDefaultDropChance");
         }
         var _loc2_:* = _loc1_._cache["EquipmentDefaultDropChance"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTargetWornItemDropRatioAdd() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TargetWornItemDropRatioAdd"])
         {
            _loc1_._cache["TargetWornItemDropRatioAdd"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TargetWornItemDropRatioAdd");
         }
         var _loc2_:* = _loc1_._cache["TargetWornItemDropRatioAdd"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTargetWornItemDropRatioMultiply() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TargetWornItemDropRatioMultiply"])
         {
            _loc1_._cache["TargetWornItemDropRatioMultiply"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TargetWornItemDropRatioMultiply");
         }
         var _loc2_:* = _loc1_._cache["TargetWornItemDropRatioMultiply"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getTaggedObjectThreshold() : int
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["TaggedObjectThreshold"])
         {
            _loc1_._cache["TaggedObjectThreshold"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","TaggedObjectThreshold");
         }
         var _loc2_:* = _loc1_._cache["TaggedObjectThreshold"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumDropChance() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["PremiumDropChance"])
         {
            _loc1_._cache["PremiumDropChance"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","PremiumDropChance");
         }
         var _loc2_:* = _loc1_._cache["PremiumDropChance"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumDropChanceAddOnKill() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["PremiumDropChanceAddOnKill"])
         {
            _loc1_._cache["PremiumDropChanceAddOnKill"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","PremiumDropChanceAddOnKill");
         }
         var _loc2_:* = _loc1_._cache["PremiumDropChanceAddOnKill"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumDropChanceEarly() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["PremiumDropChanceEarly"])
         {
            _loc1_._cache["PremiumDropChanceEarly"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","PremiumDropChanceEarly");
         }
         var _loc2_:* = _loc1_._cache["PremiumDropChanceEarly"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumDropChanceDecrease() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["PremiumDropChanceDecrease"])
         {
            _loc1_._cache["PremiumDropChanceDecrease"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","PremiumDropChanceDecrease");
         }
         var _loc2_:* = _loc1_._cache["PremiumDropChanceDecrease"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getPremiumCashAmount() : Number
      {
         var _loc1_:* = getRow();
         if(!_loc1_._cache["PremiumCashAmount"])
         {
            _loc1_._cache["PremiumCashAmount"] = com.dchoc.utils.DCUtils.find(_loc1_._fields,"name","PremiumCashAmount");
         }
         var _loc2_:* = _loc1_._cache["PremiumCashAmount"];
         return _loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value;
      }
      
      public static function getRow() : Row
      {
         if(!row)
         {
            var _loc1_:ProjectManager = ProjectManager;
            var _loc2_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("BattleRewardDropOption");
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
            var _loc4_:* = _loc3_;
            if(!_loc4_._cache["Export"])
            {
               _loc4_._cache["Export"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","Export");
            }
            §§push(_loc4_._cache["Export"]);
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
            var _loc4_:* = _loc3_;
            if(!_loc4_._cache["SWF"])
            {
               _loc4_._cache["SWF"] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name","SWF");
            }
            §§push(_loc4_._cache["SWF"]);
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
         var _loc3_:ProjectManager = ProjectManager;
         var _loc6_:* = value;
         var _loc4_:* = com.dchoc.projectdata.ProjectManager.projectData.findTable("BattleRewardIconDefault");
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
