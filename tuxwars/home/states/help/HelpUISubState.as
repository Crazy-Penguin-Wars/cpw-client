package tuxwars.home.states.help
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.help.*;
   import tuxwars.home.ui.screen.help.*;
   
   public class HelpUISubState extends TuxUIState
   {
      public function HelpUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(HelpScreen,HelpLogic,param1,param2);
      }
   }
}

