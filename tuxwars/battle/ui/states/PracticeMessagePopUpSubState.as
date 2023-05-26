package tuxwars.battle.ui.states
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleManager;
   import tuxwars.battle.ui.logic.PracticeMessagePopUpLogic;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class PracticeMessagePopUpSubState extends MessagePopUpSubState
   {
       
      
      public function PracticeMessagePopUpSubState(game:TuxWarsGame)
      {
         super(game,PracticeMessagePopUpLogic);
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
