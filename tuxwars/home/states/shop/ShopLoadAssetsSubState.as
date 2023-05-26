package tuxwars.home.states.shop
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class ShopLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function ShopLoadAssetsSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,AssetsData.getShopAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new ShopUISubState(tuxGame,params));
      }
   }
}
