package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
   
   public class ClothingDef extends ItemDef
   {
      private var _setReference:SetReference;
      
      private var _rightFootExport:String;
      
      private var _includedFacialExpressionID:String;
      
      public function ClothingDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not ItemData",true,param1 is ClothingData);
         var _loc2_:ClothingData = param1 as ClothingData;
         this._setReference = _loc2_.setReference;
         this._rightFootExport = _loc2_.rightFootExport;
         this._includedFacialExpressionID = _loc2_.includedFacialExpressionID;
      }
      
      public function get setReference() : SetReference
      {
         return this._setReference;
      }
      
      public function get rightFootExport() : String
      {
         return this._rightFootExport;
      }
      
      public function get includedFacialExpressionID() : String
      {
         return this._includedFacialExpressionID;
      }
   }
}

