package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.tournament.*;
   import tuxwars.home.ui.screen.tournament.*;
   
   public class TournamentEndUISubState extends TuxUIState
   {
      public function TournamentEndUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(TournamentEndScreen,TournamentEndLogic,param1,param2);
      }
   }
}

