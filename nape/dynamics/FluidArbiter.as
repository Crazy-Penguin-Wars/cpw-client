package nape.dynamics
{
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_FluidArbiter;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.geom.ZPP_Vec3;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class FluidArbiter extends Arbiter
   {
       
      
      public function FluidArbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_Arbiter.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate FluidArbiter derp!";
         }
         super();
      }
      
      override public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         §§push(false);
         §§push(false);
         if(param1 != null)
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b2.outer : zpp_inner.b1.outer));
         }
         if(§§pop())
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b1.outer : zpp_inner.b2.outer));
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter does not relate to body";
         }
         var _loc3_:Vec3 = buoyancyImpulse(param1);
         var _loc4_:Vec3 = dragImpulse(param1);
         var _loc5_:Vec3 = _loc4_;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(_loc5_.zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         §§push(_loc5_.zpp_inner);
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc6_:ZPP_Vec3 = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(_loc5_.zpp_inner.x);
         if(_loc3_ != null && _loc3_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc6_ = _loc3_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§pop().x = §§pop() + _loc3_.zpp_inner.x;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc5_.zpp_inner.x;
         _loc5_ = _loc4_;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(_loc5_.zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         §§push(_loc5_.zpp_inner);
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(_loc5_.zpp_inner.y);
         if(_loc3_ != null && _loc3_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc6_ = _loc3_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§pop().y = §§pop() + _loc3_.zpp_inner.y;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc5_.zpp_inner.y;
         _loc5_ = _loc4_;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(_loc5_.zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         §§push(_loc5_.zpp_inner);
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(_loc5_.zpp_inner.z);
         if(_loc3_ != null && _loc3_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc6_ = _loc3_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§pop().z = §§pop() + _loc3_.zpp_inner.z;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc5_.zpp_inner.z;
         _loc3_.dispose();
         return _loc4_;
      }
      
      public function set position(param1:Vec2) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         if(!zpp_inner.fluidarb.mutable)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter is mutable only within a pre-handler";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: FluidArbiter::position cannot be null";
         }
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         if(zpp_inner.fluidarb.wrap_position == null)
         {
            zpp_inner.fluidarb.getposition();
         }
         var _loc2_:Vec2 = zpp_inner.fluidarb.wrap_position;
         if(_loc2_ != null && _loc2_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc2_.zpp_inner;
         if(_loc3_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc3_._isimmutable != null)
         {
            _loc3_._isimmutable();
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null Vec2";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = param1.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc5_:Number = param1.zpp_inner.x;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = param1.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc6_:Number = param1.zpp_inner.y;
         if(_loc2_ != null && _loc2_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc2_.zpp_inner;
         if(_loc3_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc3_._isimmutable != null)
         {
            _loc3_._isimmutable();
         }
         if(_loc5_ != _loc5_ || _loc6_ != _loc6_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         §§push(false);
         if(_loc2_ != null && _loc2_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc2_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(_loc2_.zpp_inner.x == _loc5_)
         {
            §§pop();
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = _loc2_.zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(_loc2_.zpp_inner.y == _loc6_);
         }
         if(!§§pop())
         {
            _loc2_.zpp_inner.x = _loc5_;
            _loc2_.zpp_inner.y = _loc6_;
            _loc3_ = _loc2_.zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         var _loc4_:Vec2 = _loc2_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = param1.zpp_inner;
            if(_loc3_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc3_._isimmutable != null)
            {
               _loc3_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc3_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc7_ = param1;
            _loc7_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc7_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc7_;
            }
            ZPP_PubPool.nextVec2 = _loc7_;
            _loc7_.zpp_disp = true;
            _loc8_ = _loc3_;
            if(_loc8_.outer != null)
            {
               _loc8_.outer.zpp_inner = null;
               _loc8_.outer = null;
            }
            _loc8_._isimmutable = null;
            _loc8_._validate = null;
            _loc8_._invalidate = null;
            _loc8_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc8_;
         }
         _loc4_;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         if(zpp_inner.fluidarb.wrap_position == null)
         {
            zpp_inner.fluidarb.getposition();
         }
         return zpp_inner.fluidarb.wrap_position;
      }
      
      public function set overlap(param1:Number) : Number
      {
         if(!zpp_inner.fluidarb.mutable)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter is mutable only within a pre-handler";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: FluidArbiter::overlap cannot be NaN";
         }
         if(param1 <= 0 || param1 == Number(Math.POSITIVE_INFINITY))
         {
            Boot.lastError = new Error();
            throw "Error: FluidArbiter::overlap must be strictly positive and non infinite";
         }
         zpp_inner.fluidarb.overlap = param1;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         return zpp_inner.fluidarb.overlap;
      }
      
      public function get position() : Vec2
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         if(zpp_inner.fluidarb.wrap_position == null)
         {
            zpp_inner.fluidarb.getposition();
         }
         return zpp_inner.fluidarb.wrap_position;
      }
      
      public function get overlap() : Number
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         return zpp_inner.fluidarb.overlap;
      }
      
      public function dragImpulse(param1:Body = undefined) : Vec3
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         §§push(false);
         §§push(false);
         if(param1 != null)
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b2.outer : zpp_inner.b1.outer));
         }
         if(§§pop())
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b1.outer : zpp_inner.b2.outer));
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter does not relate to body";
         }
         var _loc2_:ZPP_FluidArbiter = zpp_inner.fluidarb;
         var _loc3_:int = param1 == null || param1.zpp_inner == zpp_inner.b2 ? 1 : -1;
         return Vec3.get(_loc2_.dampx * _loc3_,_loc2_.dampy * _loc3_,_loc2_.adamp * _loc3_);
      }
      
      public function buoyancyImpulse(param1:Body = undefined) : Vec3
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         §§push(false);
         §§push(false);
         if(param1 != null)
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b2.outer : zpp_inner.b1.outer));
         }
         if(§§pop())
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b1.outer : zpp_inner.b2.outer));
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter does not relate to body";
         }
         var _loc2_:ZPP_FluidArbiter = zpp_inner.fluidarb;
         if(param1 == null)
         {
            return Vec3.get(_loc2_.buoyx,_loc2_.buoyy,0);
         }
         if(param1.zpp_inner == zpp_inner.b2)
         {
            return Vec3.get(_loc2_.buoyx,_loc2_.buoyy,_loc2_.buoyy * _loc2_.r2x - _loc2_.buoyx * _loc2_.r2y);
         }
         return Vec3.get(-_loc2_.buoyx,-_loc2_.buoyy,-(_loc2_.buoyy * _loc2_.r1x - _loc2_.buoyx * _loc2_.r1y));
      }
   }
}
