package tuxwars.battle.net.responses
{
   import nape.geom.Vec2;
   
   public class JumpResponse extends ActionResponse
   {
       
      
      public function JumpResponse(data:Object)
      {
         super(data);
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
         return new Vec2(x,y);
      }
   }
}
