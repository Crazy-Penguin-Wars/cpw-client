package tuxwars.ui.popups.screen.exitquestion
{
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.home.ui.screen.home.DarkBackgroundElementWindow;
   import tuxwars.ui.popups.logic.exitquestion.ExitQuestionPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class ExitQuestionPopUpScreen extends PopUpBaseScreen
   {
      
      private static const BUTTON_EXIT:String = "Button_Exit";
      
      private static const TEXT_MESSAGE:String = "Text_Message";
      
      private static const TEXT_HEADER:String = "Text_Header";
       
      
      private const header:UIAutoTextField = new UIAutoTextField();
      
      private const message:UIAutoTextField = new UIAutoTextField();
      
      private var _okButton:UIButton;
      
      private var _closeButton:UIButton;
      
      private var darkBackGround:DarkBackgroundElementWindow;
      
      public function ExitQuestionPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_chicken_out");
         if(this._design["Button_Exit"])
         {
            _closeButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Exit",closePressed,"BUTTON_CANCEL");
         }
         headerField.setText(ProjectManager.getText("EXIT_MATCH_HEADER"));
         messageField.setText(BattleManager.isPracticeMode() ? ProjectManager.getText("EXIT_MATCH_MESSAGE_PRACTICE") : ProjectManager.getText("EXIT_MATCH_MESSAGE"));
      }
      
      override protected function closePressed(event:MouseEvent) : void
      {
         popUpLogic.leftButtonPressed();
      }
      
      override protected function okPressed(event:MouseEvent) : void
      {
         popUpLogic.rightButtonPressed();
      }
      
      private function get popUpLogic() : ExitQuestionPopUpLogic
      {
         return logic as ExitQuestionPopUpLogic;
      }
   }
}
