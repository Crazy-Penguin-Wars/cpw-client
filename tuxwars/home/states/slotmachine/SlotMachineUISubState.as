package tuxwars.home.states.slotmachine
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.slotmachine.*;
   import tuxwars.home.ui.screen.slotmachine.*;
   
   public class SlotMachineUISubState extends TuxUIState
   {
      public function SlotMachineUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(SlotMachineScreen,SlotMachineLogic,param1,param2);
      }
   }
}

