package tuxwars.ui.popups.states.wrongversion
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.wrongversion.*;
   import tuxwars.ui.popups.screen.wrongversion.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class WrongVersionPopupSubState extends PopUpBaseSubState
   {
      public static const WRONG_VERSION_ERROR:String = "WrongVersionError";
      
      public function WrongVersionPopupSubState(param1:DCGame, param2:* = null)
      {
         super("WrongVersionError",param1,WrongVersionPopUpScreen,WrongVersionPopUpLogic,AssetsData.getPopupAssets(),param2);
      }
      
      override public function forcePopup() : Boolean
      {
         return true;
      }
   }
}

