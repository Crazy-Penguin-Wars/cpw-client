package tuxwars.tutorial
{
   import com.dchoc.messages.*;
   import com.dchoc.utils.*;
   import tuxwars.net.messages.*;
   
   public class Tutorial
   {
      private static var __tutorial:Boolean;
      
      public static const TUTORIAL:String = "Tutorial";
      
      public static const TUTORIAL_STEP:String = "TutorialStep";
      
      public static const STEP_START:String = "TutorialStart";
      
      public static const STEP_CUSTOMIZATION_DONE:String = "TutorialCustomizationDone";
      
      public static const STEP_MOVED:String = "TutorialMoved";
      
      public static const STEP_FIRED:String = "TutorialFired";
      
      public static const STEP_CHANGE_BOOSTER:String = "TutorialChangeBooster";
      
      public static const STEP_BUY_BOOSTER:String = "TutorialBuyBooster";
      
      public static const STEP_SELECT_BOOSTER:String = "TutorialSelectBooster";
      
      public static const STEP_USE_BOOSTER:String = "TutorialUseBooster";
      
      public static const STEP_OPPONENTS_TURN:String = "TutorialOpponentsTurn";
      
      public static const STEP_CHANGE_WEAPON:String = "TutorialChangeWeapon";
      
      public static const STEP_BUY_WEAPON:String = "TutorialBuyWeapon";
      
      public static const STEP_SELECT_WEAPON:String = "TutorialSelectWeapon";
      
      public static const STEP_TURN_TIMER:String = "TutorialTurnTimer";
      
      public static const STEP_MATCH_TIMER:String = "TutorialMatchTimer";
      
      public static const STEP_MATCH_PLAYED:String = "TutorialMatchPlayed";
      
      public static const STEP_BUY_SHOP_WEAPONS:String = "TutorialBuyShopWeapons";
      
      public static const STEP_BUY_SHOP_WEAPONS_DONE:String = "TutorialBuyShopWeaponsDone";
      
      public static const STEP_BUY_CLOTHES:String = "TutorialBuyClothes";
      
      public static const STEP_BUY_CLOTHES_DONE:String = "TutorialBuyClothesDone";
      
      public static const STEP_CLOSE_SHOP_WEAPONS:String = "TutorialCloseShopWeapons";
      
      public static const STEP_END:String = "TutorialEnd";
      
      public static const WEAPON_TO_BUY:String = "ClusterRocket";
      
      public static const WEAPON_TO_BUY_IN_SHOP:String = "BasicNuke";
      
      public static const BOOSTER_TO_BUY:String = "Shield";
      
      private static var _Step:String = "TutorialCustomizationDone";
      
      public function Tutorial()
      {
         super();
      }
      
      public static function get _tutorial() : Boolean
      {
         return __tutorial;
      }
      
      public static function get tutorial() : Boolean
      {
         return __tutorial;
      }
      
      public static function setTutorial(param1:Boolean, param2:Boolean = true) : void
      {
         __tutorial = param1;
         if(param2)
         {
            MessageCenter.sendEvent(new SetFlagMessage("Tutorial",__tutorial.toString()));
         }
      }
      
      public static function get tutorialStep() : String
      {
         return __tutorialStep;
      }
      
      public static function saveTutorialStep(param1:String, param2:Boolean = true) : void
      {
         if(__tutorialStep != "TutorialEnd")
         {
            LogUtils.log("Setting tutorial step to " + param1,"Tutorial");
            __tutorialStep = param1;
            if(param2)
            {
               MessageCenter.sendEvent(new SetFlagMessage("TutorialStep",__tutorialStep));
            }
         }
      }
   }
}

