package tuxwars.ui.popups.logic
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class PopUpBaseLogic extends TuxUILogic
   {
      public function PopUpBaseLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      public function exit() : void
      {
         close(state.parent.parent);
      }
   }
}

