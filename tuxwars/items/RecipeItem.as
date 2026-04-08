package tuxwars.items
{
   import no.olog.utilfunctions.*;
   import tuxwars.items.definitions.*;
   
   public class RecipeItem extends Item
   {
      private var _ingredients:Array;
      
      private var _result:String;
      
      public function RecipeItem()
      {
         super();
      }
      
      override public function load(param1:EquippableDef) : void
      {
         super.load(param1);
         assert("data is not RecipeDef",true,param1 is RecipeDef);
         var _loc2_:RecipeDef = param1 as RecipeDef;
         this._ingredients = _loc2_.ingredients;
         this._result = _loc2_.result;
      }
      
      public function get ingredients() : Array
      {
         return this._ingredients;
      }
      
      public function get result() : String
      {
         return this._result;
      }
   }
}

