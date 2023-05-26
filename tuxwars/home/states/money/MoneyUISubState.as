package tuxwars.home.states.money
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.money.MoneyLogic;
   import tuxwars.home.ui.screen.money.MoneyScreenCash;
   import tuxwars.home.ui.screen.money.MoneyScreenCoins;
   
   public class MoneyUISubState extends TuxUIState
   {
       
      
      public function MoneyUISubState(game:TuxWarsGame, params:* = null)
      {
         var _loc3_:Class = params == "popup_get_cash_new" ? MoneyScreenCash : MoneyScreenCoins;
         super(_loc3_,MoneyLogic,game,params);
      }
   }
}
