package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
   
   public class MegaPackDef extends ItemDef
   {
      private var _itemList:Array;
      
      private var _itemAmountList:Array;
      
      public function MegaPackDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not MegaPackData",true,param1 is MegaPackData);
         var _loc2_:MegaPackData = param1 as MegaPackData;
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

