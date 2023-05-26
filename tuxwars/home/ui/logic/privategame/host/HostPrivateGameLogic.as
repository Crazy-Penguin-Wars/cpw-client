package tuxwars.home.ui.logic.privategame.host
{
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.messages.control.StartGameMessage;
   import tuxwars.home.states.privategame.host.HostPrivateGameSettingsSubState;
   import tuxwars.home.ui.logic.privategame.PrivateGameLogic;
   import tuxwars.states.TuxState;
   
   public class HostPrivateGameLogic extends PrivateGameLogic
   {
       
      
      public function HostPrivateGameLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function showSettings() : void
      {
         state.parent.changeState(new HostPrivateGameSettingsSubState(game,gameModel));
      }
      
      public function play() : void
      {
         MessageCenter.sendEvent(new StartGameMessage());
      }
   }
}
