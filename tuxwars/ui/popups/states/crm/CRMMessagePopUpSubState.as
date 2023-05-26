package tuxwars.ui.popups.states.crm
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.crm.CRMMessagePopUpLogic;
   import tuxwars.ui.popups.logic.crm.CRMPopUpData;
   import tuxwars.ui.popups.screen.crm.CRMMessagePopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class CRMMessagePopUpSubState extends PopUpBaseSubState
   {
      
      public static const TYPE_CRM:String = "TypeCRM";
       
      
      public function CRMMessagePopUpSubState(game:TuxWarsGame, params:CRMPopUpData)
      {
         super("TypeCRM",game,CRMMessagePopUpScreen,CRMMessagePopUpLogic,AssetsData.getMessagePopupAssets(),params);
      }
   }
}
