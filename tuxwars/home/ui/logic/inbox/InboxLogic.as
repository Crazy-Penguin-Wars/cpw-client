package tuxwars.home.ui.logic.inbox
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.inbox.InboxScreen;
   import tuxwars.states.TuxState;
   
   public class InboxLogic extends TuxUILogic
   {
       
      
      public function InboxLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      private function get inboxScreen() : InboxScreen
      {
         return screen;
      }
   }
}
