package tuxwars.items.managers
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import tuxwars.items.*;
   import tuxwars.items.data.*;
   import tuxwars.items.definitions.*;
   
   public class ItemManager
   {
      private static var table:Table;
      
      private static const TABLE:String = "Item";
      
      private static const TYPE:String = "Type";
      
      private static const ITEM_CLASSES:Object = {};
      
      private static const ITEM_DEFS:Object = {};
      
      private static const ITEM_DATA:Object = {};
      
      private static const SORT_ORDER_ITEM_TYPE:Array = ["Status","Emoticon","Customization","Crafting","Recipe","Booster","Clothing","Weapon","Trophy"];
      
      private static const UNLOCKED_ITEMS:Vector.<String> = new Vector.<String>();
      
      ITEM_CLASSES["Trophy"] = TrophyItem;
      ITEM_CLASSES["Crafting"] = CraftingItem;
      ITEM_CLASSES["Weapon"] = WeaponItem;
      ITEM_CLASSES["Booster"] = BoosterItem;
      ITEM_CLASSES["Clothing"] = ClothingItem;
      ITEM_CLASSES["Emoticon"] = EmoticonItem;
      ITEM_CLASSES["Recipe"] = RecipeItem;
      ITEM_CLASSES["Customization"] = CustomizationItem;
      ITEM_CLASSES["MegaPack"] = MegaPackItem;
      ITEM_CLASSES["Coupon"] = CouponItem;
      ITEM_DEFS["Trophy"] = TrophyDef;
      ITEM_DEFS["Crafting"] = CraftingDef;
      ITEM_DEFS["Weapon"] = WeaponDef;
      ITEM_DEFS["Booster"] = BoosterDef;
      ITEM_DEFS["Clothing"] = ClothingDef;
      ITEM_DEFS["Emoticon"] = EmoticonDef;
      ITEM_DEFS["Recipe"] = RecipeDef;
      ITEM_DEFS["Customization"] = CustomizationDef;
      ITEM_DEFS["MegaPack"] = MegaPackDef;
      ITEM_DEFS["Coupon"] = CouponDef;
      ITEM_DATA["Trophy"] = TrophyData;
      ITEM_DATA["Crafting"] = CraftingData;
      ITEM_DATA["Weapon"] = WeaponData;
      ITEM_DATA["Booster"] = BoosterData;
      ITEM_DATA["Clothing"] = ClothingData;
      ITEM_DATA["Emoticon"] = EmoticonData;
      ITEM_DATA["Recipe"] = RecipeData;
      ITEM_DATA["Customization"] = CustomizationData;
      ITEM_DATA["MegaPack"] = MegaPackData;
      ITEM_DATA["Coupon"] = CouponData;
      
      public function ItemManager()
      {
         super();
         throw new Error("ItemManager is a static class!");
      }
      
      public static function createItem(param1:String) : Item
      {
         var _loc2_:Row = findRow(param1);
         var _loc3_:String = getType(_loc2_);
         var _loc4_:ItemData = createData(_loc2_,_loc3_);
         var _loc5_:ItemDef = createDef(_loc3_);
         _loc5_.loadDataConf(_loc4_);
         var _loc6_:Item = createItemClass(_loc3_);
         _loc6_.load(_loc5_);
         return _loc6_;
      }
      
      public static function findItemDatas(param1:String) : Vector.<ItemData>
      {
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc2_:Field = null;
         var _loc3_:Vector.<ItemData> = new Vector.<ItemData>();
         var _loc4_:* = getTable();
         for each(_loc5_ in _loc4_._rows)
         {
            _loc6_ = "Type";
            _loc7_ = _loc5_;
            if(!_loc7_.getCache[_loc6_])
            {
               _loc7_.getCache[_loc6_] = DCUtils.find(_loc7_.getFields(),"name",_loc6_);
            }
            _loc2_ = _loc7_.getCache[_loc6_];
            if(Boolean(_loc2_) && (_loc2_.overrideValue != null ? _loc2_.overrideValue : _loc2_._value) == param1)
            {
               _loc3_.push(getItemData(_loc5_.id));
            }
         }
         return _loc3_;
      }
      
      public static function findAllItems() : Vector.<ItemData>
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:* = undefined;
         var _loc1_:Field = null;
         var _loc2_:Vector.<ItemData> = new Vector.<ItemData>();
         var _loc3_:* = getTable();
         for each(_loc4_ in _loc3_._rows)
         {
            _loc5_ = "Type";
            _loc6_ = _loc4_;
            if(!_loc6_.getCache[_loc5_])
            {
               _loc6_.getCache[_loc5_] = DCUtils.find(_loc6_.getFields(),"name",_loc5_);
            }
            _loc1_ = _loc6_.getCache[_loc5_];
            if(_loc1_)
            {
               _loc2_.push(getItemData(_loc4_.id));
            }
         }
         return _loc2_;
      }
      
      public static function getItemData(param1:String) : ItemData
      {
         var _loc2_:Row = findRow(param1);
         if(_loc2_)
         {
            return createData(_loc2_,getType(_loc2_));
         }
         LogUtils.log("ItemID: " + param1 + " does not exist in configurations","ItemManager",2,"ItemData",false,false,false);
         return null;
      }
      
      public static function getItemsUnlockedAtLevel(param1:int) : Vector.<ItemData>
      {
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:* = undefined;
         var _loc2_:Field = null;
         var _loc3_:Vector.<ItemData> = new Vector.<ItemData>();
         var _loc4_:* = getTable();
         for each(_loc5_ in _loc4_._rows)
         {
            _loc6_ = "RequiredLevel";
            _loc7_ = _loc5_;
            if(!_loc7_.getCache[_loc6_])
            {
               _loc7_.getCache[_loc6_] = DCUtils.find(_loc7_.getFields(),"name",_loc6_);
            }
            _loc2_ = _loc7_.getCache[_loc6_];
            if(_loc2_ && (_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) == param1 && !isUnlocked(_loc5_.id))
            {
               _loc3_.push(getItemData(_loc5_.id));
            }
         }
         _loc3_.sort(sortByItemTypeAndPriority);
         return _loc3_;
      }
      
      public static function unlockItem(param1:ShopItem) : void
      {
         unlockItemWithId(param1.id);
      }
      
      public static function unlockItemWithId(param1:String) : void
      {
         if(UNLOCKED_ITEMS.indexOf(param1) == -1)
         {
            UNLOCKED_ITEMS.push(param1);
         }
      }
      
      public static function isUnlocked(param1:String) : Boolean
      {
         return UNLOCKED_ITEMS.indexOf(param1) != -1;
      }
      
      public static function getTable() : Table
      {
         var _loc1_:String = null;
         if(!table)
         {
            _loc1_ = "Item";
            table = ProjectManager.findTable(_loc1_);
         }
         return table;
      }
      
      private static function findRow(param1:String) : Row
      {
         var _loc5_:Row = null;
         var _loc2_:* = param1;
         var _loc3_:* = getTable();
         if(!_loc3_.getCache[_loc2_])
         {
            _loc5_ = DCUtils.find(_loc3_.rows,"id",_loc2_);
            if(!_loc5_)
            {
               LogUtils.log("No row with name: \'" + _loc2_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_.getCache[_loc2_] = _loc5_;
         }
         var _loc4_:Row = _loc3_.getCache[_loc2_];
         if(!_loc4_)
         {
            LogUtils.log("No row for id: " + param1,"ItemManager",3);
         }
         return _loc4_;
      }
      
      private static function createItemClass(param1:String) : Item
      {
         return new ITEM_CLASSES[param1]();
      }
      
      private static function createDef(param1:String) : ItemDef
      {
         return new ITEM_DEFS[param1]();
      }
      
      private static function createData(param1:Row, param2:String) : ItemData
      {
         return new ITEM_DATA[param2](param1);
      }
      
      private static function getType(param1:Row) : String
      {
         var _loc2_:String = "Type";
         var _loc3_:* = param1;
         if(!_loc3_.getCache[_loc2_])
         {
            _loc3_.getCache[_loc2_] = DCUtils.find(_loc3_.getFields(),"name",_loc2_);
         }
         var _loc4_:* = _loc3_.getCache[_loc2_];
         return _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value;
      }
      
      public static function sortByItemTypeAndPriority(param1:ItemData, param2:ItemData) : int
      {
         var _loc3_:int = int(SORT_ORDER_ITEM_TYPE.indexOf(param1.type));
         var _loc4_:int = int(SORT_ORDER_ITEM_TYPE.indexOf(param2.type));
         if(_loc3_ == _loc4_)
         {
            _loc3_ = param1.sortPriority;
            _loc4_ = param2.sortPriority;
         }
         return _loc4_ - _loc3_;
      }
   }
}

