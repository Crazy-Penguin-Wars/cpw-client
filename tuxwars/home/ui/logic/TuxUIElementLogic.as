package tuxwars.home.ui.logic
{
   import tuxwars.TuxWarsGame;
   
   public class TuxUIElementLogic
   {
      private var _game:TuxWarsGame;
      
      private var _params:*;
      
      private var _screen:*;
      
      public function TuxUIElementLogic(param1:TuxWarsGame)
      {
         super();
         this._game = param1;
      }
      
      public function dispose() : void
      {
         this._game = null;
         this._params = null;
         this._screen = null;
      }
      
      public function init(param1:*) : void
      {
         this._params = param1;
      }
      
      public function logicUpdate(param1:int) : void
      {
      }
      
      public function set screen(param1:*) : void
      {
         this._screen = param1;
      }
      
      public function get screen() : *
      {
         return this._screen;
      }
      
      public function get params() : *
      {
         return this._params;
      }
      
      public function get game() : TuxWarsGame
      {
         return this._game;
      }
   }
}

