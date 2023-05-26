package tuxwars.ui.popups.states.exitquestion
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.exitquestion.ExitQuestionPopUpLogic;
   import tuxwars.ui.popups.screen.exitquestion.ExitQuestionPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class ExitQuestionPopUpSubState extends PopUpBaseSubState
   {
       
      
      public function ExitQuestionPopUpSubState(game:TuxWarsGame)
      {
         super("QuestionMessageType",game,ExitQuestionPopUpScreen,ExitQuestionPopUpLogic,AssetsData.getQuestionPopupAssets());
      }
   }
}
