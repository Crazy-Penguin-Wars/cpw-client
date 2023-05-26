package tuxwars.ui.popups.states.serverconnectionfailed
{
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.serverconnectionfailed.ServerConnectionFailedMessagePopUpLogic;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class ServerConnectionFailedMessagePopUpSubState extends MessagePopUpSubState
   {
       
      
      public function ServerConnectionFailedMessagePopUpSubState(game:TuxWarsGame)
      {
         super(game,ServerConnectionFailedMessagePopUpLogic);
      }
   }
}
