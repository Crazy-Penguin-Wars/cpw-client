package tuxwars.home.states.privategame.host
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.privategame.host.HostPrivateGameSettingsLogic;
   import tuxwars.home.ui.screen.privategame.host.HostPrivateGameSettingsScreen;
   
   public class HostPrivateGameSettingsSubState extends TuxUIState
   {
       
      
      public function HostPrivateGameSettingsSubState(game:TuxWarsGame, gameModel:PrivateGameModel)
      {
         super(HostPrivateGameSettingsScreen,HostPrivateGameSettingsLogic,game,gameModel);
      }
   }
}
