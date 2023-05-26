package tuxwars.home.ui.screenhandlers
{
   import com.dchoc.game.DCGame;
   import com.dchoc.game.LogicUpdater;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class ScreenHandler
   {
       
      
      protected var _screen:IScreen;
      
      protected var _logic:ILogic;
      
      public function ScreenHandler(screenClass:Class, logicClass:Class, game:TuxWarsGame, state:TuxState)
      {
         super();
         _screen = new screenClass(game);
         _logic = new logicClass(game,state);
         screen.logic = _logic;
         logic.screen = _screen;
      }
      
      public function init(params:* = null) : void
      {
         LogicUpdater.register(this,"ScreenHandler: " + logic + screen);
         DCGame.getMainMovieClip().addChild(screen.design);
         logic.preInit(params);
         screen.init(params);
         logic.init(params);
      }
      
      public function dispose() : void
      {
         LogicUpdater.unregister(this,"ScreenHandler: " + logic + screen);
         DCGame.getMainMovieClip().removeChild(screen.design);
         _screen.dispose();
         _screen = null;
         _logic.dispose();
         _logic = null;
      }
      
      public function stopUpdate() : void
      {
         LogicUpdater.unregister(this,"ScreenHandler: " + logic + screen);
      }
      
      public function logicUpdate(deltaTime:int) : void
      {
         logic.logicUpdate(deltaTime);
         screen.logicUpdate(deltaTime);
      }
      
      public function get screen() : IScreen
      {
         return _screen;
      }
      
      public function get logic() : ILogic
      {
         return _logic;
      }
   }
}
