package tuxwars.battle.utils
{
   import com.dchoc.utils.*;
   import flash.geom.*;
   import nape.geom.*;
   
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
      
      public static function toPointVector(param1:Vector.<Vec2>) : Vector.<Point>
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<Point> = new Vector.<Point>();
         var _loc4_:int = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_.push(param1[_loc2_].toPoint());
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function toPointArray(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_.push(param1[_loc2_].toPoint());
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function toVecArray(param1:Array) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:Array = [];
         var _loc4_:int = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_.push(Vec2.fromPoint(param1[_loc2_]));
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function toVecVector(param1:Vector.<Point>) : Vector.<Vec2>
      {
         var _loc2_:int = 0;
         var _loc3_:Vector.<Vec2> = new Vector.<Vec2>();
         var _loc4_:int = int(param1.length);
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            _loc3_.push(Vec2.fromPoint(param1[_loc2_]));
            _loc2_++;
         }
         return _loc3_;
      }
      
      public static function duplicatePolygon(param1:Vector.<Vec2>) : Vector.<Vec2>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<Vec2> = new Vector.<Vec2>();
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_.copy());
         }
         return _loc2_;
      }
      
      public static function duplicatePointPolygon(param1:Vector.<Point>) : Vector.<Point>
      {
         var _loc3_:* = undefined;
         var _loc2_:Vector.<Point> = new Vector.<Point>();
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_.clone());
         }
         return _loc2_;
      }
      
      public static function duplicatePolygonArray(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            _loc2_.push(_loc3_.copy());
         }
         return _loc2_;
      }
      
      public static function comparePolygons(param1:Vector.<Vec2>, param2:Vector.<Vec2>) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:int = 0;
         if(param1 == param2)
         {
            return true;
         }
         if(param1.length != param2.length)
         {
            return false;
         }
         _loc3_ = 0;
         while(true)
         {
            if(_loc3_ >= param1.length)
            {
               return true;
            }
            _loc5_ = 0;
            while(_loc5_ < param2.length)
            {
               if(param1[_loc3_].equals(param2[_loc5_]))
               {
                  _loc4_ = true;
                  break;
               }
               _loc5_++;
            }
            if(!_loc4_)
            {
               break;
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function insidePolygon(param1:Vector.<Vec2>, param2:Vec2) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Vec2 = null;
         var _loc6_:Number = Number(NaN);
         var _loc7_:Vec2 = null;
         var _loc8_:* = param1[0];
         _loc4_ = 1;
         while(_loc4_ <= param1.length)
         {
            if(param2.x == _loc8_.x && param2.y == _loc8_.y)
            {
               return true;
            }
            _loc5_ = param1[_loc4_ % param1.length];
            if(param2.y < Math.min(_loc8_.y,_loc5_.y) || param2.y > Math.max(_loc8_.y,_loc5_.y))
            {
               _loc8_ = _loc5_;
            }
            else
            {
               if(param2.y > Math.min(_loc8_.y,_loc5_.y) && param2.y < Math.max(_loc8_.y,_loc5_.y))
               {
                  if(param2.x <= Math.max(_loc8_.x,_loc5_.x))
                  {
                     if(_loc8_.y == _loc5_.y && param2.x >= Math.min(_loc8_.x,_loc5_.x))
                     {
                        return true;
                     }
                     if(_loc8_.x == _loc5_.x)
                     {
                        if(_loc8_.x == param2.x)
                        {
                           return true;
                        }
                        _loc3_++;
                     }
                     else
                     {
                        _loc6_ = (param2.y - _loc8_.y) * (_loc5_.x - _loc8_.x) / (_loc5_.y - _loc8_.y) + _loc8_.x;
                        if(Math.abs(param2.x - _loc6_) < 2.220446049250313e-16)
                        {
                           return true;
                        }
                        if(param2.x < _loc6_)
                        {
                           _loc3_++;
                        }
                     }
                  }
               }
               else if(param2.y == _loc5_.y && param2.x <= _loc5_.x)
               {
                  _loc7_ = param1[(_loc4_ + 1) % param1.length];
                  if(param2.y >= Math.min(_loc8_.y,_loc7_.y) && param2.y <= Math.max(_loc8_.y,_loc7_.y))
                  {
                     _loc3_++;
                  }
                  else
                  {
                     _loc3_ += 2;
                  }
               }
               _loc8_ = _loc5_;
            }
            _loc4_++;
         }
         return _loc3_ % 2 != 0;
      }
      
      public static function lineSegmentIntersection(param1:Vec2, param2:Vec2, param3:Vec2, param4:Vec2) : Vec2
      {
         if(param1.x == param2.x && param1.y == param2.y || param3.x == param4.x && param3.y == param4.y)
         {
            return null;
         }
         if(param1.x == param3.x && param1.y == param3.y || param2.x == param3.x && param2.y == param3.y || param1.x == param4.x && param1.y == param4.y || param2.x == param4.x && param2.y == param4.y)
         {
            return null;
         }
         param2.subeq(param1);
         param3.subeq(param1);
         param4.subeq(param1);
         var _loc5_:Number = param2.length;
         var _loc6_:Number = param2.x / _loc5_;
         var _loc7_:Number = param2.y / _loc5_;
         var _loc8_:Number = param3.x * _loc6_ + param3.y * _loc7_;
         param3.y = param3.y * _loc6_ - param3.x * _loc7_;
         param3.x = _loc8_;
         var _loc9_:Number = param4.x * _loc6_ + param4.y * _loc7_;
         param4.y = param4.y * _loc6_ - param4.x * _loc7_;
         param4.x = _loc9_;
         if(param3.y < 0 && param4.y < 0 || param3.y >= 0 && param4.y >= 0)
         {
            return null;
         }
         var _loc10_:Number = param4.x + (param3.x - param4.x) * param4.y / (param4.y - param3.y);
         if(_loc10_ < 0 || _loc10_ > _loc5_)
         {
            return null;
         }
         return new Vec2(param1.x + _loc10_ * _loc6_,param1.y + _loc10_ * _loc7_);
      }
      
      public static function translatePolygon(param1:*, param2:*) : void
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1)
         {
            _loc3_.x += param2.x;
            _loc3_.y += param2.y;
         }
      }
      
      public static function translatePolygonArray(param1:Array, param2:*) : void
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1)
         {
            _loc3_.x += param2.x;
            _loc3_.y += param2.y;
         }
      }
      
      private static function vecRot90CW(param1:Vec2) : Vec2
      {
         return new Vec2(param1.y,-param1.x);
      }
      
      private static function vecRot90CCW(param1:Vec2) : Vec2
      {
         return new Vec2(-param1.y,param1.x);
      }
      
      private static function intersect(param1:Array, param2:Array) : Vec2
      {
         var _loc3_:Number = param1[1].x - param1[0].x;
         var _loc4_:Number = param2[0].x - param2[1].x;
         var _loc5_:Number = param2[0].x - param1[0].x;
         var _loc6_:Number = param1[1].y - param1[0].y;
         var _loc7_:Number = param2[0].y - param2[1].y;
         var _loc8_:Number = param2[0].y - param1[0].y;
         var _loc9_:Number = (_loc4_ * _loc8_ - _loc7_ * _loc5_) / (_loc6_ * _loc4_ - _loc3_ * _loc7_);
         return new Vec2(param1[0].x + _loc9_ * (param1[1].x - param1[0].x),param1[0].y + _loc9_ * (param1[1].y - param1[0].y));
      }
      
      public static function isCW(param1:Vector.<Vec2>) : Boolean
      {
         var _loc2_:Vec2 = vecRot90CW(new Vec2(param1[1].x - param1[0].x,param1[1].y - param1[0].y));
         var _loc3_:Number = _loc2_.dot(new Vec2(param1[2].x - param1[1].x,param1[2].y - param1[1].y));
         return _loc3_ >= 0;
      }
      
      public static function expandPolygon(param1:Vector.<Vec2>, param2:Number) : Vector.<Vec2>
      {
         var _loc3_:int = 0;
         var _loc4_:Vec2 = null;
         var _loc5_:Vec2 = null;
         var _loc6_:Vec2 = null;
         var _loc7_:Vec2 = null;
         var _loc8_:Vec2 = null;
         var _loc9_:Vec2 = null;
         var _loc10_:Vec2 = null;
         var _loc11_:Vec2 = null;
         var _loc12_:Vec2 = null;
         var _loc13_:Vec2 = null;
         var _loc14_:Vec2 = null;
         var _loc15_:Vector.<Vec2> = new Vector.<Vec2>();
         var _loc16_:Function = isCW(param1) ? vecRot90CCW : vecRot90CW;
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_ > 0 ? _loc3_ - 1 : param1.length - 1];
            _loc5_ = param1[_loc3_];
            _loc6_ = param1[_loc3_ < param1.length - 1 ? _loc3_ + 1 : 0];
            _loc7_ = new Vec2(_loc5_.x - _loc4_.x,_loc5_.y - _loc4_.y);
            _loc8_ = new Vec2(_loc6_.x - _loc5_.x,_loc6_.y - _loc5_.y);
            _loc9_ = Vec2(_loc16_(_loc7_)).unit().mul(param2);
            _loc10_ = Vec2(_loc16_(_loc8_)).unit().mul(param2);
            _loc11_ = new Vec2(_loc4_.x + _loc9_.x,_loc4_.y + _loc9_.y);
            _loc12_ = new Vec2(_loc5_.x + _loc9_.x,_loc5_.y + _loc9_.y);
            _loc13_ = new Vec2(_loc5_.x + _loc10_.x,_loc5_.y + _loc10_.y);
            _loc14_ = new Vec2(_loc6_.x + _loc10_.x,_loc6_.y + _loc10_.y);
            _loc15_.push(intersect([_loc11_,_loc12_],[_loc13_,_loc14_]));
            _loc3_++;
         }
         return _loc15_;
      }
      
      public static function findLineSegments(param1:Vector.<Vec2>, param2:int, param3:String) : Vector.<Vector.<Vec2>>
      {
         var testFunc:Function = null;
         var segments:Vector.<Vector.<Vec2>> = null;
         var i:int = 0;
         var segment:Vector.<Vec2> = null;
         var curPoint:Vec2 = null;
         var nextPoint:Vec2 = null;
         var points:Vector.<Vec2> = param1;
         var angle:int = param2;
         var compFunc:String = param3;
         var getCurPoint:* = function(param1:int):Vec2
         {
            return param1 < points.length ? points[param1] : points[param1 - points.length];
         };
         var getNextPoint:* = function(param1:int):Vec2
         {
            if(param1 < points.length - 1)
            {
               return points[param1 + 1];
            }
            return param1 - points.length < points.length - 1 ? points[param1 - points.length + 1] : points[0];
         };
         var startIndex:int = int(findStartIndex(points));
         if(startIndex == -1)
         {
            throw new Error("No Start index found!");
         }
         testFunc = compFunc == "AngleLess" ? angleLess : angleMore;
         segments = new Vector.<Vector.<Vec2>>();
         i = startIndex;
         while(i < startIndex + points.length)
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
      
      public static function isCWArray(param1:Array) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:Array = GeomUtils.duplicatePolygonArray(param1);
         _loc3_.push(_loc3_[0].copy());
         var _loc4_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length - 1)
         {
            _loc4_ += (_loc3_[_loc2_ + 1].x - _loc3_[_loc2_].x) * (_loc3_[_loc2_ + 1].y + _loc3_[_loc2_].y) / 2;
            _loc2_++;
         }
         return _loc4_ < 0;
      }
      
      public static function calculatePolygonArea(param1:Vector.<Vec2>) : Number
      {
         var _loc2_:int = 0;
         var _loc3_:Number = 0;
         var _loc4_:int = 2;
         var _loc5_:int = 0;
         _loc2_ = 1;
         while(_loc2_ <= param1.length - 2)
         {
            _loc3_ += param1[_loc2_].x * (param1[_loc4_].y - param1[_loc5_].y);
            _loc4_++;
            _loc5_++;
            _loc2_++;
         }
         return _loc3_ / 2;
      }
      
      private static function testSegment(param1:Vec2, param2:Vec2, param3:Function, param4:int) : Boolean
      {
         return param3(MathUtils.radiansToDegrees(Math.atan2(param2.y - param1.y,param2.x - param1.x)),param4);
      }
      
      private static function angleLess(param1:Number, param2:int) : Boolean
      {
         return Math.abs(param1) < param2;
      }
      
      private static function angleMore(param1:Number, param2:int) : Boolean
      {
         return Math.abs(param1) >= param2;
      }
      
      private static function findStartIndex(param1:Vector.<Vec2>) : int
      {
         var _loc2_:int = 0;
         var _loc3_:Vec2 = null;
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = _loc2_ == 0 ? param1[param1.length - 1] : param1[_loc2_ - 1];
            if(_loc3_.x >= param1[_loc2_].x)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      public static function createBoundingBox(param1:*) : flash.geom.Rectangle
      {
         var _loc2_:flash.geom.Rectangle = new Rectangle();
         _loc2_.x = find(param1,smallerX,1.7976931348623157e+308);
         _loc2_.y = find(param1,smallerY,1.7976931348623157e+308);
         _loc2_.width = find(param1,biggerX,Number.MIN_VALUE);
         _loc2_.height = find(param1,biggerY,Number.MIN_VALUE);
         return _loc2_;
      }
      
      private static function find(param1:*, param2:Function, param3:Number) : Number
      {
         var _loc5_:* = undefined;
         var _loc4_:* = param3;
         for each(_loc5_ in param1)
         {
            _loc4_ = param2(_loc5_,_loc4_);
         }
         return _loc4_;
      }
      
      private static function smallerX(param1:*, param2:Number) : Number
      {
         return param1.x < param2 ? Number(param1.x) : param2;
      }
      
      private static function smallerY(param1:*, param2:Number) : Number
      {
         return param1.y < param2 ? Number(param1.y) : param2;
      }
      
      private static function biggerX(param1:*, param2:Number) : Number
      {
         return param1.x > param2 ? Number(param1.x) : param2;
      }
      
      private static function biggerY(param1:*, param2:Number) : Number
      {
         return param1.y > param2 ? Number(param1.y) : param2;
      }
      
      public static function multiplyPolygon(param1:Vector.<Vec2>, param2:Number) : void
      {
         var _loc3_:* = undefined;
         for each(_loc3_ in param1)
         {
            _loc3_.muleq(param2);
         }
      }
   }
}

