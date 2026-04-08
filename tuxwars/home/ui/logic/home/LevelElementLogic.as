package tuxwars.home.ui.logic.home
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUIElementLogic;
   import tuxwars.home.ui.screen.home.LevelElementScreen;
   
   public class LevelElementLogic extends TuxUIElementLogic
   {
      public function LevelElementLogic(param1:TuxWarsGame)
      {
         super(param1);
      }
      
      public function get levelElementScreen() : LevelElementScreen
      {
         return screen;
      }
   }
}

