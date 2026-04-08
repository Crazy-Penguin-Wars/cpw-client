package tuxwars.home.states.customgame
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class CustomGameLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function CustomGameLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getCustomGameAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new CustomGameUISubState(tuxGame));
      }
   }
}

