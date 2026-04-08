package tuxwars.states.tutorial
{
   import com.dchoc.ui.events.UIButtonEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.net.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialChangeWeaponSubState extends TuxTutorialSubState
   {
      public function TuxTutorialChangeWeaponSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_CHANGE_WEAPON");
      }
      
      override public function enter() : void
      {
         super.enter();
         BattleManager.getSimulation().pause();
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(false);
         addTutorialArrow("top",tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.getDesignMovieClip());
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.addEventListener("clicked",this.weaponButtonClicked,false,0,true);
      }
      
      override public function exit() : void
      {
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(true);
         super.exit();
      }
      
      private function weaponButtonClicked(param1:UIButtonEvent) : void
      {
         Tutorial.saveTutorialStep("TutorialChangeWeapon",false);
         CRMService.sendEvent("Tutorial","PlayTutorial._tutorial","Clicked","ChangeWeapon");
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.removeEventListener("clicked",this.weaponButtonClicked);
         parent.changeState(new TuxTutorialBuyWeaponSubState(tuxGame));
      }
   }
}

