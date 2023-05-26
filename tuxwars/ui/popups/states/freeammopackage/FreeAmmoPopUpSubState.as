package tuxwars.ui.popups.states.freeammopackage
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.freeammopackage.FreeAmmoPopUpLogic;
   import tuxwars.ui.popups.screen.freeammopackage.FreeAmmoPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class FreeAmmoPopUpSubState extends PopUpBaseSubState
   {
      
      public static const TYPE:String = "MessageType";
       
      
      public function FreeAmmoPopUpSubState(game:TuxWarsGame, params:* = null)
      {
         super("MessageType",game,FreeAmmoPopUpScreen,FreeAmmoPopUpLogic,AssetsData.getMessagePopupAssets(),params);
      }
   }
}
