package tuxwars.items
{
   import com.dchoc.data.GraphicsReference;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.definitions.EquippableDef;
   import tuxwars.items.definitions.ItemDef;
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
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not ItemDef",true,data is ItemDef);
         var _loc2_:ItemDef = data as ItemDef;
         _icon = _loc2_.iconRef;
         _special = _loc2_.special;
         _categories = _loc2_.categories;
         _requierdLevel = _loc2_.requierdLevel;
         _priceInfo = _loc2_.priceInfo;
         _sortPriority = _loc2_.sortPriority;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _special = null;
         _priceInfo = null;
      }
      
      public function get amount() : int
      {
         return _amount;
      }
      
      public function set amount(value:int) : void
      {
         _amount = value;
      }
      
      public function increaseAmount(value:int = 1) : int
      {
         _amount += value;
         return _amount;
      }
      
      public function get special() : SpecialReference
      {
         return _special;
      }
      
      public function get priceInfo() : PriceInfoReference
      {
         return _priceInfo;
      }
      
      public function get icon() : MovieClip
      {
         var _loc1_:MovieClip = DCResourceManager.instance.getFromSWF(_icon.swf,_icon.export);
         _loc1_.name = _icon.export;
         return _loc1_;
      }
      
      public function get categories() : Array
      {
         return _categories;
      }
      
      public function hasCategory(categoryID:String) : Boolean
      {
         return _categories.indexOf(categoryID) != -1;
      }
      
      public function get dropRatio() : int
      {
         return _dropRatio;
      }
      
      public function get requierdLevel() : int
      {
         return _requierdLevel;
      }
      
      public function get sortPriority() : int
      {
         return _sortPriority;
      }
   }
}
