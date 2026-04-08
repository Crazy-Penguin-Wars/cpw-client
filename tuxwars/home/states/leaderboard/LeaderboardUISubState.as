package tuxwars.home.states.leaderboard
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.leaderboard.*;
   import tuxwars.home.ui.screen.leaderboard.*;
   
   public class LeaderboardUISubState extends TuxUIState
   {
      public function LeaderboardUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(LeaderboardScreen,LeaderboardLogic,param1,param2);
      }
   }
}

