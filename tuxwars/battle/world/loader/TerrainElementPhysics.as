package tuxwars.battle.world.loader
{
   import flash.events.TimerEvent;
   import flash.geom.*;
   import nape.geom.*;
   import no.olog.utilfunctions.*;
   import tuxwars.battle.utils.*;
   import tuxwars.battle.world.*;
   
   public class TerrainElementPhysics
   {
      private static const FIXTURE_NAME:String = "ball_medium";
      
      private const points:Vector.<Vec2> = new Vector.<Vec2>();
      
      private const reversePoints:Array = [];
      
      private var boundingBox:flash.geom.Rectangle;
      
      private var originalTerrainPoints:Vector.<Vec2> = new Vector.<Vec2>();
      
      public function TerrainElementPhysics(param1:Object)
      {
         super();
         assert("Not enough points.",true,param1.points.length >= 3);
         this.parsePoints(param1.points);
         this.boundingBox = GeomUtils.createBoundingBox(this.points);
         GeomUtils.translatePolygon(this.points,new Point(-this.boundingBox.x,-this.boundingBox.y));
         GeomUtils.translatePolygonArray(this.reversePoints,new Point(-this.boundingBox.x,-this.boundingBox.y));
         DynamicBodyManagerFactory.getInstance().createManager(param1.theme + ".xml",this.managerCreated);
      }
      
      public function dispose() : void
      {
         this.points.splice(0,this.points.length);
         this.originalTerrainPoints.splice(0,this.originalTerrainPoints.length);
      }
      
      public function getLocation() : Vec2
      {
         return new Vec2(this.boundingBox.x,this.boundingBox.y);
      }
      
      public function getBoundingBox() : flash.geom.Rectangle
      {
         return this.boundingBox;
      }
      
      public function getPoints() : Vector.<Vec2>
      {
         return this.points;
      }
      
      public function getOriginalPoints() : Vector.<Vec2>
      {
         return this.originalTerrainPoints;
      }
      
      public function isLoaded() : Boolean
      {
         return true;
      }
      
      private function parsePoints(param1:Object) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = param1 is Array ? param1 as Array : [param1];
         for each(_loc3_ in _loc2_)
         {
            this.points.push(new Vec2(_loc3_.x,_loc3_.y));
            this.originalTerrainPoints.push(new Vec2(_loc3_.x,_loc3_.y));
            this.reversePoints.push(new Vec2(_loc3_.x,_loc3_.y));
         }
         if(GeomUtils.isCWArray(this.reversePoints))
         {
            this.reversePoints.reverse();
         }
      }
      
      private function managerCreated(param1:TimerEvent) : void
      {
      }
   }
}

