package tuxwars.home.ui.screen.home
{
   import com.dchoc.game.DCGame;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.home.HomeLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.ui.components.DarkBackgroundElementScreen;
   import tuxwars.ui.components.TopBarBackground;
   
   public class HomeScreen extends TuxUIScreen implements IHomeScreen
   {
       
      
      private var backgroundElement:BackgroundElementScreen;
      
      private var darkBackground:DarkBackgroundElementWindow;
      
      private var darkBackgroundFront:DarkBackgroundElementWindow;
      
      private var _friendBar:FriendsElementScreen;
      
      private var _navigationButtonsElementScreen:NavigationButtonsElementScreen;
      
      private var _characterFrameScreen:CharacterFrameElementScreen;
      
      private var topLeftElement:TopLeftElementScreen;
      
      private var topRightElement:TopRightElementScreen;
      
      private var topBarBackground:TopBarBackground;
      
      private var lastDarkBackgroundCaller:String;
      
      public function HomeScreen(game:TuxWarsGame)
      {
         super(game,new MovieClip());
         var _loc2_:MovieClip = getDesignMovieClip();
         _loc2_.name = "HomeScreen";
         backgroundElement = new BackgroundElementScreen(_loc2_,game);
         topBarBackground = new TopBarBackground(_loc2_,game);
         _characterFrameScreen = new CharacterFrameElementScreen(_loc2_,game);
         _navigationButtonsElementScreen = new NavigationButtonsElementScreen(_loc2_,game);
         topRightElement = new TopRightElementScreen(_loc2_,game);
         topLeftElement = new TopLeftElementScreen(_loc2_,game);
         darkBackground = new DarkBackgroundElementWindow(_loc2_,game,"flash/ui/home_screen.swf","home_screen");
         _friendBar = new FriendsElementScreen(_loc2_,game);
         darkBackgroundFront = new DarkBackgroundElementWindow(_loc2_,game,"flash/ui/home_screen.swf","home_screen");
      }
      
      public function setDarkBackground(value:Boolean, caller:*, front:Boolean) : void
      {
         if(value && caller != lastDarkBackgroundCaller)
         {
            lastDarkBackgroundCaller = caller;
         }
         var _loc4_:DarkBackgroundElementScreen = front ? darkBackgroundFront : darkBackground;
         if(caller == lastDarkBackgroundCaller)
         {
            if(!value && _loc4_.getUiTransiotion() != null && _loc4_.getUiTransiotion().isTransitioning())
            {
               _loc4_.getUiTransiotion().dispose(true);
            }
            _loc4_.setVisible(value);
            if(characterFrameElementScreen)
            {
               if(!value)
               {
                  characterFrameElementScreen.playMovieClip();
               }
               else
               {
                  characterFrameElementScreen.stopMovieClip();
               }
            }
         }
      }
      
      public function resetPlayButtons() : void
      {
         _characterFrameScreen.playButton.setEnabled(true);
         _characterFrameScreen.enableTournamentButton(true);
      }
      
      public function refreshFriends() : void
      {
         friendBar.refreshFriends();
      }
      
      override public function dispose() : void
      {
         backgroundElement.dispose();
         backgroundElement = null;
         lastDarkBackgroundCaller = null;
         darkBackground.dispose();
         darkBackground = null;
         darkBackgroundFront.dispose();
         darkBackgroundFront = null;
         _friendBar.dispose();
         _friendBar = null;
         _navigationButtonsElementScreen.dispose();
         _navigationButtonsElementScreen = null;
         topRightElement.dispose();
         topRightElement = null;
         _characterFrameScreen.dispose();
         _characterFrameScreen = null;
         topLeftElement.dispose();
         topLeftElement = null;
         topBarBackground.dispose();
         topBarBackground = null;
         super.dispose();
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         topRightElement.logicUpdate(deltaTime);
         topLeftElement.logicUpdate(deltaTime);
         _characterFrameScreen.logicUpdate(deltaTime);
      }
      
      override public function set logic(logic:*) : void
      {
         super.logic = logic;
         topRightElement.setMoneyLogic(homeLogic.moneyResourceElementLogic);
      }
      
      public function get homeLogic() : HomeLogic
      {
         return super.logic;
      }
      
      public function get friendBar() : FriendsElementScreen
      {
         return _friendBar;
      }
      
      public function get levelElementScreen() : LevelElementScreen
      {
         return topLeftElement.getLevelElement();
      }
      
      public function get challengeElementScreen() : ChallengesWindowElementScreen
      {
         return topLeftElement.getChallengeElement();
      }
      
      public function get moneyResourceElementScreen() : MoneyResourceElementScreen
      {
         return topRightElement.moneyResourceElement;
      }
      
      public function get characterFrameElementScreen() : CharacterFrameElementScreen
      {
         return _characterFrameScreen;
      }
      
      public function get navigationButtonsElementScreen() : NavigationButtonsElementScreen
      {
         return _navigationButtonsElementScreen;
      }
      
      override protected function fullscreenChanged(event:FullScreenEvent) : void
      {
         super.fullscreenChanged(event);
         var _loc2_:Boolean = DCGame.isFullScreen();
         var _loc3_:DCGame = DCGame;
         var _loc4_:DCGame = DCGame;
         LogUtils.addDebugLine("Assets","Fullscreen changed: " + _loc2_ + " size: " + com.dchoc.game.DCGame._stage.fullScreenWidth + ", " + com.dchoc.game.DCGame._stage.fullScreenHeight,"HomeScreen");
         backgroundElement.fullscreenChanged(_loc2_);
         _characterFrameScreen.fullscreenChanged(_loc2_);
         _navigationButtonsElementScreen.fullscreenChanged(_loc2_);
         topRightElement.fullscreenChanged(_loc2_);
         topLeftElement.fullscreenChanged(_loc2_);
         darkBackground.fullscreenChanged(_loc2_);
         friendBar.fullscreenChanged(_loc2_);
         darkBackgroundFront.fullscreenChanged(_loc2_);
         topBarBackground.fullscreenChanged(_loc2_);
      }
   }
}
