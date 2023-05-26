package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.events.ErrorMessage;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import com.dchoc.utils.LogUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.crafting.itemslot.IngredientContainers;
   import tuxwars.home.ui.screen.crafting.itemslot.IngredientResultSlot;
   import tuxwars.home.ui.screen.crafting.itemslot.IngredientSlot;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.RecipeData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class RecipeShow extends UIContainer
   {
      
      private static const SLOT:String = "Slot_0";
      
      private static const SLOT_RESULT:String = "Slot_Result";
       
      
      private const ingredientsContainers:Vector.<IngredientContainers> = new Vector.<IngredientContainers>();
      
      private const ingredients:Vector.<ItemData> = new Vector.<ItemData>();
      
      private var title:UIAutoTextField;
      
      private var ingredientsResultContainer:IngredientContainers;
      
      public function RecipeShow(slotIndex:int, recipe:RecipeData, design:MovieClip, parent:TuxUIScreen)
      {
         var itemData:* = null;
         super(design,parent);
         var ingrdientsList:Array = recipe.ingredients;
         var resultItem:ItemData = ItemManager.getItemData(recipe.result);
         if(resultItem == null)
         {
            MessageCenter.sendEvent(new ErrorMessage("Reciper Result Error","ResultNotFound","Recipe: " + recipe.result + " result not found!",recipe.result,new Error("Recipe: " + recipe.result + " result not found!")));
            return;
         }
         title = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text") as TextField,resultItem.name);
         ingredientsResultContainer = new IngredientContainers(IngredientResultSlot,design.getChildByName("Slot_Result") as MovieClip,recipe,resultItem,parent);
         var slotCount:int = 0;
         for each(var mc in design)
         {
            if(mc is MovieClip && mc.name.indexOf("Slot_0") != -1)
            {
               if(slotCount < ingrdientsList.length)
               {
                  mc.visible = true;
                  itemData = ItemManager.getItemData(ingrdientsList[slotCount]);
                  ingredientsContainers.push(new IngredientContainers(IngredientSlot,mc as MovieClip,recipe,itemData,parent));
               }
               else
               {
                  mc.visible = false;
               }
               slotCount++;
            }
         }
         if(slotCount < ingrdientsList.length)
         {
            LogUtils.log("Less ingredient slots than ingridients in recepy: " + recipe.id,this,3,"Crafting",false,true,true);
         }
      }
      
      override public function dispose() : void
      {
         ingredientsResultContainer.dispose();
         for each(var container in ingredientsContainers)
         {
            container.dispose();
            container = null;
         }
      }
   }
}
