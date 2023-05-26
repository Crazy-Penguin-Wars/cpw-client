package tuxwars.home.states.neighbors
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class NeighborLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function NeighborLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getNeighborScreenAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new NeighborUISubState(tuxGame));
      }
   }
}
