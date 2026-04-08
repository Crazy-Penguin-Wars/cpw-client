package tuxwars.home.ui.screen.home
{
   import com.dchoc.game.*;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.FullScreenEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.logic.home.HomeLogic;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.ui.components.*;
   
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
      
      public function HomeScreen(param1:TuxWarsGame)
      {
         super(param1,new MovieClip());
         var _loc2_:MovieClip = getDesignMovieClip();
         _loc2_.name = "HomeScreen";
         this.backgroundElement = new BackgroundElementScreen(_loc2_,param1);
         this.topBarBackground = new TopBarBackground(_loc2_,param1);
         this._characterFrameScreen = new CharacterFrameElementScreen(_loc2_,param1);
         this._navigationButtonsElementScreen = new NavigationButtonsElementScreen(_loc2_,param1);
         this.topRightElement = new TopRightElementScreen(_loc2_,param1);
         this.topLeftElement = new TopLeftElementScreen(_loc2_,param1);
         this.darkBackground = new DarkBackgroundElementWindow(_loc2_,param1,"flash/ui/home_screen.swf","home_screen");
         this._friendBar = new FriendsElementScreen(_loc2_,param1);
         this.darkBackgroundFront = new DarkBackgroundElementWindow(_loc2_,param1,"flash/ui/home_screen.swf","home_screen");
      }
      
      public function setDarkBackground(param1:Boolean, param2:*, param3:Boolean) : void
      {
         if(param1 && param2 != this.lastDarkBackgroundCaller)
         {
            this.lastDarkBackgroundCaller = param2;
         }
         var _loc4_:DarkBackgroundElementScreen = param3 ? this.darkBackgroundFront : this.darkBackground;
         if(param2 == this.lastDarkBackgroundCaller)
         {
            if(!param1 && _loc4_.getUiTransiotion() != null && _loc4_.getUiTransiotion().isTransitioning())
            {
               _loc4_.getUiTransiotion().dispose(true);
            }
            _loc4_.setVisible(param1);
            if(this.characterFrameElementScreen)
            {
               if(!param1)
               {
                  this.characterFrameElementScreen.playMovieClip();
               }
               else
               {
                  this.characterFrameElementScreen.stopMovieClip();
               }
            }
         }
      }
      
      public function resetPlayButtons() : void
      {
         this._characterFrameScreen.playButton.setEnabled(true);
         this._characterFrameScreen.enableTournamentButton(true);
      }
      
      public function refreshFriends() : void
      {
         this.friendBar.refreshFriends();
      }
      
      override public function dispose() : void
      {
         this.backgroundElement.dispose();
         this.backgroundElement = null;
         this.lastDarkBackgroundCaller = null;
         this.darkBackground.dispose();
         this.darkBackground = null;
         this.darkBackgroundFront.dispose();
         this.darkBackgroundFront = null;
         this._friendBar.dispose();
         this._friendBar = null;
         this._navigationButtonsElementScreen.dispose();
         this._navigationButtonsElementScreen = null;
         this.topRightElement.dispose();
         this.topRightElement = null;
         this._characterFrameScreen.dispose();
         this._characterFrameScreen = null;
         this.topLeftElement.dispose();
         this.topLeftElement = null;
         this.topBarBackground.dispose();
         this.topBarBackground = null;
         super.dispose();
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this.topRightElement.logicUpdate(param1);
         this.topLeftElement.logicUpdate(param1);
         this._characterFrameScreen.logicUpdate(param1);
      }
      
      override public function set logic(param1:*) : void
      {
         super.logic = param1;
         this.topRightElement.setMoneyLogic(this.homeLogic.moneyResourceElementLogic);
      }
      
      public function get homeLogic() : HomeLogic
      {
         return super.logic;
      }
      
      public function get friendBar() : FriendsElementScreen
      {
         return this._friendBar;
      }
      
      public function get levelElementScreen() : LevelElementScreen
      {
         return this.topLeftElement.getLevelElement();
      }
      
      public function get challengeElementScreen() : ChallengesWindowElementScreen
      {
         return this.topLeftElement.getChallengeElement();
      }
      
      public function get moneyResourceElementScreen() : MoneyResourceElementScreen
      {
         return this.topRightElement.moneyResourceElement;
      }
      
      public function get characterFrameElementScreen() : CharacterFrameElementScreen
      {
         return this._characterFrameScreen;
      }
      
      public function get navigationButtonsElementScreen() : NavigationButtonsElementScreen
      {
         return this._navigationButtonsElementScreen;
      }
      
      override protected function fullscreenChanged(param1:FullScreenEvent) : void
      {
         super.fullscreenChanged(param1);
         var _loc2_:Boolean = Boolean(DCGame.isFullScreen());
         LogUtils.addDebugLine("Assets","Fullscreen changed: " + _loc2_ + " size: " + DCGame.getStage().fullScreenWidth + ", " + DCGame.getStage().fullScreenHeight,"HomeScreen");
         this.backgroundElement.fullscreenChanged(_loc2_);
         this._characterFrameScreen.fullscreenChanged(_loc2_);
         this._navigationButtonsElementScreen.fullscreenChanged(_loc2_);
         this.topRightElement.fullscreenChanged(_loc2_);
         this.topLeftElement.fullscreenChanged(_loc2_);
         this.darkBackground.fullscreenChanged(_loc2_);
         this.friendBar.fullscreenChanged(_loc2_);
         this.darkBackgroundFront.fullscreenChanged(_loc2_);
         this.topBarBackground.fullscreenChanged(_loc2_);
      }
   }
}

