package tuxwars.home.states.crafting
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.crafting.*;
   import tuxwars.home.ui.screen.crafting.*;
   
   public class CraftingUISubState extends TuxUIState
   {
      public function CraftingUISubState(param1:TuxWarsGame, param2:* = null)
      {
         super(CraftingScreen,CraftingLogic,param1,param2);
      }
   }
}

