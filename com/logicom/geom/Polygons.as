package com.logicom.geom
{
   public class Polygons
   {
       
      
      private var _polygons:Vector.<Polygon>;
      
      public function Polygons()
      {
         _polygons = new Vector.<Polygon>();
         super();
      }
      
      public function addPolygon(polygon:Polygon) : void
      {
         _polygons.push(polygon);
      }
      
      public function clear() : void
      {
         _polygons.length = 0;
      }
      
      public function getPolygons() : Vector.<Polygon>
      {
         return _polygons;
      }
   }
}
