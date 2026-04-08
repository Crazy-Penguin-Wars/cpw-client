package tuxwars.items
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.resources.*;
   import flash.display.MovieClip;
   import no.olog.utilfunctions.*;
   import tuxwars.items.definitions.*;
   import tuxwars.items.references.PriceInfoReference;
   import tuxwars.items.references.SpecialReference;
   
   public class Item extends Equippable
   {
      public static const TYPE_CRAFTING:String = "Crafting";
      
      public static const TYPE_WEAPON:String = "Weapon";
      
      public static const TYPE_CLOTHING:String = "Clothing";
      
      public static const TYPE_BOOSTER:String = "Booster";
      
      public static const TYPE_STATUS:String = "Status";
      
      public static const TYPE_FOLLOWER:String = "Follower";
      
      public static const TYPE_TROPHY:String = "Trophy";
      
      public static const TYPE_EMOTICON:String = "Emoticon";
      
      public static const TYPE_RECIPE:String = "Recipe";
      
      public static const TYPE_CUSTOMIZATION:String = "Customization";
      
      public static const TYPE_MEGAPACK:String = "MegaPack";
      
      public static const TYPE_COUPON:String = "Coupon";
      
      public static const SPECIAL_CLOTHING_SET:String = "ClothingSet";
      
      public static const CATEGORY_PRACTICE:String = "Practice";
      
      private var _special:SpecialReference;
      
      private var _priceInfo:PriceInfoReference;
      
      private var _icon:GraphicsReference;
      
      private var _amount:int;
      
      private var _dropRatio:int;
      
      private var _categories:Array;
      
      private var _requierdLevel:int;
      
      private var _sortPriority:int;
      
      public function Item()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not ItemDef",true,param1 is ItemDef);
         var _loc2_:ItemDef = param1 as ItemDef;
         this._icon = _loc2_.iconRef;
         this._special = _loc2_.special;
         this._categories = _loc2_.categories;
         this._requierdLevel = _loc2_.requierdLevel;
         this._priceInfo = _loc2_.priceInfo;
         this._sortPriority = _loc2_.sortPriority;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._special = null;
         this._priceInfo = null;
      }
      
      public function get amount() : int
      {
         return this._amount;
      }
      
      public function set amount(param1:int) : void
      {
         this._amount = param1;
      }
      
      public function increaseAmount(param1:int = 1) : int
      {
         this._amount += param1;
         return this._amount;
      }
      
      public function get special() : SpecialReference
      {
         return this._special;
      }
      
      public function get priceInfo() : PriceInfoReference
      {
         return this._priceInfo;
      }
      
      public function get icon() : MovieClip
      {
         var _loc1_:MovieClip = DCResourceManager.instance.getFromSWF(this._icon.swf,this._icon.export);
         _loc1_.name = this._icon.export;
         return _loc1_;
      }
      
      public function get categories() : Array
      {
         return this._categories;
      }
      
      public function hasCategory(param1:String) : Boolean
      {
         return this._categories.indexOf(param1) != -1;
      }
      
      public function get dropRatio() : int
      {
         return this._dropRatio;
      }
      
      public function get requierdLevel() : int
      {
         return this._requierdLevel;
      }
      
      public function get sortPriority() : int
      {
         return this._sortPriority;
      }
   }
}

