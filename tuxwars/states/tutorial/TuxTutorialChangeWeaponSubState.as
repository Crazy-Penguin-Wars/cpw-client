package tuxwars.states.tutorial
{
   import com.dchoc.ui.events.UIButtonEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxTutorialChangeWeaponSubState extends TuxTutorialSubState
   {
       
      
      public function TuxTutorialChangeWeaponSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_CHANGE_WEAPON");
      }
      
      override public function enter() : void
      {
         super.enter();
         BattleManager.getSimulation().pause();
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(false);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(false);
         addTutorialArrow("top",tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.getDesignMovieClip());
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.addEventListener("clicked",weaponButtonClicked,false,0,true);
      }
      
      override public function exit() : void
      {
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.moveButton.setEnabled(true);
         super.exit();
      }
      
      private function weaponButtonClicked(event:UIButtonEvent) : void
      {
         Tutorial.saveTutorialStep("TutorialChangeWeapon",false);
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","ChangeWeapon");
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.removeEventListener("clicked",weaponButtonClicked);
         parent.changeState(new TuxTutorialBuyWeaponSubState(tuxGame));
      }
   }
}
