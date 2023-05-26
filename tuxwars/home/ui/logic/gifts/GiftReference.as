package tuxwars.home.ui.logic.gifts
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.projectdata.Field;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.projectdata.Row;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   
   public class GiftReference
   {
      
      private static const SHOW:String = "Show";
      
      private static const ITEM_REFERENCE:String = "ItemReference";
      
      private static const SORT_PRIORITY:String = "SortPriority";
      
      private static const REQUIRED_LEVEL:String = "RequiredLevel";
      
      private static const MYSTERY_GIFT_RATIO:String = "MysteryGiftRatio";
      
      private static const NAME:String = "Name";
      
      private static const DESCRIPTION:String = "Description";
      
      private static const ICON:String = "Icon";
      
      private static const AMOUNT:String = "Amount";
      
      private static const TYPE:String = "Type";
      
      public static const TYPE_ITEM:String = "Item";
      
      public static const TYPE_COINS:String = "Coins";
      
      public static const TYPE_CASH:String = "Cash";
      
      public static const TYPE_EXP:String = "Exp";
       
      
      private var row:Row;
      
      public function GiftReference(row:Row)
      {
         super();
         this.row = row;
      }
      
      public function get id() : String
      {
         return row.id;
      }
      
      public function get show() : Boolean
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Show"])
         {
            _loc2_._cache["Show"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Show");
         }
         var _loc1_:Field = _loc2_._cache["Show"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : false;
      }
      
      public function get itemData() : ItemData
      {
         var _loc3_:Row = row;
         if(!_loc3_._cache["ItemReference"])
         {
            _loc3_._cache["ItemReference"] = com.dchoc.utils.DCUtils.find(_loc3_._fields,"name","ItemReference");
         }
         var _loc1_:Field = _loc3_._cache["ItemReference"];
         var _loc4_:*;
         var _loc2_:Row = !!_loc1_ ? (_loc4_ = _loc1_, _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
         return !!_loc2_ ? ItemManager.getItemData(_loc2_.id) : null;
      }
      
      public function get sortPriority() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["SortPriority"])
         {
            _loc2_._cache["SortPriority"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","SortPriority");
         }
         var _loc1_:Field = _loc2_._cache["SortPriority"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get requiredLevel() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["RequiredLevel"])
         {
            _loc2_._cache["RequiredLevel"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","RequiredLevel");
         }
         var _loc1_:Field = _loc2_._cache["RequiredLevel"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get mysteryGiftRatio() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["MysteryGiftRatio"])
         {
            _loc2_._cache["MysteryGiftRatio"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","MysteryGiftRatio");
         }
         var _loc1_:Field = _loc2_._cache["MysteryGiftRatio"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get amount() : int
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Amount"])
         {
            _loc2_._cache["Amount"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Amount");
         }
         var _loc1_:Field = _loc2_._cache["Amount"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get type() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Type"])
         {
            _loc2_._cache["Type"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Type");
         }
         var _loc1_:Field = _loc2_._cache["Type"];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      private function get icon() : GraphicsReference
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Icon"])
         {
            _loc2_._cache["Icon"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Icon");
         }
         var _loc1_:Field = _loc2_._cache["Icon"];
         if(_loc1_)
         {
            var _loc3_:* = _loc1_;
            return new GraphicsReference(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value);
         }
         if(itemData)
         {
            return itemData.iconRef;
         }
         return null;
      }
      
      public function get iconMovieClip() : MovieClip
      {
         var _loc1_:* = null;
         if(icon)
         {
            _loc1_ = DCResourceManager.instance.getFromSWF(icon.swf,icon.export);
            if(_loc1_)
            {
               _loc1_.name = icon.export;
            }
            return _loc1_;
         }
         if(itemData)
         {
            return itemData.icon;
         }
         return null;
      }
      
      public function get name() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Name"])
         {
            _loc2_._cache["Name"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Name");
         }
         var _loc1_:Field = _loc2_._cache["Name"];
         if(_loc1_)
         {
            var _loc3_:* = _loc1_;
            return ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value);
         }
         if(itemData)
         {
            return itemData.name;
         }
         return null;
      }
      
      public function get description() : String
      {
         var _loc2_:Row = row;
         if(!_loc2_._cache["Description"])
         {
            _loc2_._cache["Description"] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name","Description");
         }
         var _loc1_:Field = _loc2_._cache["Description"];
         if(_loc1_)
         {
            var _loc3_:* = _loc1_;
            return ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value);
         }
         if(itemData)
         {
            return itemData.description;
         }
         return null;
      }
   }
}
