package tuxwars.ui.popups.states.wrongversion
{
   import com.dchoc.game.DCGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.wrongversion.WrongVersionPopUpLogic;
   import tuxwars.ui.popups.screen.wrongversion.WrongVersionPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class WrongVersionPopupSubState extends PopUpBaseSubState
   {
      
      public static const WRONG_VERSION_ERROR:String = "WrongVersionError";
       
      
      public function WrongVersionPopupSubState(game:DCGame, params:* = null)
      {
         super("WrongVersionError",game,WrongVersionPopUpScreen,WrongVersionPopUpLogic,AssetsData.getPopupAssets(),params);
      }
      
      override public function forcePopup() : Boolean
      {
         return true;
      }
   }
}
