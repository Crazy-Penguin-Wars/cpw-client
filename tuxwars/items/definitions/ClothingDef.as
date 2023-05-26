package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.ClothingData;
   import tuxwars.items.data.SetReference;
   
   public class ClothingDef extends ItemDef
   {
       
      
      private var _setReference:SetReference;
      
      private var _rightFootExport:String;
      
      private var _includedFacialExpressionID:String;
      
      public function ClothingDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not ItemData",true,data is ClothingData);
         var _loc2_:ClothingData = data as ClothingData;
         _setReference = _loc2_.setReference;
         _rightFootExport = _loc2_.rightFootExport;
         _includedFacialExpressionID = _loc2_.includedFacialExpressionID;
      }
      
      public function get setReference() : SetReference
      {
         return _setReference;
      }
      
      public function get rightFootExport() : String
      {
         return _rightFootExport;
      }
      
      public function get includedFacialExpressionID() : String
      {
         return _includedFacialExpressionID;
      }
   }
}
