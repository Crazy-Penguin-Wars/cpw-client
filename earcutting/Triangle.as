package earcutting
{
   import flash.display.Graphics;
   import flash.geom.Point;
   
   public class Triangle
   {
       
      
      public var p0:Point;
      
      public var p1:Point;
      
      public var p2:Point;
      
      public function Triangle(p0:Point, p1:Point, p2:Point)
      {
         super();
         this.p0 = p0;
         this.p1 = p1;
         this.p2 = p2;
      }
      
      public function contains(p:Point) : Boolean
      {
         if(determinant(p0,p1,p) > 0 && determinant(p1,p2,p) > 0 && determinant(p2,p0,p) > 0)
         {
            return true;
         }
         if(determinant(p0,p1,p) < 0 && determinant(p1,p2,p) < 0 && determinant(p2,p0,p) < 0)
         {
            return true;
         }
         return false;
      }
      
      public function determinant(p0:Point, p1:Point, p2:Point) : Number
      {
         return (p0.x - p1.x) * (p2.y - p1.y) - (p2.x - p1.x) * (p0.y - p1.y);
      }
      
      public function getCenter() : Point
      {
         return new Point((p0.x + p1.x + p2.x) / 3,(p0.y + p1.y + p2.y) / 3);
      }
      
      public function draw(graphics:Graphics) : void
      {
         graphics.moveTo(p0.x,p0.y);
         graphics.lineTo(p1.x,p1.y);
         graphics.lineTo(p2.x,p2.y);
         graphics.lineTo(p0.x,p0.y);
      }
   }
}
