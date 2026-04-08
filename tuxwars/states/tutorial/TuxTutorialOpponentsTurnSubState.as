package tuxwars.states.tutorial
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialOpponentsTurnSubState extends TuxTutorialSubState
   {
      public function TuxTutorialOpponentsTurnSubState(param1:TuxWarsGame)
      {
         super(param1,null);
      }
      
      override public function enter() : void
      {
         super.enter();
         MessageCenter.addListener("PlayerTurnStarted",this.playerTurnStarted);
      }
      
      override public function exit() : void
      {
         MessageCenter.removeListener("PlayerTurnStarted",this.playerTurnStarted);
         super.exit();
      }
      
      private function playerTurnStarted(param1:Message) : void
      {
         if(param1.data.id == tuxGame.player.id)
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

