package tuxwars.battle.ui.states.afterresultsales
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class AfterResultSalesLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function AfterResultSalesLoadAssetsSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,AssetsData.getPopupAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new AfterResultSalesUISubState(tuxGame,params));
      }
   }
}
