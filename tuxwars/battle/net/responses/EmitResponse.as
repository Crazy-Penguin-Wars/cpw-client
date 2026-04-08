package tuxwars.battle.net.responses
{
   import nape.geom.*;
   
   public class EmitResponse extends ActionResponse
   {
      public function EmitResponse(param1:Object)
      {
         super(param1);
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
         var _loc1_:Vec2 = null;
         if(Boolean(data.hasOwnProperty("dx")) && Boolean(data.hasOwnProperty("dy")))
         {
            _loc1_ = new Vec2(data.dx,data.dy);
            _loc1_.muleq(1 / 10000);
         }
         else if(!data.hasOwnProperty("dx") && !data.hasOwnProperty("dy"))
         {
            _loc1_ = new Vec2();
         }
         return _loc1_;
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

