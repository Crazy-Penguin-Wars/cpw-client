package tuxwars.ui.popups.states.confirmbattleend.syncerror
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.ui.popups.logic.confirmbattleend.syncerror.*;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class SyncErrorMessagePopUpSubState extends MessagePopUpSubState
   {
      public function SyncErrorMessagePopUpSubState(param1:TuxWarsGame, param2:BattleResults)
      {
         super(param1,SyncErrorMessagePopUpLogic,param2);
      }
   }
}

