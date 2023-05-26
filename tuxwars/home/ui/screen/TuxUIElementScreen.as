package tuxwars.home.ui.screen
{
   import com.dchoc.game.DCGame;
   import com.dchoc.ui.windows.UIWindow;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.tooltips.TooltipManager;
   
   public class TuxUIElementScreen extends UIWindow
   {
       
      
      private var _game:TuxWarsGame;
      
      private var _logic;
      
      public function TuxUIElementScreen(design:MovieClip, game:TuxWarsGame)
      {
         super(design);
         _game = game;
         DCUtils.setBitmapSmoothing(true,design as MovieClip);
         var _loc3_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.addEventListener("fullScreen",fullscreenChangedEvent,false,0,true);
      }
      
      override public function dispose() : void
      {
         _game = null;
         _logic = null;
         var _loc1_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.removeEventListener("fullScreen",fullscreenChangedEvent);
         TooltipManager.removeTooltip();
         super.dispose();
      }
      
      public function fullscreenChanged(fullscreen:Boolean) : void
      {
      }
      
      public function fullscreenChangedEvent(event:FullScreenEvent) : void
      {
         fullscreenChanged(event.fullScreen);
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
      }
      
      public function get game() : TuxWarsGame
      {
         return _game;
      }
      
      public function set logic(logic:*) : void
      {
         _logic = logic;
      }
      
      public function get logic() : *
      {
         return _logic;
      }
   }
}
