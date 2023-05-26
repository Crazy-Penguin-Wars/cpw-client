package tuxwars.home.ui.logic.home
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.TuxUIElementLogic;
   import tuxwars.home.ui.screen.home.CharacterAvatarElementScreen;
   
   public class CharacterAvatarElementLogic extends TuxUIElementLogic
   {
       
      
      public function CharacterAvatarElementLogic(game:TuxWarsGame)
      {
         super(game);
      }
      
      public function get characterAvatarElementScreen() : CharacterAvatarElementScreen
      {
         return screen;
      }
   }
}
