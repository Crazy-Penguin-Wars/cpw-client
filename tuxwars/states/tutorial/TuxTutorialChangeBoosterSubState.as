package tuxwars.states.tutorial
{
   import com.dchoc.ui.events.UIButtonEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialChangeBoosterSubState extends TuxTutorialSubState
   {
      public function TuxTutorialChangeBoosterSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_CHANGE_BOOSTER");
      }
      
      override public function enter() : void
      {
         super.enter();
         BattleManager.getSimulation().pause();
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(false);
         addTutorialArrow("top",tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.getDesignMovieClip());
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.addEventListener("clicked",this.boosterButtonClicked,false,0,true);
      }
      
      override public function exit() : void
      {
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(true);
         super.exit();
      }
      
      private function boosterButtonClicked(param1:UIButtonEvent) : void
      {
         Tutorial.saveTutorialStep("TutorialChangeBooster",false);
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","ChangeBooster");
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.removeEventListener("clicked",this.boosterButtonClicked);
         parent.changeState(new TuxTutorialBuyBoosterSubState(tuxGame));
      }
   }
}

