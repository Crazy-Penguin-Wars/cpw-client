package tuxwars.battle.ui.screen
{
   import flash.display.*;
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
      
      public function BattleHudScreen(param1:TuxWarsGame)
      {
         super(param1,new MovieClip());
         var _loc2_:MovieClip = getDesignMovieClip();
         _loc2_.mouseEnabled = false;
         this._topLeftElement = new TopLeftElement(_loc2_,param1);
         this._topRightElement = new TopRightElement(_loc2_,param1);
         this._bottomElement = new BottomElement(_loc2_,param1,this);
      }
      
      public function get topLeftElement() : TopLeftElement
      {
         return this._topLeftElement;
      }
      
      public function get topRightElement() : TopRightElement
      {
         return this._topRightElement;
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         this._topLeftElement.logicUpdate(param1);
         this._topRightElement.logicUpdate(param1);
         this._bottomElement.logicUpdate(param1);
      }
      
      override public function dispose() : void
      {
         this._topLeftElement.dispose();
         this._topLeftElement = null;
         this._topRightElement.dispose();
         this._topRightElement = null;
         this._bottomElement.dispose();
         this._bottomElement = null;
         super.dispose();
      }
      
      public function get playerTimerContainer() : PlayerTimerContainer
      {
         return this._topRightElement.getPlayerTimerContainer();
      }
      
      public function get matchTimeElement() : MatchTimerElement
      {
         return this._topLeftElement.getMatchTimerElement();
      }
      
      public function get chatElementScreen() : ChatElementScreen
      {
         return this._bottomElement.chatElementScreen;
      }
      
      public function get controlsElement() : BattleHudControlsElementScreen
      {
         return this._bottomElement.controlsElement;
      }
      
      public function get bottomElement() : BottomElement
      {
         return this._bottomElement;
      }
      
      public function showHud() : void
      {
         setVisible(true);
      }
      
      public function hideHud() : void
      {
         setVisible(false);
      }
      
      override public function set logic(param1:*) : void
      {
         super.logic = param1;
         this._bottomElement.logic = param1;
      }
      
      override protected function fullscreenChanged(param1:FullScreenEvent) : void
      {
         super.fullscreenChanged(param1);
         this._topRightElement.fullscreenChanged(param1.fullScreen);
         this._topLeftElement.fullscreenChanged(param1.fullScreen);
         this._bottomElement.fullscreenChanged(param1.fullScreen);
      }
   }
}

