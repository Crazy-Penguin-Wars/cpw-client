package tuxwars.states.tutorial
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import tuxwars.TuxWarsGame;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxTutorialOpponentsTurnSubState extends TuxTutorialSubState
   {
       
      
      public function TuxTutorialOpponentsTurnSubState(game:TuxWarsGame)
      {
         super(game,null);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.addListener("PlayerTurnStarted",playerTurnStarted);
      }
      
      override public function exit() : void
      {
         MessageCenter.removeListener("PlayerTurnStarted",playerTurnStarted);
         super.exit();
      }
      
      private function playerTurnStarted(msg:Message) : void
      {
         if(msg.data.id == tuxGame.player.id)
         {
            tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.setEnabled(true);
            Tutorial.saveTutorialStep("TutorialOpponentsTurn",false);
            parent.changeState(new TuxTutorialChangeWeaponSubState(tuxGame));
         }
         else
         {
            setText(ProjectManager.getText("TUTORIAL_OPPONENTS_TURN"));
            addTutorialArrow("top",tuxGame.battleState.hud.screen.bottomElement.design.Container_Arrow);
         }
      }
   }
}
