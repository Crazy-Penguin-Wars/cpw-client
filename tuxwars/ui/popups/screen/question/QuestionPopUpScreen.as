package tuxwars.ui.popups.screen.question
{
   import com.dchoc.ui.buttons.UIButton;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.question.QuestionPopUpLogic;
   import tuxwars.ui.popups.screen.PopUpBaseScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class QuestionPopUpScreen extends PopUpBaseScreen
   {
      
      private static const BUTTON_LEFT:String = "Button_Negative";
      
      private static const BUTTON_RIGHT:String = "Button_Positive";
       
      
      private var leftButton:UIButton;
      
      private var rightButton:UIButton;
      
      public function QuestionPopUpScreen(game:TuxWarsGame)
      {
         super(game,"flash/ui/popups.swf","popup_dialog");
         leftButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Negative",leftButtonPressed,"");
         rightButton = TuxUiUtils.createButton(UIButton,this._design,"Button_Positive",rightButtonPressed,"");
      }
      
      override public function init(params:*) : void
      {
         headerField.setText(questionLogic.headerText);
         messageField.setText(questionLogic.messageText);
         leftButton.setText(questionLogic.leftButtonText);
         rightButton.setText(questionLogic.rightButtonText);
      }
      
      override public function dispose() : void
      {
         leftButton.dispose();
         leftButton = null;
         rightButton.dispose();
         rightButton = null;
         super.dispose();
      }
      
      private function leftButtonPressed(event:MouseEvent) : void
      {
         questionLogic.leftButtonPressed();
      }
      
      private function rightButtonPressed(event:MouseEvent) : void
      {
         questionLogic.rightButtonPressed();
      }
      
      private function get questionLogic() : QuestionPopUpLogic
      {
         return logic;
      }
   }
}
