package tuxwars.home.states.dailynews
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.dailynews.DailyNewsData;
   import tuxwars.states.TuxState;
   
   public class DailyNewsState extends TuxState
   {
      public function DailyNewsState(param1:TuxWarsGame, param2:DailyNewsData)
      {
         super(param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new DailyNewsLoadAssetsSubState(tuxGame,params));
      }
   }
}

