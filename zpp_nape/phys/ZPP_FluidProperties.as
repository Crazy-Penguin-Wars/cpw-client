package zpp_nape.phys
{
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.phys.FluidProperties;
   import nape.shape.ShapeList;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPList_ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_FluidProperties
   {
      
      public static var zpp_pool:ZPP_FluidProperties = null;
       
      
      public var wrap_shapes:ShapeList;
      
      public var wrap_gravity:Vec2;
      
      public var viscosity:Number;
      
      public var userData;
      
      public var shapes:ZNPList_ZPP_Shape;
      
      public var outer:FluidProperties;
      
      public var next:ZPP_FluidProperties;
      
      public var gravityy:Number;
      
      public var gravityx:Number;
      
      public var density:Number;
      
      public function ZPP_FluidProperties()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         wrap_gravity = null;
         gravityy = 0;
         gravityx = 0;
         density = 0;
         viscosity = 0;
         wrap_shapes = null;
         shapes = null;
         outer = null;
         userData = null;
         next = null;
         shapes = new ZNPList_ZPP_Shape();
         viscosity = 1;
         density = 1;
         wrap_gravity = null;
         gravityx = 0;
         gravityy = 0;
      }
      
      public function wrapper() : FluidProperties
      {
         var _loc1_:* = null as ZPP_FluidProperties;
         if(outer == null)
         {
            outer = new FluidProperties();
            _loc1_ = outer.zpp_inner;
            _loc1_.outer = null;
            _loc1_.next = ZPP_FluidProperties.zpp_pool;
            ZPP_FluidProperties.zpp_pool = _loc1_;
            outer.zpp_inner = this;
         }
         return outer;
      }
      
      public function remShape(param1:ZPP_Shape) : void
      {
         shapes.remove(param1);
      }
      
      public function invalidate() : void
      {
         var _loc2_:* = null as ZPP_Shape;
         var _loc1_:ZNPNode_ZPP_Shape = shapes.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.invalidate_fluidprops();
            _loc1_ = _loc1_.next;
         }
      }
      
      public function gravity_validate() : void
      {
         wrap_gravity.zpp_inner.x = gravityx;
         wrap_gravity.zpp_inner.y = gravityy;
      }
      
      public function gravity_invalidate(param1:ZPP_Vec2) : void
      {
         gravityx = param1.x;
         gravityy = param1.y;
         invalidate();
      }
      
      public function getgravity() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = gravityx;
         var _loc2_:Number = gravityy;
         §§push(§§findproperty(wrap_gravity));
         if(_loc1_ != _loc1_ || _loc2_ != _loc2_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
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
            _loc6_.x = _loc1_;
            _loc6_.y = _loc2_;
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
            if(_loc1_ != _loc1_ || _loc2_ != _loc2_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
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
            if(_loc4_.zpp_inner.x == _loc1_)
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
               §§push(_loc4_.zpp_inner.y == _loc2_);
            }
            if(!§§pop())
            {
               _loc4_.zpp_inner.x = _loc1_;
               _loc4_.zpp_inner.y = _loc2_;
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc4_;
         }
         _loc4_.zpp_inner.weak = false;
         §§pop().wrap_gravity = _loc4_;
         wrap_gravity.zpp_inner._inuse = true;
         wrap_gravity.zpp_inner._invalidate = gravity_invalidate;
         wrap_gravity.zpp_inner._validate = gravity_validate;
      }
      
      public function copy() : ZPP_FluidProperties
      {
         var _loc1_:* = null as ZPP_FluidProperties;
         if(ZPP_FluidProperties.zpp_pool == null)
         {
            _loc1_ = new ZPP_FluidProperties();
         }
         else
         {
            _loc1_ = ZPP_FluidProperties.zpp_pool;
            ZPP_FluidProperties.zpp_pool = _loc1_.next;
            _loc1_.next = null;
         }
         _loc1_.viscosity = viscosity;
         _loc1_.density = density;
         return _loc1_;
      }
   }
}
