package tuxwars.battle.ui.states.couponfound
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class CouponFoundLoadAssetsSubState extends TuxBatchLoadingState
   {
       
      
      public function CouponFoundLoadAssetsSubState(game:DCGame, params:* = null)
      {
         super(game,AssetsData.getPopupAssets(),params);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new CouponFoundUISubState(tuxGame,params));
      }
   }
}
