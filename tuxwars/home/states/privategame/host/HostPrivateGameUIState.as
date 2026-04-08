package tuxwars.home.states.privategame.host
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.privategame.host.*;
   import tuxwars.home.ui.screen.privategame.host.*;
   
   public class HostPrivateGameUIState extends TuxUIState
   {
      public function HostPrivateGameUIState(param1:TuxWarsGame, param2:PrivateGameModel)
      {
         super(HostPrivateGameScreen,HostPrivateGameLogic,param1,param2);
      }
   }
}

