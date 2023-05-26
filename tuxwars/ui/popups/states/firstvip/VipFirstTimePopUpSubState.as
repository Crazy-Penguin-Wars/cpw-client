package tuxwars.ui.popups.states.firstvip
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.firstvip.VipFirstTimePopUpLogic;
   import tuxwars.ui.popups.screen.firstvip.VipFirstTimePopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class VipFirstTimePopUpSubState extends PopUpBaseSubState
   {
      
      public static const TYPE:String = "MessageType";
       
      
      public function VipFirstTimePopUpSubState(game:TuxWarsGame, params:* = null)
      {
         super("MessageType",game,VipFirstTimePopUpScreen,VipFirstTimePopUpLogic,AssetsData.getMessagePopupAssets(),params);
      }
   }
}
