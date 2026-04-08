package earcutting
{
   import flash.geom.*;
   
   public class EarCutting
   {
      private static var p:Point;
      
      private static var p0:Point;
      
      private static var p1:Point;
      
      private static var p2:Point;
      
      private static var s:Segment;
      
      private static var cs0:Segment;
      
      private static var cs1:Segment;
      
      private static var cs2:Segment;
      
      private static var t:Triangle;
      
      private static var det0:Number = 0;
      
      private static var det1:Number = 0;
      
      private static var ear:int = 0;
      
      private static var breaker:Boolean = false;
      
      private static var CW:Boolean = true;
      
      private static var points:Array = [];
      
      private static var tmp:Array = [];
      
      private static var segments:Array = [];
      
      private static var triangles:Array = [];
      
      public function EarCutting()
      {
         super();
      }
      
      public static function cut(param1:Array, param2:Boolean = false) : Array
      {
         if(param1.length < 3)
         {
            return [new Triangle(param1[0],param1[1],param1[2])];
         }
         if(param1[0].x == param1[param1.length - 1].x && param1[0].y == param1[param1.length - 1].y)
         {
            param1.pop();
         }
         points = param1.concat();
         buildSegments(points);
         if(param2 && selfIntersection())
         {
            return [];
         }
         CW = getDirection(points);
         process();
         return triangles;
      }
      
      public static function process() : Array
      {
         ear = 0;
         breaker = false;
         triangles = [];
         tmp = points.concat();
         while(tmp.length > 2)
         {
            tmp = earCut(tmp);
            if(breaker)
            {
               return triangles;
            }
         }
         return triangles;
      }
      
      public static function earCut(param1:Array) : Array
      {
         if(param1.length < 3)
         {
            triangles.push(new Triangle(param1[0],param1[1],param1[2]));
            return param1;
         }
         ear = ear < 0 ? 0 : int(ear);
         if(param1[ear] == null)
         {
            breaker = true;
            return param1;
         }
         p0 = param1[ear];
         var _loc2_:int = ear + 1 < param1.length ? int(ear + 1) : 0;
         p1 = param1[_loc2_];
         var _loc3_:int = ear + 2 < param1.length ? int(ear + 2) : 1;
         p2 = param1[_loc3_];
         t = new Triangle(p0,p1,p2);
         if(triangleContainsPoints(t,param1))
         {
            ++ear;
            return param1;
         }
         cs0.p0 = cs2.p1 = p0;
         cs1.p0 = cs0.p1 = p1;
         cs2.p0 = cs1.p1 = p2;
         p = cs2.getCenter();
         det0 = determinant(cs0.p0,cs0.p1,p);
         det1 = determinant(cs1.p0,cs1.p1,p);
         if(Boolean(CW) && det0 > 0 && det1 > 0 || !CW && det0 < 0 && det1 < 0)
         {
            ++ear;
            return param1;
         }
         triangles.push(t);
         param1.splice(_loc2_,1);
         --ear;
         return param1;
      }
      
      private static function getDirection(param1:Array) : Boolean
      {
         var _loc2_:Point = null;
         var _loc3_:int = int(param1.length - 1);
         p0 = param1[_loc3_];
         p1 = !!param1[_loc3_ + 1] ? param1[_loc3_ + 1] : param1[0];
         p2 = !!param1[_loc3_ + 2] ? param1[_loc3_ + 2] : param1[1];
         cs0 = new Segment(p0,p1);
         cs1 = new Segment(p1,p2);
         cs2 = new Segment(p0,p2);
         var _loc4_:Point = cs2.getCenter();
         var _loc5_:Point = new Point(_loc4_.x + 10000,_loc4_.y);
         var _loc6_:Segment = new Segment(_loc4_,_loc5_);
         var _loc7_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < segments.length)
         {
            s = segments[_loc3_];
            _loc2_ = s.segmentIntersct(_loc6_,true);
            if(_loc2_ != null)
            {
               _loc7_++;
            }
            _loc3_++;
         }
         t = new Triangle(p0,p1,p2);
         if(_loc7_ % 2 == 0 && !triangleContainsPoints(t,param1))
         {
            param1.reverse();
         }
         det0 = determinant(cs0.p0,cs0.p1,_loc4_);
         det1 = determinant(cs1.p0,cs1.p1,_loc4_);
         return det0 < 0 && det1 < 0;
      }
      
      public static function selfIntersection() : Boolean
      {
         var _loc1_:* = null;
         var _loc2_:Point = null;
         for each(s in segments)
         {
            for each(_loc1_ in segments)
            {
               if(s != cs0)
               {
                  _loc2_ = s.segmentIntersct(_loc1_,true);
                  if(_loc2_ != null && !(Boolean(s.p0.equals(_loc1_.p0)) || Boolean(s.p0.equals(_loc1_.p1))) && !(Boolean(s.p1.equals(_loc1_.p0)) || Boolean(s.p1.equals(_loc1_.p1))))
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public static function buildSegments(param1:Array) : Array
      {
         var _loc2_:int = 0;
         segments = [];
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            p0 = param1[_loc2_];
            p1 = !!param1[_loc2_ + 1] ? param1[_loc2_ + 1] : param1[0];
            s = new Segment(p0,p1);
            segments.push(s);
            _loc2_++;
         }
         return segments;
      }
      
      private static function triangleContainsPoints(param1:Triangle, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = int(param2.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            p = param2[_loc3_];
            if(p != p0 && p != p1 && p != p2)
            {
               if(param1.contains(p))
               {
                  return true;
               }
            }
            _loc3_++;
         }
         return false;
      }
      
      public static function determinant(param1:Point, param2:Point, param3:Point) : Number
      {
         return (param1.x - param2.x) * (param3.y - param2.y) - (param3.x - param2.x) * (param1.y - param2.y);
      }
   }
}

