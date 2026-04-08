package tuxwars.home.states.gifts
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class GiftLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function GiftLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getGiftScreenAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new GiftUISubState(tuxGame,params));
      }
   }
}

