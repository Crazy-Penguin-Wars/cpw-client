package tuxwars.states.tutorial
{
   import com.dchoc.ui.events.UIButtonEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxTutorialChangeBoosterSubState extends TuxTutorialSubState
   {
       
      
      public function TuxTutorialChangeBoosterSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_CHANGE_BOOSTER");
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
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.addEventListener("clicked",boosterButtonClicked,false,0,true);
      }
      
      override public function exit() : void
      {
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(true);
         super.exit();
      }
      
      private function boosterButtonClicked(event:UIButtonEvent) : void
      {
         Tutorial.saveTutorialStep("TutorialChangeBooster",false);
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","ChangeBooster");
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.removeEventListener("clicked",boosterButtonClicked);
         parent.changeState(new TuxTutorialBuyBoosterSubState(tuxGame));
      }
   }
}
