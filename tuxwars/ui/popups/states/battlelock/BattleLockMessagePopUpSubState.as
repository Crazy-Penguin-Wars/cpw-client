package tuxwars.ui.popups.states.battlelock
{
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.battlelock.BattleLockMessagePopUpLogic;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class BattleLockMessagePopUpSubState extends MessagePopUpSubState
   {
       
      
      public function BattleLockMessagePopUpSubState(game:TuxWarsGame)
      {
         super(game,BattleLockMessagePopUpLogic);
      }
   }
}
