package tuxwars.home.ui.screen.home
{
   import com.dchoc.game.DCGame;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   
   public class BackgroundElementScreen extends TuxUIElementScreen
   {
      
      private static const BACKGROUND_IMAGE:String = "background_main";
       
      
      public function BackgroundElementScreen(whereToAdd:MovieClip, game:TuxWarsGame)
      {
         var _loc3_:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/home_screen.swf","background_main");
         whereToAdd.addChild(_loc3_);
         super(_loc3_,game);
         fullscreenChanged(DCGame.isFullScreen());
      }
      
      override public function fullscreenChanged(fullscreen:Boolean) : void
      {
         var _loc2_:DCGame = DCGame;
         getDesignMovieClip().width = com.dchoc.game.DCGame._stage.stageWidth;
         var _loc3_:DCGame = DCGame;
         getDesignMovieClip().height = com.dchoc.game.DCGame._stage.stageHeight;
      }
   }
}
