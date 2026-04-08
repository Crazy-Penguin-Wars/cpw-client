package tuxwars.states
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   
   public class TuxLoadingStartUpSharedAssetsSubState extends TuxBatchLoadingState
   {
      public function TuxLoadingStartUpSharedAssetsSubState(param1:DCGame)
      {
         super(param1,AssetsData.getStartUpSharedAssets());
      }
      
      override protected function assetsLoaded() : void
      {
         TuxLoadingState(parent).sharedAssetsLoaded();
         parent.changeState(new TuxLoadingStartUpAssetsSubState(tuxGame));
      }
   }
}

