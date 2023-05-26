package tuxwars.home.ui.logic
{
   import com.dchoc.states.StateMachine;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screenhandlers.ILogic;
   import tuxwars.states.TuxState;
   
   public class TuxUILogic implements ILogic
   {
       
      
      private var _screen;
      
      private var _game:TuxWarsGame;
      
      private var _params;
      
      private var _state:TuxState;
      
      public function TuxUILogic(game:TuxWarsGame, state:TuxState)
      {
         super();
         _game = game;
         _state = state;
      }
      
      public function preInit(params:*) : void
      {
         _params = params;
      }
      
      public function init(params:*) : void
      {
         screen.setState("Visible");
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
      }
      
      public function get game() : TuxWarsGame
      {
         return _game;
      }
      
      public function get state() : TuxState
      {
         return _state;
      }
      
      public function set screen(screen:*) : void
      {
         _screen = screen;
         _screen.setState("Close");
      }
      
      public function get screen() : *
      {
         return _screen;
      }
      
      public function dispose() : void
      {
         _screen = null;
         _params = null;
         _game = null;
      }
      
      public function get params() : *
      {
         return _params;
      }
      
      public function close(exitState:StateMachine = null) : void
      {
         _screen.close(exitState);
      }
   }
}
