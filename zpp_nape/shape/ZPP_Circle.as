package zpp_nape.shape
{
   import flash.Boot;
   import nape.Config;
   import nape.geom.Mat23;
   import nape.geom.Vec2;
   import nape.shape.Circle;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_Circle extends ZPP_Shape
   {
       
      
      public var radius:Number;
      
      public var outer_zn:Circle;
      
      public function ZPP_Circle()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         radius = 0;
         outer_zn = null;
         super(ZPP_Flags.id_ShapeType_CIRCLE);
         circle = this;
         zip_localCOM = false;
      }
      
      public function setupLocalCOM() : void
      {
         var _loc5_:* = null as Vec2;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc2_:Number = localCOMx;
         var _loc3_:Number = localCOMy;
         §§push(§§findproperty(wrap_localCOM));
         if(_loc2_ != _loc2_ || _loc3_ != _loc3_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc5_ = new Vec2();
         }
         else
         {
            _loc5_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc5_.zpp_pool;
            _loc5_.zpp_pool = null;
            _loc5_.zpp_disp = false;
            if(_loc5_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc5_.zpp_inner == null)
         {
            _loc6_ = false;
            §§push(_loc5_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc7_ = new ZPP_Vec2();
            }
            else
            {
               _loc7_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc7_.next;
               _loc7_.next = null;
            }
            _loc7_.weak = false;
            _loc7_._immutable = _loc6_;
            _loc7_.x = _loc2_;
            _loc7_.y = _loc3_;
            §§pop().zpp_inner = _loc7_;
            _loc5_.zpp_inner.outer = _loc5_;
         }
         else
         {
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc5_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc2_ != _loc2_ || _loc3_ != _loc3_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc5_.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            if(_loc5_.zpp_inner.x == _loc2_)
            {
               §§pop();
               if(_loc5_ != null && _loc5_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc5_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               §§push(_loc5_.zpp_inner.y == _loc3_);
            }
            if(!§§pop())
            {
               _loc5_.zpp_inner.x = _loc2_;
               _loc5_.zpp_inner.y = _loc3_;
               _loc7_ = _loc5_.zpp_inner;
               if(_loc7_._invalidate != null)
               {
                  _loc7_._invalidate(_loc7_);
               }
            }
            _loc5_;
         }
         _loc5_.zpp_inner.weak = false;
         §§pop().wrap_localCOM = _loc5_;
         wrap_localCOM.zpp_inner._inuse = true;
         wrap_localCOM.zpp_inner._validate = localCOM_validate;
         wrap_localCOM.zpp_inner._invalidate = localCOM_invalidate;
         wrap_localCOM.zpp_inner._isimmutable = localCOM_immutable;
      }
      
      public function localCOM_validate() : void
      {
         wrap_localCOM.zpp_inner.x = localCOMx;
         wrap_localCOM.zpp_inner.y = localCOMy;
      }
      
      public function localCOM_invalidate(param1:ZPP_Vec2) : void
      {
         localCOMx = param1.x;
         localCOMy = param1.y;
         invalidate_localCOM();
         if(body != null)
         {
            body.wake();
         }
      }
      
      public function localCOM_immutable() : void
      {
         if(body != null && body.type == ZPP_Flags.id_BodyType_STATIC && body.space != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot modify localCOM of Circle added to a static Body whilst within a Space";
         }
      }
      
      public function invalidate_radius() : void
      {
         invalidate_area_inertia();
         invalidate_angDrag();
         zip_aabb = true;
         if(body != null)
         {
            body.zip_aabb = true;
         }
         if(body != null)
         {
            body.wake();
         }
      }
      
      public function __validate_sweepRadius() : void
      {
         sweepCoef = Math.sqrt(localCOMx * localCOMx + localCOMy * localCOMy);
         sweepRadius = sweepCoef + radius;
      }
      
      public function __validate_area_inertia() : void
      {
         var _loc1_:Number = radius * radius;
         area = _loc1_ * Math.PI;
         inertia = _loc1_ * 0.5 + (localCOMx * localCOMx + localCOMy * localCOMy);
      }
      
      public function __validate_angDrag() : void
      {
         var _loc1_:Number = localCOMx * localCOMx + localCOMy * localCOMy;
         var _loc2_:Number = radius * radius;
         var _loc3_:Number = material.dynamicFriction * Config.fluidAngularDragFriction;
         angDrag = (_loc1_ + 2 * _loc2_) * _loc3_ + 0.5 * Config.fluidAngularDrag * (1 + Config.fluidVacuumDrag) * _loc1_;
         angDrag /= 2 * (_loc1_ + 0.5 * _loc2_);
      }
      
      public function __translate(param1:Number, param2:Number) : void
      {
         localCOMx += param1 * 1;
         localCOMy += param2 * 1;
         invalidate_localCOM();
      }
      
      public function __transform(param1:Mat23) : void
      {
         var _loc2_:Number = param1.zpp_inner.a * param1.zpp_inner.d - param1.zpp_inner.b * param1.zpp_inner.c;
         if(_loc2_ < 0)
         {
            _loc2_ = -_loc2_;
         }
         radius *= Math.sqrt(_loc2_);
         var _loc3_:Number = param1.zpp_inner.a * localCOMx + param1.zpp_inner.b * localCOMy + param1.zpp_inner.tx;
         localCOMy = param1.zpp_inner.c * localCOMx + param1.zpp_inner.d * localCOMy + param1.zpp_inner.ty;
         localCOMx = _loc3_;
         invalidate_radius();
         invalidate_localCOM();
      }
      
      public function __scale(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = ((param1 < 0 ? -param1 : param1) + (param2 < 0 ? -param2 : param2)) / 2;
         radius *= _loc3_ < 0 ? -_loc3_ : _loc3_;
         invalidate_radius();
         if(localCOMx * localCOMx + localCOMy * localCOMy > 0)
         {
            localCOMx *= param1;
            localCOMy *= param2;
            invalidate_localCOM();
         }
      }
      
      public function __rotate(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(localCOMx * localCOMx + localCOMy * localCOMy > 0)
         {
            _loc3_ = 0;
            _loc4_ = 0;
            _loc3_ = param2 * localCOMx - param1 * localCOMy;
            _loc4_ = localCOMx * param1 + localCOMy * param2;
            localCOMx = _loc3_;
            localCOMy = _loc4_;
            invalidate_localCOM();
         }
      }
      
      public function __copy() : ZPP_Circle
      {
         var _loc1_:ZPP_Circle = new Circle(radius).zpp_inner_zn;
         _loc1_.localCOMx = localCOMx;
         _loc1_.localCOMy = localCOMy;
         _loc1_.zip_localCOM = false;
         return _loc1_;
      }
      
      public function __clear() : void
      {
      }
   }
}
