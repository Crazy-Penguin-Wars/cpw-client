package tuxwars.battle.world.loader
{
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   import no.olog.utilfunctions.assert;
   import tuxwars.battle.utils.GeomUtils;
   import tuxwars.battle.world.DynamicBodyManagerFactory;
   
   public class TerrainElementPhysics
   {
      
      private static const FIXTURE_NAME:String = "ball_medium";
       
      
      private const points:Vector.<Vec2> = new Vector.<Vec2>();
      
      private const reversePoints:Array = [];
      
      private var boundingBox:Rectangle;
      
      private var originalTerrainPoints:Vector.<Vec2>;
      
      public function TerrainElementPhysics(data:Object)
      {
         originalTerrainPoints = new Vector.<Vec2>();
         super();
         assert("Not enough points.",true,data.points.length >= 3);
         parsePoints(data.points);
         boundingBox = GeomUtils.createBoundingBox(points);
         GeomUtils.translatePolygon(points,new Point(-boundingBox.x,-boundingBox.y));
         GeomUtils.translatePolygonArray(reversePoints,new Point(-boundingBox.x,-boundingBox.y));
         DynamicBodyManagerFactory.getInstance().createManager(data.theme + ".xml",managerCreated);
      }
      
      public function dispose() : void
      {
         points.splice(0,points.length);
         originalTerrainPoints.splice(0,originalTerrainPoints.length);
      }
      
      public function getLocation() : Vec2
      {
         return new Vec2(boundingBox.x,boundingBox.y);
      }
      
      public function getBoundingBox() : Rectangle
      {
         return boundingBox;
      }
      
      public function getPoints() : Vector.<Vec2>
      {
         return points;
      }
      
      public function getOriginalPoints() : Vector.<Vec2>
      {
         return originalTerrainPoints;
      }
      
      public function isLoaded() : Boolean
      {
         return true;
      }
      
      private function parsePoints(pointsData:Object) : void
      {
         var _loc3_:Array = pointsData is Array ? pointsData as Array : [pointsData];
         for each(var pointData in _loc3_)
         {
            points.push(new Vec2(pointData.x,pointData.y));
            originalTerrainPoints.push(new Vec2(pointData.x,pointData.y));
            reversePoints.push(new Vec2(pointData.x,pointData.y));
         }
         if(GeomUtils.isCWArray(reversePoints))
         {
            reversePoints.reverse();
         }
      }
      
      private function managerCreated(event:TimerEvent) : void
      {
      }
   }
}
