package tuxwars.home.states.vip
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class VIPLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function VIPLoadAssetsSubState(game:TuxWarsGame, params:* = null)
      {
         super(game,AssetsData.getVIPAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new VIPUISubState(tuxGame));
      }
   }
}
