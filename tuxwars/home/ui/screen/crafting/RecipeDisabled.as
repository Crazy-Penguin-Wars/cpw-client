package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.RecipeData;
   import tuxwars.items.managers.ItemManager;
   import tuxwars.utils.TuxUiUtils;
   
   public class RecipeDisabled extends UIContainer
   {
       
      
      private var title:UIAutoTextField;
      
      private var description:UIAutoTextField;
      
      public function RecipeDisabled(slotIndex:int, object:RecipeData, design:MovieClip, parent:TuxUIScreen)
      {
         var _loc5_:ItemData = ItemManager.getItemData(object.result);
         title = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text") as TextField,_loc5_.name);
         description = TuxUiUtils.createAutoTextFieldWithText(design.getChildByName("Text_Description") as TextField,object.description);
         super(design,parent);
      }
   }
}
