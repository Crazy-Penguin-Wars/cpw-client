package tuxwars.items
{
   import no.olog.utilfunctions.assert;
   import tuxwars.items.definitions.EquippableDef;
   import tuxwars.items.definitions.RecipeDef;
   
   public class RecipeItem extends Item
   {
       
      
      private var _ingredients:Array;
      
      private var _result:String;
      
      public function RecipeItem()
      {
         super();
      }
      
      override public function load(data:EquippableDef) : void
      {
         super.load(data);
         assert("data is not RecipeDef",true,data is RecipeDef);
         var _loc2_:RecipeDef = data as RecipeDef;
         _ingredients = _loc2_.ingredients;
         _result = _loc2_.result;
      }
      
      public function get ingredients() : Array
      {
         return _ingredients;
      }
      
      public function get result() : String
      {
         return _result;
      }
   }
}
