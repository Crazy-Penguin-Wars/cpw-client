package tuxwars.ui.popups.states.exitquestion
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.exitquestion.*;
   import tuxwars.ui.popups.screen.exitquestion.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class ExitQuestionPopUpSubState extends PopUpBaseSubState
   {
      public function ExitQuestionPopUpSubState(param1:TuxWarsGame)
      {
         super("QuestionMessageType",param1,ExitQuestionPopUpScreen,ExitQuestionPopUpLogic,AssetsData.getQuestionPopupAssets());
      }
   }
}

