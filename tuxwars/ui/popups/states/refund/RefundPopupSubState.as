package tuxwars.ui.popups.states.refund
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.PopUpBaseLogic;
   import tuxwars.ui.popups.screen.refund.RefundPopupScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class RefundPopupSubState extends PopUpBaseSubState
   {
       
      
      public function RefundPopupSubState(game:DCGame, params:* = null)
      {
         super("TypeInformation",game,RefundPopupScreen,PopUpBaseLogic,AssetsData.getPopupAssets(),params);
      }
   }
}
