package tuxwars.home.states.money
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class MoneyLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function MoneyLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getMoneyScreenAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new MoneyUISubState(tuxGame,params));
      }
   }
}

