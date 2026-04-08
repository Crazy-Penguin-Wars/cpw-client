package tuxwars.ui.popups.logic.exitquestion
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.net.messages.control.*;
   import tuxwars.home.states.homestate.*;
   import tuxwars.net.*;
   import tuxwars.states.TuxState;
   import tuxwars.tutorial.*;
   import tuxwars.ui.popups.logic.question.QuestionPopUpLogic;
   
   public class ExitQuestionPopUpLogic extends QuestionPopUpLogic
   {
      public function ExitQuestionPopUpLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function get headerText() : String
      {
         return ProjectManager.getText("EXIT_MATCH_HEADER");
      }
      
      override public function get messageText() : String
      {
         return !!BattleManager.isPracticeMode() ? ProjectManager.getText("EXIT_MATCH_MESSAGE_PRACTICE") : ProjectManager.getText("EXIT_MATCH_MESSAGE");
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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(!BattleManager.isPracticeMode())
         {
            if(Tutorial._tutorial)
            {
               CRMService.sendEvent("Tutorial","Battle_Ended","Confirmed","PressExit");
            }
            else
            {
               CRMService.sendEvent("Game","Battle_Ended","Confirmed","PressExit");
               CRMService.sendEvent("Game","Battle_Ended","Starting position","Exit","" + game.tuxWorld.getIndexOfPlayerWithId(game.player.id));
               _loc1_ = 0;
               _loc2_ = int(BattleManager.getMatchTimeUsed());
               _loc1_ = 0;
               while(_loc1_ <= _loc2_ + 5000)
               {
                  if(_loc1_ > _loc2_)
                  {
                     CRMService.sendEvent("Game","Battle_Ended","Played time","Exit",(_loc1_ / 1000 - 5).toString() + "-" + (_loc1_ / 1000).toString());
                  }
                  _loc1_ += 5000;
               }
            }
         }
         MessageCenter.sendEvent(new ChickeningOutMessage(game.player.id,2));
         MessageCenter.sendMessage("Exits",game.player);
         game.changeState(new HomeState(game));
      }
   }
}

