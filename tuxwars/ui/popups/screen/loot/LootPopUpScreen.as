package tuxwars.ui.popups.screen.loot
{
   import com.dchoc.projectdata.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.*;
   import tuxwars.ui.popups.logic.loot.*;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class LootPopUpScreen extends PopUpBaseScreen
   {
      private var icon:MovieClip;
      
      public function LootPopUpScreen(param1:TuxWarsGame)
      {
         super(param1,"flash/ui/popups.swf","popup_loot");
         this.icon = getDesignMovieClip().getChildByName("Icon") as MovieClip;
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         var _loc2_:ItemData = param1 as ItemData;
         if(_loc2_.type == "Recipe")
         {
            headerField.setText(ProjectManager.getText("TITLE_NEW_RECIPE"));
            messageField.setText(ProjectManager.getText("BODY_NEW_RECIPE",[_loc2_.name]));
         }
         else if(_loc2_.type == "Trophy")
         {
            headerField.setText(ProjectManager.getText("TITLE_NEW_MEDAL"));
            messageField.setText(ProjectManager.getText("BODY_NEW_MEDAL",[_loc2_.name]));
         }
         else
         {
            headerField.setText(_loc2_.name);
            messageField.setText(_loc2_.description);
         }
         DCUtils.replaceDisplayObject(this.icon,_loc2_.icon);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.icon = null;
      }
      
      private function getLogic() : LootPopUpLogic
      {
         return logic as LootPopUpLogic;
      }
   }
}

