package tuxwars.home.states.tournament
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.tournament.TournamentEndLogic;
   import tuxwars.home.ui.screen.tournament.TournamentEndScreen;
   
   public class TournamentEndUISubState extends TuxUIState
   {
       
      
      public function TournamentEndUISubState(game:TuxWarsGame, params:* = null)
      {
         super(TournamentEndScreen,TournamentEndLogic,game,params);
      }
   }
}
