package tuxwars.battle.ui.states.afterresultsales
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class AfterResultSalesLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function AfterResultSalesLoadAssetsSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,AssetsData.getPopupAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new AfterResultSalesUISubState(tuxGame,params));
      }
   }
}

