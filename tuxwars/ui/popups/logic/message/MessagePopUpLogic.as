package tuxwars.ui.popups.logic.message
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   import tuxwars.ui.popups.screen.message.MessagePopUpScreen;
   
   public class MessagePopUpLogic extends PopUpBaseLogic
   {
       
      
      public function MessagePopUpLogic(game:TuxWarsGame, state:TuxState)
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
      
      public function get messageScreen() : MessagePopUpScreen
      {
         return screen;
      }
      
      public function get picture() : String
      {
         return null;
      }
   }
}
