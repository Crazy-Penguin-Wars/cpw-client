package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.tournament.TournamentLogic;
   import tuxwars.home.ui.screen.tournament.TournamentScreen;
   
   public class TournamentUISubState extends TuxUIState
   {
       
      
      public function TournamentUISubState(game:TuxWarsGame, params:* = null)
      {
         super(TournamentScreen,TournamentLogic,game,params);
      }
   }
}
