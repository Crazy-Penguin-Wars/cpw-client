package tuxwars.home.ui.screen.challenge
{
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.ui.buttons.UIButton;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.challenge.ChallengeLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.home.ui.screen.home.IHomeScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class ChallengesScreen extends TuxUIScreen
   {
      
      private static const EXPORT:String = "challenges_screen";
      
      private static const BUTTON_CLOSE:String = "Button_Close";
       
      
      private var elementScreens:ChallengeElementScreens;
      
      private var challengesContainer:ChallengeTypeContainerElementScreens;
      
      private var closeButton:UIButton;
      
      public function ChallengesScreen(game:TuxWarsGame)
      {
         super(game,DCResourceManager.instance.getFromSWF("flash/ui/challenges_screen.swf","challenges_screen"));
         var _loc2_:MovieClip = getDesignMovieClip();
         closeButton = TuxUiUtils.createButton(UIButton,_loc2_,"Button_Close",closeButtonHandler);
         TuxUiUtils.createAutoTextField(_loc2_.Text_Header,"CHALLENGES_TITLE");
         TuxUiUtils.createAutoTextField(_loc2_.Text_Description,"CHALLENGES_DESCRIPTION");
         elementScreens = new ChallengeElementScreens(_loc2_.Container_Challenges_Display,game);
         challengesContainer = new ChallengeTypeContainerElementScreens(_loc2_,game);
         IHomeScreen(game.homeState.screenHandler.screen).setDarkBackground(true,this,true);
      }
      
      override public function init(params:*) : void
      {
         super.init(params);
         elementScreens.init(challengeLogic.getActiveChallenges());
         challengesContainer.init(challengeLogic.getActiveChallenges());
      }
      
      override public function dispose() : void
      {
         IHomeScreen(_game.homeState.screenHandler.screen).setDarkBackground(false,this,true);
         closeButton.dispose();
         closeButton = null;
         challengesContainer.dispose();
         challengesContainer = null;
         elementScreens.dispose();
         elementScreens = null;
         super.dispose();
      }
      
      private function closeButtonHandler(event:MouseEvent) : void
      {
         challengeLogic.quit();
      }
      
      private function get challengeLogic() : ChallengeLogic
      {
         return logic;
      }
   }
}
