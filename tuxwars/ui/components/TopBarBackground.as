package tuxwars.ui.components
{
   import com.dchoc.game.DCGame;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.utils.TuxUiUtils;
   
   public class TopBarBackground extends TuxUIElementScreen
   {
       
      
      private var background:MovieClip;
      
      public function TopBarBackground(whereToAdd:MovieClip, game:TuxWarsGame)
      {
         background = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","top_bar");
         super(background,game);
         var _loc3_:DCGame = DCGame;
         background.y = -Number(com.dchoc.game.DCGame._stage.stageHeight) * 0.5;
         whereToAdd.addChild(background);
         fullscreenChanged(DCGame.isFullScreen());
      }
      
      override public function dispose() : void
      {
         super.dispose();
         background = null;
      }
      
      override public function fullscreenChanged(fullscreen:Boolean) : void
      {
         var _loc2_:DCGame = DCGame;
         background.width = com.dchoc.game.DCGame._stage.stageWidth;
         TuxUiUtils.setMovieClipPosition(background,"top","center");
      }
   }
}
