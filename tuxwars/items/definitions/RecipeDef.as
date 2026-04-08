package tuxwars.items.definitions
{
   import com.dchoc.data.GameData;
   import no.olog.utilfunctions.*;
   import tuxwars.items.data.*;
   
   public class RecipeDef extends ItemDef
   {
      private var _ingredients:Array;
      
      private var _result:String;
      
      public function RecipeDef()
      {
         super();
      }
      
      override public function loadDataConf(param1:GameData) : void
      {
         super.loadDataConf(param1);
         assert("GameData is not RecipeData",true,param1 is RecipeData);
         var _loc2_:RecipeData = param1 as RecipeData;
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

