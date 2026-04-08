package tuxwars.battle.net.responses
{
   import nape.geom.*;
   
   public class JumpResponse extends ActionResponse
   {
      public function JumpResponse(param1:Object)
      {
         super(param1);
      }
      
      public function get x() : Number
      {
         return data.x;
      }
      
      public function get y() : Number
      {
         return data.y;
      }
      
      public function get direction() : Vec2
      {
         return new Vec2(this.x,this.y);
      }
   }
}

