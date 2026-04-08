package com.dchoc.game
{
   import flash.events.*;
   import flash.geom.*;
   import starling.core.*;
   import starling.display.*;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class WorldContainer extends Sprite
   {
      private const _backgroundContainer:Sprite = new Sprite();
      
      private const _objectContainer:Sprite = new Sprite();
      
      private var _world:GameWorld;
      
      public function WorldContainer()
      {
         super();
         addEventListener("addedToStage",this.addedToStage);
      }
      
      public function set world(param1:GameWorld) : void
      {
         this._world = param1;
      }
      
      public function get backgroundContainer() : Sprite
      {
         return this._backgroundContainer;
      }
      
      public function get objectContainer() : Sprite
      {
         return this._objectContainer;
      }
      
      public function fullscreenChanged(param1:Boolean) : void
      {
         var _loc2_:DCGame = null;
         var _loc4_:DCGame = null;
         var _loc3_:int = int(param1 ? (_loc2_ = DCGame, DCGame.getStage().fullScreenWidth) : 760);
         var _loc5_:int = int(param1 ? (_loc4_ = DCGame, DCGame.getStage().fullScreenHeight) : 668);
         Starling.current.viewPort = new Rectangle(0,0,_loc3_,_loc5_);
         Starling.current.stage.stageWidth = _loc3_;
         Starling.current.stage.stageHeight = _loc5_;
      }
      
      public function addEventListeners() : void
      {
         this._backgroundContainer.addEventListener("touch",this.touchCallback);
         this._objectContainer.addEventListener("touch",this.touchCallback);
      }
      
      private function addedToStage(param1:starling.events.Event) : void
      {
         removeEventListener("addedToStage",this.addedToStage);
         addChild(this._backgroundContainer);
         addChild(this._objectContainer);
      }
      
      private function touchCallback(param1:starling.events.TouchEvent) : void
      {
         var _loc2_:* = undefined;
         for each(_loc2_ in param1.touches)
         {
            if(this.isValid(_loc2_))
            {
               this.handleTouch(_loc2_,param1.target as DisplayObject);
            }
         }
      }
      
      private function handleTouch(param1:Touch, param2:DisplayObject) : void
      {
         var _loc3_:Point = null;
         var _loc4_:flash.events.Event = null;
         if(Boolean(param2) && Boolean(param1.target))
         {
            _loc3_ = param1.getLocation(param2);
            _loc4_ = this.createEvent(param1.phase,_loc3_);
            if(_loc4_)
            {
               this._world.eventHandler(_loc4_);
            }
         }
      }
      
      private function isValid(param1:Touch) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc4_:GameWorld = null;
         var _loc2_:Array = DCGame.getStage().getObjectsUnderPoint(new Point(param1.globalX,param1.globalY));
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.visible)
            {
               _loc4_ = this._world;
               if(!_loc4_._objectContainer.contains(_loc3_))
               {
                  if(!DCGame._infoLayer.contains(_loc3_))
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      private function createEvent(param1:String, param2:Point) : flash.events.Event
      {
         switch(param1)
         {
            case "began":
               return new MouseEvent("mouseDown",true,false,param2.x,param2.y);
            case "ended":
               return new MouseEvent("mouseUp",true,false,param2.x,param2.y);
            case "hover":
               return new MouseEvent("mouseMove",true,false,param2.x,param2.y);
            default:
               return null;
         }
      }
   }
}

