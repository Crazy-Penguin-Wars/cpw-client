package tuxwars.home.ui.screen.challenge
{
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   
   public class ChallengeTypeContainerElementScreens
   {
      
      private static const ELEMENT:String = "Container_Challenges_";
      
      private static const ELEMENT_ARRAY:Array = ["Battle","Grind","Skill","Impossible"];
       
      
      private const elements:Vector.<ChallengeTypeContainerScreen> = new Vector.<ChallengeTypeContainerScreen>();
      
      public function ChallengeTypeContainerElementScreens(design:MovieClip, game:TuxWarsGame)
      {
         var i:int = 0;
         super();
         for(i = 0; i < ELEMENT_ARRAY.length; )
         {
            elements.push(new ChallengeTypeContainerScreen(design.getChildByName("Container_Challenges_" + (i + 1)) as MovieClip,game,ELEMENT_ARRAY[i]));
            i++;
         }
      }
      
      public function dispose() : void
      {
         for each(var element in elements)
         {
            element.dispose();
         }
         elements.splice(0,elements.length);
      }
      
      public function init(activeChallenges:Vector.<Challenge>) : void
      {
         for each(var element in elements)
         {
            element.init(getActiveChallengeOfType(element.challengeType,activeChallenges));
         }
      }
      
      private function getActiveChallengeOfType(challengeType:String, activeChallenges:Vector.<Challenge>) : Challenge
      {
         for each(var challenge in activeChallenges)
         {
            if(challenge.type == challengeType)
            {
               return challenge;
            }
         }
         return null;
      }
   }
}
