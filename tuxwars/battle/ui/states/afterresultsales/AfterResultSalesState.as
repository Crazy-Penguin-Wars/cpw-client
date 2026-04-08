package tuxwars.battle.ui.states.afterresultsales
{
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class AfterResultSalesState extends TuxState
   {
      public function AfterResultSalesState(param1:TuxWarsGame, param2:* = null)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new AfterResultSalesLoadAssetsSubState(tuxGame,params));
      }
   }
}

