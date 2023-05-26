package tuxwars.home.states.money
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class MoneyLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function MoneyLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getMoneyScreenAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new MoneyUISubState(tuxGame,params));
      }
   }
}
