package tuxwars.home.states.leaderboard
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class LeaderboardLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function LeaderboardLoadAssetsSubState(param1:TuxWarsGame, param2:* = null)
      {
         var _loc3_:AssetsData = AssetsData;
         super(param1,new AssetsData("LeaderboardScreen"),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.exitCurrentState();
      }
   }
}

