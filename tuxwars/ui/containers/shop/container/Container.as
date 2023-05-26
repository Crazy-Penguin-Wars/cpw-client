package tuxwars.ui.containers.shop.container
{
   import com.dchoc.ui.base.UIComponent;
   import com.dchoc.ui.windows.UIContainer;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   
   public class Container extends UIContainer
   {
       
      
      private var _game:TuxWarsGame;
      
      private var _data;
      
      public function Container(design:MovieClip, data:*, game:TuxWarsGame, parent:UIComponent = null)
      {
         super(design,parent);
         _game = game;
         _data = data;
         setShowTransitions(false);
      }
      
      override public function dispose() : void
      {
         _game = null;
         _data = null;
         super.dispose();
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      public function get game() : TuxWarsGame
      {
         return _game;
      }
   }
}
