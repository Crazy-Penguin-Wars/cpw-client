package com.dchoc.game
{
   import com.dchoc.camera.*;
   import com.dchoc.events.*;
   import com.dchoc.gameobjects.*;
   import com.dchoc.input.*;
   import com.dchoc.states.StateMachine;
   import com.dchoc.utils.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.events.FullScreenEvent;
   import starling.core.*;
   import starling.display.DisplayObject;
   
   public class GameWorld extends StateMachine
   {
      private static const inputSystem:InputSystem = new InputSystem();
      
      private const _objectContainer:WorldObjectContainer = new WorldObjectContainer();
      
      private const _backgroundContainer:MovieClip = new MovieClip();
      
      private const eventQueue:EventQueue = new EventQueue();
      
      private const inputEventHandlers:Vector.<InputEventHandler> = new Vector.<InputEventHandler>();
      
      private var __gameObjects:GameObjects;
      
      private var _game:DCGame;
      
      private var _camera:Camera;
      
      private var _worldReady:Boolean;
      
      private var _removeMarkedGameObjects:Boolean;
      
      public function GameWorld(param1:DCGame)
      {
         super();
         this._game = param1;
         (Starling.current.root as WorldContainer).world = this;
         this._objectContainer.name = "ObjectContainer";
         this.__gameObjects = new GameObjects(param1);
         this._worldReady = false;
         inputSystem.setGameWorld(this);
         DCGame.getStage().addEventListener("fullScreen",this.fullscreenChanged,false,0,true);
      }
      
      public static function getInputSystem() : InputSystem
      {
         return inputSystem;
      }
      
      public function get removeMarkedGameObjects() : Boolean
      {
         return this._removeMarkedGameObjects;
      }
      
      public function set removeMarkedGameObjects(param1:Boolean) : void
      {
         this._removeMarkedGameObjects = param1;
      }
      
      public function initCamera(param1:Number, param2:Class = null) : void
      {
         var _loc3_:Class = !!param2 ? param2 : Camera;
         this._camera = new _loc3_(this,param1);
      }
      
      public function cameraZoomingUpdated() : void
      {
      }
      
      override public function dispose() : void
      {
         super.dispose();
         DCGame.getStage().removeEventListener("fullScreen",this.fullscreenChanged);
         this.removeFromStage();
         this._camera.dispose();
         this._camera = null;
         this.__gameObjects.clear();
         this.__gameObjects = null;
         (Starling.current.root as WorldContainer).backgroundContainer.removeChildren(0,-1,true);
         (Starling.current.root as WorldContainer).objectContainer.removeChildren(0,-1,true);
         inputSystem.dispose();
         this._game = null;
         DCUtils.disposeAllBitmapData(this._objectContainer);
         DCUtils.removeChildren(this._objectContainer);
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
         this.__gameObjects.worldReady();
         this._worldReady = true;
      }
      
      public function isWorldReady() : Boolean
      {
         return this._worldReady;
      }
      
      public function addInputEventHandler(param1:InputEventHandler) : void
      {
         if(this.inputEventHandlers.indexOf(param1) == -1)
         {
            this.inputEventHandlers.push(param1);
            if(this.inputEventHandlers.length == 1)
            {
               this.registerListeners();
            }
         }
      }
      
      public function removeInputEventHandler(param1:InputEventHandler) : void
      {
         this.inputEventHandlers.splice(this.inputEventHandlers.indexOf(param1),1);
         if(this.inputEventHandlers.length == 0)
         {
            this.unregisterListeners();
         }
      }
      
      final public function get objectContainer() : WorldObjectContainer
      {
         return this._objectContainer;
      }
      
      final public function get camera() : Camera
      {
         return this._camera;
      }
      
      final public function get game() : DCGame
      {
         return this._game;
      }
      
      final public function get gameObjects() : GameObjects
      {
         return this.__gameObjects;
      }
      
      final public function get _gameObjects() : GameObjects
      {
         return this.__gameObjects;
      }
      
      public function createGameObject(param1:GameObjectDef) : *
      {
         return this.__gameObjects.createGameObject(param1);
      }
      
      public function init(param1:* = null) : void
      {
      }
      
      public function addDisplayObject(param1:starling.display.DisplayObject, param2:int = -1) : void
      {
         if(param2 == -1)
         {
            (Starling.current.root as WorldContainer).objectContainer.addChild(param1);
         }
         else
         {
            (Starling.current.root as WorldContainer).objectContainer.addChildAt(param1,param2);
         }
      }
      
      public function removeDisplayObject(param1:starling.display.DisplayObject) : void
      {
         if((Starling.current.root as WorldContainer).objectContainer.contains(param1))
         {
            (Starling.current.root as WorldContainer).objectContainer.removeChild(param1,true);
         }
      }
      
      override public function logicUpdate(param1:int) : void
      {
         super.logicUpdate(param1);
         inputSystem.logicUpdate(param1);
         this.eventQueue.processNewEvents();
         while(this.eventQueue.hasEvents())
         {
            this.passInputEvents();
         }
         this.postInputUpdate(param1);
         if(this.__gameObjects)
         {
            this.__gameObjects.logicUpdate(param1,this.removeMarkedGameObjects);
         }
      }
      
      protected function fullscreenChanged(param1:FullScreenEvent) : void
      {
         (Starling.current.root as WorldContainer).fullscreenChanged(param1.fullScreen);
      }
      
      protected function postInputUpdate(param1:int) : void
      {
      }
      
      private function passInputEvents() : void
      {
         var _loc2_:* = undefined;
         var _loc1_:Event = this.eventQueue.pop();
         for each(_loc2_ in this.inputEventHandlers)
         {
            _loc2_.handleInputEvent(_loc1_);
         }
      }
      
      private function registerListeners() : void
      {
         (Starling.current.root as WorldContainer).addEventListeners();
         this._objectContainer.addEventListener("click",this.eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseDown",this.eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseUp",this.eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseMove",this.eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseOver",this.eventHandler,false,0,true);
         this._objectContainer.addEventListener("mouseOut",this.eventHandler,false,0,true);
         DCGame.getStage().addEventListener("mouseLeave",this.eventHandler,false,0,true);
         DCGame.getStage().addEventListener("keyDown",this.eventHandler,false,0,true);
         DCGame.getStage().addEventListener("keyUp",this.eventHandler,false,0,true);
      }
      
      private function unregisterListeners() : void
      {
         (Starling.current.root as WorldContainer).removeEventListeners();
         this._objectContainer.removeEventListener("click",this.eventHandler);
         this._objectContainer.removeEventListener("mouseDown",this.eventHandler);
         this._objectContainer.removeEventListener("mouseUp",this.eventHandler);
         this._objectContainer.removeEventListener("mouseMove",this.eventHandler);
         this._objectContainer.removeEventListener("mouseOver",this.eventHandler);
         this._objectContainer.removeEventListener("mouseOut",this.eventHandler);
         DCGame.getStage().removeEventListener("mouseLeave",this.eventHandler);
         DCGame.getStage().removeEventListener("keyDown",this.eventHandler);
         DCGame.getStage().removeEventListener("keyUp",this.eventHandler);
      }
      
      public function eventHandler(param1:Event) : void
      {
         this.eventQueue.addToQueue(param1);
      }
   }
}

