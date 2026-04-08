package tuxwars.items
{
   import com.dchoc.avatar.*;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.SetReference;
   import tuxwars.items.definitions.*;
   import tuxwars.items.managers.*;
   
   public class ClothingItem extends Item
   {
      private var _setReference:SetReference;
      
      private var _slot:String;
      
      private var _rightFootExport:String;
      
      private var _includedFacialExpressionID:String;
      
      public function ClothingItem()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not ClothingDef",true,param1 is ClothingDef);
         var _loc2_:ClothingDef = param1 as ClothingDef;
         this._setReference = _loc2_.setReference;
         this._slot = _loc2_.slot;
         this._rightFootExport = _loc2_.rightFootExport;
         this._includedFacialExpressionID = _loc2_.includedFacialExpressionID;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function get setReference() : SetReference
      {
         return this._setReference;
      }
      
      public function get slot() : String
      {
         return this._slot;
      }
      
      public function get rightFootExport() : String
      {
         return this._rightFootExport;
      }
      
      public function getRightFootAsWearableItem() : WearableItem
      {
         return new WearableItem({
            "swf":graphics.swf,
            "export":this._rightFootExport,
            "wearableSlot":Slots.getWearableSlot("RightFoot"),
            "name":id,
            "id":id
         });
      }
      
      public function get includedFacialExpressionID() : String
      {
         return this._includedFacialExpressionID;
      }
   }
}

