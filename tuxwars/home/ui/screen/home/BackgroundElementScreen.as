package tuxwars.home.ui.screen.home
{
   import com.dchoc.game.*;
   import com.dchoc.resources.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   
   public class BackgroundElementScreen extends TuxUIElementScreen
   {
      private static const BACKGROUND_IMAGE:String = "background_main";
      
      public function BackgroundElementScreen(param1:MovieClip, param2:TuxWarsGame)
      {
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","background_main");
         param1.addChild(_loc3_);
         super(_loc3_,param2);
         this.fullscreenChanged(DCGame.isFullScreen());
      }
      
      override public function fullscreenChanged(param1:Boolean) : void
      {
         getDesignMovieClip().width = DCGame.getStage().stageWidth;
         getDesignMovieClip().height = DCGame.getStage().stageHeight;
      }
   }
}

