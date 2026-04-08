package tuxwars.ui.components
{
   import avmplus.*;
   import com.dchoc.game.*;
   import com.dchoc.resources.*;
   import com.dchoc.states.State;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import flash.events.TimerEvent;
   import flash.utils.*;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.*;
   import tuxwars.utils.*;
   
   public class LoadingIndicatorScreen
   {
      private static const LOADING_DEFAULT:String = "loading_default";
      
      private var _game:TuxWarsGame;
      
      private var _design:MovieClip;
      
      private var _darkBackground:MovieClip;
      
      private var _loadingImage:MovieClip;
      
      private var _loadingText:UIAutoTextField;
      
      private var _loadingTID:String;
      
      private var _timer:Timer;
      
      public function LoadingIndicatorScreen(param1:TuxWarsGame, param2:String, param3:int = 250, param4:Number = -1)
      {
         super();
         if(param1)
         {
            this._game = param1;
            this._design = DCGame.getMainMovieClip();
            this._loadingTID = param2;
            if(this.addLoadingScreen(param1.currentState))
            {
               this._timer = new Timer(param3,1);
               this._timer.addEventListener("timerComplete",this.timerCallback);
               this._timer.start();
               this._darkBackground = DCResourceManager.instance.getFromSWF("flash/ui/loading_anim.swf","dark_back");
               this._darkBackground.width = DCGame.getStage().stageWidth;
               this._darkBackground.height = DCGame.getStage().stageHeight;
               if(param4 != -1)
               {
                  this._darkBackground.alpha = param4;
               }
               this._loadingImage = DCResourceManager.instance.getFromSWF("flash/ui/loading_anim.swf","loading_default");
               this._loadingImage.x = DCGame.getStage().stageWidth * 0.5;
               this._loadingImage.y = DCGame.getStage().stageHeight * 0.5;
               if(this._loadingImage)
               {
                  this._loadingText = TuxUiUtils.createAutoTextField(this._loadingImage.Text_Message,param2);
               }
               DCGame.getStage().addEventListener("fullScreen",this.fullscreenChanged,false,0,true);
            }
         }
      }
      
      public function dispose() : void
      {
         DCGame.getStage().removeEventListener("fullScreen",this.fullscreenChanged);
         if(this._timer)
         {
            this._timer.stop();
            this._timer = null;
         }
         if(Boolean(this._darkBackground) && Boolean(this._design.contains(this._darkBackground)))
         {
            this._design.removeChild(this._darkBackground);
         }
         this._darkBackground = null;
         if(Boolean(this._loadingImage) && Boolean(this._design.contains(this._loadingImage)))
         {
            this._design.removeChild(this._loadingImage);
         }
         this._loadingImage = null;
         this._design = null;
         this._game = null;
      }
      
      private function fullscreenChanged(param1:FullScreenEvent) : void
      {
         if(this._darkBackground)
         {
            this._darkBackground.width = DCGame.getStage().stageWidth;
            this._darkBackground.height = DCGame.getStage().stageHeight;
         }
         if(this._loadingImage)
         {
            this._loadingImage.x = DCGame.getStage().stageWidth * 0.5;
            this._loadingImage.y = DCGame.getStage().stageHeight * 0.5;
         }
      }
      
      private function timerCallback(param1:TimerEvent) : void
      {
         this._timer.stop();
         this._timer = null;
         if(this._darkBackground)
         {
            this._design.addChild(this._darkBackground);
         }
         if(this._loadingImage)
         {
            this._design.addChild(this._loadingImage);
         }
      }
      
      private function addLoadingScreen(param1:State) : Boolean
      {
         switch(getQualifiedClassName(param1))
         {
            case getQualifiedClassName(TuxLoadingStartUpSharedAssetsSubState):
            case getQualifiedClassName(TuxLoadingStartUpAssetsSubState):
               return false;
            default:
               return true;
         }
      }
   }
}

