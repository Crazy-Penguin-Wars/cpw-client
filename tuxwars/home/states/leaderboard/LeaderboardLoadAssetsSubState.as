package tuxwars.home.states.leaderboard
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class LeaderboardLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function LeaderboardLoadAssetsSubState(game:TuxWarsGame, params:* = null)
      {
         var _loc3_:AssetsData = AssetsData;
         super(game,new tuxwars.data.assets.AssetsData("LeaderboardScreen"),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.exitCurrentState();
      }
   }
}
