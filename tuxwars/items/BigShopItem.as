package tuxwars.items
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.IResourceLoaderURL;
   import com.dchoc.resources.ResourceLoaderURL;
   import com.dchoc.resources.URLResourceLoader;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.ItemManager;
   
   public class BigShopItem extends ShopItem implements IResourceLoaderURL
   {
      private static const SIZE:String = "Size";
      
      private static const SORT_ORDER:String = "SortOrder";
      
      private static const BIG_TYPE:String = "BigType";
      
      private static const TEXT:String = "Text";
      
      private static const IMAGE:String = "Image";
      
      private static const IMAGE_URL:String = "ImageURL";
      
      private static const ACTION_CODE:String = "ActionCode";
      
      private static const ACTION_LABEL:String = "ActionLabel";
      
      private static const ITEM:String = "Item";
      
      private static const REPLACE:String = "Replace";
      
      private static const TAG:String = "Tag";
      
      private static const SALE_PERCENTAGE:String = "SalePercentage";
      
      private static const ACTION_PARAM_ONE:String = "ActionParamOne";
      
      private static const ACTION_PARAM_TWO:String = "ActionParamTwo";
      
      private var _row:Row;
      
      private var _imageContainer:MovieClip;
      
      private var _iconOverride:MovieClip;
      
      private var _loader:URLResourceLoader;
      
      private var _placeholderItem:Boolean;
      
      public function BigShopItem(row:Row)
      {
         assert("BigItem row is null",true,row != null);
         _row = row;
         super(item);
      }
      
      public function isPlaceholderItem() : Boolean
      {
         return _placeholderItem;
      }
      
      public function set iconOverride(value:MovieClip) : void
      {
         _iconOverride = value;
      }
      
      public function load(imageContaincer:MovieClip) : void
      {
         assert("imageContainer is null",true,imageContaincer != null);
         _imageContainer = imageContaincer;
         _loader = ResourceLoaderURL.getInstance().load(this);
      }
      
      public function dispose() : void
      {
         _row = null;
         _imageContainer = null;
         if(_loader)
         {
            _loader.dispose();
            _loader = null;
         }
      }
      
      override public function get size() : int
      {
         var _loc4_:String = "Size";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : super.size;
      }
      
      public function get sortOrder() : int
      {
         var _loc4_:String = "SortOrder";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : 0;
      }
      
      public function get salePercentage() : int
      {
         var _loc6_:String = "SalePercentage";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc6_])
         {
            _loc2_._cache[_loc6_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc6_);
         }
         var field:Field = _loc2_._cache[_loc6_];
         if(field && (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) != 0)
         {
            var _loc4_:*;
            return !!field ? (_loc4_ = field, _loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : 0;
         }
         var _loc7_:String = "Item";
         var _loc5_:Row = _row;
         if(!_loc5_._cache[_loc7_])
         {
            _loc5_._cache[_loc7_] = com.dchoc.utils.DCUtils.find(_loc5_._fields,"name",_loc7_);
         }
         field = _loc5_._cache[_loc7_];
         return field && priceObject ? priceObject.salePercentage : 0;
      }
      
      public function get bigType() : String
      {
         var _loc4_:String = "BigType";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get text() : String
      {
         var _loc4_:String = "Text";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get actionCode() : String
      {
         var _loc4_:String = "ActionCode";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get actionLabel() : String
      {
         var _loc4_:String = "ActionLabel";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, ProjectManager.getText(_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value)) : ProjectManager.getText("BUTTON_OK");
      }
      
      private function get overrideTag() : String
      {
         var _loc4_:String = "Tag";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get actionParamOne() : String
      {
         var _loc4_:String = "ActionParamOne";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get actionParamTwo() : String
      {
         var _loc4_:String = "ActionParamTwo";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : null;
      }
      
      public function get item() : ItemData
      {
         var _loc5_:String = "Item";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc5_])
         {
            _loc2_._cache[_loc5_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc5_);
         }
         var _loc1_:Field = _loc2_._cache[_loc5_];
         if(_loc1_ && (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) is Row)
         {
            var _loc4_:* = _loc1_;
            return ItemManager.getItemData(((_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) as Row).id);
         }
         _placeholderItem = true;
         return ItemManager.getItemData("BasicNuke");
      }
      
      public function get replace() : Boolean
      {
         var _loc4_:String = "Replace";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc4_])
         {
            _loc2_._cache[_loc4_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc4_);
         }
         var _loc1_:Field = _loc2_._cache[_loc4_];
         var _loc3_:*;
         return !!_loc1_ ? (_loc3_ = _loc1_, _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) : false;
      }
      
      public function getResourceUrl() : String
      {
         var _loc6_:String = "ImageURL";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc6_])
         {
            _loc2_._cache[_loc6_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc6_);
         }
         var field:Field = _loc2_._cache[_loc6_];
         if(field)
         {
            var _loc3_:* = field;
            return _loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value;
         }
         var _loc7_:String = "Image";
         var _loc4_:Row = _row;
         if(!_loc4_._cache[_loc7_])
         {
            _loc4_._cache[_loc7_] = com.dchoc.utils.DCUtils.find(_loc4_._fields,"name",_loc7_);
         }
         field = _loc4_._cache[_loc7_];
         var _loc5_:*;
         return !!field ? (_loc5_ = field, Config.getDataDir() + (_loc5_.overrideValue != null ? _loc5_.overrideValue : _loc5_._value)) : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return _imageContainer;
      }
      
      override public function get tag() : String
      {
         if(overrideTag)
         {
            if(overrideTag == "Sale")
            {
               return "tag_sale";
            }
            if(overrideTag == "Vip")
            {
               return "tag_vip";
            }
            if(overrideTag == "New")
            {
               return "tag_new";
            }
         }
         var _loc3_:String = "Item";
         var _loc2_:Row = _row;
         if(!_loc2_._cache[_loc3_])
         {
            _loc2_._cache[_loc3_] = com.dchoc.utils.DCUtils.find(_loc2_._fields,"name",_loc3_);
         }
         var _loc1_:Field = _loc2_._cache[_loc3_];
         return !!_loc1_ ? super.tag : null;
      }
      
      override public function get icon() : MovieClip
      {
         if(_iconOverride && _iconOverride.numChildren > 0)
         {
            return _iconOverride.getChildByName("LoadedIcon") as MovieClip;
         }
         return super.icon;
      }
   }
}

