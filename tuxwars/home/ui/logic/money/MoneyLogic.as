package tuxwars.home.ui.logic.money
{
   import com.dchoc.states.StateMachine;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class MoneyLogic extends TuxUILogic
   {
       
      
      public function MoneyLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      override public function close(exitState:StateMachine = null) : void
      {
         if(exitState)
         {
            super.close(exitState);
         }
         else
         {
            super.close(state.parent.parent);
         }
      }
   }
}
