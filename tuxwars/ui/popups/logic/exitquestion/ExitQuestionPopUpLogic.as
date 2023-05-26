package tuxwars.ui.popups.logic.exitquestion
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.net.messages.control.ChickeningOutMessage;
   import tuxwars.home.states.homestate.HomeState;
   import tuxwars.net.CRMService;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.Tutorial;
   import tuxwars.ui.popups.logic.question.QuestionPopUpLogic;
   
   public class ExitQuestionPopUpLogic extends QuestionPopUpLogic
   {
       
      
      public function ExitQuestionPopUpLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function get headerText() : String
      {
         return ProjectManager.getText("EXIT_MATCH_HEADER");
      }
      
      override public function get messageText() : String
      {
         return BattleManager.isPracticeMode() ? ProjectManager.getText("EXIT_MATCH_MESSAGE_PRACTICE") : ProjectManager.getText("EXIT_MATCH_MESSAGE");
      }
      
      override public function get leftButtonText() : String
      {
         return ProjectManager.getText("BUTTON_CANCEL");
      }
      
      override public function get rightButtonText() : String
      {
         return ProjectManager.getText("BUTTON_OK");
      }
      
      override public function leftButtonPressed() : void
      {
         if(!BattleManager.isPracticeMode())
         {
            CRMService.sendEvent("Game","Battle_Ended","Cancelled","PressExit");
         }
         MessageCenter.sendEvent(new ChickeningOutMessage(game.player.id,0));
         close(game.battleState);
      }
      
      override public function rightButtonPressed() : void
      {
         var sortingTime:int = 0;
         var timeUsed:int = 0;
         if(!BattleManager.isPracticeMode())
         {
            var _loc3_:Tutorial = Tutorial;
            if(tuxwars.tutorial.Tutorial._tutorial)
            {
               CRMService.sendEvent("Tutorial","Battle_Ended","Confirmed","PressExit");
            }
            else
            {
               CRMService.sendEvent("Game","Battle_Ended","Confirmed","PressExit");
               CRMService.sendEvent("Game","Battle_Ended","Starting position","Exit","" + game.tuxWorld.getIndexOfPlayerWithId(game.player.id));
               sortingTime = 0;
               timeUsed = BattleManager.getMatchTimeUsed();
               for(sortingTime = 0; sortingTime <= timeUsed + 5000; )
               {
                  if(sortingTime > timeUsed)
                  {
                     CRMService.sendEvent("Game","Battle_Ended","Played time","Exit",(sortingTime / 1000 - 5).toString() + "-" + (sortingTime / 1000).toString());
                  }
                  sortingTime += 5000;
               }
            }
         }
         MessageCenter.sendEvent(new ChickeningOutMessage(game.player.id,2));
         MessageCenter.sendMessage("Exits",game.player);
         game.changeState(new HomeState(game));
      }
   }
}
