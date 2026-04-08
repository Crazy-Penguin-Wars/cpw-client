package tuxwars.battle.net.responses
{
   import nape.geom.*;
   
   public class FireWeaponResponse extends ActionResponse
   {
      public function FireWeaponResponse(param1:Object)
      {
         super(param1);
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
         return new Vec2(this.x,this.y);
      }
      
      public function get location() : Vec2
      {
         return new Vec2(data.lx,data.ly);
      }
   }
}

