package tuxwars.ui.popups.logic.serverconnectionfailed
{
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.*;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   
   public class ServerConnectionFailedMessagePopUpLogic extends MessagePopUpLogic
   {
      public function ServerConnectionFailedMessagePopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function get headerText() : String
      {
         return ProjectManager.getText("BATTLE_SERVER_CONNECTION_FAILED_POP_UP_HEADER_TEXT");
      }
      
      override public function get messageText() : String
      {
         return ProjectManager.getText("BATTLE_SERVER_CONNECTION_FAILED_POP_UP_MESSAGE_TEXT");
      }
      
      override public function get picture() : String
      {
         return PopUpData.getPicture("errorpopup_1");
      }
   }
}

