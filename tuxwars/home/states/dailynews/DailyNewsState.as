package tuxwars.home.states.dailynews
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.dailynews.DailyNewsData;
   import tuxwars.states.TuxState;
   
   public class DailyNewsState extends TuxState
   {
       
      
      public function DailyNewsState(game:TuxWarsGame, dailyNewsData:DailyNewsData)
      {
         super(game,dailyNewsData);
      }
      
      override public function enter() : void
      {
         super.enter();
         changeState(new DailyNewsLoadAssetsSubState(tuxGame,params));
      }
   }
}
