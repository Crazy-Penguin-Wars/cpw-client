package tuxwars.states
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxLoadingStartUpAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function TuxLoadingStartUpAssetsSubState(game:TuxWarsGame)
      {
         var _loc2_:Tutorial = Tutorial;
         super(game,!!tuxwars.tutorial.Tutorial._tutorial ? AssetsData.getStartUpTutorialAssets() : AssetsData.getStartUpAssets());
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new TuxLoadingFinishedSubState(tuxGame));
      }
   }
}
