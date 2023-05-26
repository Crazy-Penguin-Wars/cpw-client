package tuxwars.battle.net.responses
{
   import nape.geom.Vec2;
   
   public class EmitResponse extends ActionResponse
   {
       
      
      public function EmitResponse(data:Object)
      {
         super(data);
      }
      
      public function get emitterId() : String
      {
         return data.eid;
      }
      
      public function get location() : Vec2
      {
         return new Vec2(data.lx,data.ly);
      }
      
      public function get direction() : Vec2
      {
         var point:* = null;
         if(data.hasOwnProperty("dx") && data.hasOwnProperty("dy"))
         {
            point = new Vec2(data.dx,data.dy);
            point.muleq(1 / 10000);
         }
         else if(!data.hasOwnProperty("dx") && !data.hasOwnProperty("dy"))
         {
            point = new Vec2();
         }
         return point;
      }
      
      public function get powerBar() : int
      {
         return data.p;
      }
      
      public function get playerAttack() : int
      {
         return data.a;
      }
      
      public function get impulseList() : Array
      {
         return !!data.hasOwnProperty("il") ? data.il : [];
      }
      
      public function get damageList() : Array
      {
         return !!data.hasOwnProperty("dl") ? data.dl : [];
      }
      
      public function get terrainList() : Array
      {
         return !!data.hasOwnProperty("tl") ? data.tl : [];
      }
   }
}
