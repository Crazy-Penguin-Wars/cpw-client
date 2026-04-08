package tuxwars.ui.popups.states.refund
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.*;
   import tuxwars.ui.popups.screen.refund.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class RefundPopupSubState extends PopUpBaseSubState
   {
      public function RefundPopupSubState(param1:DCGame, param2:* = null)
      {
         super("TypeInformation",param1,RefundPopupScreen,PopUpBaseLogic,AssetsData.getPopupAssets(),param2);
      }
   }
}

