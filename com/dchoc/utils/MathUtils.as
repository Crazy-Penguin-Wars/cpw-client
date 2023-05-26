package com.dchoc.utils
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   
   public class MathUtils
   {
      
      public static const ONE80_PER_PI:Number = 57.29577951308232;
      
      public static const PI_PER_ONE80:Number = 0.017453292519943295;
       
      
      public function MathUtils()
      {
         super();
      }
      
      public static function degreesToRadians(angle:Number) : Number
      {
         return angle * 0.017453292519943295;
      }
      
      public static function radiansToDegrees(radians:Number) : Number
      {
         return radians * 57.29577951308232;
      }
      
      public static function dot(vec1:Point, vec2:Point) : Number
      {
         return vec1.x * vec2.x + vec1.y * vec2.y;
      }
      
      public static function randomNumber(low:int, high:int) : int
      {
         return Math.round(Math.random() * (high - low)) + low;
      }
      
      public static function multiplyPoint(point:Point, value:Number) : Point
      {
         point.x *= value;
         point.y *= value;
         return point;
      }
      
      public static function multiplyVec(vec:Vec2, value:Number) : Vec2
      {
         vec.x *= value;
         vec.y *= value;
         return vec;
      }
      
      public static function translatePoint(point:Point, other:Point) : Point
      {
         point.x += other.x;
         point.y += other.y;
         return point;
      }
      
      public static function normalize(p:Point) : Number
      {
         var _loc3_:Number = Math.sqrt(p.x * p.x + p.y * p.y);
         if(_loc3_ < Number.MIN_VALUE)
         {
            return 0;
         }
         var _loc2_:Number = 1 / _loc3_;
         p.x *= _loc2_;
         p.y *= _loc2_;
         return _loc3_;
      }
      
      public static function roundPoint(p:Point, decimals:int = 1) : Point
      {
         if(decimals == 0)
         {
            p.x = Math.round(p.x);
            p.y = Math.round(p.y);
         }
         else
         {
            p.x = round(p.x,decimals);
            p.y = round(p.y,decimals);
         }
         return p;
      }
      
      public static function roundV2(v:Vec2, decimals:int = 1) : Vec2
      {
         if(decimals == 0)
         {
            v.setxy(Math.round(v.x),Math.round(v.y));
         }
         else
         {
            v.x = round(v.x,decimals);
            v.y = round(v.y,decimals);
         }
         return v;
      }
      
      public static function round(num:Number, decimals:int = 2) : Number
      {
         if(decimals == 0)
         {
            return Math.round(num);
         }
         var _loc3_:int = Math.pow(10,decimals);
         return Math.round(num * _loc3_) / _loc3_;
      }
      
      public static function roundRect(rect:Rectangle, decimals:int = 0) : Rectangle
      {
         rect.x = round(rect.x,decimals);
         rect.y = round(rect.y,decimals);
         rect.width = round(rect.width,decimals);
         rect.height = round(rect.height,decimals);
         return rect;
      }
      
      public static function angle(p1:Point, p2:Point) : Number
      {
         return Math.atan2(p2.y - p1.y,p2.x - p1.x) * 57.29577951308232;
      }
      
      public static function rotatePoint(p:Point, angle:Number) : Point
      {
         var _loc3_:Number = Math.cos(angle);
         var _loc4_:Number = Math.sin(angle);
         p.x = p.x * _loc3_ - p.y * _loc4_;
         p.y = p.x * _loc4_ + p.y * _loc3_;
         return p;
      }
      
      public static function equals(value1:Number, value2:Number, precision:Number) : Boolean
      {
         if(value1 == value2)
         {
            return true;
         }
         if(isNaN(value1))
         {
            return isNaN(value2);
         }
         if(isNaN(value2))
         {
            return false;
         }
         return Math.abs(value1 - value2) <= precision;
      }
   }
}
