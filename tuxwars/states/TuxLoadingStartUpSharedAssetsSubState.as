package tuxwars.states
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   
   public class TuxLoadingStartUpSharedAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function TuxLoadingStartUpSharedAssetsSubState(game:DCGame)
      {
         super(game,AssetsData.getStartUpSharedAssets());
      }
      
      override protected function assetsLoaded() : void
      {
         TuxLoadingState(parent).sharedAssetsLoaded();
         parent.changeState(new TuxLoadingStartUpAssetsSubState(tuxGame));
      }
   }
}
