package tuxwars.battle.net.responses
{
   import nape.geom.Vec2;
   
   public class FireWeaponResponse extends ActionResponse
   {
       
      
      public function FireWeaponResponse(data:Object)
      {
         super(data);
      }
      
      public function get weaponId() : String
      {
         return data.wid;
      }
      
      public function get powerBar() : int
      {
         return data.pb;
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
      
      public function get location() : Vec2
      {
         return new Vec2(data.lx,data.ly);
      }
   }
}
