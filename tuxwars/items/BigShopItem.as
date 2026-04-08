package tuxwars.items
{
   import com.dchoc.projectdata.*;
   import com.dchoc.resources.*;
   import com.dchoc.utils.DCUtils;
   import flash.display.*;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.managers.*;
   
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
      
      public function BigShopItem(param1:Row)
      {
         assert("BigItem row is null",true,param1 != null);
         this._row = param1;
         super(this.item);
      }
      
      public function isPlaceholderItem() : Boolean
      {
         return this._placeholderItem;
      }
      
      public function set iconOverride(param1:MovieClip) : void
      {
         this._iconOverride = param1;
      }
      
      public function load(param1:MovieClip) : void
      {
         assert("imageContainer is null",true,param1 != null);
         this._imageContainer = param1;
         this._loader = ResourceLoaderURL.getInstance().load(this);
      }
      
      public function dispose() : void
      {
         this._row = null;
         this._imageContainer = null;
         if(this._loader)
         {
            this._loader.dispose();
            this._loader = null;
         }
      }
      
      override public function get size() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Size";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : super.size;
      }
      
      public function get sortOrder() : int
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "SortOrder";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? int(_loc4_.overrideValue) : int(_loc4_._value)) : 0;
      }
      
      public function get salePercentage() : int
      {
         var _loc6_:* = undefined;
         var _loc1_:String = "SalePercentage";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(Boolean(_loc3_) && (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) != 0)
         {
            _loc6_ = _loc3_;
            return !!_loc3_ ? (_loc6_.overrideValue != null ? int(_loc6_.overrideValue) : int(_loc6_._value)) : 0;
         }
         var _loc4_:String = "Item";
         var _loc5_:Row = this._row;
         if(!_loc5_.getCache[_loc4_])
         {
            _loc5_.getCache[_loc4_] = DCUtils.find(_loc5_.getFields(),"name",_loc4_);
         }
         _loc3_ = _loc5_.getCache[_loc4_];
         return Boolean(_loc3_) && Boolean(priceObject) ? priceObject.salePercentage : 0;
      }
      
      public function get bigType() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "BigType";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get text() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Text";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get actionCode() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "ActionCode";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get actionLabel() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "ActionLabel";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? (_loc4_ = _loc3_, ProjectManager.getText(_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value)) : ProjectManager.getText("BUTTON_OK");
      }
      
      private function get overrideTag() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Tag";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get actionParamOne() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "ActionParamOne";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get actionParamTwo() : String
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "ActionParamTwo";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) : null;
      }
      
      public function get item() : ItemData
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Item";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(Boolean(_loc3_) && (_loc3_.overrideValue != null ? _loc3_.overrideValue : _loc3_._value) is Row)
         {
            _loc4_ = _loc3_;
            return ItemManager.getItemData(((_loc4_.overrideValue != null ? _loc4_.overrideValue : _loc4_._value) as Row).id);
         }
         this._placeholderItem = true;
         return ItemManager.getItemData("BasicNuke");
      }
      
      public function get replace() : Boolean
      {
         var _loc4_:* = undefined;
         var _loc1_:String = "Replace";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         _loc4_ = _loc3_;
         return !!_loc3_ ? (_loc4_.overrideValue != null ? Boolean(_loc4_.overrideValue) : Boolean(_loc4_._value)) : false;
      }
      
      public function getResourceUrl() : String
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc1_:String = "ImageURL";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         if(_loc3_)
         {
            _loc7_ = _loc3_;
            return _loc7_.overrideValue != null ? _loc7_.overrideValue : _loc7_._value;
         }
         var _loc4_:String = "Image";
         var _loc5_:Row = this._row;
         if(!_loc5_.getCache[_loc4_])
         {
            _loc5_.getCache[_loc4_] = DCUtils.find(_loc5_.getFields(),"name",_loc4_);
         }
         _loc3_ = _loc5_.getCache[_loc4_];
         return !!_loc3_ ? (_loc6_ = _loc3_, Config.getDataDir() + (_loc6_.overrideValue != null ? _loc6_.overrideValue : _loc6_._value)) : null;
      }
      
      public function getTargetMovieClip() : MovieClip
      {
         return this._imageContainer;
      }
      
      override public function get tag() : String
      {
         if(this.overrideTag)
         {
            if(this.overrideTag == "Sale")
            {
               return "tag_sale";
            }
            if(this.overrideTag == "Vip")
            {
               return "tag_vip";
            }
            if(this.overrideTag == "New")
            {
               return "tag_new";
            }
         }
         var _loc1_:String = "Item";
         var _loc2_:Row = this._row;
         if(!_loc2_.getCache[_loc1_])
         {
            _loc2_.getCache[_loc1_] = DCUtils.find(_loc2_.getFields(),"name",_loc1_);
         }
         var _loc3_:Field = _loc2_.getCache[_loc1_];
         return !!_loc3_ ? super.tag : null;
      }
      
      override public function get icon() : MovieClip
      {
         if(Boolean(this._iconOverride) && this._iconOverride.numChildren > 0)
         {
            return this._iconOverride.getChildByName("LoadedIcon") as MovieClip;
         }
         return super.icon;
      }
   }
}

