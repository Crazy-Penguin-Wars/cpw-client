package tuxwars.home.states.privategame.join
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.privategame.join.*;
   import tuxwars.home.ui.screen.privategame.join.*;
   
   public class JoinPrivateGameUIState extends TuxUIState
   {
      public function JoinPrivateGameUIState(param1:TuxWarsGame, param2:* = null)
      {
         super(JoinPrivateGameScreen,JoinPrivateGameLogic,param1,param2);
      }
   }
}

