package tuxwars.home.states.crafting
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.states.TuxUIState;
   import tuxwars.home.ui.logic.crafting.CraftingLogic;
   import tuxwars.home.ui.screen.crafting.CraftingScreen;
   
   public class CraftingUISubState extends TuxUIState
   {
       
      
      public function CraftingUISubState(game:TuxWarsGame, params:* = null)
      {
         super(CraftingScreen,CraftingLogic,game,params);
      }
   }
}
