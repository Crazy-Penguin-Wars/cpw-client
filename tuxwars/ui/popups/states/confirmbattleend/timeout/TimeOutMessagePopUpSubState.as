package tuxwars.ui.popups.states.confirmbattleend.timeout
{
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.confirmbattleend.timeout.TimeOutMessagePopUpLogic;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class TimeOutMessagePopUpSubState extends MessagePopUpSubState
   {
       
      
      public function TimeOutMessagePopUpSubState(game:TuxWarsGame)
      {
         super(game,TimeOutMessagePopUpLogic);
      }
   }
}
