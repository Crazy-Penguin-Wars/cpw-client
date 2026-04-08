package com.dchoc.camera
{
   import com.dchoc.game.GameWorld;
   import com.dchoc.game.WorldContainer;
   import starling.core.Starling;
   
   public class Camera
   {
      protected var _world:GameWorld;
      
      protected var _zoom:Number;
      
      public function Camera(param1:GameWorld, param2:Number)
      {
         super();
         this._world = param1;
         this._zoom = param2;
      }
      
      public function dispose() : void
      {
         this._world = null;
      }
      
      public function updateZoom() : void
      {
         var _loc1_:GameWorld = this._world;
         (Starling.current.root as WorldContainer).objectContainer.scaleX = this._zoom;
         var _loc2_:GameWorld = this._world;
         (Starling.current.root as WorldContainer).objectContainer.scaleY = this._zoom;
         var _loc3_:GameWorld = this._world;
         _loc3_._objectContainer.scaleX = this._zoom;
         var _loc4_:GameWorld = this._world;
         _loc4_._objectContainer.scaleY = this._zoom;
         this._world.cameraZoomingUpdated();
      }
      
      public function get worldX() : Number
      {
         var _loc1_:GameWorld = this._world;
         return _loc1_._objectContainer.x;
      }
      
      public function get worldY() : Number
      {
         var _loc1_:GameWorld = this._world;
         return _loc1_._objectContainer.y;
      }
      
      public function set worldX(param1:Number) : void
      {
         var _loc2_:GameWorld = this._world;
         _loc2_._objectContainer.x = param1;
         var _loc3_:GameWorld = this._world;
         (Starling.current.root as WorldContainer).objectContainer.x = param1;
      }
      
      public function set worldY(param1:Number) : void
      {
         var _loc2_:GameWorld = this._world;
         _loc2_._objectContainer.y = param1;
         var _loc3_:GameWorld = this._world;
         (Starling.current.root as WorldContainer).objectContainer.y = param1;
      }
      
      public function get zoom() : Number
      {
         return this._zoom;
      }
      
      public function set zoom(param1:Number) : void
      {
         this._zoom = param1;
         this.updateZoom();
      }
   }
}

