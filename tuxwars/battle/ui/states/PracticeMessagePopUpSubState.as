package tuxwars.battle.ui.states
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.*;
   import tuxwars.battle.ui.logic.*;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class PracticeMessagePopUpSubState extends MessagePopUpSubState
   {
      public function PracticeMessagePopUpSubState(param1:TuxWarsGame)
      {
         super(param1,PracticeMessagePopUpLogic);
      }
      
      override public function enter() : void
      {
         super.enter();
         BattleManager.getSimulation().pause();
      }
      
      override public function exit() : void
      {
         super.exit();
         if(BattleManager.getSimulation())
         {
            BattleManager.getSimulation().resume();
         }
      }
   }
}

