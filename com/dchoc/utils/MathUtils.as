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
      
      public static function degreesToRadians(param1:Number) : Number
      {
         return param1 * 0.017453292519943295;
      }
      
      public static function radiansToDegrees(param1:Number) : Number
      {
         return param1 * 57.29577951308232;
      }
      
      public static function dot(param1:Point, param2:Point) : Number
      {
         return param1.x * param2.x + param1.y * param2.y;
      }
      
      public static function randomNumber(param1:int, param2:int) : int
      {
         return Math.round(Math.random() * (param2 - param1)) + param1;
      }
      
      public static function multiplyPoint(param1:Point, param2:Number) : Point
      {
         param1.x *= param2;
         param1.y *= param2;
         return param1;
      }
      
      public static function multiplyVec(param1:Vec2, param2:Number) : Vec2
      {
         param1.x *= param2;
         param1.y *= param2;
         return param1;
      }
      
      public static function translatePoint(param1:Point, param2:Point) : Point
      {
         param1.x += param2.x;
         param1.y += param2.y;
         return param1;
      }
      
      public static function normalize(param1:Point) : Number
      {
         var _loc2_:Number = Math.sqrt(param1.x * param1.x + param1.y * param1.y);
         if(_loc2_ < Number.MIN_VALUE)
         {
            return 0;
         }
         var _loc3_:Number = 1 / _loc2_;
         param1.x *= _loc3_;
         param1.y *= _loc3_;
         return _loc2_;
      }
      
      public static function roundPoint(param1:Point, param2:int = 1) : Point
      {
         if(param2 == 0)
         {
            param1.x = Math.round(param1.x);
            param1.y = Math.round(param1.y);
         }
         else
         {
            param1.x = round(param1.x,param2);
            param1.y = round(param1.y,param2);
         }
         return param1;
      }
      
      public static function roundV2(param1:Vec2, param2:int = 1) : Vec2
      {
         if(param2 == 0)
         {
            param1.setxy(Math.round(param1.x),Math.round(param1.y));
         }
         else
         {
            param1.x = round(param1.x,param2);
            param1.y = round(param1.y,param2);
         }
         return param1;
      }
      
      public static function round(param1:Number, param2:int = 2) : Number
      {
         if(param2 == 0)
         {
            return Math.round(param1);
         }
         var _loc3_:int = Math.pow(10,param2);
         return Math.round(param1 * _loc3_) / _loc3_;
      }
      
      public static function roundRect(param1:flash.geom.Rectangle, param2:int = 0) : flash.geom.Rectangle
      {
         param1.x = round(param1.x,param2);
         param1.y = round(param1.y,param2);
         param1.width = round(param1.width,param2);
         param1.height = round(param1.height,param2);
         return param1;
      }
      
      public static function angle(param1:Point, param2:Point) : Number
      {
         return Math.atan2(param2.y - param1.y,param2.x - param1.x) * 57.29577951308232;
      }
      
      public static function rotatePoint(param1:Point, param2:Number) : Point
      {
         var _loc3_:Number = Math.cos(param2);
         var _loc4_:Number = Math.sin(param2);
         param1.x = param1.x * _loc3_ - param1.y * _loc4_;
         param1.y = param1.x * _loc4_ + param1.y * _loc3_;
         return param1;
      }
      
      public static function equals(param1:Number, param2:Number, param3:Number) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(isNaN(param1))
         {
            return isNaN(param2);
         }
         if(isNaN(param2))
         {
            return false;
         }
         return Math.abs(param1 - param2) <= param3;
      }
   }
}

