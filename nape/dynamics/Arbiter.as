package nape.dynamics
{
   import flash.Boot;
   import nape.callbacks.PreFlag;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.shape.Shape;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.util.ZPP_Flags;
   
   public class Arbiter
   {
       
      
      public var zpp_inner:ZPP_Arbiter;
      
      public function Arbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(!ZPP_Arbiter.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate Arbiter derp!";
         }
      }
      
      public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
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
         return Vec3.get(0,0,0);
      }
      
      public function toString() : String
      {
         var _loc2_:int = 0;
         var _loc1_:String = zpp_inner.type == ZPP_Arbiter.COL ? "CollisionArbiter" : (zpp_inner.type == ZPP_Arbiter.FLUID ? "FluidArbiter" : "SensorArbiter");
         if(zpp_inner.cleared)
         {
            return _loc1_ + "(object-pooled)";
         }
         §§push(_loc1_ + "(");
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         §§push(§§pop() + (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.ws2.outer : zpp_inner.ws1.outer).toString() + "|");
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         §§push(§§pop() + (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.ws1.outer : zpp_inner.ws2.outer).toString() + ")" + (zpp_inner.type == ZPP_Arbiter.COL ? "[" + ["SD","DD"][zpp_inner.colarb.stat ? 0 : 1] + "]" : "") + "<-");
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         _loc2_ = zpp_inner.immState;
         if(_loc2_ == (ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS))
         {
            if(ZPP_Flags.PreFlag_ACCEPT == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.PreFlag_ACCEPT);
         }
         else if(_loc2_ == ZPP_Flags.id_ImmState_ACCEPT)
         {
            if(ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.PreFlag_ACCEPT_ONCE);
         }
         else if(_loc2_ == (ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS))
         {
            if(ZPP_Flags.PreFlag_IGNORE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.PreFlag_IGNORE = new PreFlag();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.PreFlag_IGNORE);
         }
         else
         {
            if(ZPP_Flags.PreFlag_IGNORE_ONCE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.PreFlag_IGNORE_ONCE = new PreFlag();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.PreFlag_IGNORE_ONCE);
         }
         return §§pop() + §§pop().toString();
      }
      
      public function isSensorArbiter() : Boolean
      {
         return zpp_inner.type == ZPP_Arbiter.SENSOR;
      }
      
      public function isFluidArbiter() : Boolean
      {
         return zpp_inner.type == ZPP_Arbiter.FLUID;
      }
      
      public function isCollisionArbiter() : Boolean
      {
         return zpp_inner.type == ZPP_Arbiter.COL;
      }
      
      public function get type() : ArbiterType
      {
         if(ZPP_Flags.ArbiterType_COLLISION == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ArbiterType_COLLISION = new ArbiterType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.ArbiterType_COLLISION);
         if(ZPP_Flags.ArbiterType_FLUID == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ArbiterType_FLUID = new ArbiterType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.ArbiterType_FLUID);
         if(ZPP_Flags.ArbiterType_SENSOR == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ArbiterType_SENSOR = new ArbiterType();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.type];
      }
      
      public function get state() : PreFlag
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         var _loc1_:int = zpp_inner.immState;
         if(_loc1_ == (ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS))
         {
            if(ZPP_Flags.PreFlag_ACCEPT == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.PreFlag_ACCEPT);
         }
         else if(_loc1_ == ZPP_Flags.id_ImmState_ACCEPT)
         {
            if(ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.PreFlag_ACCEPT_ONCE);
         }
         else if(_loc1_ == (ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS))
         {
            if(ZPP_Flags.PreFlag_IGNORE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.PreFlag_IGNORE = new PreFlag();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.PreFlag_IGNORE);
         }
         else
         {
            if(ZPP_Flags.PreFlag_IGNORE_ONCE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.PreFlag_IGNORE_ONCE = new PreFlag();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.PreFlag_IGNORE_ONCE);
         }
         return §§pop();
      }
      
      public function get shape2() : Shape
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         return zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.ws1.outer : zpp_inner.ws2.outer;
      }
      
      public function get shape1() : Shape
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         return zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.ws2.outer : zpp_inner.ws1.outer;
      }
      
      public function get isSleeping() : Boolean
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         return zpp_inner.sleeping;
      }
      
      public function get fluidArbiter() : FluidArbiter
      {
         return zpp_inner.type == ZPP_Arbiter.FLUID ? zpp_inner.fluidarb.outer_zn : null;
      }
      
      public function get collisionArbiter() : CollisionArbiter
      {
         return zpp_inner.type == ZPP_Arbiter.COL ? zpp_inner.colarb.outer_zn : null;
      }
      
      public function get body2() : Body
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         return zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b1.outer : zpp_inner.b2.outer;
      }
      
      public function get body1() : Body
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         return zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b2.outer : zpp_inner.b1.outer;
      }
   }
}
