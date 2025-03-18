package tuxwars.home.ui.screen.home
{
   import flash.display.MovieClip;
   import flash.external.ExternalInterface;
   import tuxwars.TuxWarsGame;
   
   public class ChallengesWindowElementScreen extends ChallengeElementScreen
   {
      private static const CHALLENGES_WINDOW:String = "Container_Challenges";
      
      public function ChallengesWindowElementScreen(design:MovieClip, game:TuxWarsGame)
      {
         ExternalInterface.call("console.log","[AnnoyingDebug] ChallengesWindowElementScreen is the cause (GOT YOU :troll:)");
         super(design.getChildByName("Container_Challenges") as MovieClip,game);
      }
   }
}

