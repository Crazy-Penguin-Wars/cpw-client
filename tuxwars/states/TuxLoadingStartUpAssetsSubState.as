package tuxwars.states
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.tutorial.*;
   
   public class TuxLoadingStartUpAssetsSubState extends TuxBatchLoadingState
   {
      public function TuxLoadingStartUpAssetsSubState(param1:TuxWarsGame)
      {
         super(param1,!!Tutorial._tutorial ? AssetsData.getStartUpTutorialAssets() : AssetsData.getStartUpAssets());
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new TuxLoadingFinishedSubState(tuxGame));
      }
   }
}

