package com.logicom.geom
{
   public class IntPoint
   {
       
      
      public var X:int;
      
      public var Y:int;
      
      public function IntPoint(x:int = 0, y:int = 0)
      {
         super();
         this.X = x;
         this.Y = y;
      }
      
      public static function cross(vec1:IntPoint, vec2:IntPoint) : int
      {
         return vec1.X * vec2.Y - vec2.X * vec1.Y;
      }
      
      public function equals(pt:IntPoint) : Boolean
      {
         return this.X == pt.X && this.Y == pt.Y;
      }
   }
}
