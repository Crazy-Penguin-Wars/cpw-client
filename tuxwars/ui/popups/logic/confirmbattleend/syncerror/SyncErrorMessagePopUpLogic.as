package tuxwars.ui.popups.logic.confirmbattleend.syncerror
{
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   import tuxwars.ui.popups.logic.confirmbattleend.ConfirmBattleEndPopUpLogic;
   
   public class SyncErrorMessagePopUpLogic extends ConfirmBattleEndPopUpLogic
   {
      public function SyncErrorMessagePopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
         showResultScreen = false;
      }
      
      override public function get headerText() : String
      {
         return ProjectManager.getText("DROP_OUT_OF_MATCH_TITLE");
      }
      
      override public function get messageText() : String
      {
         return ProjectManager.getText("DROP_OUT_OF_MATCH_MESSAGE");
      }
   }
}

