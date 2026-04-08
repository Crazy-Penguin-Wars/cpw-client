package tuxwars.ui.popups.states.confirmbattleend.timeout
{
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.confirmbattleend.timeout.*;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class TimeOutMessagePopUpSubState extends MessagePopUpSubState
   {
      public function TimeOutMessagePopUpSubState(param1:TuxWarsGame)
      {
         super(param1,TimeOutMessagePopUpLogic);
      }
   }
}

