package tuxwars.home.states.shop
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.shop.*;
   import tuxwars.home.ui.screen.shop.*;
   import tuxwars.states.tutorial.*;
   import tuxwars.tutorial.*;
   
   public class ShopUISubState extends TuxUIState
   {
      public function ShopUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(ShopScreen,ShopLogic,param1,param2);
      }
      
      override public function enter() : void
      {
         super.enter();
         if(Tutorial._tutorial)
         {
            if(Tutorial._tutorialStep == "TutorialMatchPlayed" || Tutorial._tutorialStep == "TutorialBuyShopWeaponsDone")
            {
               changeState(new TuxTutorialBuyShopWeaponSubState(tuxGame));
            }
         }
      }
   }
}

