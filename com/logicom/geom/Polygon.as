package com.logicom.geom
{
   public class Polygon
   {
       
      
      private var _points:Vector.<IntPoint>;
      
      public function Polygon()
      {
         _points = new Vector.<IntPoint>();
         super();
      }
      
      public function addPoint(point:IntPoint) : void
      {
         _points.push(point);
      }
      
      public function getPoint(index:int) : IntPoint
      {
         return _points[index];
      }
      
      public function getPoints() : Vector.<IntPoint>
      {
         return _points;
      }
      
      public function getSize() : int
      {
         return _points.length;
      }
      
      public function reverse() : void
      {
         _points.reverse();
      }
   }
}
