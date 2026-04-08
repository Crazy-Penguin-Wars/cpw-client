package tuxwars.battle.world.loader
{
   import com.dchoc.utils.*;
   import com.logicom.geom.*;
   import flash.geom.*;
   import nape.geom.*;
   import tuxwars.battle.utils.*;
   
   public class TerrainModel
   {
      private var _polygon:Vector.<Vec2>;
      
      private var intersectionPoints:Array;
      
      private var newModels:Array;
      
      public function TerrainModel(param1:Vector.<Vec2>)
      {
         super();
         this._polygon = param1;
      }
      
      public function get points() : Vector.<Vec2>
      {
         return this._polygon;
      }
      
      public function createNewModels() : Array
      {
         var _loc3_:* = undefined;
         var _loc1_:TerrainModel = null;
         var _loc2_:Array = [];
         for each(_loc3_ in this.newModels)
         {
            _loc1_ = new TerrainModel(Vector.<Vec2>(GeomUtils.toVecArray(_loc3_)));
            _loc1_.intersectionPoints = this.intersectionPoints;
            _loc2_.push(_loc1_);
         }
         return _loc2_;
      }
      
      public function applyExplosion(param1:Vector.<Point>) : void
      {
         var _loc2_:Array = DCUtils.toArray(GeomUtils.toPointVector(this._polygon));
         var _loc3_:Array = DCUtils.toArray(param1);
         this.newModels = this.getNewModels(_loc2_,_loc3_);
         this.intersectionPoints = Clipper.clipPolygon(_loc2_,_loc3_,0);
         if(this.newModels.length > 0)
         {
            this._polygon = Vector.<Vec2>(GeomUtils.toVecArray(this.newModels.splice(0,1)[0]));
         }
         else
         {
            this._polygon.splice(0,this._polygon.length);
         }
      }
      
      public function calculateIntersectionPoints() : Vector.<Vector.<Point>>
      {
         return !!this.intersectionPoints ? this.trimIntersectionPoints() : new Vector.<Vector.<Point>>();
      }
      
      private function getNewModels(param1:Array, param2:Array) : Array
      {
         var i:int = 0;
         var model:Array = null;
         var polygon:Array = param1;
         var explosion:Array = param2;
         var models:Array = Clipper.clipPolygon(polygon,explosion,2);
         i = int(models.length - 1);
         while(i >= 0)
         {
            model = models[i];
            if(model.length < 3)
            {
               models.splice(i,1);
            }
            i--;
         }
         models.sort(function(param1:Array, param2:Array):int
         {
            return calculateAllXs(param1) - calculateAllXs(param2);
         });
         return models;
      }
      
      private function calculateAllXs(param1:Array) : int
      {
         var _loc3_:* = undefined;
         var _loc2_:int = 0;
         for each(_loc3_ in param1)
         {
            _loc2_ += _loc3_.x;
         }
         return _loc2_;
      }
      
      private function trimIntersectionPoints() : Vector.<Vector.<Point>>
      {
         var _loc1_:int = 0;
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:* = undefined;
         var _loc6_:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
         _loc1_ = 0;
         while(_loc1_ < this.intersectionPoints.length)
         {
            _loc2_ = this.intersectionPoints[_loc1_];
            _loc3_ = int(this.findStartIndex(_loc2_));
            _loc4_ = int(this.findEndIndex(_loc2_));
            if(_loc3_ != -1 && _loc4_ != -1)
            {
               if(_loc4_ > _loc3_)
               {
                  _loc6_.push(GeomUtils.toPointVector(this._polygon.slice(_loc3_,_loc4_)));
               }
               else if(_loc4_ < _loc3_)
               {
                  _loc5_ = GeomUtils.toPointVector(this._polygon.slice(_loc3_));
                  _loc6_.push(_loc5_.concat(GeomUtils.toPointVector(this._polygon.slice(0,_loc4_))));
               }
            }
            _loc1_++;
         }
         return _loc6_;
      }
      
      private function findStartIndex(param1:Array) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = int(this.findIndex(this._polygon,Vec2.fromPoint(param1[_loc2_])));
            if(_loc3_ != -1)
            {
               _loc4_ = _loc3_ > 0 ? _loc3_ - 1 : int(this._polygon.length - 1);
               if(!this.containsPoint(GeomUtils.toVecArray(param1),this._polygon[_loc4_]))
               {
                  return _loc3_;
               }
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function findEndIndex(param1:Array) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = int(this.findIndex(this._polygon,Vec2.fromPoint(param1[_loc2_])));
            if(_loc3_ != -1)
            {
               _loc4_ = _loc3_ < this._polygon.length - 1 ? _loc3_ + 1 : 0;
               if(!this.containsPoint(GeomUtils.toVecArray(param1),this._polygon[_loc4_]))
               {
                  return _loc4_;
               }
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function containsPoint(param1:Array, param2:Vec2) : Boolean
      {
         return this.findIndex(Vector.<Vec2>(param1),param2) != -1;
      }
      
      private function findIndex(param1:Vector.<Vec2>, param2:Vec2) : int
      {
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            if(param2.x == param1[_loc3_].x && param2.y == param1[_loc3_].y)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
   }
}

