package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.MegaPackData;
   
   public class MegaPackDef extends ItemDef
   {
       
      
      private var _itemList:Array;
      
      private var _itemAmountList:Array;
      
      public function MegaPackDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not MegaPackData",true,data is MegaPackData);
         var _loc2_:MegaPackData = data as MegaPackData;
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
