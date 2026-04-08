package tuxwars.home.ui.logic.gifts
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.gifts.GiftScreen;
   import tuxwars.states.TuxState;
   
   public class GiftLogic extends TuxUILogic
   {
      public function GiftLogic(param1:TuxWarsGame, param2:TuxState)
      {
         super(param1,param2);
      }
      
      private function get giftScreen() : GiftScreen
      {
         return screen;
      }
   }
}

