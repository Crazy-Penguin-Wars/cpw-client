package tuxwars.home.ui.logic
{
   import tuxwars.TuxWarsGame;
   
   public class TuxUIElementLogic
   {
       
      
      private var _game:TuxWarsGame;
      
      private var _params;
      
      private var _screen;
      
      public function TuxUIElementLogic(game:TuxWarsGame)
      {
         super();
         _game = game;
      }
      
      public function dispose() : void
      {
         _game = null;
         _params = null;
         _screen = null;
      }
      
      public function init(params:*) : void
      {
         _params = params;
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
      }
      
      public function set screen(screen:*) : void
      {
         _screen = screen;
      }
      
      public function get screen() : *
      {
         return _screen;
      }
      
      public function get params() : *
      {
         return _params;
      }
      
      public function get game() : TuxWarsGame
      {
         return _game;
      }
   }
}
