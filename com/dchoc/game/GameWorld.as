package com.dchoc.game
{
   import com.dchoc.camera.Camera;
   import com.dchoc.events.EventQueue;
   import com.dchoc.events.InputEventHandler;
   import com.dchoc.gameobjects.GameObjectDef;
   import com.dchoc.gameobjects.GameObjects;
   import com.dchoc.input.InputSystem;
   import com.dchoc.states.StateMachine;
   import com.dchoc.utils.DCUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   
   public class GameWorld extends StateMachine
   {
      
      private static const inputSystem:InputSystem = new InputSystem();
       
      
      private const _objectContainer:WorldObjectContainer = new WorldObjectContainer();
      
      private const _backgroundContainer:MovieClip = new MovieClip();
      
      private const eventQueue:EventQueue = new EventQueue();
      
      private const inputEventHandlers:Vector.<InputEventHandler> = new Vector.<InputEventHandler>();
      
      private var _gameObjects:GameObjects;
      
      private var _game:DCGame;
      
      private var _camera:Camera;
      
      private var _worldReady:Boolean;
      
      private var _removeMarkedGameObjects:Boolean;
      
      public function GameWorld(game:DCGame)
      {
         super();
         this._game = game;
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).world = this;
         this._objectContainer.name = "ObjectContainer";
         _gameObjects = new GameObjects(game);
         _worldReady = false;
         inputSystem.setGameWorld(this);
         var _loc2_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.addEventListener("fullScreen",fullscreenChanged,false,0,true);
      }
      
      public static function getInputSystem() : InputSystem
      {
         return inputSystem;
      }
      
      public function get removeMarkedGameObjects() : Boolean
      {
         return _removeMarkedGameObjects;
      }
      
      public function set removeMarkedGameObjects(value:Boolean) : void
      {
         _removeMarkedGameObjects = value;
      }
      
      public function initCamera(zoom:Number, cameraClass:Class = null) : void
      {
         var _loc3_:Class = !!cameraClass ? cameraClass : Camera;
         _camera = new _loc3_(this,zoom);
      }
      
      public function cameraZoomingUpdated() : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var _loc1_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.removeEventListener("fullScreen",fullscreenChanged);
         removeFromStage();
         _camera.dispose();
         _camera = null;
         _gameObjects.clear();
         _gameObjects = null;
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).backgroundContainer.removeChildren(0,-1,true);
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).objectContainer.removeChildren(0,-1,true);
         inputSystem.dispose();
         _game = null;
         DCUtils.disposeAllBitmapData(_objectContainer);
         DCUtils.removeChildren(_objectContainer);
      }
      
      final public function get worldContainer() : WorldContainer
      {
         return Starling.current.root as WorldContainer;
      }
      
      public function addToStage() : void
      {
         DCGame.getMainMovieClip().addChild(this._objectContainer);
      }
      
      public function removeFromStage() : void
      {
         if(DCGame.getMainMovieClip().contains(this._objectContainer))
         {
            DCGame.getMainMovieClip().removeChild(this._objectContainer);
         }
      }
      
      public function ready() : void
      {
         _gameObjects.worldReady();
         _worldReady = true;
      }
      
      public function isWorldReady() : Boolean
      {
         return _worldReady;
      }
      
      public function addInputEventHandler(handler:InputEventHandler) : void
      {
         if(inputEventHandlers.indexOf(handler) == -1)
         {
            inputEventHandlers.push(handler);
            if(inputEventHandlers.length == 1)
            {
               registerListeners();
            }
         }
      }
      
      public function removeInputEventHandler(handler:InputEventHandler) : void
      {
         inputEventHandlers.splice(inputEventHandlers.indexOf(handler),1);
         if(inputEventHandlers.length == 0)
         {
            unregisterListeners();
         }
      }
      
      final public function get objectContainer() : WorldObjectContainer
      {
         return _objectContainer;
      }
      
      final public function get camera() : Camera
      {
         return _camera;
      }
      
      final public function get game() : DCGame
      {
         return _game;
      }
      
      final public function get gameObjects() : GameObjects
      {
         return _gameObjects;
      }
      
      public function createGameObject(def:GameObjectDef) : *
      {
         return _gameObjects.createGameObject(def);
      }
      
      public function init(value:* = null) : void
      {
      }
      
      public function addDisplayObject(displayObject:DisplayObject, index:int = -1) : void
      {
         if(index == -1)
         {
            (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).objectContainer.addChild(displayObject);
         }
         else
         {
            (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).objectContainer.addChildAt(displayObject,index);
         }
      }
      
      public function removeDisplayObject(displayObject:DisplayObject) : void
      {
         if((starling.core.Starling.current.root as com.dchoc.game.WorldContainer).objectContainer.contains(displayObject))
         {
            (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).objectContainer.removeChild(displayObject,true);
         }
      }
      
      override public function logicUpdate(deltaTime:int) : void
      {
         super.logicUpdate(deltaTime);
         inputSystem.logicUpdate(deltaTime);
         eventQueue.processNewEvents();
         while(eventQueue.hasEvents())
         {
            passInputEvents();
         }
         postInputUpdate(deltaTime);
         if(_gameObjects)
         {
            _gameObjects.logicUpdate(deltaTime,removeMarkedGameObjects);
         }
      }
      
      protected function fullscreenChanged(event:FullScreenEvent) : void
      {
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).fullscreenChanged(event.fullScreen);
      }
      
      protected function postInputUpdate(deltaTime:int) : void
      {
      }
      
      private function passInputEvents() : void
      {
         var _loc1_:Event = eventQueue.pop();
         for each(var handler in inputEventHandlers)
         {
            handler.handleInputEvent(_loc1_);
         }
      }
      
      private function registerListeners() : void
      {
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).addEventListeners();
         this._objectContainer.addEventListener("click",eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseDown",eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseUp",eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseMove",eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseOver",eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseOut",eventHandler,false,0,true);
         var _loc1_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.addEventListener("mouseLeave",eventHandler,false,0,true);
         var _loc2_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.addEventListener("keyDown",eventHandler,false,0,true);
         var _loc3_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.addEventListener("keyUp",eventHandler,false,0,true);
      }
      
      private function unregisterListeners() : void
      {
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).removeEventListeners();
         this._objectContainer.removeEventListener("click",eventHandler);
         this._objectContainer.removeEventListener("mouseDown",eventHandler);
         this._objectContainer.removeEventListener("mouseUp",eventHandler);
         this._objectContainer.removeEventListener("mouseMove",eventHandler);
         this._objectContainer.removeEventListener("mouseOver",eventHandler);
         this._objectContainer.removeEventListener("mouseOut",eventHandler);
         var _loc1_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.removeEventListener("mouseLeave",eventHandler);
         var _loc2_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.removeEventListener("keyDown",eventHandler);
         var _loc3_:DCGame = DCGame;
         com.dchoc.game.DCGame._stage.removeEventListener("keyUp",eventHandler);
      }
      
      public function eventHandler(event:Event) : void
      {
         eventQueue.addToQueue(event);
      }
   }
}
