package tuxwars.home.ui.screenhandlers
{
   import com.dchoc.game.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxState;
   
   public class ScreenHandler
   {
      protected var _screen:IScreen;
      
      protected var _logic:ILogic;
      
      public function ScreenHandler(param1:Class, param2:Class, param3:TuxWarsGame, param4:TuxState)
      {
         super();
         this._screen = new param1(param3);
         this._logic = new param2(param3,param4);
         this.screen.logic = this._logic;
         this.logic.screen = this._screen;
      }
      
      public function init(param1:* = null) : void
      {
         LogicUpdater.register(this,"ScreenHandler: " + this.logic + this.screen);
         DCGame.getMainMovieClip().addChild(this.screen.design);
         this.logic.preInit(param1);
         this.screen.init(param1);
         this.logic.init(param1);
      }
      
      public function dispose() : void
      {
         LogicUpdater.unregister(this,"ScreenHandler: " + this.logic + this.screen);
         DCGame.getMainMovieClip().removeChild(this.screen.design);
         this._screen.dispose();
         this._screen = null;
         this._logic.dispose();
         this._logic = null;
      }
      
      public function stopUpdate() : void
      {
         LogicUpdater.unregister(this,"ScreenHandler: " + this.logic + this.screen);
      }
      
      public function logicUpdate(param1:int) : void
      {
         this.logic.logicUpdate(param1);
         this.screen.logicUpdate(param1);
      }
      
      public function get screen() : IScreen
      {
         return this._screen;
      }
      
      public function get logic() : ILogic
      {
         return this._logic;
      }
   }
}

