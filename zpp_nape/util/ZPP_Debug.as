package zpp_nape.util
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.geom.Mat23;
   import nape.geom.Vec2;
   import nape.util.Debug;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class ZPP_Debug
   {
      
      public static var §internal§:Boolean = false;
       
      
      public var xnull:Boolean;
      
      public var xform:ZPP_Mat23;
      
      public var xdet:Number;
      
      public var width:int;
      
      public var viewport:ZPP_AABB;
      
      public var tmpab:ZPP_AABB;
      
      public var outer:Debug;
      
      public var isbmp:Boolean;
      
      public var iport:ZPP_AABB;
      
      public var height:int;
      
      public var d_shape:ZPP_ShapeDebug;
      
      public var d_bmp:ZPP_BitmapDebug;
      
      public var bg_r:Number;
      
      public var bg_g:Number;
      
      public var bg_col:int;
      
      public var bg_b:Number;
      
      public function ZPP_Debug(param1:int = 0, param2:int = 0)
      {
         var _loc3_:* = null as ZPP_AABB;
         if(Boot.skip_constructor)
         {
            return;
         }
         tmpab = null;
         iport = null;
         viewport = null;
         height = 0;
         width = 0;
         xdet = 0;
         xnull = false;
         xform = null;
         bg_col = 0;
         bg_b = 0;
         bg_g = 0;
         bg_r = 0;
         d_shape = null;
         d_bmp = null;
         isbmp = false;
         outer = null;
         xnull = true;
         xdet = 1;
         width = param1;
         height = param2;
         §§push(§§findproperty(viewport));
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc3_ = new ZPP_AABB();
         }
         else
         {
            _loc3_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.minx = 0;
         _loc3_.miny = 0;
         _loc3_.maxx = param1;
         _loc3_.maxy = param2;
         §§pop().viewport = _loc3_;
         §§push(§§findproperty(iport));
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc3_ = new ZPP_AABB();
         }
         else
         {
            _loc3_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.minx = 0;
         _loc3_.miny = 0;
         _loc3_.maxx = param1;
         _loc3_.maxy = param2;
         §§pop().iport = _loc3_;
         tmpab = new ZPP_AABB();
      }
      
      public function xform_invalidate() : void
      {
         var _loc2_:Number = NaN;
         var _loc6_:* = null as Vec2;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc3_:Mat23 = xform.outer;
         _loc2_ = _loc3_.zpp_inner.a * _loc3_.zpp_inner.d - _loc3_.zpp_inner.b * _loc3_.zpp_inner.c;
         var _loc1_:Number = Number(_loc2_ < 0 ? -_loc2_ : _loc2_);
         xdet = _loc1_ == 0 ? 0 : (sf32(_loc1_,0), si32(1597463007 - (li32(0) >> 1),0), _loc2_ = lf32(0), 1 / (_loc2_ * (1.5 - 0.5 * _loc1_ * _loc2_ * _loc2_)));
         xnull = xform.a == 1 && xform.b == 0 && xform.c == 0 && xform.d == 1 && xform.tx == 0 && xform.ty == 0;
         _loc3_ = xform.outer.inverse();
         _loc1_ = 0;
         _loc2_ = 0;
         if(_loc1_ != _loc1_ || _loc2_ != _loc2_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc6_ = new Vec2();
         }
         else
         {
            _loc6_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc6_.zpp_pool;
            _loc6_.zpp_pool = null;
            _loc6_.zpp_disp = false;
            if(_loc6_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc6_.zpp_inner == null)
         {
            _loc7_ = false;
            §§push(_loc6_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc8_ = new ZPP_Vec2();
            }
            else
            {
               _loc8_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc8_.next;
               _loc8_.next = null;
            }
            _loc8_.weak = false;
            _loc8_._immutable = _loc7_;
            _loc8_.x = _loc1_;
            _loc8_.y = _loc2_;
            §§pop().zpp_inner = _loc8_;
            _loc6_.zpp_inner.outer = _loc6_;
         }
         else
         {
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc8_._isimmutable != null)
            {
               _loc8_._isimmutable();
            }
            if(_loc1_ != _loc1_ || _loc2_ != _loc2_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            if(_loc6_.zpp_inner.x == _loc1_)
            {
               §§pop();
               if(_loc6_ != null && _loc6_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._validate != null)
               {
                  _loc8_._validate();
               }
               §§push(_loc6_.zpp_inner.y == _loc2_);
            }
            if(!§§pop())
            {
               _loc6_.zpp_inner.x = _loc1_;
               _loc6_.zpp_inner.y = _loc2_;
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._invalidate != null)
               {
                  _loc8_._invalidate(_loc8_);
               }
            }
            _loc6_;
         }
         _loc6_.zpp_inner.weak = false;
         var _loc4_:Vec2 = _loc6_;
         _loc6_ = _loc3_.transform(_loc4_);
         §§push(iport);
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         §§pop().minx = _loc6_.zpp_inner.x;
         §§push(iport);
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         §§pop().miny = _loc6_.zpp_inner.y;
         iport.maxx = iport.minx;
         iport.maxy = iport.miny;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc8_._isimmutable != null)
         {
            _loc8_._isimmutable();
         }
         if(_loc6_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc8_ = _loc6_.zpp_inner;
         _loc6_.zpp_inner.outer = null;
         _loc6_.zpp_inner = null;
         var _loc9_:Vec2 = _loc6_;
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
         var _loc10_:ZPP_Vec2 = _loc8_;
         if(_loc10_.outer != null)
         {
            _loc10_.outer.zpp_inner = null;
            _loc10_.outer = null;
         }
         _loc10_._isimmutable = null;
         _loc10_._validate = null;
         _loc10_._invalidate = null;
         _loc10_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc10_;
         _loc1_ = width;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc8_._isimmutable != null)
         {
            _loc8_._isimmutable();
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         if(_loc4_.zpp_inner.x != _loc1_)
         {
            if(_loc1_ != _loc1_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2::" + "x" + " cannot be NaN";
            }
            _loc4_.zpp_inner.x = _loc1_;
            _loc8_ = _loc4_.zpp_inner;
            if(_loc8_._invalidate != null)
            {
               _loc8_._invalidate(_loc8_);
            }
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc4_.zpp_inner.x;
         _loc6_ = _loc3_.transform(_loc4_);
         var _loc11_:ZPP_AABB = iport;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc1_ = _loc6_.zpp_inner.x;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc2_ = _loc6_.zpp_inner.y;
         if(_loc1_ < _loc11_.minx)
         {
            _loc11_.minx = _loc1_;
         }
         if(_loc1_ > _loc11_.maxx)
         {
            _loc11_.maxx = _loc1_;
         }
         if(_loc2_ < _loc11_.miny)
         {
            _loc11_.miny = _loc2_;
         }
         if(_loc2_ > _loc11_.maxy)
         {
            _loc11_.maxy = _loc2_;
         }
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc8_._isimmutable != null)
         {
            _loc8_._isimmutable();
         }
         if(_loc6_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc8_ = _loc6_.zpp_inner;
         _loc6_.zpp_inner.outer = null;
         _loc6_.zpp_inner = null;
         _loc9_ = _loc6_;
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
         _loc10_ = _loc8_;
         if(_loc10_.outer != null)
         {
            _loc10_.outer.zpp_inner = null;
            _loc10_.outer = null;
         }
         _loc10_._isimmutable = null;
         _loc10_._validate = null;
         _loc10_._invalidate = null;
         _loc10_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc10_;
         _loc1_ = height;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc8_._isimmutable != null)
         {
            _loc8_._isimmutable();
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         if(_loc4_.zpp_inner.y != _loc1_)
         {
            if(_loc1_ != _loc1_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2::" + "y" + " cannot be NaN";
            }
            _loc4_.zpp_inner.y = _loc1_;
            _loc8_ = _loc4_.zpp_inner;
            if(_loc8_._invalidate != null)
            {
               _loc8_._invalidate(_loc8_);
            }
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc4_.zpp_inner.y;
         _loc6_ = _loc3_.transform(_loc4_);
         _loc11_ = iport;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc1_ = _loc6_.zpp_inner.x;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc2_ = _loc6_.zpp_inner.y;
         if(_loc1_ < _loc11_.minx)
         {
            _loc11_.minx = _loc1_;
         }
         if(_loc1_ > _loc11_.maxx)
         {
            _loc11_.maxx = _loc1_;
         }
         if(_loc2_ < _loc11_.miny)
         {
            _loc11_.miny = _loc2_;
         }
         if(_loc2_ > _loc11_.maxy)
         {
            _loc11_.maxy = _loc2_;
         }
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc8_._isimmutable != null)
         {
            _loc8_._isimmutable();
         }
         if(_loc6_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc8_ = _loc6_.zpp_inner;
         _loc6_.zpp_inner.outer = null;
         _loc6_.zpp_inner = null;
         _loc9_ = _loc6_;
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
         _loc10_ = _loc8_;
         if(_loc10_.outer != null)
         {
            _loc10_.outer.zpp_inner = null;
            _loc10_.outer = null;
         }
         _loc10_._isimmutable = null;
         _loc10_._validate = null;
         _loc10_._invalidate = null;
         _loc10_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc10_;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc8_._isimmutable != null)
         {
            _loc8_._isimmutable();
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         if(_loc4_.zpp_inner.x != 0)
         {
            _loc4_.zpp_inner.x = 0;
            _loc8_ = _loc4_.zpp_inner;
            if(_loc8_._invalidate != null)
            {
               _loc8_._invalidate(_loc8_);
            }
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc4_.zpp_inner.x;
         _loc6_ = _loc3_.transform(_loc4_);
         _loc11_ = iport;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc1_ = _loc6_.zpp_inner.x;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc2_ = _loc6_.zpp_inner.y;
         if(_loc1_ < _loc11_.minx)
         {
            _loc11_.minx = _loc1_;
         }
         if(_loc1_ > _loc11_.maxx)
         {
            _loc11_.maxx = _loc1_;
         }
         if(_loc2_ < _loc11_.miny)
         {
            _loc11_.miny = _loc2_;
         }
         if(_loc2_ > _loc11_.maxy)
         {
            _loc11_.maxy = _loc2_;
         }
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc6_.zpp_inner;
         if(_loc8_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc8_._isimmutable != null)
         {
            _loc8_._isimmutable();
         }
         if(_loc6_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc8_ = _loc6_.zpp_inner;
         _loc6_.zpp_inner.outer = null;
         _loc6_.zpp_inner = null;
         _loc9_ = _loc6_;
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
         _loc10_ = _loc8_;
         if(_loc10_.outer != null)
         {
            _loc10_.outer.zpp_inner = null;
            _loc10_.outer = null;
         }
         _loc10_._isimmutable = null;
         _loc10_._validate = null;
         _loc10_._invalidate = null;
         _loc10_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc10_;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = _loc4_.zpp_inner;
         if(_loc8_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc8_._isimmutable != null)
         {
            _loc8_._isimmutable();
         }
         if(_loc4_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc8_ = _loc4_.zpp_inner;
         _loc4_.zpp_inner.outer = null;
         _loc4_.zpp_inner = null;
         _loc9_ = _loc4_;
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
         _loc10_ = _loc8_;
         if(_loc10_.outer != null)
         {
            _loc10_.outer.zpp_inner = null;
            _loc10_.outer = null;
         }
         _loc10_._isimmutable = null;
         _loc10_._validate = null;
         _loc10_._invalidate = null;
         _loc10_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc10_;
      }
      
      public function sup_setbg(param1:int) : void
      {
         bg_r = param1 >> 16 & 255;
         bg_g = param1 >> 8 & 255;
         bg_b = param1 & 255;
         bg_col = param1;
      }
      
      public function setform() : void
      {
         xform = new Mat23().zpp_inner;
         xform._invalidate = xform_invalidate;
      }
      
      public function cull(param1:ZPP_AABB) : Boolean
      {
         var _loc2_:* = null as ZPP_AABB;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_AABB;
         if(xnull)
         {
            _loc2_ = viewport;
            return _loc2_.miny <= param1.maxy && param1.miny <= _loc2_.maxy && _loc2_.minx <= param1.maxx && param1.minx <= _loc2_.maxx;
         }
         _loc3_ = 0;
         _loc4_ = 0;
         _loc5_ = 0;
         _loc6_ = 0;
         _loc5_ = param1.minx;
         _loc6_ = param1.miny;
         tmpab.minx = xform.a * _loc5_ + xform.b * _loc6_ + xform.tx;
         tmpab.miny = xform.c * _loc5_ + xform.d * _loc6_ + xform.ty;
         tmpab.maxx = tmpab.minx;
         tmpab.maxy = tmpab.miny;
         _loc5_ = param1.maxx;
         _loc3_ = xform.a * _loc5_ + xform.b * _loc6_ + xform.tx;
         _loc4_ = xform.c * _loc5_ + xform.d * _loc6_ + xform.ty;
         _loc2_ = tmpab;
         if(_loc3_ < _loc2_.minx)
         {
            _loc2_.minx = _loc3_;
         }
         if(_loc3_ > _loc2_.maxx)
         {
            _loc2_.maxx = _loc3_;
         }
         if(_loc4_ < _loc2_.miny)
         {
            _loc2_.miny = _loc4_;
         }
         if(_loc4_ > _loc2_.maxy)
         {
            _loc2_.maxy = _loc4_;
         }
         _loc6_ = param1.maxy;
         _loc3_ = xform.a * _loc5_ + xform.b * _loc6_ + xform.tx;
         _loc4_ = xform.c * _loc5_ + xform.d * _loc6_ + xform.ty;
         _loc2_ = tmpab;
         if(_loc3_ < _loc2_.minx)
         {
            _loc2_.minx = _loc3_;
         }
         if(_loc3_ > _loc2_.maxx)
         {
            _loc2_.maxx = _loc3_;
         }
         if(_loc4_ < _loc2_.miny)
         {
            _loc2_.miny = _loc4_;
         }
         if(_loc4_ > _loc2_.maxy)
         {
            _loc2_.maxy = _loc4_;
         }
         _loc5_ = param1.minx;
         _loc3_ = xform.a * _loc5_ + xform.b * _loc6_ + xform.tx;
         _loc4_ = xform.c * _loc5_ + xform.d * _loc6_ + xform.ty;
         _loc2_ = tmpab;
         if(_loc3_ < _loc2_.minx)
         {
            _loc2_.minx = _loc3_;
         }
         if(_loc3_ > _loc2_.maxx)
         {
            _loc2_.maxx = _loc3_;
         }
         if(_loc4_ < _loc2_.miny)
         {
            _loc2_.miny = _loc4_;
         }
         if(_loc4_ > _loc2_.maxy)
         {
            _loc2_.maxy = _loc4_;
         }
         _loc2_ = tmpab;
         _loc7_ = viewport;
         return _loc7_.miny <= _loc2_.maxy && _loc2_.miny <= _loc7_.maxy && _loc7_.minx <= _loc2_.maxx && _loc2_.minx <= _loc7_.maxx;
      }
   }
}
