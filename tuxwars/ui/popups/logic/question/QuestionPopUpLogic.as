package tuxwars.ui.popups.logic.question
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   
   public class QuestionPopUpLogic extends PopUpBaseLogic
   {
       
      
      public function QuestionPopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function get headerText() : String
      {
         return null;
      }
      
      public function get messageText() : String
      {
         return null;
      }
      
      public function get leftButtonText() : String
      {
         return null;
      }
      
      public function get rightButtonText() : String
      {
         return null;
      }
      
      public function leftButtonPressed() : void
      {
      }
      
      public function rightButtonPressed() : void
      {
      }
   }
}
