package tuxwars.home.states.customgame
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.customgame.*;
   import tuxwars.home.ui.screen.customgame.*;
   
   public class CustomGameUISubState extends TuxUIState
   {
      public function CustomGameUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(CustomGameScreen,CustomGameLogic,param1,param2);
      }
   }
}

