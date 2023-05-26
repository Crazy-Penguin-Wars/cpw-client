package tuxwars.ui.popups.logic.serverconnectionfailed
{
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PopUpData;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   
   public class ServerConnectionFailedMessagePopUpLogic extends MessagePopUpLogic
   {
       
      
      public function ServerConnectionFailedMessagePopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
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
