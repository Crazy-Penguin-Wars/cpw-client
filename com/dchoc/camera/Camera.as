package com.dchoc.camera
{
   import com.dchoc.game.GameWorld;
   
   public class Camera
   {
       
      
      protected var _world:GameWorld;
      
      protected var _zoom:Number;
      
      public function Camera(world:GameWorld, zoom:Number)
      {
         super();
         _world = world;
         _zoom = zoom;
      }
      
      public function dispose() : void
      {
         _world = null;
      }
      
      public function updateZoom() : void
      {
         var _loc1_:GameWorld = _world;
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).objectContainer.scaleX = _zoom;
         var _loc2_:GameWorld = _world;
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).objectContainer.scaleY = _zoom;
         var _loc3_:GameWorld = _world;
         _loc3_._objectContainer.scaleX = _zoom;
         var _loc4_:GameWorld = _world;
         _loc4_._objectContainer.scaleY = _zoom;
         _world.cameraZoomingUpdated();
      }
      
      public function get worldX() : Number
      {
         var _loc1_:GameWorld = _world;
         return _loc1_._objectContainer.x;
      }
      
      public function get worldY() : Number
      {
         var _loc1_:GameWorld = _world;
         return _loc1_._objectContainer.y;
      }
      
      public function set worldX(value:Number) : void
      {
         var _loc2_:GameWorld = _world;
         _loc2_._objectContainer.x = value;
         var _loc3_:GameWorld = _world;
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).objectContainer.x = value;
      }
      
      public function set worldY(value:Number) : void
      {
         var _loc2_:GameWorld = _world;
         _loc2_._objectContainer.y = value;
         var _loc3_:GameWorld = _world;
         (starling.core.Starling.current.root as com.dchoc.game.WorldContainer).objectContainer.y = value;
      }
      
      public function get zoom() : Number
      {
         return _zoom;
      }
      
      public function set zoom(value:Number) : void
      {
         _zoom = value;
         updateZoom();
      }
   }
}
