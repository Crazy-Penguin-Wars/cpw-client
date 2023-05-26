package tuxwars.ui.popups.logic
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class PopUpBaseLogic extends TuxUILogic
   {
       
      
      public function PopUpBaseLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      public function exit() : void
      {
         close(state.parent.parent);
      }
   }
}
