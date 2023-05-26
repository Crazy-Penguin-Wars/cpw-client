package tuxwars.ui.popups.states.nomoney
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.assets.AssetsData;
   import tuxwars.ui.popups.logic.nomoney.NoMoneyPopUpLogic;
   import tuxwars.ui.popups.screen.nomoney.NoMoneyPopUpScreen;
   import tuxwars.ui.popups.states.PopUpBaseSubState;
   
   public class NoMoneyPopUpSubState extends PopUpBaseSubState
   {
      
      public static const TYPE_NO_MONEY:String = "TypeNoMoney";
       
      
      public function NoMoneyPopUpSubState(game:TuxWarsGame, params:* = null)
      {
         super("TypeNoMoney",game,NoMoneyPopUpScreen,NoMoneyPopUpLogic,AssetsData.getPopupAssets(),params);
      }
   }
}
