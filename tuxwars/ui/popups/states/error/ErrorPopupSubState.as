package tuxwars.ui.popups.states.error
{
   import com.dchoc.game.DCGame;
   import com.dchoc.states.State;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.error.*;
   import tuxwars.ui.popups.screen.error.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class ErrorPopupSubState extends PopUpBaseSubState
   {
      public static const TYPE_ERROR:String = "TypeError";
      
      public function ErrorPopupSubState(param1:DCGame, param2:* = null)
      {
         super("TypeError",param1,ErrorPopUpScreen,ErrorPopUpLogic,AssetsData.getPopupAssets(),param2);
      }
      
      override public function forcePopup() : Boolean
      {
         return true;
      }
      
      override public function allowStateChange(param1:State) : Boolean
      {
         return false;
      }
   }
}

