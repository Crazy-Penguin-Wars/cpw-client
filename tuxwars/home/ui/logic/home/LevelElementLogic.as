package tuxwars.home.ui.logic.home
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUIElementLogic;
   import tuxwars.home.ui.screen.home.LevelElementScreen;
   
   public class LevelElementLogic extends TuxUIElementLogic
   {
       
      
      public function LevelElementLogic(game:TuxWarsGame)
      {
         super(game);
      }
      
      public function get levelElementScreen() : LevelElementScreen
      {
         return screen;
      }
   }
}
