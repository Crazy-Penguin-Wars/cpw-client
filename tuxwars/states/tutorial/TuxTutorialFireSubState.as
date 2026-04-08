package tuxwars.states.tutorial
{
   import com.dchoc.messages.*;
   import com.dchoc.projectdata.*;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialFireSubState extends TuxTutorialSubState
   {
      public function TuxTutorialFireSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_FIRE");
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:UIButton = tuxGame.battleState.hud.screen.controlsElement.weaponButton;
         addTutorialArrow("top",_loc1_.getDesignMovieClip());
         _loc1_.addEventListener("clicked",this.weaponButtonClicked,false,0,true);
         MessageCenter.addListener("PlayerFired",this.playerFired);
      }
      
      private function weaponButtonClicked(param1:UIButtonEvent) : void
      {
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","SelectWeapon","Bazooka");
         removeTutorialArrow();
         addTutorialArrow("top",BattleManager.getOpponents()[0].container);
         setText(ProjectManager.getText("TUTORIAL_AIM"));
      }
      
      private function playerFired(param1:Message) : void
      {
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","ShootEnemy","Shoot");
         MessageCenter.removeListener("PlayerFired",this.playerFired);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.removeEventListener("clicked",this.weaponButtonClicked);
         BattleManager.getCurrentActivePlayer().weapon.controls.showPowerBar(false);
         Tutorial.saveTutorialStep("TutorialFired",false);
         BattleManager.getSimulation().resume();
         parent.changeState(new TuxTutorialChangeBoosterSubState(tuxGame));
      }
   }
}

