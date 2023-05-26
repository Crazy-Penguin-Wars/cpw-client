package tuxwars.states.tutorial
{
   import com.dchoc.game.DCGame;
   import tuxwars.TuxWarsGame;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxTutorialMatchTimerSubState extends TuxTutorialSubState
   {
       
      
      private var startTime:int;
      
      public function TuxTutorialMatchTimerSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_MATCH_TIMER");
      }
      
      override public function enter() : void
      {
         super.enter();
         addTutorialArrow("bottom",tuxGame.battleState.hud.screen.topLeftElement.design.Container_Arrow);
         startTime = DCGame.getTime();
      }
      
      override public function exit() : void
      {
         Tutorial.saveTutorialStep("TutorialMatchTimer",false);
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(true);
         super.exit();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         if(DCGame.getTime() - startTime > 7000)
         {
            parent.exitCurrentState();
            startTime = DCGame.getTime();
         }
      }
   }
}
