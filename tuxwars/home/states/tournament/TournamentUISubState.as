package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.tournament.*;
   import tuxwars.home.ui.screen.tournament.*;
   
   public class TournamentUISubState extends TuxUIState
   {
      public function TournamentUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(TournamentScreen,TournamentLogic,param1,param2);
      }
   }
}

