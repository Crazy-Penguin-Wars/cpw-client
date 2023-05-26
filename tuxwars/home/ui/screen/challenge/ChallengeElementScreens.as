package tuxwars.home.ui.screen.challenge
{
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   
   public class ChallengeElementScreens
   {
      
      public static const NUM_SLOTS:int = 4;
      
      private static const ELEMENT:String = "Challenge_Display_";
      
      private static const ELEMENT_MAP:Object = {};
      
      {
         ELEMENT_MAP["Battle"] = 0;
         ELEMENT_MAP["Grind"] = 1;
         ELEMENT_MAP["Skill"] = 2;
         ELEMENT_MAP["Impossible"] = 3;
      }
      
      private const elements:Vector.<ChallengeElementScreen> = new Vector.<ChallengeElementScreen>(4,true);
      
      public function ChallengeElementScreens(design:MovieClip, game:TuxWarsGame)
      {
         var i:int = 0;
         super();
         for(i = 0; i < 4; )
         {
            elements[i] = new ChallengeElementScreen(design.getChildByName("Challenge_Display_" + (i + 1)) as MovieClip,game);
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
         initActiveSlots(activeChallenges);
         initNonactiveSlots(activeChallenges.length);
      }
      
      private function initNonactiveSlots(startIndex:int) : void
      {
         var i:* = 0;
         for(i = startIndex; i < 4; )
         {
            elements[i].init(null,getType(i));
            i++;
         }
      }
      
      private function getType(index:int) : String
      {
         for(var prop in ELEMENT_MAP)
         {
            if(ELEMENT_MAP[prop] == index)
            {
               return prop;
            }
         }
         return null;
      }
      
      private function initActiveSlots(activeChallenges:Vector.<Challenge>) : void
      {
         var i:int = 0;
         var _loc2_:int = 0;
         for(i = 0; i < activeChallenges.length; )
         {
            _loc2_ = int(ELEMENT_MAP[activeChallenges[i].type]);
            elements[_loc2_].init(activeChallenges[i]);
            i++;
         }
      }
   }
}
