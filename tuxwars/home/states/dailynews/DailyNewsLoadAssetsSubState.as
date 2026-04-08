package tuxwars.home.states.dailynews
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.home.ui.logic.dailynews.DailyNewsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class DailyNewsLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function DailyNewsLoadAssetsSubState(param1:DCGame, param2:DailyNewsData)
      {
         super(param1,AssetsData.getDailyNewsAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new DailyNewsUISubState(tuxGame,params));
      }
   }
}

