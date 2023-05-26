package tuxwars.home.states.gifts
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class GiftLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function GiftLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getGiftScreenAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new GiftUISubState(tuxGame,params));
      }
   }
}
