package tuxwars.states.tutorial
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.events.UIButtonEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.events.BoosterActivatedMessage;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialUseBoosterSubState extends TuxTutorialSubState
   {
      public function TuxTutorialUseBoosterSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_BOOST");
      }
      
      override public function enter() : void
      {
         super.enter();
         addTutorialArrow("top",tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.getDesignMovieClip());
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.addEventListener("clicked",this.boosterButtonClicked,false,0,true);
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.setEnabled(true);
         MessageCenter.addListener("BoosterActivated",this.playerBoosted);
      }
      
      private function boosterButtonClicked(param1:UIButtonEvent) : void
      {
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","UseBooster","ShieldBoost");
         removeTutorialArrow();
         addTutorialArrow("top",BattleManager.getOpponents()[0].container);
         setText(ProjectManager.getText("TUTORIAL_AIM"));
      }
      
      private function playerBoosted(param1:BoosterActivatedMessage) : void
      {
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","UseBooster","ShieldBoost");
         MessageCenter.removeListener("BoosterActivated",this.playerBoosted);
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.boosterButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.removeEventListener("clicked",this.boosterButtonClicked);
         Tutorial.saveTutorialStep("TutorialUseBooster",false);
         BattleManager.getSimulation().resume();
         parent.changeState(new TuxTutorialOpponentsTurnSubState(tuxGame));
      }
   }
}

