package tuxwars.items
{
   import no.olog.utilfunctions.*;
   import tuxwars.items.definitions.*;
   
   public class MegaPackItem extends Item
   {
      private var _itemList:Array;
      
      private var _itemAmountList:Array;
      
      public function MegaPackItem()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not MegaPackDef",true,param1 is MegaPackDef);
         var _loc2_:MegaPackDef = param1 as MegaPackDef;
         this._itemList = _loc2_.itemList;
         this._itemAmountList = _loc2_.itemAmountList;
      }
      
      public function get itemList() : Array
      {
         return this._itemList;
      }
      
      public function get itemAmountList() : Array
      {
         return this._itemAmountList;
      }
   }
}

