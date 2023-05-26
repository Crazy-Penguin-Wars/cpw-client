package tuxwars.home.states.vipend
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.home.ui.logic.vipend.VipEndPopUpLogic;
   import tuxwars.home.ui.screen.vipend.VipEndPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class VipEndPopupSubState extends PopUpBaseSubState
   {
       
      
      public function VipEndPopupSubState(game:DCGame)
      {
         super("MessageType",game,VipEndPopUpScreen,VipEndPopUpLogic,AssetsData.getPopupAssets());
      }
      
      override public function forcePopup() : Boolean
      {
         return true;
      }
   }
}
