package tuxwars.home.ui.screen.challenge
{
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.challenges.Challenge;
   
   public class ChallengeTypeContainerElementScreens
   {
      private static const ELEMENT:String = "Container_Challenges_";
      
      private static const ELEMENT_ARRAY:Array = ["Battle","Grind","Skill","Impossible"];
      
      private const elements:Vector.<ChallengeTypeContainerScreen>;
      
      public function ChallengeTypeContainerElementScreens(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc3_:int = 0;
         this.elements = new Vector.<ChallengeTypeContainerScreen>();
         super();
         _loc3_ = 0;
         while(_loc3_ < ELEMENT_ARRAY.length)
         {
            this.elements.push(new ChallengeTypeContainerScreen(param1.getChildByName("Container_Challenges_" + (_loc3_ + 1)) as MovieClip,param2,ELEMENT_ARRAY[_loc3_]));
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
         var _loc2_:* = undefined;
         for each(_loc2_ in this.elements)
         {
            _loc2_.init(this.getActiveChallengeOfType(_loc2_.challengeType,param1));
         }
      }
      
      private function getActiveChallengeOfType(param1:String, param2:Vector.<Challenge>) : Challenge
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param2)
         {
            if(_loc3_.type == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

