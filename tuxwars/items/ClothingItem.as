package tuxwars.items
{
   import com.dchoc.avatar.WearableItem;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.SetReference;
   import tuxwars.items.definitions.ClothingDef;
   import tuxwars.items.definitions.EquippableDef;
   import tuxwars.items.managers.Slots;
   
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
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not ClothingDef",true,data is ClothingDef);
         var _loc2_:ClothingDef = data as ClothingDef;
         _setReference = _loc2_.setReference;
         _slot = _loc2_.slot;
         _rightFootExport = _loc2_.rightFootExport;
         _includedFacialExpressionID = _loc2_.includedFacialExpressionID;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      public function get setReference() : SetReference
      {
         return _setReference;
      }
      
      public function get slot() : String
      {
         return _slot;
      }
      
      public function get rightFootExport() : String
      {
         return _rightFootExport;
      }
      
      public function getRightFootAsWearableItem() : WearableItem
      {
         return new WearableItem({
            "swf":graphics.swf,
            "export":_rightFootExport,
            "wearableSlot":Slots.getWearableSlot("RightFoot"),
            "name":id,
            "id":id
         });
      }
      
      public function get includedFacialExpressionID() : String
      {
         return _includedFacialExpressionID;
      }
   }
}
