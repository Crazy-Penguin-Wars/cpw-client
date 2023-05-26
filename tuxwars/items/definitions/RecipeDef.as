package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.assert;
   import tuxwars.items.data.RecipeData;
   
   public class RecipeDef extends ItemDef
   {
       
      
      private var _ingredients:Array;
      
      private var _result:String;
      
      public function RecipeDef()
      {
         super();
      }
      
      override public function loadDataConf(data:GameData) : void
      {
         super.loadDataConf(data);
         assert("GameData is not RecipeData",true,data is RecipeData);
         var _loc2_:RecipeData = data as RecipeData;
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
