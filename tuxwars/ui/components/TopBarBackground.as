package tuxwars.ui.components
{
   import com.dchoc.game.*;
   import com.dchoc.resources.*;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.home.ui.screen.TuxUIElementScreen;
   import tuxwars.utils.*;
   
   public class TopBarBackground extends TuxUIElementScreen
   {
      private var background:MovieClip = DCResourceManager.instance.getFromSWF("flash/ui/hud_shared.swf","top_bar");
      
      public function TopBarBackground(param1:MovieClip, param2:TuxWarsGame)
      {
         super(this.background,param2);
         this.background.y = -DCGame.getStage().stageHeight * 0.5;
         param1.addChild(this.background);
         this.fullscreenChanged(DCGame.isFullScreen());
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.background = null;
      }
      
      override public function fullscreenChanged(param1:Boolean) : void
      {
         this.background.width = DCGame.getStage().stageWidth;
         TuxUiUtils.setMovieClipPosition(this.background,"top","center");
      }
   }
}

