package com.dchoc.game
{
   import com.dchoc.states.*;
   import com.dchoc.utils.*;
   import flash.display.*;
      import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFieldAutoSize;
   import flash.utils.*;
   
   public class DCGame implements IStateMachine
   {
      private static var gameTime:int;
      
      private static var _stage:Stage;
      
      private static const FRAME_RATE:int = 25;
      
      private static const mainMovieClip:MovieClip = new MovieClip();
      
      private static const _infoLayer:Sprite = new Sprite();
      
      private const stateMachine:StateMachine = new StateMachine();
      
      protected var gameLoaded:Boolean;
      
      private var _world:GameWorld;
      
      private var _updateWorld:Boolean;
      CONFIG::FPS_COUNTER {
         private var fpsCounter:TextField;
         private var fpsFrameCount:int;
         private var fpsLastTime:int;
      }
      
      public function DCGame(param1:Stage)
      {
         super();
         _stage = param1;
         mainMovieClip.name = "MainMovieClip";
         param1.showDefaultContextMenu = false;
         param1.stageFocusRect = false;
         param1.tabChildren = false;
         param1.align = "TL";
         param1.frameRate = 25;
         param1.addChild(mainMovieClip);
         _infoLayer.mouseChildren = false;
         _infoLayer.mouseEnabled = false;
         mainMovieClip.addChild(_infoLayer);
         gameTime = getTimer();
         CONFIG::FPS_COUNTER {
            this.fpsCounter = new TextField();
            this.fpsCounter.x = 4;
            this.fpsCounter.y = 4;
            this.fpsCounter.autoSize = TextFieldAutoSize.LEFT;
            this.fpsCounter.selectable = false;
            this.fpsCounter.mouseEnabled = false;
            this.fpsCounter.background = true;
            this.fpsCounter.backgroundColor = 0;
            this.fpsCounter.textColor = 16777215;
            this.fpsCounter.defaultTextFormat = new TextFormat("_sans",12,16777215,true);
            this.fpsCounter.text = "FPS: --";
            _infoLayer.addChild(this.fpsCounter);
            this.fpsLastTime = getTimer();
         }
         param1.addEventListener("enterFrame",this.runGame,false,1000,true);
      }
      
      public static function getMainMovieClip() : MovieClip
      {
         return mainMovieClip;
      }
      
      public static function getStage() : Stage
      {
         return _stage;
      }
      
      public static function get infoContainer() : Sprite
      {
         return _infoLayer;
      }
      
      public static function isFullScreen() : Boolean
      {
         CONFIG::BUILD_FOR_BROWSER {
            return DCGame.getStage().displayState == "fullScreen";
         }
         CONFIG::BUILD_FOR_PC {
            return DCGame.getStage().displayState == "fullScreenInteractive";
         }
      }
      
      public static function setFullScreen(param1:Boolean) : void
      {
         if(param1)
         {
            CONFIG::BUILD_FOR_BROWSER {
               DCGame.getStage().displayState = "fullScreen";
            }
            CONFIG::BUILD_FOR_PC {
               DCGame.getStage().displayState = "fullScreenInteractive";
            }
         }
         else
         {
            DCGame.getStage().displayState = "normal";
         }
      }
      
      public static function setScaleMode(param1:String) : void
      {
         DCGame.getStage().scaleMode = param1;
      }
      
      public static function getScaleMode() : String
      {
         return DCGame.getStage().scaleMode;
      }
      
      public static function getQuality() : String
      {
         return DCGame.getStage().quality;
      }
      
      public static function setQuality(param1:String) : void
      {
         DCGame.getStage().quality = param1;
      }
      
      public static function getTime() : int
      {
         return gameTime;
      }
      
      public function setFocus() : void
      {
         _stage.focus = mainMovieClip;
      }
      
      public function get updateWorld() : Boolean
      {
         return this._updateWorld;
      }
      
      public function set updateWorld(param1:Boolean) : void
      {
         this._updateWorld = param1;
      }
      
      public function get world() : GameWorld
      {
         return this._world;
      }
      
      public function set world(param1:GameWorld) : void
      {
         this._world = param1;
      }
      
      public function get state() : State
      {
         return this.stateMachine.state;
      }
      
      public function changeState(param1:State, param2:Boolean = false) : void
      {
         this.stateMachine.changeState(param1,param2);
      }
      
      public function exitCurrentState(param1:Boolean = false) : void
      {
         this.stateMachine.exitCurrentState(param1);
      }
      
      protected function logicUpdate(param1:int) : void
      {
         this.stateMachine.logicUpdate(param1);
         if(!this.gameLoaded)
         {
            return;
         }
         if(Boolean(this._world) && this.updateWorld)
         {
            this._world.logicUpdate(param1);
         }
         LogicUpdater.logicUpdate(param1);
      }
      
      private function runGame(param1:Event) : void
      {
         var _loc2_:int = int(getTimer());
         var _loc3_:int = _loc2_ - gameTime;
         gameTime = _loc2_;
         this.logicUpdate(_loc3_);
         CONFIG::FPS_COUNTER {
            ++this.fpsFrameCount;
            if(_loc2_ - this.fpsLastTime >= 1000)
            {
               this.fpsCounter.text = "FPS: " + this.fpsFrameCount;
               this.fpsFrameCount = 0;
               this.fpsLastTime = _loc2_;
            }
         }
         if(mainMovieClip.contains(_infoLayer))
         {
            DCUtils.bringToFront(mainMovieClip,_infoLayer);
         }
      }
   }
}

