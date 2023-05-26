package tuxwars.home.states.slotmachine
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.slotmachine.SlotMachineLogic;
   import tuxwars.home.ui.screen.slotmachine.SlotMachineScreen;
   
   public class SlotMachineUISubState extends TuxUIState
   {
       
      
      public function SlotMachineUISubState(game:TuxWarsGame, params:* = null)
      {
         super(SlotMachineScreen,SlotMachineLogic,game,params);
      }
   }
}
