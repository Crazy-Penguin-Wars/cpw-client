package com.dchoc.gameobjects
{
   import flash.geom.*;
   import starling.core.*;
   import starling.display.Sprite;
   
   public class GameDisplayObject extends Sprite
   {
      private static var counter:int = 1;
      
      private const globalPoint:Point = new Point();
      
      private var _gameObject:GameObject;
      
      public function GameDisplayObject()
      {
         super();
         name = "GameDisplayObject" + counter++;
      }
      
      public function set gameObject(param1:GameObject) : void
      {
         this._gameObject = param1;
      }
      
      public function get gameObject() : GameObject
      {
         return this._gameObject;
      }
      
      public function get mouseX() : Number
      {
         this.globalPoint.x = Starling.current.nativeStage.mouseX;
         this.globalPoint.y = Starling.current.nativeStage.mouseY;
         return globalToLocal(this.globalPoint).x;
      }
      
      public function get mouseY() : Number
      {
         this.globalPoint.x = Starling.current.nativeStage.mouseX;
         this.globalPoint.y = Starling.current.nativeStage.mouseY;
         return globalToLocal(this.globalPoint).y;
      }
   }
}

