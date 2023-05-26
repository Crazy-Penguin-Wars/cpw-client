package tuxwars.home.states.customgame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.customgame.CustomGameLogic;
   import tuxwars.home.ui.screen.customgame.CustomGameScreen;
   
   public class CustomGameUISubState extends TuxUIState
   {
       
      
      public function CustomGameUISubState(game:TuxWarsGame, params:* = null)
      {
         super(CustomGameScreen,CustomGameLogic,game,params);
      }
   }
}
