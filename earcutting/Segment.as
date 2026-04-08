package earcutting
{
   import flash.display.Graphics;
   import flash.geom.*;
   
   public class Segment
   {
      public var p0:Point;
      
      public var p1:Point;
      
      private var p:Point = new Point();
      
      private var minX:Number = 0;
      
      private var minY:Number = 0;
      
      private var maxX:Number = 0;
      
      private var maxY:Number = 0;
      
      public function Segment(param1:Point, param2:Point)
      {
         super();
         this.p0 = param1;
         this.p1 = param2;
      }
      
      public function segmentIntersct(param1:Segment, param2:Boolean = true) : Point
      {
         var _loc3_:Point = null;
         var _loc4_:Number = Number(NaN);
         var _loc5_:Number = Number(NaN);
         var _loc6_:Number = Number(NaN);
         var _loc7_:Number = Number(NaN);
         var _loc8_:Number = Number(NaN);
         var _loc9_:Number = Number(NaN);
         var _loc10_:Point = this.p0;
         var _loc11_:Point = this.p1;
         var _loc12_:Point = param1.p0;
         var _loc13_:Point = param1.p1;
         _loc4_ = _loc11_.y - _loc10_.y;
         _loc6_ = _loc10_.x - _loc11_.x;
         _loc8_ = _loc11_.x * _loc10_.y - _loc10_.x * _loc11_.y;
         _loc5_ = _loc13_.y - _loc12_.y;
         _loc7_ = _loc12_.x - _loc13_.x;
         _loc9_ = _loc13_.x * _loc12_.y - _loc12_.x * _loc13_.y;
         var _loc14_:Number = _loc4_ * _loc7_ - _loc5_ * _loc6_;
         if(_loc14_ == 0)
         {
            return null;
         }
         _loc3_ = new Point();
         _loc3_.x = (_loc6_ * _loc9_ - _loc7_ * _loc8_) / _loc14_;
         _loc3_.y = (_loc5_ * _loc8_ - _loc4_ * _loc9_) / _loc14_;
         if(param2)
         {
            if(Point.distance(_loc3_,_loc11_) > Point.distance(_loc10_,_loc11_))
            {
               return null;
            }
            if(Point.distance(_loc3_,_loc10_) > Point.distance(_loc10_,_loc11_))
            {
               return null;
            }
            if(Point.distance(_loc3_,_loc13_) > Point.distance(_loc12_,_loc13_))
            {
               return null;
            }
            if(Point.distance(_loc3_,_loc12_) > Point.distance(_loc12_,_loc13_))
            {
               return null;
            }
         }
         return _loc3_;
      }
      
      public function equals(param1:Segment) : Boolean
      {
         return this.p0 == param1.p0 && this.p1 == param1.p1 || this.p0 == param1.p1 && this.p1 == param1.p0;
      }
      
      public function getCenter() : Point
      {
         return new Point(this.p0.x + (this.p1.x - this.p0.x) / 2,this.p0.y + (this.p1.y - this.p0.y) / 2);
      }
      
      public function determinant(param1:Point, param2:Point, param3:Point) : Number
      {
         return (param1.x - param2.x) * (param3.y - param2.y) - (param3.x - param2.x) * (param1.y - param2.y);
      }
      
      public function midPoint() : Point
      {
         return new Point((this.p0.x + this.p1.x) / 2,(this.p0.y + this.p1.y) / 2);
      }
      
      public function render(param1:Graphics) : void
      {
         param1.moveTo(this.p0.x,this.p0.y);
         param1.lineTo(this.p1.x,this.p1.y);
      }
   }
}

