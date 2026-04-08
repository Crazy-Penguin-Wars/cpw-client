package tuxwars.home.states
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screenhandlers.*;
   import tuxwars.states.TuxState;
   
   public class TuxUIState extends TuxState
   {
      protected var _screenHandler:ScreenHandler;
      
      public function TuxUIState(param1:Class, param2:Class, param3:TuxWarsGame, param4:* = null)
      {
         super(param3,param4);
         this._screenHandler = new ScreenHandler(param1,param2,param3,this);
      }
      
      override public function enter() : void
      {
         super.enter();
         this._screenHandler.init(_params);
      }
      
      override public function exit() : void
      {
         this._screenHandler.dispose();
         super.exit();
      }
      
      public function get screenHandler() : ScreenHandler
      {
         return this._screenHandler;
      }
   }
}

