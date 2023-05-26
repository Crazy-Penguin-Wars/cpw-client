package tuxwars.states.tutorial
{
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import com.dchoc.projectdata.ProjectManager;
   import com.dchoc.ui.buttons.UIButton;
   import com.dchoc.ui.events.UIButtonEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.net.CRMService;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxTutorialFireSubState extends TuxTutorialSubState
   {
       
      
      public function TuxTutorialFireSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_FIRE");
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:UIButton = tuxGame.battleState.hud.screen.controlsElement.weaponButton;
         addTutorialArrow("top",_loc1_.getDesignMovieClip());
         _loc1_.addEventListener("clicked",weaponButtonClicked,false,0,true);
         MessageCenter.addListener("PlayerFired",playerFired);
      }
      
      private function weaponButtonClicked(event:UIButtonEvent) : void
      {
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","SelectWeapon","Bazooka");
         removeTutorialArrow();
         addTutorialArrow("top",BattleManager.getOpponents()[0].container);
         setText(ProjectManager.getText("TUTORIAL_AIM"));
      }
      
      private function playerFired(msg:Message) : void
      {
         CRMService.sendEvent("Tutorial","Play_Tutorial","Clicked","ShootEnemy","Shoot");
         MessageCenter.removeListener("PlayerFired",playerFired);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.removeEventListener("clicked",weaponButtonClicked);
         BattleManager.getCurrentActivePlayer().weapon.controls.showPowerBar(false);
         Tutorial.saveTutorialStep("TutorialFired",false);
         BattleManager.getSimulation().resume();
         parent.changeState(new TuxTutorialChangeBoosterSubState(tuxGame));
      }
   }
}
