package tuxwars.home.states.vip
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.vip.*;
   import tuxwars.home.ui.screen.vip.*;
   
   public class VIPUISubState extends TuxUIState
   {
      public function VIPUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(VIPScreen,VIPLogic,param1,param2);
      }
   }
}

