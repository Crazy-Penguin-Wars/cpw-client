package tuxwars.home.ui.screen.crafting
{
   import com.dchoc.ui.text.UIAutoTextField;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import flash.text.*;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.items.data.ItemData;
   import tuxwars.items.data.RecipeData;
   import tuxwars.items.managers.*;
   import tuxwars.utils.*;
   
   public class RecipeDisabled extends UIContainer
   {
      private var title:UIAutoTextField;
      
      private var description:UIAutoTextField;
      
      public function RecipeDisabled(param1:int, param2:RecipeData, param3:MovieClip, param4:TuxUIScreen)
      {
         var _loc5_:ItemData = ItemManager.getItemData(param2.result);
         this.title = TuxUiUtils.createAutoTextFieldWithText(param3.getChildByName("Text") as TextField,_loc5_.name);
         this.description = TuxUiUtils.createAutoTextFieldWithText(param3.getChildByName("Text_Description") as TextField,param2.description);
         super(param3,param4);
      }
   }
}

