package tuxwars.home.states.matchloading
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.screen.matchloading.MatchLoadingScreen;
   
   public class MatchLoadingUISubState extends TuxUIState
   {
       
      
      public function MatchLoadingUISubState(game:TuxWarsGame, logicClass:Class, params:* = null)
      {
         super(MatchLoadingScreen,logicClass,game,params);
      }
   }
}
