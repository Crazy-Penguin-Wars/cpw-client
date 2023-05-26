package tuxwars.home.states.privategame.host
{
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PrivateGameModel;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.privategame.host.HostPrivateGameLogic;
   import tuxwars.home.ui.screen.privategame.host.HostPrivateGameScreen;
   
   public class HostPrivateGameUIState extends TuxUIState
   {
       
      
      public function HostPrivateGameUIState(game:TuxWarsGame, gameModel:PrivateGameModel)
      {
         super(HostPrivateGameScreen,HostPrivateGameLogic,game,gameModel);
      }
   }
}
