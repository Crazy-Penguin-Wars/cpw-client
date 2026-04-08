package tuxwars.ui.popups.states.nomoney
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.*;
   import tuxwars.ui.popups.logic.nomoney.*;
   import tuxwars.ui.popups.screen.nomoney.*;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class NoMoneyPopUpSubState extends PopUpBaseSubState
   {
      public static const TYPE_NO_MONEY:String = "TypeNoMoney";
      
      public function NoMoneyPopUpSubState(param1:TuxWarsGame, param2:* = null)
      {
         super("TypeNoMoney",param1,NoMoneyPopUpScreen,NoMoneyPopUpLogic,AssetsData.getPopupAssets(),param2);
      }
   }
}

