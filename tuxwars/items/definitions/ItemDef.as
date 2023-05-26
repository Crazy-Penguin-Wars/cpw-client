package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import com.dchoc.data.GraphicsReference;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.references.PriceInfoReference;
   import tuxwars.items.references.SpecialReference;
   
   public class ItemDef extends EquippableDef
   {
       
      
      private var _iconRef:GraphicsReference;
      
      private var _priceInfo:PriceInfoReference;
      
      private var _special:SpecialReference;
      
      private var _dropRatio:int;
      
      private var _categories:Array;
      
      private var categoryDefault:String;
      
      private var _requierdLevel:int;
      
      private var _sortPriority:int;
      
      public function ItemDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not ItemData",true,data is ItemData);
         var _loc2_:ItemData = data as ItemData;
         _priceInfo = _loc2_.priceInfoReference;
         _iconRef = _loc2_.iconRef;
         _special = _loc2_.special;
         _categories = _loc2_.categories;
         categoryDefault = _loc2_.getCategoryDefault();
         _requierdLevel = _loc2_.requiredLevel;
         _sortPriority = _loc2_.sortPriority;
      }
      
      public function get iconRef() : GraphicsReference
      {
         return _iconRef;
      }
      
      public function get priceInfo() : PriceInfoReference
      {
         return _priceInfo;
      }
      
      public function get special() : SpecialReference
      {
         return _special;
      }
      
      public function get dropRatio() : int
      {
         return _dropRatio;
      }
      
      public function get categories() : Array
      {
         return _categories;
      }
      
      public function getCategoryDefault() : String
      {
         return categoryDefault;
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
