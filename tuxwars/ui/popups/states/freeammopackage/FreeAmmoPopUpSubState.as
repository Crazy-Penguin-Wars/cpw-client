package tuxwars.ui.popups.states.freeammopackage
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.freeammopackage.*;
   import tuxwars.ui.popups.screen.freeammopackage.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class FreeAmmoPopUpSubState extends PopUpBaseSubState
   {
      public static const TYPE:String = "MessageType";
      
      public function FreeAmmoPopUpSubState(param1:TuxWarsGame, param2:* = null)
      {
         super("MessageType",param1,FreeAmmoPopUpScreen,FreeAmmoPopUpLogic,AssetsData.getMessagePopupAssets(),param2);
      }
   }
}

