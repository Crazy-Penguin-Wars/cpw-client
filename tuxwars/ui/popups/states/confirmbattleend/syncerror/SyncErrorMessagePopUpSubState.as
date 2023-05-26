package tuxwars.ui.popups.states.confirmbattleend.syncerror
{
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.BattleResults;
   import tuxwars.ui.popups.logic.confirmbattleend.syncerror.SyncErrorMessagePopUpLogic;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class SyncErrorMessagePopUpSubState extends MessagePopUpSubState
   {
       
      
      public function SyncErrorMessagePopUpSubState(game:TuxWarsGame, battleResults:BattleResults)
      {
         super(game,SyncErrorMessagePopUpLogic,battleResults);
      }
   }
}
