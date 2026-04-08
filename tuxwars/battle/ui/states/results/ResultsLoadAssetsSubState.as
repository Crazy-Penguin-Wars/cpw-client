package tuxwars.battle.ui.states.results
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class ResultsLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function ResultsLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getResultsAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new ResultsUISubState(tuxGame,params));
      }
   }
}

