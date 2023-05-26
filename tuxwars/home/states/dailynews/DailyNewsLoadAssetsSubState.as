package tuxwars.home.states.dailynews
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.home.ui.logic.dailynews.DailyNewsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class DailyNewsLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function DailyNewsLoadAssetsSubState(game:DCGame, dailyNewsData:DailyNewsData)
      {
         super(game,AssetsData.getDailyNewsAssets(),dailyNewsData);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new DailyNewsUISubState(tuxGame,params));
      }
   }
}
