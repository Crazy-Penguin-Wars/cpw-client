package earcutting
{
   import flash.geom.Point;
   
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
      
      private static var det0:Number = 0;
      
      private static var det1:Number = 0;
      
      private static var t:Triangle;
      
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
      
      public static function cut(pts:Array, performSelfIntersectionTest:Boolean = false) : Array
      {
         if(pts.length < 3)
         {
            return [new Triangle(pts[0],pts[1],pts[2])];
         }
         if(pts[0].x == pts[pts.length - 1].x && pts[0].y == pts[pts.length - 1].y)
         {
            pts.pop();
         }
         points = pts.concat();
         buildSegments(points);
         if(performSelfIntersectionTest && selfIntersection())
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
      
      public static function earCut(pts:Array) : Array
      {
         if(pts.length < 3)
         {
            triangles.push(new Triangle(pts[0],pts[1],pts[2]));
            return pts;
         }
         ear = ear < 0 ? 0 : ear;
         if(pts[ear] == null)
         {
            breaker = true;
            return pts;
         }
         p0 = pts[ear];
         var p1Index:int = ear + 1 < pts.length ? ear + 1 : 0;
         p1 = pts[p1Index];
         var p2Index:int = ear + 2 < pts.length ? ear + 2 : 1;
         p2 = pts[p2Index];
         t = new Triangle(p0,p1,p2);
         if(triangleContainsPoints(t,pts))
         {
            ear++;
            return pts;
         }
         cs0.p0 = cs2.p1 = p0;
         cs1.p0 = cs0.p1 = p1;
         cs2.p0 = cs1.p1 = p2;
         p = cs2.getCenter();
         det0 = determinant(cs0.p0,cs0.p1,p);
         det1 = determinant(cs1.p0,cs1.p1,p);
         if(CW && det0 > 0 && det1 > 0 || !CW && det0 < 0 && det1 < 0)
         {
            ear++;
            return pts;
         }
         triangles.push(t);
         pts.splice(p1Index,1);
         ear--;
         return pts;
      }
      
      private static function getDirection(tmp:Array) : Boolean
      {
         var ip:* = null;
         var i:int = tmp.length - 1;
         p0 = tmp[i];
         p1 = !!tmp[i + 1] ? tmp[i + 1] : tmp[0];
         p2 = !!tmp[i + 2] ? tmp[i + 2] : tmp[1];
         cs0 = new Segment(p0,p1);
         cs1 = new Segment(p1,p2);
         cs2 = new Segment(p0,p2);
         var p:Point = cs2.getCenter();
         var ep:Point = new Point(p.x + 10000,p.y);
         var cs:Segment = new Segment(p,ep);
         var count:int = 0;
         for(i = 0; i < segments.length; )
         {
            s = segments[i];
            ip = s.segmentIntersct(cs,true);
            if(ip != null)
            {
               count++;
            }
            i++;
         }
         t = new Triangle(p0,p1,p2);
         if(count % 2 == 0 && !triangleContainsPoints(t,tmp))
         {
            tmp.reverse();
         }
         det0 = determinant(cs0.p0,cs0.p1,p);
         det1 = determinant(cs1.p0,cs1.p1,p);
         return det0 < 0 && det1 < 0;
      }
      
      public static function selfIntersection() : Boolean
      {
         var ss:* = null;
         var ip:* = null;
         for each(s in segments)
         {
            for each(ss in segments)
            {
               if(s != cs0)
               {
                  ip = s.segmentIntersct(ss,true);
                  if(ip != null && !(s.p0.equals(ss.p0) || s.p0.equals(ss.p1)) && !(s.p1.equals(ss.p0) || s.p1.equals(ss.p1)))
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      public static function buildSegments(points:Array) : Array
      {
         var i:int = 0;
         segments = [];
         for(i = 0; i < points.length; )
         {
            p0 = points[i];
            p1 = !!points[i + 1] ? points[i + 1] : points[0];
            s = new Segment(p0,p1);
            segments.push(s);
            i++;
         }
         return segments;
      }
      
      private static function triangleContainsPoints(t:Triangle, pts:Array) : Boolean
      {
         var i:int = 0;
         var PL:int = pts.length;
         for(i = 0; i < PL; )
         {
            p = pts[i];
            if(p != p0 && p != p1 && p != p2)
            {
               if(t.contains(p))
               {
                  return true;
               }
            }
            i++;
         }
         return false;
      }
      
      public static function determinant(p0:Point, p1:Point, p2:Point) : Number
      {
         return (p0.x - p1.x) * (p2.y - p1.y) - (p2.x - p1.x) * (p0.y - p1.y);
      }
   }
}
