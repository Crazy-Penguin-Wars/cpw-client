package tuxwars.home.states.inbox
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.inbox.*;
   import tuxwars.home.ui.screen.inbox.*;
   
   public class InboxUISubState extends TuxUIState
   {
      public function InboxUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(InboxScreen,InboxLogic,param1,param2);
      }
   }
}

