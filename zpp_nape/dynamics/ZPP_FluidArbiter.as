package zpp_nape.dynamics
{
   import flash.Boot;
   import nape.dynamics.FluidArbiter;
   import nape.geom.Vec2;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_FluidArbiter extends ZPP_Arbiter
   {
      
      public static var zpp_pool:ZPP_FluidArbiter = null;
       
      
      public var wrap_position:Vec2;
      
      public var wMass:Number;
      
      public var vMassc:Number;
      
      public var vMassb:Number;
      
      public var vMassa:Number;
      
      public var r2y:Number;
      
      public var r2x:Number;
      
      public var r1y:Number;
      
      public var r1x:Number;
      
      public var pre_dt:Number;
      
      public var overlap:Number;
      
      public var outer_zn:FluidArbiter;
      
      public var ny:Number;
      
      public var nx:Number;
      
      public var nodrag:Boolean;
      
      public var next:ZPP_FluidArbiter;
      
      public var mutable:Boolean;
      
      public var lgamma:Number;
      
      public var dampy:Number;
      
      public var dampx:Number;
      
      public var centroidy:Number;
      
      public var centroidx:Number;
      
      public var buoyy:Number;
      
      public var buoyx:Number;
      
      public var agamma:Number;
      
      public var adamp:Number;
      
      public function ZPP_FluidArbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         pre_dt = 0;
         mutable = false;
         wrap_position = null;
         buoyy = 0;
         buoyx = 0;
         ny = 0;
         nx = 0;
         lgamma = 0;
         dampy = 0;
         dampx = 0;
         vMassc = 0;
         vMassb = 0;
         vMassa = 0;
         agamma = 0;
         adamp = 0;
         wMass = 0;
         nodrag = false;
         r2y = 0;
         r2x = 0;
         r1y = 0;
         r1x = 0;
         overlap = 0;
         centroidy = 0;
         centroidx = 0;
         next = null;
         outer_zn = null;
         super();
         type = ZPP_Arbiter.FLUID;
         fluidarb = this;
         buoyx = 0;
         buoyy = 0;
         pre_dt = -1;
      }
      
      public function position_validate() : void
      {
         if(!active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         wrap_position.zpp_inner.x = centroidx;
         wrap_position.zpp_inner.y = centroidy;
      }
      
      public function position_invalidate(param1:ZPP_Vec2) : void
      {
         centroidx = param1.x;
         centroidy = param1.y;
      }
      
      public function getposition() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         §§push(§§findproperty(wrap_position));
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc4_ = new Vec2();
         }
         else
         {
            _loc4_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc4_.zpp_pool;
            _loc4_.zpp_pool = null;
            _loc4_.zpp_disp = false;
            if(_loc4_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc4_.zpp_inner == null)
         {
            _loc5_ = false;
            §§push(_loc4_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc6_ = new ZPP_Vec2();
            }
            else
            {
               _loc6_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc6_.next;
               _loc6_.next = null;
            }
            _loc6_.weak = false;
            _loc6_._immutable = _loc5_;
            _loc6_.x = 0;
            _loc6_.y = 0;
            §§pop().zpp_inner = _loc6_;
            _loc4_.zpp_inner.outer = _loc4_;
         }
         else
         {
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            §§push(false);
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            if(_loc4_.zpp_inner.x == 0)
            {
               §§pop();
               if(_loc4_ != null && _loc4_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               §§push(_loc4_.zpp_inner.y == 0);
            }
            if(!§§pop())
            {
               _loc4_.zpp_inner.x = 0;
               _loc4_.zpp_inner.y = 0;
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc4_;
         }
         _loc4_.zpp_inner.weak = false;
         §§pop().wrap_position = _loc4_;
         wrap_position.zpp_inner._inuse = true;
         wrap_position.zpp_inner._immutable = !mutable;
         wrap_position.zpp_inner._validate = position_validate;
         wrap_position.zpp_inner._invalidate = position_invalidate;
      }
   }
}
