package tuxwars.ui.popups.logic.battlelock
{
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.data.PopUpData;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.message.MessagePopUpLogic;
   
   public class BattleLockMessagePopUpLogic extends MessagePopUpLogic
   {
      
      private static const TABLE:String = "PopupData";
      
      private static const PICTURE:String = "Picture";
       
      
      public function BattleLockMessagePopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function get headerText() : String
      {
         return ProjectManager.getText("BATTLE_LOCK_POP_UP_HEADER_TEXT");
      }
      
      override public function get messageText() : String
      {
         return ProjectManager.getText("BATTLE_LOCK_POP_UP_MESSAGE_TEXT");
      }
      
      override public function get picture() : String
      {
         return PopUpData.getPicture("errorpopup_1");
      }
   }
}
