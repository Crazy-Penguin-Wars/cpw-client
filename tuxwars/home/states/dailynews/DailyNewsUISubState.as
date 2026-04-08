package tuxwars.home.states.dailynews
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.dailynews.*;
   import tuxwars.home.ui.screen.dailynews.*;
   
   public class DailyNewsUISubState extends TuxUIState
   {
      public function DailyNewsUISubState(param1:TuxWarsGame, param2:DailyNewsData)
      {
         super(DailyNewsScreen,DailyNewsLogic,param1,param2);
      }
   }
}

