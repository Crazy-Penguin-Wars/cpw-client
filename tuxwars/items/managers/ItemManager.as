package tuxwars.items.managers
{
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.projectdata.Table;
   import com.dchoc.utils.LogUtils;
   import tuxwars.items.BoosterItem;
   import tuxwars.items.ClothingItem;
   import tuxwars.items.CouponItem;
   import tuxwars.items.CraftingItem;
   import tuxwars.items.CustomizationItem;
   import tuxwars.items.EmoticonItem;
   import tuxwars.items.Item;
   import tuxwars.items.MegaPackItem;
   import tuxwars.items.RecipeItem;
   import tuxwars.items.ShopItem;
   import tuxwars.items.TrophyItem;
   import tuxwars.items.WeaponItem;
   import tuxwars.items.data.BoosterData;
   import tuxwars.items.data.ClothingData;
   import tuxwars.items.data.CouponData;
   import tuxwars.items.data.CraftingData;
   import tuxwars.items.data.CustomizationData;
   import tuxwars.items.data.EmoticonData;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.MegaPackData;
   import tuxwars.items.data.RecipeData;
   import tuxwars.items.data.TrophyData;
   import tuxwars.items.data.WeaponData;
   import tuxwars.items.definitions.BoosterDef;
   import tuxwars.items.definitions.ClothingDef;
   import tuxwars.items.definitions.CouponDef;
   import tuxwars.items.definitions.CraftingDef;
   import tuxwars.items.definitions.CustomizationDef;
   import tuxwars.items.definitions.EmoticonDef;
   import tuxwars.items.definitions.ItemDef;
   import tuxwars.items.definitions.MegaPackDef;
   import tuxwars.items.definitions.RecipeDef;
   import tuxwars.items.definitions.TrophyDef;
   import tuxwars.items.definitions.WeaponDef;
   
   public class ItemManager
   {
      
      private static const TABLE:String = "Item";
      
      private static const TYPE:String = "Type";
      
      private static const ITEM_CLASSES:Object = {};
      
      private static const ITEM_DEFS:Object = {};
      
      private static const ITEM_DATA:Object = {};
      
      private static const SORT_ORDER_ITEM_TYPE:Array = ["Status","Emoticon","Customization","Crafting","Recipe","Booster","Clothing","Weapon","Trophy"];
      
      private static const UNLOCKED_ITEMS:Vector.<String> = new Vector.<String>();
      
      private static var table:Table;
      
      {
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
      }
      
      public function ItemManager()
      {
         super();
         throw new Error("ItemManager is a static class!");
      }
      
      public static function createItem(id:String) : Item
      {
         var _loc6_:Row = findRow(id);
         var _loc5_:String = getType(_loc6_);
         var _loc4_:ItemData = createData(_loc6_,_loc5_);
         var _loc2_:ItemDef = createDef(_loc5_);
         _loc2_.loadDataConf(_loc4_);
         var _loc3_:Item = createItemClass(_loc5_);
         _loc3_.load(_loc2_);
         return _loc3_;
      }
      
      public static function findItemDatas(type:String) : Vector.<ItemData>
      {
         var _loc2_:* = null;
         var _loc3_:Vector.<ItemData> = new Vector.<ItemData>();
         var _loc5_:* = getTable();
         for each(var row in _loc5_._rows)
         {
            var _loc6_:* = row;
            if(!_loc6_._cache["Type"])
            {
               _loc6_._cache["Type"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","Type");
            }
            _loc2_ = _loc6_._cache["Type"];
            if(_loc2_ && (_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) == type)
            {
               _loc3_.push(getItemData(row.id));
            }
         }
         return _loc3_;
      }
      
      public static function findAllItems() : Vector.<ItemData>
      {
         var _loc1_:* = null;
         var _loc2_:Vector.<ItemData> = new Vector.<ItemData>();
         var _loc4_:* = getTable();
         for each(var row in _loc4_._rows)
         {
            var _loc5_:* = row;
            if(!_loc5_._cache["Type"])
            {
               _loc5_._cache["Type"] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name","Type");
            }
            _loc1_ = _loc5_._cache["Type"];
            if(_loc1_)
            {
               _loc2_.push(getItemData(row.id));
            }
         }
         return _loc2_;
      }
      
      public static function getItemData(id:String) : ItemData
      {
         var _loc2_:Row = findRow(id);
         if(_loc2_)
         {
            return createData(_loc2_,getType(_loc2_));
         }
         LogUtils.log("ItemID: " + id + " does not exist in configurations","ItemManager",2,"ItemData",false,false,false);
         return null;
      }
      
      public static function getItemsUnlockedAtLevel(level:int) : Vector.<ItemData>
      {
         var field:* = null;
         var _loc3_:Vector.<ItemData> = new Vector.<ItemData>();
         var _loc5_:* = getTable();
         for each(var row in _loc5_._rows)
         {
            var _loc6_:* = row;
            if(!_loc6_._cache["RequiredLevel"])
            {
               _loc6_._cache["RequiredLevel"] = com.dchoc.utils.DCUtils.find(_loc6_._fields,"name","RequiredLevel");
            }
            field = _loc6_._cache["RequiredLevel"];
            if(field && (_loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value) == level && !isUnlocked(row.id))
            {
               _loc3_.push(getItemData(row.id));
            }
         }
         _loc3_.sort(sortByItemTypeAndPriority);
         return _loc3_;
      }
      
      public static function unlockItem(item:ShopItem) : void
      {
         unlockItemWithId(item.id);
      }
      
      public static function unlockItemWithId(id:String) : void
      {
         if(UNLOCKED_ITEMS.indexOf(id) == -1)
         {
            UNLOCKED_ITEMS.push(id);
         }
      }
      
      public static function isUnlocked(id:String) : Boolean
      {
         return UNLOCKED_ITEMS.indexOf(id) != -1;
      }
      
      public static function getTable() : Table
      {
         if(!table)
         {
            var _loc1_:ProjectManager = ProjectManager;
            table = com.dchoc.projectdata.ProjectManager.projectData.findTable("Item");
         }
         return table;
      }
      
      private static function findRow(id:String) : Row
      {
         var _loc4_:* = id;
         var _loc3_:* = getTable();
         if(!_loc3_._cache[_loc4_])
         {
            var _loc5_:Row = com.dchoc.utils.DCUtils.find(_loc3_.rows,"id",_loc4_);
            if(!_loc5_)
            {
               com.dchoc.utils.LogUtils.log("No row with name: \'" + _loc4_ + "\' was found in table: \'" + _loc3_.name + "\'",_loc3_,3);
            }
            _loc3_._cache[_loc4_] = _loc5_;
         }
         var _loc2_:Row = _loc3_._cache[_loc4_];
         if(!_loc2_)
         {
            LogUtils.log("No row for id: " + id,"ItemManager",3);
         }
         return _loc2_;
      }
      
      private static function createItemClass(type:String) : Item
      {
         return new ITEM_CLASSES[type]();
      }
      
      private static function createDef(type:String) : ItemDef
      {
         return new ITEM_DEFS[type]();
      }
      
      private static function createData(row:Row, type:String) : ItemData
      {
         return new ITEM_DATA[type](row);
      }
      
      private static function getType(row:Row) : String
      {
         var _loc2_:* = row;
         if(!_loc2_._cache["Type"])
         {
            _loc2_._cache["Type"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Type");
         }
         var _loc3_:* = _loc2_._cache["Type"];
         return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
      }
      
      public static function sortByItemTypeAndPriority(a:ItemData, b:ItemData) : int
      {
         var indexA:int = SORT_ORDER_ITEM_TYPE.indexOf(a.type);
         var indexB:int = SORT_ORDER_ITEM_TYPE.indexOf(b.type);
         if(indexA == indexB)
         {
            indexA = a.sortPriority;
            indexB = b.sortPriority;
         }
         return indexB - indexA;
      }
   }
}
