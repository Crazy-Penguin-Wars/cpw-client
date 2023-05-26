package tuxwars.states.tutorial
{
   import com.dchoc.game.DCGame;
   import com.dchoc.messages.Message;
   import com.dchoc.messages.MessageCenter;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.tutorial.Tutorial;
   
   public class TuxTutorialTurnTimerSubState extends TuxTutorialSubState
   {
       
      
      public function TuxTutorialTurnTimerSubState(game:TuxWarsGame)
      {
         super(game,"TUTORIAL_SHOOT_SECOND");
      }
      
      override public function enter() : void
      {
         super.enter();
         BattleManager.getSimulation().resume();
         var _loc2_:* = DCGame.getTime();
         var _loc1_:* = BattleManager.getSimulation();
         _loc1_._turnStartTime = _loc2_;
         addTutorialArrow("bottom",tuxGame.battleState.hud.screen.topRightElement.design.Container_Arrow);
         MessageCenter.addListener("PlayerTurnEnded",playerTurnEnded);
      }
      
      override public function exit() : void
      {
         MessageCenter.removeListener("PlayerTurnEnded",playerTurnEnded);
         super.exit();
      }
      
      private function playerTurnEnded(msg:Message) : void
      {
         if(msg.data.id == tuxGame.player.id)
         {
            Tutorial.saveTutorialStep("TutorialTurnTimer",false);
            parent.changeState(new TuxTutorialMatchTimerSubState(tuxGame));
         }
      }
   }
}
