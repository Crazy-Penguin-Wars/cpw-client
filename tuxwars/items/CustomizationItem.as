package tuxwars.items
{
   import no.olog.utilfunctions.assert;
   import tuxwars.items.definitions.CustomizationDef;
   import tuxwars.items.definitions.EquippableDef;
   
   public class CustomizationItem extends ClothingItem
   {
       
      
      private var _isDefaultValue:Boolean;
      
      public function CustomizationItem()
      {
         super();
      }
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not CustomizationDef",true,data is CustomizationDef);
         var _loc2_:CustomizationDef = data as CustomizationDef;
         var _loc3_:String = _loc2_.getCategoryDefault();
         _isDefaultValue = !!_loc3_ ? _loc3_ == "TRUE" : false;
      }
      
      public function isDefaultValue() : Boolean
      {
         return _isDefaultValue;
      }
   }
}
