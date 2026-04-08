package tuxwars.battle.ui.states.afterresultsales
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.afterresultsales.*;
   import tuxwars.battle.ui.screen.afterresultsales.*;
   import tuxwars.home.states.TuxUIState;
   
   public class AfterResultSalesUISubState extends TuxUIState
   {
      public function AfterResultSalesUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(AfterResultSalesScreen,AfterResultSalesLogic,param1,param2);
      }
   }
}

