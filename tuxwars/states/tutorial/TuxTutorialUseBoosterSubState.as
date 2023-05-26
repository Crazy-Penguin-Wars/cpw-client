package tuxwars.states.tutorial
{
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.events.UIButtonEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.events.BoosterActivatedMessage;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxTutorialUseBoosterSubState extends TuxTutorialSubState
   {
       
      
      public function TuxTutorialUseBoosterSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_BOOST");
      }
      
      override public function enter() : void
      {
         super.enter();
         addTutorialArrow("top",tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.getDesignMovieClip());
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.addEventListener("clicked",boosterButtonClicked,false,0,true);
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.setEnabled(true);
         MessageCenter.addListener("BoosterActivated",playerBoosted);
      }
      
      private function boosterButtonClicked(event:UIButtonEvent) : void
      {
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","UseBooster","ShieldBoost");
         removeTutorialArrow();
         addTutorialArrow("top",BattleManager.getOpponents()[0].container);
         setText(ProjectManager.getText("TUTORIAL_AIM"));
      }
      
      private function playerBoosted(msg:BoosterActivatedMessage) : void
      {
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","UseBooster","ShieldBoost");
         MessageCenter.removeListener("BoosterActivated",playerBoosted);
         tuxGame.battleState.hud.screen.controlsElement.changeBoosterButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.boosterButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.boosterSelectedButton.removeEventListener("clicked",boosterButtonClicked);
         Tutorial.saveTutorialStep("TutorialUseBooster",false);
         BattleManager.getSimulation().resume();
         parent.changeState(new TuxTutorialOpponentsTurnSubState(tuxGame));
      }
   }
}
