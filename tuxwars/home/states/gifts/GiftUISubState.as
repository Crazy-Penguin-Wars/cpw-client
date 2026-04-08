package tuxwars.home.states.gifts
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.gifts.*;
   import tuxwars.home.ui.screen.gifts.*;
   
   public class GiftUISubState extends TuxUIState
   {
      public function GiftUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(GiftScreen,GiftLogic,param1,param2);
      }
   }
}

