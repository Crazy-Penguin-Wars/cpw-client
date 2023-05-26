package tuxwars.home.ui.logic.home
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.home.CharacterFrameElementScreen;
   
   public class CharacterFrameElementLogic extends CharacterAvatarElementLogic
   {
       
      
      public function CharacterFrameElementLogic(game:TuxWarsGame)
      {
         super(game);
      }
      
      public function get characterFrameElementScreen() : CharacterFrameElementScreen
      {
         return screen;
      }
   }
}
