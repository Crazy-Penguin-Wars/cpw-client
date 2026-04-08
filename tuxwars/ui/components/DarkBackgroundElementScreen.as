package tuxwars.ui.components
{
   import com.dchoc.resources.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   
   public class DarkBackgroundElementScreen extends TuxUIElementScreen
   {
      public function DarkBackgroundElementScreen(param1:MovieClip, param2:TuxWarsGame, param3:MovieClip, param4:Boolean = false)
      {
         var _loc5_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","dark_back");
         param3.addChild(_loc5_);
         if(!param4)
         {
            param1.addChild(param3);
         }
         else
         {
            param1.addChildAt(param3,0);
         }
         super(param3,param2);
         setVisible(false);
      }
   }
}

