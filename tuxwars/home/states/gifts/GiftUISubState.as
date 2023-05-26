package tuxwars.home.states.gifts
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.gifts.GiftLogic;
   import tuxwars.home.ui.screen.gifts.GiftScreen;
   
   public class GiftUISubState extends TuxUIState
   {
       
      
      public function GiftUISubState(game:TuxWarsGame, params:* = null)
      {
         super(GiftScreen,GiftLogic,game,params);
      }
   }
}
