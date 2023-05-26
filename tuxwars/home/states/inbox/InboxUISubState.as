package tuxwars.home.states.inbox
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.inbox.InboxLogic;
   import tuxwars.home.ui.screen.inbox.InboxScreen;
   
   public class InboxUISubState extends TuxUIState
   {
       
      
      public function InboxUISubState(game:TuxWarsGame, params:* = null)
      {
         super(InboxScreen,InboxLogic,game,params);
      }
   }
}
