package tuxwars.ui.popups.states.firstvip
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.firstvip.*;
   import tuxwars.ui.popups.screen.firstvip.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class VipFirstTimePopUpSubState extends PopUpBaseSubState
   {
      public static const TYPE:String = "MessageType";
      
      public function VipFirstTimePopUpSubState(param1:TuxWarsGame, param2:* = null)
      {
         super("MessageType",param1,VipFirstTimePopUpScreen,VipFirstTimePopUpLogic,AssetsData.getMessagePopupAssets(),param2);
      }
   }
}

