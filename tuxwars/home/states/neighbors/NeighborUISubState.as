package tuxwars.home.states.neighbors
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.neighbors.*;
   import tuxwars.home.ui.screen.neighbors.*;
   
   public class NeighborUISubState extends TuxUIState
   {
      public function NeighborUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(NeighborsScreen,NeighborLogic,param1,param2);
      }
   }
}

