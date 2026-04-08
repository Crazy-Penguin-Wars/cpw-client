package tuxwars.battle.data.parallaxes
{
   import flash.display.Sprite;
   import flash.geom.*;
   
   public class ParallaxSprite extends Sprite
   {
      public var rp:Point;
      
      public function ParallaxSprite()
      {
         super();
         this.setRegistration();
      }
      
      public function setRegistration(param1:Number = 0, param2:Number = 0) : void
      {
         this.rp = new Point(param1,param2);
      }
      
      public function getX() : Number
      {
         var _loc1_:Point = null;
         if(this.parent)
         {
            _loc1_ = this.parent.globalToLocal(this.localToGlobal(this.rp));
            return _loc1_.x;
         }
         return this.x;
      }
      
      public function setX(param1:Number) : void
      {
         var _loc2_:Point = null;
         if(this.parent)
         {
            _loc2_ = parent.globalToLocal(this.localToGlobal(this.rp));
            this.x += param1 - _loc2_.x;
         }
         else if(this.rp)
         {
            this.x = param1 - this.rp.x;
         }
         else
         {
            this.x = param1;
         }
      }
      
      public function getY() : Number
      {
         var _loc1_:Point = null;
         if(this.parent)
         {
            _loc1_ = this.parent.globalToLocal(this.localToGlobal(this.rp));
            return _loc1_.y;
         }
         return this.y;
      }
      
      public function setY(param1:Number) : void
      {
         var _loc2_:Point = null;
         if(this.parent)
         {
            _loc2_ = this.parent.globalToLocal(this.localToGlobal(this.rp));
            this.y += param1 - _loc2_.y;
         }
         else if(this.rp)
         {
            this.y = param1 - this.rp.y;
         }
         else
         {
            this.y = param1;
         }
      }
   }
}

