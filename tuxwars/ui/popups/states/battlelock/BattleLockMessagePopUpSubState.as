package tuxwars.ui.popups.states.battlelock
{
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.battlelock.*;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class BattleLockMessagePopUpSubState extends MessagePopUpSubState
   {
      public function BattleLockMessagePopUpSubState(param1:TuxWarsGame)
      {
         super(param1,BattleLockMessagePopUpLogic);
      }
   }
}

