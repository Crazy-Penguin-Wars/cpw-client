package tuxwars.items
{
   import no.olog.utilfunctions.*;
   import tuxwars.items.definitions.*;
   
   public class CustomizationItem extends ClothingItem
   {
      private var _isDefaultValue:Boolean;
      
      public function CustomizationItem()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not CustomizationDef",true,param1 is CustomizationDef);
         var _loc2_:CustomizationDef = param1 as CustomizationDef;
         var _loc3_:String = _loc2_.getCategoryDefault();
         this._isDefaultValue = !!_loc3_ ? _loc3_ == "TRUE" : false;
      }
      
      public function isDefaultValue() : Boolean
      {
         return this._isDefaultValue;
      }
   }
}

