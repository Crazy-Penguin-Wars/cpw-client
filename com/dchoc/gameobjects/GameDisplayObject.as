package com.dchoc.gameobjects
{
   import flash.geom.Point;
   import starling.core.Starling;
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
      
      public function set gameObject(gameObject:GameObject) : void
      {
         _gameObject = gameObject;
      }
      
      public function get gameObject() : GameObject
      {
         return _gameObject;
      }
      
      public function get mouseX() : Number
      {
         globalPoint.x = Starling.current.nativeStage.mouseX;
         globalPoint.y = Starling.current.nativeStage.mouseY;
         return globalToLocal(globalPoint).x;
      }
      
      public function get mouseY() : Number
      {
         globalPoint.x = Starling.current.nativeStage.mouseX;
         globalPoint.y = Starling.current.nativeStage.mouseY;
         return globalToLocal(globalPoint).y;
      }
   }
}
