package tuxwars.home.ui.screen
{
   import com.dchoc.game.DCGame;
   import com.dchoc.states.StateMachine;
   import com.dchoc.ui.windows.UIWindow;
   import com.dchoc.utils.*;
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screenhandlers.*;
   
   public class TuxUIScreen extends UIWindow implements IScreen
   {
      protected var _logic:*;
      
      protected var _game:TuxWarsGame;
      
      protected var _params:*;
      
      private var _exitState:StateMachine;
      
      public function TuxUIScreen(param1:TuxWarsGame, param2:MovieClip)
      {
         super(param2);
         this._game = param1;
         this.centerOnScreen();
         DCUtils.setBitmapSmoothing(true,param2);
         getDesignMovieClip().mouseEnabled = false;
         DCGame.getStage().addEventListener("fullScreen",this.fullscreenChanged,false,0,true);
      }
      
      public function init(param1:*) : void
      {
         this._params = param1;
      }
      
      override public function dispose() : void
      {
         DCGame.getStage().removeEventListener("fullScreen",this.fullscreenChanged);
         this._game.setFocus();
         this._logic = null;
         this._game = null;
         super.dispose();
      }
      
      public function set logic(param1:*) : void
      {
         this._logic = param1;
      }
      
      public function get logic() : *
      {
         return this._logic;
      }
      
      public function logicUpdate(param1:int) : void
      {
      }
      
      public function get params() : *
      {
         return this._params;
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return this._game;
      }
      
      public function centerOnScreen() : void
      {
         getDesignMovieClip().x = DCGame.getStage().stageWidth * 0.5;
         getDesignMovieClip().y = DCGame.getStage().stageHeight * 0.5;
      }
      
      protected function fullscreenChanged(param1:FullScreenEvent) : void
      {
         this.centerOnScreen();
      }
      
      override public function close(param1:StateMachine = null) : void
      {
         super.close(param1);
         this._exitState = param1;
      }
      
      override public function clean() : void
      {
         if(this._exitState)
         {
            this._exitState.exitCurrentState();
         }
         else if(Boolean(this._game) && Boolean(this._game.homeState))
         {
            this._game.homeState.exitCurrentState();
         }
         else if(Boolean(this._game) && Boolean(this._game.battleState))
         {
            this._game.battleState.exitCurrentState();
         }
         else
         {
            LogUtils.log("Unable to exit to any state, no _exitState is set and _game.homeState is null",this,3,"ErrorLogging",true,true,true);
         }
         this._exitState = null;
         super.clean();
      }
   }
}

