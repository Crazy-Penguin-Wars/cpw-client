package tuxwars.home.ui.logic.gifts
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUILogic;
   import tuxwars.home.ui.screen.gifts.GiftScreen;
   import tuxwars.states.TuxState;
   
   public class GiftLogic extends TuxUILogic
   {
       
      
      public function GiftLogic(game:TuxWarsGame, state:TuxState)
      {
         super(game,state);
      }
      
      private function get giftScreen() : GiftScreen
      {
         return screen;
      }
   }
}
