package tuxwars.items
{
   import no.olog.utilfunctions.assert;
   import tuxwars.items.definitions.EquippableDef;
   import tuxwars.items.definitions.MegaPackDef;
   
   public class MegaPackItem extends Item
   {
       
      
      private var _itemList:Array;
      
      private var _itemAmountList:Array;
      
      public function MegaPackItem()
      {
         super();
      }
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not MegaPackDef",true,data is MegaPackDef);
         var _loc2_:MegaPackDef = data as MegaPackDef;
         _itemList = _loc2_.itemList;
         _itemAmountList = _loc2_.itemAmountList;
      }
      
      public function get itemList() : Array
      {
         return _itemList;
      }
      
      public function get itemAmountList() : Array
      {
         return _itemAmountList;
      }
   }
}
