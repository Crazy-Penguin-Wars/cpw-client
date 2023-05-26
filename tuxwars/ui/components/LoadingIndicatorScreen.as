package tuxwars.ui.components
{
   import avmplus.getQualifiedClassName;
   import com.dchoc.game.DCGame;
   import com.dchoc.resources.DCResourceManager;
   import com.dchoc.states.State;
   import com.dchoc.ui.text.UIAutoTextField;
   import flash.display.MovieClip;
   import flash.events.FullScreenEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import tuxwars.TuxWarsGame;
   import tuxwars.states.TuxLoadingStartUpAssetsSubState;
   import tuxwars.states.TuxLoadingStartUpSharedAssetsSubState;
   import tuxwars.utils.TuxUiUtils;
   
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
      
      public function LoadingIndicatorScreen(game:TuxWarsGame, loadingTID:String, delayBeforeActivate:int = 250, darkBackgroundAlpha:Number = -1)
      {
         super();
         if(game)
         {
            _game = game;
            _design = DCGame.getMainMovieClip();
            _loadingTID = loadingTID;
            if(addLoadingScreen(game.currentState))
            {
               _timer = new Timer(delayBeforeActivate,1);
               _timer.addEventListener("timerComplete",timerCallback);
               _timer.start();
               _darkBackground = DCResourceManager.instance.getFromSWF("flash/ui/loading_anim.swf","dark_back");
               var _loc5_:DCGame = DCGame;
               _darkBackground.width = com.dchoc.game.DCGame._stage.stageWidth;
               var _loc6_:DCGame = DCGame;
               _darkBackground.height = com.dchoc.game.DCGame._stage.stageHeight;
               if(darkBackgroundAlpha != -1)
               {
                  _darkBackground.alpha = darkBackgroundAlpha;
               }
               _loadingImage = DCResourceManager.instance.getFromSWF("flash/ui/loading_anim.swf","loading_default");
               var _loc7_:DCGame = DCGame;
               _loadingImage.x = Number(com.dchoc.game.DCGame._stage.stageWidth) * 0.5;
               var _loc8_:DCGame = DCGame;
               _loadingImage.y = Number(com.dchoc.game.DCGame._stage.stageHeight) * 0.5;
               if(_loadingImage)
               {
                  _loadingText = TuxUiUtils.createAutoTextField(_loadingImage.Text_Message,loadingTID);
               }
               var _loc9_:DCGame = DCGame;
               com.dchoc.game.DCGame._stage.addEventListener("fullScreen",fullscreenChanged,false,0,true);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.removeEventListener("fullScreen",fullscreenChanged);
         if(_timer)
         {
            _timer.stop();
            _timer = null;
         }
         if(_darkBackground && _design.contains(_darkBackground))
         {
            _design.removeChild(_darkBackground);
         }
         _darkBackground = null;
         if(_loadingImage && _design.contains(_loadingImage))
         {
            _design.removeChild(_loadingImage);
         }
         _loadingImage = null;
         _design = null;
         _game = null;
      }
      
      private function fullscreenChanged(event:FullScreenEvent) : void
      {
         if(_darkBackground)
         {
            var _loc2_:DCGame = DCGame;
            _darkBackground.width = com.dchoc.game.DCGame._stage.stageWidth;
            var _loc3_:DCGame = DCGame;
            _darkBackground.height = com.dchoc.game.DCGame._stage.stageHeight;
         }
         if(_loadingImage)
         {
            var _loc4_:DCGame = DCGame;
            _loadingImage.x = Number(com.dchoc.game.DCGame._stage.stageWidth) * 0.5;
            var _loc5_:DCGame = DCGame;
            _loadingImage.y = Number(com.dchoc.game.DCGame._stage.stageHeight) * 0.5;
         }
      }
      
      private function timerCallback(event:TimerEvent) : void
      {
         _timer.stop();
         _timer = null;
         if(_darkBackground)
         {
            _design.addChild(_darkBackground);
         }
         if(_loadingImage)
         {
            _design.addChild(_loadingImage);
         }
      }
      
      private function addLoadingScreen(current:State) : Boolean
      {
         switch(getQualifiedClassName(current))
         {
            case getQualifiedClassName(TuxLoadingStartUpSharedAssetsSubState):
               break;
            case getQualifiedClassName(TuxLoadingStartUpAssetsSubState):
               break;
            default:
               return true;
         }
         return false;
      }
   }
}
