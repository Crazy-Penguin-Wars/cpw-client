package tuxwars.home.states.crafting
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class CraftingLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function CraftingLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getCraftingAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new CraftingUISubState(tuxGame));
      }
   }
}

