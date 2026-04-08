package tuxwars.home.ui.screen
{
   import com.dchoc.game.DCGame;
   import com.dchoc.ui.windows.UIWindow;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.FullScreenEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.tooltips.*;
   
   public class TuxUIElementScreen extends UIWindow
   {
      private var _game:TuxWarsGame;
      
      private var _logic:*;
      
      public function TuxUIElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         super(param1);
         this._game = param2;
         DCUtils.setBitmapSmoothing(true,param1 as MovieClip);
         DCGame.getStage().addEventListener("fullScreen",this.fullscreenChangedEvent,false,0,true);
      }
      
      override public function dispose() : void
      {
         this._game = null;
         this._logic = null;
         DCGame.getStage().removeEventListener("fullScreen",this.fullscreenChangedEvent);
         TooltipManager.removeTooltip();
         super.dispose();
      }
      
      public function fullscreenChanged(param1:Boolean) : void
      {
      }
      
      public function fullscreenChangedEvent(param1:FullScreenEvent) : void
      {
         this.fullscreenChanged(param1.fullScreen);
      }
      
      public function logicUpdate(param1:int) : void
      {
      }
      
      public function get game() : TuxWarsGame
      {
         return this._game;
      }
      
      public function set logic(param1:*) : void
      {
         this._logic = param1;
      }
      
      public function get logic() : *
      {
         return this._logic;
      }
   }
}

