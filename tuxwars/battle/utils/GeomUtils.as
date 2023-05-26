package tuxwars.battle.utils
{
   import com.dchoc.utils.MathUtils;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   
   public final class GeomUtils
   {
      
      private static const DBL_EPSILON:Number = 2.220446049250313e-16;
      
      public static const ANGLE_LESS:String = "AngleLess";
      
      public static const ANGLE_MORE:String = "AngleMore";
       
      
      public function GeomUtils()
      {
         super();
         throw new Error("GeomUtils is a static class!");
      }
      
      public static function toPointVector(polygon:Vector.<Vec2>) : Vector.<Point>
      {
         var i:int = 0;
         var _loc2_:Vector.<Point> = new Vector.<Point>();
         var _loc3_:int = polygon.length;
         for(i = 0; i < _loc3_; )
         {
            _loc2_.push(polygon[i].toPoint());
            i++;
         }
         return _loc2_;
      }
      
      public static function toPointArray(vecList:Array) : Array
      {
         var i:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = vecList.length;
         for(i = 0; i < _loc3_; )
         {
            _loc2_.push(vecList[i].toPoint());
            i++;
         }
         return _loc2_;
      }
      
      public static function toVecArray(pointPoly:Array) : Array
      {
         var i:int = 0;
         var _loc2_:Array = [];
         var _loc3_:int = pointPoly.length;
         for(i = 0; i < _loc3_; )
         {
            _loc2_.push(Vec2.fromPoint(pointPoly[i]));
            i++;
         }
         return _loc2_;
      }
      
      public static function toVecVector(pointPoly:Vector.<Point>) : Vector.<Vec2>
      {
         var i:int = 0;
         var _loc2_:Vector.<Vec2> = new Vector.<Vec2>();
         var _loc3_:int = pointPoly.length;
         for(i = 0; i < _loc3_; )
         {
            _loc2_.push(Vec2.fromPoint(pointPoly[i]));
            i++;
         }
         return _loc2_;
      }
      
      public static function duplicatePolygon(points:Vector.<Vec2>) : Vector.<Vec2>
      {
         var _loc2_:Vector.<Vec2> = new Vector.<Vec2>();
         for each(var p in points)
         {
            _loc2_.push(p.copy());
         }
         return _loc2_;
      }
      
      public static function duplicatePointPolygon(points:Vector.<Point>) : Vector.<Point>
      {
         var _loc2_:Vector.<Point> = new Vector.<Point>();
         for each(var p in points)
         {
            _loc2_.push(p.clone());
         }
         return _loc2_;
      }
      
      public static function duplicatePolygonArray(points:Array) : Array
      {
         var _loc2_:Array = [];
         for each(var p in points)
         {
            _loc2_.push(p.copy());
         }
         return _loc2_;
      }
      
      public static function comparePolygons(polygon1:Vector.<Vec2>, polygon2:Vector.<Vec2>) : Boolean
      {
         var i:int = 0;
         var found:Boolean = false;
         var j:int = 0;
         if(polygon1 == polygon2)
         {
            return true;
         }
         if(polygon1.length != polygon2.length)
         {
            return false;
         }
         i = 0;
         while(true)
         {
            if(i >= polygon1.length)
            {
               return true;
            }
            for(j = 0; j < polygon2.length; )
            {
               if(polygon1[i].equals(polygon2[j]))
               {
                  found = true;
                  break;
               }
               j++;
            }
            if(!found)
            {
               break;
            }
            i++;
         }
         return false;
      }
      
      public static function insidePolygon(polygon:Vector.<Vec2>, point:Vec2) : Boolean
      {
         var count:int = 0;
         var i:int = 0;
         var _loc6_:* = null;
         var _loc4_:Number = NaN;
         var _loc3_:* = null;
         var p1:* = polygon[0];
         for(i = 1; i <= polygon.length; )
         {
            if(point.x == p1.x && point.y == p1.y)
            {
               return true;
            }
            _loc6_ = polygon[i % polygon.length];
            if(point.y < Math.min(p1.y,_loc6_.y) || point.y > Math.max(p1.y,_loc6_.y))
            {
               p1 = _loc6_;
            }
            else
            {
               if(point.y > Math.min(p1.y,_loc6_.y) && point.y < Math.max(p1.y,_loc6_.y))
               {
                  if(point.x <= Math.max(p1.x,_loc6_.x))
                  {
                     if(p1.y == _loc6_.y && point.x >= Math.min(p1.x,_loc6_.x))
                     {
                        return true;
                     }
                     if(p1.x == _loc6_.x)
                     {
                        if(p1.x == point.x)
                        {
                           return true;
                        }
                        count++;
                     }
                     else
                     {
                        _loc4_ = (point.y - p1.y) * (_loc6_.x - p1.x) / (_loc6_.y - p1.y) + p1.x;
                        if(Math.abs(point.x - _loc4_) < 2.220446049250313e-16)
                        {
                           return true;
                        }
                        if(point.x < _loc4_)
                        {
                           count++;
                        }
                     }
                  }
               }
               else if(point.y == _loc6_.y && point.x <= _loc6_.x)
               {
                  _loc3_ = polygon[(i + 1) % polygon.length];
                  if(point.y >= Math.min(p1.y,_loc3_.y) && point.y <= Math.max(p1.y,_loc3_.y))
                  {
                     count++;
                  }
                  else
                  {
                     count += 2;
                  }
               }
               p1 = _loc6_;
            }
            i++;
         }
         return count % 2 != 0;
      }
      
      public static function lineSegmentIntersection(pA:Vec2, pB:Vec2, pC:Vec2, pD:Vec2) : Vec2
      {
         if(pA.x == pB.x && pA.y == pB.y || pC.x == pD.x && pC.y == pD.y)
         {
            return null;
         }
         if(pA.x == pC.x && pA.y == pC.y || pB.x == pC.x && pB.y == pC.y || pA.x == pD.x && pA.y == pD.y || pB.x == pD.x && pB.y == pD.y)
         {
            return null;
         }
         pB.subeq(pA);
         pC.subeq(pA);
         pD.subeq(pA);
         var _loc7_:Number = pB.length;
         var _loc10_:Number = pB.x / _loc7_;
         var _loc9_:Number = pB.y / _loc7_;
         var _loc6_:Number = pC.x * _loc10_ + pC.y * _loc9_;
         pC.y = pC.y * _loc10_ - pC.x * _loc9_;
         pC.x = _loc6_;
         var _loc5_:Number = pD.x * _loc10_ + pD.y * _loc9_;
         pD.y = pD.y * _loc10_ - pD.x * _loc9_;
         pD.x = _loc5_;
         if(pC.y < 0 && pD.y < 0 || pC.y >= 0 && pD.y >= 0)
         {
            return null;
         }
         var _loc8_:Number = pD.x + (pC.x - pD.x) * pD.y / (pD.y - pC.y);
         if(_loc8_ < 0 || _loc8_ > _loc7_)
         {
            return null;
         }
         return new Vec2(pA.x + _loc8_ * _loc10_,pA.y + _loc8_ * _loc9_);
      }
      
      public static function translatePolygon(polygon:*, distance:*) : void
      {
         for each(var p in polygon)
         {
            p.x += distance.x;
            p.y += distance.y;
         }
      }
      
      public static function translatePolygonArray(polygon:Array, distance:*) : void
      {
         for each(var p in polygon)
         {
            p.x += distance.x;
            p.y += distance.y;
         }
      }
      
      private static function vecRot90CW(v:Vec2) : Vec2
      {
         return new Vec2(v.y,-v.x);
      }
      
      private static function vecRot90CCW(v:Vec2) : Vec2
      {
         return new Vec2(-v.y,v.x);
      }
      
      private static function intersect(line1:Array, line2:Array) : Vec2
      {
         var _loc7_:Number = Number(line1[1].x) - Number(line1[0].x);
         var _loc6_:Number = Number(line2[0].x) - Number(line2[1].x);
         var _loc4_:Number = Number(line2[0].x) - Number(line1[0].x);
         var _loc9_:Number = Number(line1[1].y) - Number(line1[0].y);
         var _loc8_:Number = Number(line2[0].y) - Number(line2[1].y);
         var _loc5_:Number = Number(line2[0].y) - Number(line1[0].y);
         var _loc3_:Number = (_loc6_ * _loc5_ - _loc8_ * _loc4_) / (_loc9_ * _loc6_ - _loc7_ * _loc8_);
         return new Vec2(line1[0].x + _loc3_ * (Number(line1[1].x) - Number(line1[0].x)),line1[0].y + _loc3_ * (Number(line1[1].y) - Number(line1[0].y)));
      }
      
      public static function isCW(polygon:Vector.<Vec2>) : Boolean
      {
         var _loc2_:Vec2 = vecRot90CW(new Vec2(polygon[1].x - polygon[0].x,polygon[1].y - polygon[0].y));
         var _loc3_:Number = _loc2_.dot(new Vec2(polygon[2].x - polygon[1].x,polygon[2].y - polygon[1].y));
         return _loc3_ >= 0;
      }
      
      public static function expandPolygon(polygon:Vector.<Vec2>, distance:Number) : Vector.<Vec2>
      {
         var i:int = 0;
         var _loc13_:* = null;
         var _loc12_:* = null;
         var _loc15_:* = null;
         var _loc4_:* = null;
         var _loc14_:* = null;
         var _loc16_:* = null;
         var _loc11_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc8_:* = null;
         var _loc5_:* = null;
         var _loc9_:Vector.<Vec2> = new Vector.<Vec2>();
         var _loc3_:Function = isCW(polygon) ? vecRot90CCW : vecRot90CW;
         for(i = 0; i < polygon.length; )
         {
            _loc13_ = polygon[i > 0 ? i - 1 : polygon.length - 1];
            _loc12_ = polygon[i];
            _loc15_ = polygon[i < polygon.length - 1 ? i + 1 : 0];
            _loc4_ = new Vec2(_loc12_.x - _loc13_.x,_loc12_.y - _loc13_.y);
            _loc14_ = new Vec2(_loc15_.x - _loc12_.x,_loc15_.y - _loc12_.y);
            _loc16_ = Vec2(_loc3_(_loc4_)).unit().mul(distance);
            _loc11_ = Vec2(_loc3_(_loc14_)).unit().mul(distance);
            _loc7_ = new Vec2(_loc13_.x + _loc16_.x,_loc13_.y + _loc16_.y);
            _loc6_ = new Vec2(_loc12_.x + _loc16_.x,_loc12_.y + _loc16_.y);
            _loc8_ = new Vec2(_loc12_.x + _loc11_.x,_loc12_.y + _loc11_.y);
            _loc5_ = new Vec2(_loc15_.x + _loc11_.x,_loc15_.y + _loc11_.y);
            _loc9_.push(intersect([_loc7_,_loc6_],[_loc8_,_loc5_]));
            i++;
         }
         return _loc9_;
      }
      
      public static function findLineSegments(points:Vector.<Vec2>, angle:int, compFunc:String) : Vector.<Vector.<Vec2>>
      {
         var testFunc:Function;
         var segments:Vector.<Vector.<Vec2>>;
         var i:int;
         var segment:Vector.<Vec2>;
         var curPoint:Vec2;
         var nextPoint:Vec2;
         var getCurPoint:* = function(i:int):Vec2
         {
            return i < points.length ? points[i] : points[i - points.length];
         };
         var getNextPoint:* = function(i:int):Vec2
         {
            if(i < points.length - 1)
            {
               return points[i + 1];
            }
            return i - points.length < points.length - 1 ? points[i - points.length + 1] : points[0];
         };
         var startIndex:int = findStartIndex(points);
         if(startIndex == -1)
         {
            throw new Error("No Start index found!");
         }
         testFunc = compFunc == "AngleLess" ? angleLess : angleMore;
         segments = new Vector.<Vector.<Vec2>>();
         for(i = startIndex; i < startIndex + points.length; )
         {
            segment = new Vector.<Vec2>();
            curPoint = getCurPoint(i);
            nextPoint = getNextPoint(i);
            while(testSegment(curPoint,nextPoint,testFunc,angle))
            {
               if(segment.indexOf(curPoint) == -1)
               {
                  segment.push(curPoint);
               }
               if(segment.indexOf(nextPoint) == -1)
               {
                  segment.push(nextPoint);
               }
               i++;
               if(i >= points.length + startIndex)
               {
                  break;
               }
               curPoint = getCurPoint(i);
               nextPoint = getNextPoint(i);
            }
            if(segment.length > 0)
            {
               segments.push(segment);
            }
            i++;
         }
         return segments;
      }
      
      public static function isCWArray(polygon:Array) : Boolean
      {
         var i:int = 0;
         var _loc4_:Array = GeomUtils.duplicatePolygonArray(polygon);
         _loc4_.push(_loc4_[0].copy());
         var area:Number = 0;
         for(i = 0; i < _loc4_.length - 1; )
         {
            area += (Number(_loc4_[i + 1].x) - Number(_loc4_[i].x)) * (_loc4_[i + 1].y + _loc4_[i].y) / 2;
            i++;
         }
         return area < 0;
      }
      
      public static function calculatePolygonArea(poly:Vector.<Vec2>) : Number
      {
         var i:int = 0;
         var area:Number = 0;
         var j:int = 2;
         var k:int = 0;
         for(i = 1; i <= poly.length - 2; )
         {
            area += poly[i].x * (poly[j].y - poly[k].y);
            j++;
            k++;
            i++;
         }
         return area / 2;
      }
      
      private static function testSegment(p1:Vec2, p2:Vec2, func:Function, targetAngle:int) : Boolean
      {
         return func(MathUtils.radiansToDegrees(Math.atan2(p2.y - p1.y,p2.x - p1.x)),targetAngle);
      }
      
      private static function angleLess(angle:Number, targetAngle:int) : Boolean
      {
         return Math.abs(angle) < targetAngle;
      }
      
      private static function angleMore(angle:Number, targetAngle:int) : Boolean
      {
         return Math.abs(angle) >= targetAngle;
      }
      
      private static function findStartIndex(points:Vector.<Vec2>) : int
      {
         var i:int = 0;
         var _loc2_:* = null;
         for(i = 0; i < points.length; )
         {
            _loc2_ = i == 0 ? points[points.length - 1] : points[i - 1];
            if(_loc2_.x >= points[i].x)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public static function createBoundingBox(polygon:*) : Rectangle
      {
         var _loc2_:Rectangle = new Rectangle();
         _loc2_.x = find(polygon,smallerX,1.7976931348623157e+308);
         _loc2_.y = find(polygon,smallerY,1.7976931348623157e+308);
         _loc2_.width = find(polygon,biggerX,Number.MIN_VALUE);
         _loc2_.height = find(polygon,biggerY,Number.MIN_VALUE);
         return _loc2_;
      }
      
      private static function find(points:*, func:Function, startValue:Number) : Number
      {
         var ret:* = startValue;
         for each(var p in points)
         {
            ret = func(p,ret);
         }
         return ret;
      }
      
      private static function smallerX(p:*, comp:Number) : Number
      {
         return p.x < comp ? p.x : comp;
      }
      
      private static function smallerY(p:*, comp:Number) : Number
      {
         return p.y < comp ? p.y : comp;
      }
      
      private static function biggerX(p:*, comp:Number) : Number
      {
         return p.x > comp ? p.x : comp;
      }
      
      private static function biggerY(p:*, comp:Number) : Number
      {
         return p.y > comp ? p.y : comp;
      }
      
      public static function multiplyPolygon(polygon:Vector.<Vec2>, zoom:Number) : void
      {
         for each(var p in polygon)
         {
            p.muleq(zoom);
         }
      }
   }
}
