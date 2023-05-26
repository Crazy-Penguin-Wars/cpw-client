package tuxwars.ui.popups.logic.confirmbattleend.timeout
{
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   
   public class TimeOutMessagePopUpLogic extends MessagePopUpLogic
   {
       
      
      public function TimeOutMessagePopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function get headerText() : String
      {
         return ProjectManager.getText("TIMEOUT_ERROR_TITLE");
      }
      
      override public function get messageText() : String
      {
         return ProjectManager.getText("TIMEOUT_ERROR_MESSAGE");
      }
   }
}
