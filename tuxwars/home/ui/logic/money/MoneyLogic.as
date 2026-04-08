package tuxwars.home.ui.logic.money
{
   import com.dchoc.states.StateMachine;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.states.TuxState;
   
   public class MoneyLogic extends TuxUILogic
   {
      public function MoneyLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      override public function close(param1:StateMachine = null) : void
      {
         if(param1)
         {
            super.close(param1);
         }
         else
         {
            super.close(state.parent.parent);
         }
      }
   }
}

