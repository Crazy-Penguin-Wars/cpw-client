package tuxwars.home.ui.logic.inbox
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.inbox.InboxScreen;
   import tuxwars.states.TuxState;
   
   public class InboxLogic extends TuxUILogic
   {
      public function InboxLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      private function get inboxScreen() : InboxScreen
      {
         return screen;
      }
   }
}

