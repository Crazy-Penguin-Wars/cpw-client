package tuxwars.ui.containers.shop.container
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   
   public class Container extends UIContainer
   {
      private var _game:TuxWarsGame;
      
      private var _data:*;
      
      public function Container(param1:MovieClip, param2:*, param3:TuxWarsGame, param4:UIComponent = null)
      {
         super(param1,param4);
         this._game = param3;
         this._data = param2;
         setShowTransitions(false);
      }
      
      override public function dispose() : void
      {
         this._game = null;
         this._data = null;
         super.dispose();
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function get game() : TuxWarsGame
      {
         return this._game;
      }
   }
}

