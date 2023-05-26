package tuxwars.home.states.neighbors
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.neighbors.NeighborLogic;
   import tuxwars.home.ui.screen.neighbors.NeighborsScreen;
   
   public class NeighborUISubState extends TuxUIState
   {
       
      
      public function NeighborUISubState(game:TuxWarsGame, params:* = null)
      {
         super(NeighborsScreen,NeighborLogic,game,params);
      }
   }
}
