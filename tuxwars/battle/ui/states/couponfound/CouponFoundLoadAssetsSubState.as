package tuxwars.battle.ui.states.couponfound
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.states.TuxBatchLoadingState;
   
   public class CouponFoundLoadAssetsSubState extends TuxBatchLoadingState
   {
      public function CouponFoundLoadAssetsSubState(param1:DCGame, param2:* = null)
      {
         super(param1,AssetsData.getPopupAssets(),param2);
      }
      
      override protected function assetsLoaded() : void
      {
         parent.changeState(new CouponFoundUISubState(tuxGame,params));
      }
   }
}

