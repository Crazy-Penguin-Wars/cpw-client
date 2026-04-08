package tuxwars.home.ui.logic.gifts
{
   import com.dchoc.data.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   
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
      
      public function GiftReference(param1:Row)
      {
         super();
         this.row = param1;
      }
      
      public function get id() : String
      {
         return this.row.id;
      }
      
      public function get show() : Boolean
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Show";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Boolean(_loc4_.overrideValue) : Boolean(_loc4_._value)) : false;
      }
      
      public function get itemData() : ItemData
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "ItemReference";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         var _loc5_:Row = !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
         return !!_loc5_ ? ItemManager.getItemData(_loc5_.id) : null;
      }
      
      public function get sortPriority() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SortPriority";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get requiredLevel() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "RequiredLevel";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get mysteryGiftRatio() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "MysteryGiftRatio";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get amount() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Amount";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get type() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Type";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      private function get icon() : GraphicsReference
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Icon";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(_loc3_)
         {
            _loc4_ = _loc3_;
            return new GraphicsReference(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
         }
         if(this.itemData)
         {
            return this.itemData.iconRef;
         }
         return null;
      }
      
      public function get iconMovieClip() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(this.icon)
         {
            _loc1_ = DCResourceManager.instance.getFromSWF(this.icon.swf,this.icon.export);
            if(_loc1_)
            {
               _loc1_.name = this.icon.export;
            }
            return _loc1_;
         }
         if(this.itemData)
         {
            return this.itemData.icon;
         }
         return null;
      }
      
      public function get name() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Name";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(_loc3_)
         {
            _loc4_ = _loc3_;
            return ProjectManager.getText(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
         }
         if(this.itemData)
         {
            return this.itemData.name;
         }
         return null;
      }
      
      public function get description() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Description";
         var _loc2_:Row = this.row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(_loc3_)
         {
            _loc4_ = _loc3_;
            return ProjectManager.getText(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value);
         }
         if(this.itemData)
         {
            return this.itemData.description;
         }
         return null;
      }
   }
}

