package tuxwars.ui.popups.states.question
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.question.QuestionPopUpLogic;
   import tuxwars.ui.popups.screen.question.QuestionPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class QuestionPopupSubState extends PopUpBaseSubState
   {
      
      public static const TYPE_QUESTION:String = "QuestionMessageType";
       
      
      public function QuestionPopupSubState(game:TuxWarsGame)
      {
         super("QuestionMessageType",game,QuestionPopUpScreen,QuestionPopUpLogic,AssetsData.getQuestionPopupAssets());
      }
   }
}
