package tuxwars.home.states
{
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screenhandlers.ScreenHandler;
   import tuxwars.states.TuxState;
   
   public class TuxUIState extends TuxState
   {
       
      
      protected var _screenHandler:ScreenHandler;
      
      public function TuxUIState(screenClass:Class, logicClass:Class, game:TuxWarsGame, params:* = null)
      {
         super(game,params);
         _screenHandler = new ScreenHandler(screenClass,logicClass,game,this);
      }
      
      override public function enter() : void
      {
         super.enter();
         _screenHandler.init(_params);
      }
      
      override public function exit() : void
      {
         _screenHandler.dispose();
         super.exit();
      }
      
      public function get screenHandler() : ScreenHandler
      {
         return _screenHandler;
      }
   }
}
