package tuxwars.home.states.money
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.money.*;
   import tuxwars.home.ui.screen.money.*;
   
   public class MoneyUISubState extends TuxUIState
   {
      public function MoneyUISubState(param1:TuxWarsGame, param2:* = null)
      {
         var _loc3_:Class = param2 == "popup_get_cash_new" ? MoneyScreenCash : MoneyScreenCoins;
         super(_loc3_,MoneyLogic,param1,param2);
      }
   }
}

