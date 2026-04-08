package tuxwars.ui.containers.shop
{
   import com.dchoc.ui.windows.*;
   import flash.display.DisplayObject;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIScreen;
   import tuxwars.ui.containers.shop.container.Container;
   
   public class Content extends Container
   {
      private var _containers:UIContainers = new UIContainers();
      
      public function Content(param1:DisplayObject, param2:*, param3:TuxWarsGame, param4:TuxUIScreen = null)
      {
         setShowTransitions(false);
         super(param1,param2,param3,param4);
      }
      
      override public function dispose() : void
      {
         if(this._containers)
         {
            this._containers.dispose();
            this._containers = null;
         }
         super.dispose();
      }
      
      public function get containers() : UIContainers
      {
         return this._containers;
      }
   }
}

