package tuxwars.home.states.leaderboard
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.leaderboard.LeaderboardLogic;
   import tuxwars.home.ui.screen.leaderboard.LeaderboardScreen;
   
   public class LeaderboardUISubState extends TuxUIState
   {
       
      
      public function LeaderboardUISubState(game:TuxWarsGame, params:* = null)
      {
         super(LeaderboardScreen,LeaderboardLogic,game,params);
      }
   }
}
