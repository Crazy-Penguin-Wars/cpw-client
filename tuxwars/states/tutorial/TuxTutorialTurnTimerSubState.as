package tuxwars.states.tutorial
{
   import com.dchoc.game.*;
   import com.dchoc.messages.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.tutorial.*;
   
   public class TuxTutorialTurnTimerSubState extends TuxTutorialSubState
   {
      public function TuxTutorialTurnTimerSubState(param1:TuxWarsGame)
      {
         super(param1,"TUTORIAL_SHOOT_SECOND");
      }
      
      override public function enter() : void
      {
         super.enter();
         BattleManager.getSimulation().resume();
         var _loc1_:* = DCGame.getTime();
         var _loc2_:* = BattleManager.getSimulation();
         _loc2_._turnStartTime = _loc1_;
         addTutorialArrow("bottom",tuxGame.battleState.hud.screen.topRightElement.design.Container_Arrow);
         MessageCenter.addListener("PlayerTurnEnded",this.playerTurnEnded);
      }
      
      override public function exit() : void
      {
         MessageCenter.removeListener("PlayerTurnEnded",this.playerTurnEnded);
         super.exit();
      }
      
      private function playerTurnEnded(param1:Message) : void
      {
         if(param1.data.id == tuxGame.player.id)
         {
            Tutorial.saveTutorialStep("TutorialTurnTimer",false);
            parent.changeState(new TuxTutorialMatchTimerSubState(tuxGame));
         }
      }
   }
}

