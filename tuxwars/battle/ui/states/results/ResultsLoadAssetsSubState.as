package tuxwars.battle.ui.states.results
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class ResultsLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function ResultsLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getResultsAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new ResultsUISubState(tuxGame,params));
      }
   }
}
