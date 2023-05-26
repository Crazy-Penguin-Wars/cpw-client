package tuxwars.ui.popups.states.hostleft
{
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.popups.logic.hostleft.HostLeftMessagePopUpLogic;
   import tuxwars.ui.popups.states.message.MessagePopUpSubState;
   
   public class HostLeftMessagePopUpSubState extends MessagePopUpSubState
   {
       
      
      public function HostLeftMessagePopUpSubState(game:TuxWarsGame)
      {
         super(game,HostLeftMessagePopUpLogic);
      }
   }
}
