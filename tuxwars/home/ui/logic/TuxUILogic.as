package tuxwars.home.ui.logic
{
   import com.dchoc.states.StateMachine;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screenhandlers.*;
   import tuxwars.states.TuxState;
   
   public class TuxUILogic implements ILogic
   {
      private var _screen:*;
      
      private var _game:TuxWarsGame;
      
      private var _params:*;
      
      private var _state:TuxState;
      
      public function TuxUILogic(param1:TuxWarsGame, param2:TuxState)
      {
         super();
         this._game = param1;
         this._state = param2;
      }
      
      public function preInit(param1:*) : void
      {
         this._params = param1;
      }
      
      public function init(param1:*) : void
      {
         this.screen.setState("Visible");
      }
      
      public function logicUpdate(param1:int) : void
      {
      }
      
      public function get game() : TuxWarsGame
      {
         return this._game;
      }
      
      public function get state() : TuxState
      {
         return this._state;
      }
      
      public function set screen(param1:*) : void
      {
         this._screen = param1;
         this._screen.setState("Close");
      }
      
      public function get screen() : *
      {
         return this._screen;
      }
      
      public function dispose() : void
      {
         this._screen = null;
         this._params = null;
         this._game = null;
      }
      
      public function get params() : *
      {
         return this._params;
      }
      
      public function close(param1:StateMachine = null) : void
      {
         this._screen.close(param1);
      }
   }
}

