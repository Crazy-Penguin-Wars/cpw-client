package tuxwars.battle.data.parallaxes
{
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class ParallaxSprite extends Sprite
   {
       
      
      public var rp:Point;
      
      public function ParallaxSprite()
      {
         super();
         setRegistration();
      }
      
      public function setRegistration(x:Number = 0, y:Number = 0) : void
      {
         rp = new Point(x,y);
      }
      
      public function getX() : Number
      {
         var p:* = null;
         if(this.parent)
         {
            p = this.parent.globalToLocal(this.localToGlobal(rp));
            return p.x;
         }
         return this.x;
      }
      
      public function setX(value:Number) : void
      {
         var p:* = null;
         if(this.parent)
         {
            p = parent.globalToLocal(this.localToGlobal(rp));
            this.x += value - p.x;
         }
         else if(rp)
         {
            this.x = value - rp.x;
         }
         else
         {
            this.x = value;
         }
      }
      
      public function getY() : Number
      {
         var p:* = null;
         if(this.parent)
         {
            p = this.parent.globalToLocal(this.localToGlobal(rp));
            return p.y;
         }
         return this.y;
      }
      
      public function setY(value:Number) : void
      {
         var p:* = null;
         if(this.parent)
         {
            p = this.parent.globalToLocal(this.localToGlobal(rp));
            this.y += value - p.y;
         }
         else if(rp)
         {
            this.y = value - rp.y;
         }
         else
         {
            this.y = value;
         }
      }
   }
}
