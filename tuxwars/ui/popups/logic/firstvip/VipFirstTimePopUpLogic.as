package tuxwars.ui.popups.logic.firstvip
{
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   import tuxwars.ui.popups.screen.firstvip.VipFirstTimePopUpScreen;
   
   public class VipFirstTimePopUpLogic extends PopUpBaseLogic
   {
       
      
      public function VipFirstTimePopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function get headerText() : String
      {
         return ProjectManager.getText("FIRST_TIME_VIP_HEADER");
      }
      
      public function get messageText() : String
      {
         return ProjectManager.getText("FIRST_TIME_VIP_TEXT");
      }
      
      public function get messageScreen() : VipFirstTimePopUpScreen
      {
         return screen;
      }
      
      public function get picture() : String
      {
         return null;
      }
   }
}
