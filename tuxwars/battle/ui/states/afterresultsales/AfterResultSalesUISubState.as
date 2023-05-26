package tuxwars.battle.ui.states.afterresultsales
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.logic.afterresultsales.AfterResultSalesLogic;
   import tuxwars.battle.ui.screen.afterresultsales.AfterResultSalesScreen;
   import tuxwars.home.states.TuxUIState;
   
   public class AfterResultSalesUISubState extends TuxUIState
   {
       
      
      public function AfterResultSalesUISubState(game:TuxWarsGame, params:* = null)
      {
         super(AfterResultSalesScreen,AfterResultSalesLogic,game,params);
      }
   }
}
