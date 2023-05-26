package tuxwars.battle.ui.states.afterresultsales
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class AfterResultSalesState extends TuxState
   {
       
      
      public function AfterResultSalesState(game:TuxWarsGame, params:* = null)
      {
         super(game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new AfterResultSalesLoadAssetsSubState(tuxGame,params));
      }
   }
}
