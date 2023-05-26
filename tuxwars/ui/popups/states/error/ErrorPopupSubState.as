package tuxwars.ui.popups.states.error
{
   import com.dchoc.game.DCGame;
   import com.dchoc.states.State;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.error.ErrorPopUpLogic;
   import tuxwars.ui.popups.screen.error.ErrorPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class ErrorPopupSubState extends PopUpBaseSubState
   {
      
      public static const TYPE_ERROR:String = "TypeError";
       
      
      public function ErrorPopupSubState(game:DCGame, params:* = null)
      {
         super("TypeError",game,ErrorPopUpScreen,ErrorPopUpLogic,AssetsData.getPopupAssets(),params);
      }
      
      override public function forcePopup() : Boolean
      {
         return true;
      }
      
      override public function allowStateChange(nextState:State) : Boolean
      {
         return false;
      }
   }
}
