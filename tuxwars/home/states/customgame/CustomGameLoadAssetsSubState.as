package tuxwars.home.states.customgame
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class CustomGameLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function CustomGameLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getCustomGameAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new CustomGameUISubState(tuxGame));
      }
   }
}
