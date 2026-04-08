package tuxwars.home.ui.screen.challenge
{
   import com.dchoc.resources.*;
   import com.dchoc.ui.buttons.*;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.challenge.ChallengeLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.*;
   import tuxwars.utils.*;
   
   public class ChallengesScreen extends TuxUIScreen
   {
      private static const EXPORT:String = "challenges_screen";
      
      private static const BUTTON_CLOSE:String = "Button_Close";
      
      private var elementScreens:ChallengeElementScreens;
      
      private var challengesContainer:ChallengeTypeContainerElementScreens;
      
      private var closeButton:UIButton;
      
      public function ChallengesScreen(param1:TuxWarsGame)
      {
         super(param1,DCResourceManager.instance.getFromSWF("flash/ui/challenges_screen.swf","challenges_screen"));
         var _loc2_:MovieClip = getDesignMovieClip();
         this.closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",this.closeButtonHandler);
         TuxUiUtils.createAutoTextField(_loc2_.Text_Header,"CHALLENGES_TITLE");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Description,"CHALLENGES_DESCRIPTION");
         this.elementScreens = new ChallengeElementScreens(_loc2_.Container_Challenges_Display,param1);
         this.challengesContainer = new ChallengeTypeContainerElementScreens(_loc2_,param1);
         IHomeScreen(param1.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(param1:*) : void
      {
         super.init(param1);
         this.elementScreens.init(this.challengeLogic.getActiveChallenges());
         this.challengesContainer.init(this.challengeLogic.getActiveChallenges());
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         this.closeButton.dispose();
         this.closeButton = null;
         this.challengesContainer.dispose();
         this.challengesContainer = null;
         this.elementScreens.dispose();
         this.elementScreens = null;
         super.dispose();
      }
      
      private function closeButtonHandler(param1:MouseEvent) : void
      {
         this.challengeLogic.quit();
      }
      
      private function get challengeLogic() : ChallengeLogic
      {
         return logic;
      }
   }
}

