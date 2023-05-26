package tuxwars.home.ui.screen.home
{
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   
   public class ChallengesWindowElementScreen extends ChallengeElementScreen
   {
      
      private static const CHALLENGES_WINDOW:String = "Container_Challenges";
       
      
      public function ChallengesWindowElementScreen(design:MovieClip, game:TuxWarsGame)
      {
         super(design.getChildByName("Container_Challenges") as MovieClip,game);
      }
   }
}
