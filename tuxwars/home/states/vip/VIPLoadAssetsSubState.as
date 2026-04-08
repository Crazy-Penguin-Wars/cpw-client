package tuxwars.home.states.vip
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class VIPLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function VIPLoadAssetsSubState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,AssetsData.getVIPAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new VIPUISubState(tuxGame));
      }
   }
}

