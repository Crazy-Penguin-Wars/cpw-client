package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.events.*;
   import com.dchoc.messages.*;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.text.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.crafting.itemslot.*;
   import tuxwars.items.data.*;
   import tuxwars.items.managers.*;
   import tuxwars.utils.*;
   
   public class RecipeShow extends UIContainer
   {
      private static const SLOT:String = "Slot_0";
      
      private static const SLOT_RESULT:String = "Slot_Result";
      
      private const ingredientsContainers:Vector.<IngredientContainers>;
      
      private const ingredients:Vector.<ItemData>;
      
      private var title:UIAutoTextField;
      
      private var ingredientsResultContainer:IngredientContainers;
      
      public function RecipeShow(param1:int, param2:RecipeData, param3:MovieClip, param4:TuxUIScreen)
      {
         var _loc9_:* = undefined;
         var _loc5_:ItemData = null;
         this.ingredientsContainers = new Vector.<IngredientContainers>();
         this.ingredients = new Vector.<ItemData>();
         super(param3,param4);
         var _loc6_:Array = param2.ingredients;
         var _loc7_:ItemData = ItemManager.getItemData(param2.result);
         if(_loc7_ == null)
         {
            MessageCenter.sendEvent(new ErrorMessage("Reciper Result Error","ResultNotFound","Recipe: " + param2.result + " result not found!",param2.result,new Error("Recipe: " + param2.result + " result not found!")));
            return;
         }
         this.title = TuxUiUtils.createAutoTextFieldWithText(param3.getChildByName("Text") as TextField,_loc7_.name);
         this.ingredientsResultContainer = new IngredientContainers(IngredientResultSlot,param3.getChildByName("Slot_Result") as MovieClip,param2,_loc7_,param4);
         var _loc8_:int = 0;
         for each(_loc9_ in param3)
         {
            if(_loc9_ is MovieClip && _loc9_.name.indexOf("Slot_0") != -1)
            {
               if(_loc8_ < _loc6_.length)
               {
                  _loc9_.visible = true;
                  _loc5_ = ItemManager.getItemData(_loc6_[_loc8_]);
                  this.ingredientsContainers.push(new IngredientContainers(IngredientSlot,_loc9_ as MovieClip,param2,_loc5_,param4));
               }
               else
               {
                  _loc9_.visible = false;
               }
               _loc8_++;
            }
         }
         if(_loc8_ < _loc6_.length)
         {
            LogUtils.log("Less ingredient slots than ingridients in recepy: " + param2.id,this,3,"Crafting",false,true,true);
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:* = undefined;
         this.ingredientsResultContainer.dispose();
         for each(_loc1_ in this.ingredientsContainers)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
      }
   }
}

