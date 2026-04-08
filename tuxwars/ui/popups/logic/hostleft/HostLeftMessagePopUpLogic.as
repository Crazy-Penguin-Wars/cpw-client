package tuxwars.ui.popups.logic.hostleft
{
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   
   public class HostLeftMessagePopUpLogic extends MessagePopUpLogic
   {
      public function HostLeftMessagePopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function get headerText() : String
      {
         return ProjectManager.getText("HOST_LEFT_LOBBY_HEADER");
      }
      
      override public function get messageText() : String
      {
         return ProjectManager.getText("HOST_LEFT_LOBBY_TEXT");
      }
   }
}

