package tuxwars.home.states.crafting
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class CraftingLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function CraftingLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getCraftingAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new CraftingUISubState(tuxGame));
      }
   }
}
