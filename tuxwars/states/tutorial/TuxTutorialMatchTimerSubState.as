package tuxwars.states.tutorial
{
   import com.dchoc.game.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialMatchTimerSubState extends TuxTutorialSubState
   {
      private var startTime:int;
      
      public function TuxTutorialMatchTimerSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_MATCH_TIMER");
      }
      
      override public function enter() : void
      {
         super.enter();
         addTutorialArrow("bottom",tuxGame.battleState.hud.screen.topLeftElement.design.Container_Arrow);
         this.startTime = DCGame.getTime();
      }
      
      override public function exit() : void
      {
         Tutorial.saveTutorialStep("TutorialMatchTimer",false);
         tuxGame.battleState.hud.screen.controlsElement.changeWeaponButton.setEnabled(true);
         tuxGame.battleState.hud.screen.controlsElement.weaponButton.setEnabled(true);
         super.exit();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         if(DCGame.getTime() - this.startTime > 7000)
         {
            parent.exitCurrentState();
            this.startTime = DCGame.getTime();
         }
      }
   }
}

