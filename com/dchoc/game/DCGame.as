package com.dchoc.game
{
   import com.dchoc.states.IStateMachine;
   import com.dchoc.states.State;
   import com.dchoc.states.StateMachine;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   public class DCGame implements IStateMachine
   {
      
      private static const FRAME_RATE:int = 25;
      
      private static const mainMovieClip:MovieClip = new MovieClip();
      
      private static const _infoLayer:Sprite = new Sprite();
      
      private static var gameTime:int;
      
      private static var _stage:Stage;
       
      
      private const stateMachine:StateMachine = new StateMachine();
      
      protected var gameLoaded:Boolean;
      
      private var _world:GameWorld;
      
      private var _updateWorld:Boolean;
      
      public function DCGame(stage:Stage)
      {
         super();
         _stage = stage;
         mainMovieClip.name = "MainMovieClip";
         stage.showDefaultContextMenu = false;
         stage.stageFocusRect = false;
         stage.tabChildren = false;
         stage.align = "TL";
         stage.frameRate = 25;
         stage.addChild(mainMovieClip);
         _infoLayer.mouseChildren = false;
         _infoLayer.mouseEnabled = false;
         mainMovieClip.addChild(_infoLayer);
         gameTime = getTimer();
         stage.addEventListener("enterFrame",runGame,false,1000,true);
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
         return com.dchoc.game.DCGame._stage.displayState == "fullScreen";
      }
      
      public static function setFullScreen(value:Boolean, stageScaleMode:String = null) : void
      {
         if(stageScaleMode)
         {
            setScaleMode(stageScaleMode);
         }
         if(value)
         {
            com.dchoc.game.DCGame._stage.displayState = "fullScreen";
         }
         else
         {
            com.dchoc.game.DCGame._stage.displayState = "normal";
         }
      }
      
      public static function setScaleMode(value:String) : void
      {
         com.dchoc.game.DCGame._stage.scaleMode = value;
      }
      
      public static function getScaleMode() : String
      {
         return com.dchoc.game.DCGame._stage.scaleMode;
      }
      
      public static function getQuality() : String
      {
         return com.dchoc.game.DCGame._stage.quality;
      }
      
      public static function setQuality(value:String) : void
      {
         com.dchoc.game.DCGame._stage.quality = value;
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
         return _updateWorld;
      }
      
      public function set updateWorld(value:Boolean) : void
      {
         _updateWorld = value;
      }
      
      public function get world() : GameWorld
      {
         return _world;
      }
      
      public function set world(value:GameWorld) : void
      {
         _world = value;
      }
      
      public function get state() : State
      {
         return stateMachine.state;
      }
      
      public function changeState(state:State, immediately:Boolean = false) : void
      {
         stateMachine.changeState(state,immediately);
      }
      
      public function exitCurrentState(clearQueue:Boolean = false) : void
      {
         stateMachine.exitCurrentState(clearQueue);
      }
      
      protected function logicUpdate(deltaTime:int) : void
      {
         stateMachine.logicUpdate(deltaTime);
         if(!gameLoaded)
         {
            return;
         }
         if(_world && updateWorld)
         {
            _world.logicUpdate(deltaTime);
         }
         LogicUpdater.logicUpdate(deltaTime);
      }
      
      private function runGame(e:Event) : void
      {
         var _loc3_:int = getTimer();
         var _loc2_:int = _loc3_ - gameTime;
         gameTime = _loc3_;
         logicUpdate(_loc2_);
         if(mainMovieClip.contains(_infoLayer))
         {
            DCUtils.bringToFront(mainMovieClip,_infoLayer);
         }
      }
   }
}
