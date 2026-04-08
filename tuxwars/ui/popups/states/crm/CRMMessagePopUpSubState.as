package tuxwars.ui.popups.states.crm
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.crm.*;
   import tuxwars.ui.popups.screen.crm.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class CRMMessagePopUpSubState extends PopUpBaseSubState
   {
      public static const TYPE_CRM:String = "TypeCRM";
      
      public function CRMMessagePopUpSubState(param1:TuxWarsGame, param2:CRMPopUpData)
      {
         super("TypeCRM",param1,CRMMessagePopUpScreen,CRMMessagePopUpLogic,AssetsData.getMessagePopupAssets(),param2);
      }
   }
}

