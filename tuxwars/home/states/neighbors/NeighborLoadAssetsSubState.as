package tuxwars.home.states.neighbors
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class NeighborLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function NeighborLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getNeighborScreenAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new NeighborUISubState(tuxGame));
      }
   }
}

