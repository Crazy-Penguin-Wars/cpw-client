package tuxwars.battle.ui.screen
{
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.battle.ui.screen.chat.ChatElementScreen;
   import tuxwars.battle.ui.screen.timer.MatchTimerElement;
   import tuxwars.battle.ui.screen.timer.PlayerTimerContainer;
   import tuxwars.home.ui.screen.TuxUIScreen;
   
   public class BattleHudScreen extends TuxUIScreen implements IBattleHudScreen
   {
       
      
      private var _topLeftElement:TopLeftElement;
      
      private var _topRightElement:TopRightElement;
      
      private var _bottomElement:BottomElement;
      
      public function BattleHudScreen(game:TuxWarsGame)
      {
         super(game,new MovieClip());
         var _loc2_:MovieClip = getDesignMovieClip();
         _loc2_.mouseEnabled = false;
         _topLeftElement = new TopLeftElement(_loc2_,game);
         _topRightElement = new TopRightElement(_loc2_,game);
         _bottomElement = new BottomElement(_loc2_,game,this);
      }
      
      public function get topLeftElement() : TopLeftElement
      {
         return _topLeftElement;
      }
      
      public function get topRightElement() : TopRightElement
      {
         return _topRightElement;
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         _topLeftElement.logicUpdate(deltaTime);
         _topRightElement.logicUpdate(deltaTime);
         _bottomElement.logicUpdate(deltaTime);
      }
      
      override public function dispose() : void
      {
         _topLeftElement.dispose();
         _topLeftElement = null;
         _topRightElement.dispose();
         _topRightElement = null;
         _bottomElement.dispose();
         _bottomElement = null;
         super.dispose();
      }
      
      public function get playerTimerContainer() : PlayerTimerContainer
      {
         return _topRightElement.getPlayerTimerContainer();
      }
      
      public function get matchTimeElement() : MatchTimerElement
      {
         return _topLeftElement.getMatchTimerElement();
      }
      
      public function get chatElementScreen() : ChatElementScreen
      {
         return _bottomElement.chatElementScreen;
      }
      
      public function get controlsElement() : BattleHudControlsElementScreen
      {
         return _bottomElement.controlsElement;
      }
      
      public function get bottomElement() : BottomElement
      {
         return _bottomElement;
      }
      
      public function showHud() : void
      {
         setVisible(true);
      }
      
      public function hideHud() : void
      {
         setVisible(false);
      }
      
      override public function set logic(logic:*) : void
      {
         super.logic = logic;
         _bottomElement.logic = logic;
      }
      
      override protected function fullscreenChanged(event:FullScreenEvent) : void
      {
         super.fullscreenChanged(event);
         _topRightElement.fullscreenChanged(event.fullScreen);
         _topLeftElement.fullscreenChanged(event.fullScreen);
         _bottomElement.fullscreenChanged(event.fullScreen);
      }
   }
}
