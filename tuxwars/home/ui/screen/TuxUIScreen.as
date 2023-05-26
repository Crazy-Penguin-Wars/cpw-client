package tuxwars.home.ui.screen
{
   import com.dchoc.game.DCGame;
   import com.dchoc.states.StateMachine;
   import com.dchoc.ui.windows.UIWindow;
   import com.dchoc.utils.DCUtils;
   import com.dchoc.utils.LogUtils;
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screenhandlers.IScreen;
   
   public class TuxUIScreen extends UIWindow implements IScreen
   {
       
      
      protected var _logic;
      
      protected var _game:TuxWarsGame;
      
      protected var _params;
      
      private var _exitState:StateMachine;
      
      public function TuxUIScreen(game:TuxWarsGame, screen:MovieClip)
      {
         super(screen);
         _game = game;
         centerOnScreen();
         DCUtils.setBitmapSmoothing(true,screen);
         getDesignMovieClip().mouseEnabled = false;
         var _loc3_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.addEventListener("fullScreen",fullscreenChanged,false,0,true);
      }
      
      public function init(params:*) : void
      {
         _params = params;
      }
      
      override public function dispose() : void
      {
         var _loc1_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.removeEventListener("fullScreen",fullscreenChanged);
         _game.setFocus();
         _logic = null;
         _game = null;
         super.dispose();
      }
      
      public function set logic(logic:*) : void
      {
         _logic = logic;
      }
      
      public function get logic() : *
      {
         return _logic;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
      }
      
      public function get params() : *
      {
         return _params;
      }
      
      public function get tuxGame() : TuxWarsGame
      {
         return _game;
      }
      
      public function centerOnScreen() : void
      {
         var _loc1_:DCGame = DCGame;
         getDesignMovieClip().x = Number(com.dchoc.game.DCGame._stage.stageWidth) * 0.5;
         var _loc2_:DCGame = DCGame;
         getDesignMovieClip().y = Number(com.dchoc.game.DCGame._stage.stageHeight) * 0.5;
      }
      
      protected function fullscreenChanged(event:FullScreenEvent) : void
      {
         centerOnScreen();
      }
      
      override public function close(exitState:StateMachine = null) : void
      {
         super.close(exitState);
         _exitState = exitState;
      }
      
      override public function clean() : void
      {
         if(_exitState)
         {
            _exitState.exitCurrentState();
         }
         else if(_game && _game.homeState)
         {
            _game.homeState.exitCurrentState();
         }
         else
         {
            LogUtils.log("Unable to exit to any state, no _exitState is set and _game.homeState is null",this,3,"ErrorLogging",true,true,true);
         }
         _exitState = null;
         super.clean();
      }
   }
}
