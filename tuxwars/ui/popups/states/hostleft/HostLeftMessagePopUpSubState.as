package tuxwars.ui.popups.states.hostleft
{
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.hostleft.*;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class HostLeftMessagePopUpSubState extends MessagePopUpSubState
   {
      public function HostLeftMessagePopUpSubState(param1:TuxWarsGame)
      {
         super(param1,HostLeftMessagePopUpLogic);
      }
   }
}

