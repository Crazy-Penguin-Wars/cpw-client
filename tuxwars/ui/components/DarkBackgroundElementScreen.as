package tuxwars.ui.components
{
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   
   public class DarkBackgroundElementScreen extends TuxUIElementScreen
   {
       
      
      public function DarkBackgroundElementScreen(whereToAdd:MovieClip, game:TuxWarsGame, container:MovieClip, setInBackground:Boolean = false)
      {
         var _loc5_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","dark_back");
         container.addChild(_loc5_);
         if(!setInBackground)
         {
            whereToAdd.addChild(container);
         }
         else
         {
            whereToAdd.addChildAt(container,0);
         }
         super(container,game);
         setVisible(false);
      }
   }
}
