package tuxwars.ui.popups.screen.loot
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.items.data.ItemData;
   import tuxwars.ui.popups.logic.loot.LootPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class LootPopUpScreen extends PopUpBaseScreen
   {
       
      
      private var icon:MovieClip;
      
      public function LootPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_loot");
         icon = getDesignMovieClip().getChildByName("Icon") as MovieClip;
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         var _loc2_:ItemData = params as ItemData;
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
         DCUtils.replaceDisplayObject(icon,_loc2_.icon);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         icon = null;
      }
      
      private function getLogic() : LootPopUpLogic
      {
         return logic as LootPopUpLogic;
      }
   }
}
