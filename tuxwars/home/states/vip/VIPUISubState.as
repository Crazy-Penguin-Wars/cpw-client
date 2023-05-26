package tuxwars.home.states.vip
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.vip.VIPLogic;
   import tuxwars.home.ui.screen.vip.VIPScreen;
   
   public class VIPUISubState extends TuxUIState
   {
       
      
      public function VIPUISubState(game:TuxWarsGame, params:* = null)
      {
         super(VIPScreen,VIPLogic,game,params);
      }
   }
}
