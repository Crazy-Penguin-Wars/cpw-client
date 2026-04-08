package tuxwars.home.ui.logic.privategame.host
{
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.home.states.privategame.host.*;
   import tuxwars.home.ui.logic.privategame.PrivateGameLogic;
   import tuxwars.states.TuxState;
   
   public class HostPrivateGameLogic extends PrivateGameLogic
   {
      public function HostPrivateGameLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
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

