package tuxwars.home.states.dailynews
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.dailynews.DailyNewsData;
   import tuxwars.home.ui.logic.dailynews.DailyNewsLogic;
   import tuxwars.home.ui.screen.dailynews.DailyNewsScreen;
   
   public class DailyNewsUISubState extends TuxUIState
   {
       
      
      public function DailyNewsUISubState(game:TuxWarsGame, dailyNewsData:DailyNewsData)
      {
         super(DailyNewsScreen,DailyNewsLogic,game,dailyNewsData);
      }
   }
}
