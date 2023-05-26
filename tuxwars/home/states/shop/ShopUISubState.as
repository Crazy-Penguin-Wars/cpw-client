package tuxwars.home.states.shop
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.shop.ShopLogic;
   import tuxwars.home.ui.screen.shop.ShopScreen;
   import tuxwars.states.tutorial.TuxTutorialBuyShopWeaponSubState;
   import tuxwars.tutorial.Tutorial;
   
   public class ShopUISubState extends TuxUIState
   {
       
      
      public function ShopUISubState(game:TuxWarsGame, params:* = null)
      {
         super(ShopScreen,ShopLogic,game,params);
      }
      
      override public function enter() : void
      {
         super.enter();
         var _loc1_:Tutorial = Tutorial;
         if(tuxwars.tutorial.Tutorial._tutorial)
         {
            var _loc2_:Tutorial = Tutorial;
            if(tuxwars.tutorial.Tutorial._tutorialStep == "TutorialMatchPlayed" || tuxwars.tutorial.Tutorial._tutorialStep == "TutorialBuyShopWeaponsDone")
            {
               changeState(new TuxTutorialBuyShopWeaponSubState(tuxGame));
            }
         }
      }
   }
}
