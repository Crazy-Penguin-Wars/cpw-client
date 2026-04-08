package tuxwars.home.ui.screen.challenge
{
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   
   public class ChallengeElementScreens
   {
      public static const NUM_SLOTS:int = 4;
      
      private static const ELEMENT:String = "Challenge_Display_";
      
      private static const ELEMENT_MAP:Object = {};
      
      ELEMENT_MAP["Battle"] = 0;
      ELEMENT_MAP["Grind"] = 1;
      ELEMENT_MAP["Skill"] = 2;
      ELEMENT_MAP["Impossible"] = 3;
      
      private const elements:Vector.<ChallengeElementScreen>;
      
      public function ChallengeElementScreens(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc3_:int = 0;
         this.elements = new Vector.<ChallengeElementScreen>(4,true);
         super();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            this.elements[_loc3_] = new ChallengeElementScreen(param1.getChildByName("Challenge_Display_" + (_loc3_ + 1)) as MovieClip,param2);
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:* = undefined;
         for each(_loc1_ in this.elements)
         {
            _loc1_.dispose();
         }
         this.elements.splice(0,this.elements.length);
      }
      
      public function init(param1:Vector.<Challenge>) : void
      {
         this.initActiveSlots(param1);
         this.initNonactiveSlots(param1.length);
      }
      
      private function initNonactiveSlots(param1:int) : void
      {
         var _loc2_:* = 0;
         _loc2_ = param1;
         while(_loc2_ < 4)
         {
            this.elements[_loc2_].init(null,this.getType(_loc2_));
            _loc2_++;
         }
      }
      
      private function getType(param1:int) : String
      {
         var _loc2_:* = undefined;
         for(_loc2_ in ELEMENT_MAP)
         {
            if(ELEMENT_MAP[_loc2_] == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function initActiveSlots(param1:Vector.<Challenge>) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = int(ELEMENT_MAP[param1[_loc2_].type]);
            this.elements[_loc3_].init(param1[_loc2_]);
            _loc2_++;
         }
      }
   }
}

