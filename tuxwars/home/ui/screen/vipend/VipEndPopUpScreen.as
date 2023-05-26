package tuxwars.home.ui.screen.vipend
{
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.vip.VIPState;
   import tuxwars.home.ui.logic.vipend.VipEndPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   
   public class VipEndPopUpScreen extends PopUpBaseScreen
   {
       
      
      public function VipEndPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_expired");
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         headerField.setText(ProjectManager.getText("TITLE_VIP_END"));
         messageField.setText(ProjectManager.getText("BODY_VIP_END"));
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override public function clean() : void
      {
         var _loc1_:TuxWarsGame = tuxGame;
         super.clean();
         _loc1_.homeState.changeState(new VIPState(_loc1_));
      }
      
      private function getLogic() : VipEndPopUpLogic
      {
         return logic as VipEndPopUpLogic;
      }
   }
}
