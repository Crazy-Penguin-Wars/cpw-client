package tuxwars.ui.containers.shop
{
   import com.dchoc.ui.windows.UIContainers;
   import flash.display.DisplayObject;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.ui.containers.shop.container.Container;
   
   public class Content extends Container
   {
       
      
      private var _containers:UIContainers;
      
      public function Content(design:DisplayObject, data:*, game:TuxWarsGame, parent:TuxUIScreen = null)
      {
         _containers = new UIContainers();
         setShowTransitions(false);
         super(design,data,game,parent);
      }
      
      override public function dispose() : void
      {
         if(_containers)
         {
            _containers.dispose();
            _containers = null;
         }
         super.dispose();
      }
      
      public function get containers() : UIContainers
      {
         return _containers;
      }
   }
}
