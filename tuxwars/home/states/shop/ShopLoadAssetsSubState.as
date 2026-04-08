package tuxwars.home.states.shop
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class ShopLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function ShopLoadAssetsSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,AssetsData.getShopAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new ShopUISubState(tuxGame,params));
      }
   }
}

