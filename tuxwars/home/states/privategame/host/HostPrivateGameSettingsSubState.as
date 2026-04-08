package tuxwars.home.states.privategame.host
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.privategame.host.*;
   import tuxwars.home.ui.screen.privategame.host.*;
   
   public class HostPrivateGameSettingsSubState extends TuxUIState
   {
      public function HostPrivateGameSettingsSubState(param1:TuxWarsGame, param2:PrivateGameModel)
      {
         super(HostPrivateGameSettingsScreen,HostPrivateGameSettingsLogic,param1,param2);
      }
   }
}

