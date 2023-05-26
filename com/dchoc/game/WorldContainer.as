package com.dchoc.game
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
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
         addEventListener("addedToStage",addedToStage);
      }
      
      public function set world(value:GameWorld) : void
      {
         _world = value;
      }
      
      public function get backgroundContainer() : Sprite
      {
         return _backgroundContainer;
      }
      
      public function get objectContainer() : Sprite
      {
         return _objectContainer;
      }
      
      public function fullscreenChanged(fullScreen:Boolean) : void
      {
         var _loc4_:DCGame;
         var _loc2_:int = int(fullScreen ? (_loc4_ = DCGame, com.dchoc.game.DCGame._stage.fullScreenWidth) : 760);
         var _loc5_:DCGame;
         var _loc3_:int = int(fullScreen ? (_loc5_ = DCGame, com.dchoc.game.DCGame._stage.fullScreenHeight) : 668);
         Starling.current.viewPort = new Rectangle(0,0,_loc2_,_loc3_);
         Starling.current.stage.stageWidth = _loc2_;
         Starling.current.stage.stageHeight = _loc3_;
      }
      
      public function addEventListeners() : void
      {
         _backgroundContainer.addEventListener("touch",touchCallback);
         _objectContainer.addEventListener("touch",touchCallback);
      }
      
      private function addedToStage(event:starling.events.Event) : void
      {
         removeEventListener("addedToStage",addedToStage);
         addChild(_backgroundContainer);
         addChild(_objectContainer);
      }
      
      private function touchCallback(event:TouchEvent) : void
      {
         for each(var touch in event.touches)
         {
            if(isValid(touch))
            {
               handleTouch(touch,event.target as starling.display.DisplayObject);
            }
         }
      }
      
      private function handleTouch(touch:Touch, target:starling.display.DisplayObject) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         if(target && touch.target)
         {
            _loc4_ = touch.getLocation(target);
            _loc3_ = createEvent(touch.phase,_loc4_);
            if(_loc3_)
            {
               _world.eventHandler(_loc3_);
            }
         }
      }
      
      private function isValid(touch:Touch) : Boolean
      {
         var _loc4_:DCGame = DCGame;
         var _loc2_:Array = com.dchoc.game.DCGame._stage.getObjectsUnderPoint(new Point(touch.globalX,touch.globalY));
         for each(var obj in _loc2_)
         {
            if(obj.visible)
            {
               var _loc5_:GameWorld = _world;
               if(!_loc5_._objectContainer.contains(obj))
               {
                  var _loc6_:DCGame = DCGame;
                  if(!com.dchoc.game.DCGame._infoLayer.contains(obj))
                  {
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      private function createEvent(phase:String, pos:Point) : flash.events.Event
      {
         switch(phase)
         {
            case "began":
               return new MouseEvent("mouseDown",true,false,pos.x,pos.y);
            case "ended":
               return new MouseEvent("mouseUp",true,false,pos.x,pos.y);
            case "hover":
               return new MouseEvent("mouseMove",true,false,pos.x,pos.y);
            default:
               return null;
         }
      }
   }
}
