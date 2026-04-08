package tuxwars.home.states.vipend
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.home.ui.logic.vipend.*;
   import tuxwars.home.ui.screen.vipend.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class VipEndPopupSubState extends PopUpBaseSubState
   {
      public function VipEndPopupSubState(param1:DCGame)
      {
         super("MessageType",param1,VipEndPopUpScreen,VipEndPopUpLogic,AssetsData.getPopupAssets());
      }
      
      override public function forcePopup() : Boolean
      {
         return true;
      }
   }
}

