package tuxwars.home.ui.screen.home
{
   import com.dchoc.game.DCGame;
   import com.dchoc.resources.DCResourceManager;
   import flash.display.MovieClip;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.components.DarkBackgroundElementScreen;
   
   public class DarkBackgroundElementWindow extends DarkBackgroundElementScreen
   {
      
      private static const TRANSITION_OFFSET:int = 100;
       
      
      public function DarkBackgroundElementWindow(whereToAdd:MovieClip, game:TuxWarsGame, swf:String, export:String, setInBackground:Boolean = false)
      {
         var container:* = null;
         var _loc7_:* = null;
         if(swf != null || export != null)
         {
            _loc7_ = DCResourceManager.instance.getFromSWF(swf,export);
            container = _loc7_.getChildByName("Dark_Background_Container") as MovieClip;
         }
         else
         {
            container = new MovieClip();
         }
         super(whereToAdd,game,container,setInBackground);
         fullscreenChanged(DCGame.isFullScreen());
      }
      
      override public function fullscreenChanged(fullscreen:Boolean) : void
      {
         if(getDesignMovieClip())
         {
            var _loc2_:DCGame = DCGame;
            getDesignMovieClip().width = com.dchoc.game.DCGame._stage.stageWidth;
            var _loc3_:DCGame = DCGame;
            getDesignMovieClip().height = com.dchoc.game.DCGame._stage.stageHeight + 100;
            getDesignMovieClip().x = -getDesignMovieClip().width * 0.5;
            getDesignMovieClip().y = -(getDesignMovieClip().height * 0.5 + 100 / 2);
         }
      }
   }
}
