package tuxwars.home.ui.screen.home
{
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   
   public class ChallengesWindowElementScreen extends ChallengeElementScreen
   {
      private static const CHALLENGES_WINDOW:String = "Container_Challenges";
      
      public function ChallengesWindowElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1.getChildByName("Container_Challenges") as MovieClip,param2);
      }
   }
}

