package tuxwars.ui.popups.states.serverconnectionfailed
{
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.serverconnectionfailed.*;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class ServerConnectionFailedMessagePopUpSubState extends MessagePopUpSubState
   {
      public function ServerConnectionFailedMessagePopUpSubState(param1:TuxWarsGame)
      {
         super(param1,ServerConnectionFailedMessagePopUpLogic);
      }
   }
}

