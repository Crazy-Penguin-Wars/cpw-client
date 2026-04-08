package tuxwars.home.ui.screen.home
{
   import com.dchoc.game.*;
   import com.dchoc.resources.*;
   import flash.display.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.ui.components.DarkBackgroundElementScreen;
   
   public class DarkBackgroundElementWindow extends DarkBackgroundElementScreen
   {
      private static const TRANSITION_OFFSET:int = 100;
      
      public function DarkBackgroundElementWindow(param1:MovieClip, param2:TuxWarsGame, param3:String, param4:String, param5:Boolean = false)
      {
         var _loc6_:MovieClip = null;
         var _loc7_:MovieClip = null;
         if(param3 != null || param4 != null)
         {
            _loc7_ = DCResourceManager.instance.getFromSWF(param3,param4);
            _loc6_ = _loc7_.getChildByName("Dark_Background_Container") as MovieClip;
         }
         else
         {
            _loc6_ = new MovieClip();
         }
         super(param1,param2,_loc6_,param5);
         this.fullscreenChanged(DCGame.isFullScreen());
      }
      
      override public function fullscreenChanged(param1:Boolean) : void
      {
         if(getDesignMovieClip())
         {
            getDesignMovieClip().width = DCGame.getStage().stageWidth;
            getDesignMovieClip().height = DCGame.getStage().stageHeight + 100;
            getDesignMovieClip().x = -getDesignMovieClip().width * 0.5;
            getDesignMovieClip().y = -(getDesignMovieClip().height * 0.5 + 100 / 2);
         }
      }
   }
}

