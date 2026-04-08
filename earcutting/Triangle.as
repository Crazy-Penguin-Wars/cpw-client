package earcutting
{
   import flash.display.Graphics;
   import flash.geom.*;
   
   public class Triangle
   {
      public var p0:Point;
      
      public var p1:Point;
      
      public var p2:Point;
      
      public function Triangle(param1:Point, param2:Point, param3:Point)
      {
         super();
         this.p0 = param1;
         this.p1 = param2;
         this.p2 = param3;
      }
      
      public function contains(param1:Point) : Boolean
      {
         if(this.determinant(this.p0,this.p1,param1) > 0 && this.determinant(this.p1,this.p2,param1) > 0 && this.determinant(this.p2,this.p0,param1) > 0)
         {
            return true;
         }
         if(this.determinant(this.p0,this.p1,param1) < 0 && this.determinant(this.p1,this.p2,param1) < 0 && this.determinant(this.p2,this.p0,param1) < 0)
         {
            return true;
         }
         return false;
      }
      
      public function determinant(param1:Point, param2:Point, param3:Point) : Number
      {
         return (param1.x - param2.x) * (param3.y - param2.y) - (param3.x - param2.x) * (param1.y - param2.y);
      }
      
      public function getCenter() : Point
      {
         return new Point((this.p0.x + this.p1.x + this.p2.x) / 3,(this.p0.y + this.p1.y + this.p2.y) / 3);
      }
      
      public function draw(param1:Graphics) : void
      {
         param1.moveTo(this.p0.x,this.p0.y);
         param1.lineTo(this.p1.x,this.p1.y);
         param1.lineTo(this.p2.x,this.p2.y);
         param1.lineTo(this.p0.x,this.p0.y);
      }
   }
}

