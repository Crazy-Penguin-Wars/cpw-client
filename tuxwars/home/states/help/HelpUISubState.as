package tuxwars.home.states.help
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.help.HelpLogic;
   import tuxwars.home.ui.screen.help.HelpScreen;
   
   public class HelpUISubState extends TuxUIState
   {
       
      
      public function HelpUISubState(game:TuxWarsGame, params:* = null)
      {
         super(HelpScreen,HelpLogic,game,params);
      }
   }
}
