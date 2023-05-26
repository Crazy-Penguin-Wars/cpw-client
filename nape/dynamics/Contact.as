package nape.dynamics
{
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_ColArbiter;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.dynamics.ZPP_IContact;
   
   public final class Contact
   {
       
      
      public var zpp_inner:ZPP_Contact;
      
      public function Contact()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(!ZPP_Contact.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate Contact derp!";
         }
      }
      
      public function totalImpulse(param1:Body = undefined) : Vec3
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         if(zpp_inner.inactiveme())
         {
            Boot.lastError = new Error();
            throw "Error: Contact not currently in use";
         }
         var _loc2_:ZPP_ColArbiter = zpp_inner.arbiter.colarb;
         var _loc3_:ZPP_IContact = zpp_inner.inner;
         var _loc4_:Number = _loc3_.jnAcc;
         var _loc5_:Number = _loc3_.jtAcc;
         var _loc6_:Number = _loc2_.jrAcc;
         if(param1 == null)
         {
            return Vec3.get(_loc2_.nx * _loc4_ - _loc2_.ny * _loc5_,_loc2_.ny * _loc4_ + _loc2_.nx * _loc5_,_loc6_);
         }
         if(param1 != _loc2_.b1.outer && param1 != _loc2_.b2.outer)
         {
            Boot.lastError = new Error();
            throw "Error: Contact does not relate to the given body";
         }
         _loc7_ = _loc2_.nx * _loc4_ - _loc2_.ny * _loc5_;
         _loc8_ = _loc2_.ny * _loc4_ + _loc2_.nx * _loc5_;
         if(param1 == _loc2_.b1.outer)
         {
            return Vec3.get(-_loc7_,-_loc8_,-(_loc8_ * _loc3_.r1x - _loc7_ * _loc3_.r1y) - _loc6_);
         }
         return Vec3.get(_loc7_,_loc8_,_loc8_ * _loc3_.r2x - _loc7_ * _loc3_.r2y + _loc6_);
      }
      
      public function toString() : String
      {
         if(zpp_inner.arbiter == null || zpp_inner.arbiter.cleared)
         {
            return "{object-pooled}";
         }
         return "{Contact}";
      }
      
      public function tangentImpulse(param1:Body = undefined) : Vec3
      {
         if(zpp_inner.inactiveme())
         {
            Boot.lastError = new Error();
            throw "Error: Contact not currently in use";
         }
         var _loc2_:ZPP_ColArbiter = zpp_inner.arbiter.colarb;
         var _loc3_:ZPP_IContact = zpp_inner.inner;
         var _loc4_:Number = _loc3_.jtAcc;
         if(param1 == null)
         {
            return Vec3.get(-_loc2_.ny * _loc4_,_loc2_.nx * _loc4_);
         }
         if(param1 != _loc2_.b1.outer && param1 != _loc2_.b2.outer)
         {
            Boot.lastError = new Error();
            throw "Error: Contact does not relate to the given body";
         }
         if(param1 == _loc2_.b1.outer)
         {
            return Vec3.get(_loc2_.ny * _loc4_,-_loc2_.nx * _loc4_,-(_loc3_.r1x * _loc2_.nx + _loc3_.r1y * _loc2_.ny) * _loc4_);
         }
         return Vec3.get(-_loc2_.ny * _loc4_,_loc2_.nx * _loc4_,(_loc3_.r2x * _loc2_.nx + _loc3_.r2y * _loc2_.ny) * _loc4_);
      }
      
      public function rollingImpulse(param1:Body = undefined) : Number
      {
         if(zpp_inner.inactiveme())
         {
            Boot.lastError = new Error();
            throw "Error: Contact not currently in use";
         }
         var _loc2_:ZPP_ColArbiter = zpp_inner.arbiter.colarb;
         var _loc3_:Number = zpp_inner.arbiter.colarb.jrAcc;
         if(param1 == null)
         {
            return _loc3_;
         }
         if(param1 != _loc2_.b1.outer && param1 != _loc2_.b2.outer)
         {
            Boot.lastError = new Error();
            throw "Error: Contact does not relate to the given body";
         }
         if(param1 == _loc2_.b1.outer)
         {
            return -_loc3_;
         }
         return _loc3_;
      }
      
      public function normalImpulse(param1:Body = undefined) : Vec3
      {
         if(zpp_inner.inactiveme())
         {
            Boot.lastError = new Error();
            throw "Error: Contact not currently in use";
         }
         var _loc2_:ZPP_ColArbiter = zpp_inner.arbiter.colarb;
         var _loc3_:ZPP_IContact = zpp_inner.inner;
         var _loc4_:Number = _loc3_.jnAcc;
         if(param1 == null)
         {
            return Vec3.get(_loc2_.nx * _loc4_,_loc2_.ny * _loc4_);
         }
         if(param1 != _loc2_.b1.outer && param1 != _loc2_.b2.outer)
         {
            Boot.lastError = new Error();
            throw "Error: Contact does not relate to the given body";
         }
         if(param1 == _loc2_.b1.outer)
         {
            return Vec3.get(_loc2_.nx * -_loc4_,_loc2_.ny * -_loc4_,-(_loc2_.ny * _loc3_.r1x - _loc2_.nx * _loc3_.r1y) * _loc4_);
         }
         return Vec3.get(_loc2_.nx * _loc4_,_loc2_.ny * _loc4_,(_loc2_.ny * _loc3_.r2x - _loc2_.nx * _loc3_.r2y) * _loc4_);
      }
      
      public function get position() : Vec2
      {
         if(zpp_inner.inactiveme())
         {
            Boot.lastError = new Error();
            throw "Error: Contact not currently in use";
         }
         if(zpp_inner.wrap_position == null)
         {
            zpp_inner.getposition();
         }
         return zpp_inner.wrap_position;
      }
      
      public function get penetration() : Number
      {
         if(zpp_inner.inactiveme())
         {
            Boot.lastError = new Error();
            throw "Error: Contact not currently in use";
         }
         return -zpp_inner.dist;
      }
      
      public function get friction() : Number
      {
         if(zpp_inner.inactiveme())
         {
            Boot.lastError = new Error();
            throw "Error: Contact not currently in use";
         }
         return zpp_inner.inner.friction;
      }
      
      public function get fresh() : Boolean
      {
         if(zpp_inner.inactiveme())
         {
            Boot.lastError = new Error();
            throw "Error: Contact not currently in use";
         }
         return zpp_inner.fresh;
      }
      
      public function get arbiter() : CollisionArbiter
      {
         var _loc1_:* = null as Arbiter;
         return zpp_inner.arbiter == null ? null : (_loc1_ = zpp_inner.arbiter.outer, _loc1_.zpp_inner.type == ZPP_Arbiter.COL ? _loc1_.zpp_inner.colarb.outer_zn : null);
      }
   }
}
