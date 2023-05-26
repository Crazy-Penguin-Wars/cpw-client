package tuxwars.battle.world.loader
{
   import com.dchoc.utils.DCUtils;
   import com.logicom.geom.Clipper;
   import flash.geom.Point;
   import nape.geom.Vec2;
   import tuxwars.battle.utils.GeomUtils;
   
   public class TerrainModel
   {
       
      
      private var _polygon:Vector.<Vec2>;
      
      private var intersectionPoints:Array;
      
      private var newModels:Array;
      
      public function TerrainModel(polygon:Vector.<Vec2>)
      {
         super();
         _polygon = polygon;
      }
      
      public function get points() : Vector.<Vec2>
      {
         return _polygon;
      }
      
      public function createNewModels() : Array
      {
         var _loc2_:* = null;
         var _loc1_:Array = [];
         for each(var newModel in newModels)
         {
            _loc2_ = new TerrainModel(Vector.<Vec2>(GeomUtils.toVecArray(newModel)));
            _loc2_.intersectionPoints = intersectionPoints;
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function applyExplosion(explosionPolygon:Vector.<Point>) : void
      {
         var _loc2_:Array = DCUtils.toArray(GeomUtils.toPointVector(_polygon));
         var _loc3_:Array = DCUtils.toArray(explosionPolygon);
         newModels = getNewModels(_loc2_,_loc3_);
         intersectionPoints = Clipper.clipPolygon(_loc2_,_loc3_,0);
         if(newModels.length > 0)
         {
            _polygon = Vector.<Vec2>(GeomUtils.toVecArray(newModels.splice(0,1)[0]));
         }
         else
         {
            _polygon.splice(0,_polygon.length);
         }
      }
      
      public function calculateIntersectionPoints() : Vector.<Vector.<Point>>
      {
         return !!intersectionPoints ? trimIntersectionPoints() : new Vector.<Vector.<Point>>();
      }
      
      private function getNewModels(polygon:Array, explosion:Array) : Array
      {
         var i:int;
         var model:Array;
         var models:Array = Clipper.clipPolygon(polygon,explosion,2);
         for(i = models.length - 1; i >= 0; )
         {
            model = models[i];
            if(model.length < 3)
            {
               models.splice(i,1);
            }
            i--;
         }
         models.sort(function(arr1:Array, arr2:Array):int
         {
            return calculateAllXs(arr1) - calculateAllXs(arr2);
         });
         return models;
      }
      
      private function calculateAllXs(list:Array) : int
      {
         var x:int = 0;
         for each(var p in list)
         {
            x += p.x;
         }
         return x;
      }
      
      private function trimIntersectionPoints() : Vector.<Vector.<Point>>
      {
         var i:int = 0;
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = undefined;
         var _loc2_:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
         for(i = 0; i < intersectionPoints.length; )
         {
            _loc4_ = intersectionPoints[i];
            _loc1_ = findStartIndex(_loc4_);
            _loc5_ = findEndIndex(_loc4_);
            if(_loc1_ != -1 && _loc5_ != -1)
            {
               if(_loc5_ > _loc1_)
               {
                  _loc2_.push(GeomUtils.toPointVector(_polygon.slice(_loc1_,_loc5_)));
               }
               else if(_loc5_ < _loc1_)
               {
                  _loc3_ = GeomUtils.toPointVector(_polygon.slice(_loc1_));
                  _loc2_.push(_loc3_.concat(GeomUtils.toPointVector(_polygon.slice(0,_loc5_))));
               }
            }
            i++;
         }
         return _loc2_;
      }
      
      private function findStartIndex(intersectionPolygon:Array) : int
      {
         var i:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         for(i = 0; i < intersectionPolygon.length; )
         {
            _loc3_ = findIndex(_polygon,Vec2.fromPoint(intersectionPolygon[i]));
            if(_loc3_ != -1)
            {
               _loc2_ = _loc3_ > 0 ? _loc3_ - 1 : _polygon.length - 1;
               if(!containsPoint(GeomUtils.toVecArray(intersectionPolygon),_polygon[_loc2_]))
               {
                  return _loc3_;
               }
            }
            i++;
         }
         return -1;
      }
      
      private function findEndIndex(intersectionPolygon:Array) : int
      {
         var i:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         for(i = 0; i < intersectionPolygon.length; )
         {
            _loc3_ = findIndex(_polygon,Vec2.fromPoint(intersectionPolygon[i]));
            if(_loc3_ != -1)
            {
               _loc2_ = _loc3_ < _polygon.length - 1 ? _loc3_ + 1 : 0;
               if(!containsPoint(GeomUtils.toVecArray(intersectionPolygon),_polygon[_loc2_]))
               {
                  return _loc2_;
               }
            }
            i++;
         }
         return -1;
      }
      
      private function containsPoint(points:Array, p:Vec2) : Boolean
      {
         return findIndex(Vector.<Vec2>(points),p) != -1;
      }
      
      private function findIndex(points:Vector.<Vec2>, p:Vec2) : int
      {
         var i:int = 0;
         for(i = 0; i < points.length; )
         {
            if(p.x == points[i].x && p.y == points[i].y)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
   }
}
