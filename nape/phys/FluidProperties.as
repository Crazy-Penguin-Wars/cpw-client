package nape.phys
{
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.shape.ShapeList;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_FluidProperties;
   import zpp_nape.util.ZPP_PubPool;
   import zpp_nape.util.ZPP_ShapeList;
   
   public final class FluidProperties
   {
       
      
      public var zpp_inner:ZPP_FluidProperties;
      
      public function FluidProperties(param1:Number = 1, param2:Number = 1)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(ZPP_FluidProperties.zpp_pool == null)
         {
            zpp_inner = new ZPP_FluidProperties();
         }
         else
         {
            zpp_inner = ZPP_FluidProperties.zpp_pool;
            ZPP_FluidProperties.zpp_pool = zpp_inner.next;
            zpp_inner.next = null;
         }
         zpp_inner.outer = this;
         if(param1 != zpp_inner.density * 1000)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: FluidProperties::" + "density" + " cannot be NaN";
            }
            zpp_inner.density = param1 / 1000;
            zpp_inner.invalidate();
         }
         zpp_inner.density * 1000;
         if(param2 != zpp_inner.viscosity)
         {
            if(param2 != param2)
            {
               Boot.lastError = new Error();
               throw "Error: FluidProperties::" + "viscosity" + " cannot be NaN";
            }
            if(param2 < 0)
            {
               Boot.lastError = new Error();
               throw "Error: FluidProperties::" + "viscosity" + " (" + param2 + ") must be >= 0";
            }
            zpp_inner.viscosity = param2 / 1;
            zpp_inner.invalidate();
         }
         zpp_inner.viscosity;
      }
      
      public function toString() : String
      {
         return "{ density: " + zpp_inner.density * 1000 + " viscosity: " + zpp_inner.viscosity + " gravity: " + Std.string(zpp_inner.wrap_gravity) + " }";
      }
      
      public function set viscosity(param1:Number) : Number
      {
         if(param1 != zpp_inner.viscosity)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: FluidProperties::" + "viscosity" + " cannot be NaN";
            }
            if(param1 < 0)
            {
               Boot.lastError = new Error();
               throw "Error: FluidProperties::" + "viscosity" + " (" + param1 + ") must be >= 0";
            }
            zpp_inner.viscosity = param1 / 1;
            zpp_inner.invalidate();
         }
         return zpp_inner.viscosity;
      }
      
      public function set gravity(param1:Vec2) : Vec2
      {
         var _loc2_:* = null as Vec2;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:* = null as Vec2;
         if(param1 == null)
         {
            if(zpp_inner.wrap_gravity != null)
            {
               zpp_inner.wrap_gravity.zpp_inner._inuse = false;
               _loc2_ = zpp_inner.wrap_gravity;
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
               if(_loc2_.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc3_ = _loc2_.zpp_inner;
               _loc2_.zpp_inner.outer = null;
               _loc2_.zpp_inner = null;
               _loc4_ = _loc2_;
               _loc4_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc4_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc4_;
               }
               ZPP_PubPool.nextVec2 = _loc4_;
               _loc4_.zpp_disp = true;
               _loc5_ = _loc3_;
               if(_loc5_.outer != null)
               {
                  _loc5_.outer.zpp_inner = null;
                  _loc5_.outer = null;
               }
               _loc5_._isimmutable = null;
               _loc5_._validate = null;
               _loc5_._invalidate = null;
               _loc5_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc5_;
               zpp_inner.wrap_gravity = null;
            }
         }
         else
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(zpp_inner.wrap_gravity == null)
            {
               zpp_inner.getgravity();
            }
            _loc2_ = zpp_inner.wrap_gravity;
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
            _loc6_ = param1.zpp_inner.x;
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
            _loc7_ = param1.zpp_inner.y;
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
            if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
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
            if(_loc2_.zpp_inner.x == _loc6_)
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
               §§push(_loc2_.zpp_inner.y == _loc7_);
            }
            if(!§§pop())
            {
               _loc2_.zpp_inner.x = _loc6_;
               _loc2_.zpp_inner.y = _loc7_;
               _loc3_ = _loc2_.zpp_inner;
               if(_loc3_._invalidate != null)
               {
                  _loc3_._invalidate(_loc3_);
               }
            }
            _loc4_ = _loc2_;
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
               _loc8_ = param1;
               _loc8_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc8_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc8_;
               }
               ZPP_PubPool.nextVec2 = _loc8_;
               _loc8_.zpp_disp = true;
               _loc5_ = _loc3_;
               if(_loc5_.outer != null)
               {
                  _loc5_.outer.zpp_inner = null;
                  _loc5_.outer = null;
               }
               _loc5_._isimmutable = null;
               _loc5_._validate = null;
               _loc5_._invalidate = null;
               _loc5_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc5_;
            }
            _loc4_;
         }
         return zpp_inner.wrap_gravity;
      }
      
      public function set density(param1:Number) : Number
      {
         if(param1 != zpp_inner.density * 1000)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: FluidProperties::" + "density" + " cannot be NaN";
            }
            zpp_inner.density = param1 / 1000;
            zpp_inner.invalidate();
         }
         return zpp_inner.density * 1000;
      }
      
      public function get viscosity() : Number
      {
         return zpp_inner.viscosity;
      }
      
      public function get userData() : *
      {
         if(zpp_inner.userData == null)
         {
            zpp_inner.userData = {};
         }
         return zpp_inner.userData;
      }
      
      public function get shapes() : ShapeList
      {
         if(zpp_inner.wrap_shapes == null)
         {
            zpp_inner.wrap_shapes = ZPP_ShapeList.get(zpp_inner.shapes,true);
         }
         return zpp_inner.wrap_shapes;
      }
      
      public function get gravity() : Vec2
      {
         return zpp_inner.wrap_gravity;
      }
      
      public function get density() : Number
      {
         return zpp_inner.density * 1000;
      }
      
      public function copy() : FluidProperties
      {
         var _loc3_:* = null as Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as Vec2;
         var _loc1_:FluidProperties = new FluidProperties(zpp_inner.density * 1000,zpp_inner.viscosity);
         if(zpp_inner.userData != null)
         {
            _loc1_.zpp_inner.userData = Reflect.copy(zpp_inner.userData);
         }
         var _loc2_:Vec2 = zpp_inner.wrap_gravity;
         if(_loc2_ == null)
         {
            if(_loc1_.zpp_inner.wrap_gravity != null)
            {
               _loc1_.zpp_inner.wrap_gravity.zpp_inner._inuse = false;
               _loc3_ = _loc1_.zpp_inner.wrap_gravity;
               if(_loc3_ != null && _loc3_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc4_ = _loc3_.zpp_inner;
               if(_loc4_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc4_._isimmutable != null)
               {
                  _loc4_._isimmutable();
               }
               if(_loc3_.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc4_ = _loc3_.zpp_inner;
               _loc3_.zpp_inner.outer = null;
               _loc3_.zpp_inner = null;
               _loc5_ = _loc3_;
               _loc5_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc5_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc5_;
               }
               ZPP_PubPool.nextVec2 = _loc5_;
               _loc5_.zpp_disp = true;
               _loc6_ = _loc4_;
               if(_loc6_.outer != null)
               {
                  _loc6_.outer.zpp_inner = null;
                  _loc6_.outer = null;
               }
               _loc6_._isimmutable = null;
               _loc6_._validate = null;
               _loc6_._invalidate = null;
               _loc6_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc6_;
               _loc1_.zpp_inner.wrap_gravity = null;
            }
         }
         else
         {
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(_loc1_.zpp_inner.wrap_gravity == null)
            {
               _loc1_.zpp_inner.getgravity();
            }
            _loc3_ = _loc1_.zpp_inner.wrap_gravity;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc3_.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            if(_loc2_ == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot assign null Vec2";
            }
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc2_.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc7_ = _loc2_.zpp_inner.x;
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc2_.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc8_ = _loc2_.zpp_inner.y;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc3_.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            if(_loc7_ != _loc7_ || _loc8_ != _loc8_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc3_.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            if(_loc3_.zpp_inner.x == _loc7_)
            {
               §§pop();
               if(_loc3_ != null && _loc3_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc4_ = _loc3_.zpp_inner;
               if(_loc4_._validate != null)
               {
                  _loc4_._validate();
               }
               §§push(_loc3_.zpp_inner.y == _loc8_);
            }
            if(!§§pop())
            {
               _loc3_.zpp_inner.x = _loc7_;
               _loc3_.zpp_inner.y = _loc8_;
               _loc4_ = _loc3_.zpp_inner;
               if(_loc4_._invalidate != null)
               {
                  _loc4_._invalidate(_loc4_);
               }
            }
            _loc5_ = _loc3_;
            if(_loc2_.zpp_inner.weak)
            {
               if(_loc2_ != null && _loc2_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc4_ = _loc2_.zpp_inner;
               if(_loc4_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc4_._isimmutable != null)
               {
                  _loc4_._isimmutable();
               }
               if(_loc2_.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc4_ = _loc2_.zpp_inner;
               _loc2_.zpp_inner.outer = null;
               _loc2_.zpp_inner = null;
               _loc9_ = _loc2_;
               _loc9_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc9_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc9_;
               }
               ZPP_PubPool.nextVec2 = _loc9_;
               _loc9_.zpp_disp = true;
               _loc6_ = _loc4_;
               if(_loc6_.outer != null)
               {
                  _loc6_.outer.zpp_inner = null;
                  _loc6_.outer = null;
               }
               _loc6_._isimmutable = null;
               _loc6_._validate = null;
               _loc6_._invalidate = null;
               _loc6_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc6_;
            }
            _loc5_;
         }
         _loc1_.zpp_inner.wrap_gravity;
         return _loc1_;
      }
   }
}
