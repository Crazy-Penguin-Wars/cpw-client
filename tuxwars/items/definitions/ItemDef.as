package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import com.dchoc.data.GraphicsReference;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
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
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not ItemData",true,param1 is ItemData);
         var _loc2_:ItemData = param1 as ItemData;
         this._priceInfo = _loc2_.priceInfoReference;
         this._iconRef = _loc2_.iconRef;
         this._special = _loc2_.special;
         this._categories = _loc2_.categories;
         this.categoryDefault = _loc2_.getCategoryDefault();
         this._requierdLevel = _loc2_.requiredLevel;
         this._sortPriority = _loc2_.sortPriority;
      }
      
      public function get iconRef() : GraphicsReference
      {
         return this._iconRef;
      }
      
      public function get priceInfo() : PriceInfoReference
      {
         return this._priceInfo;
      }
      
      public function get special() : SpecialReference
      {
         return this._special;
      }
      
      public function get dropRatio() : int
      {
         return this._dropRatio;
      }
      
      public function get categories() : Array
      {
         return this._categories;
      }
      
      public function getCategoryDefault() : String
      {
         return this.categoryDefault;
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

