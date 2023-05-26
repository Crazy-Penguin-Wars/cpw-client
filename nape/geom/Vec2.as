package nape.geom
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import flash.geom.Point;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class Vec2
   {
       
      
      public var zpp_pool:Vec2;
      
      public var zpp_inner:ZPP_Vec2;
      
      public var zpp_disp:Boolean;
      
      public function Vec2(param1:Number = 0, param2:Number = 0)
      {
         var _loc4_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_pool = null;
         zpp_inner = null;
         if(param1 != param1 || param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         §§push(§§findproperty(zpp_inner));
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc4_ = new ZPP_Vec2();
         }
         else
         {
            _loc4_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc4_.next;
            _loc4_.next = null;
         }
         _loc4_.weak = false;
         _loc4_._immutable = false;
         _loc4_.x = param1;
         _loc4_.y = param2;
         §§pop().zpp_inner = _loc4_;
         zpp_inner.outer = this;
      }
      
      public static function weak(param1:Number = 0, param2:Number = 0) : Vec2
      {
         var _loc3_:* = null as Vec2;
         var _loc4_:Boolean = false;
         var _loc5_:* = null as ZPP_Vec2;
         if(param1 != param1 || param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc3_ = new Vec2();
         }
         else
         {
            _loc3_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc3_.zpp_pool;
            _loc3_.zpp_pool = null;
            _loc3_.zpp_disp = false;
            if(_loc3_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc3_.zpp_inner == null)
         {
            _loc4_ = false;
            §§push(_loc3_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc5_ = new ZPP_Vec2();
            }
            else
            {
               _loc5_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            _loc5_.weak = false;
            _loc5_._immutable = _loc4_;
            _loc5_.x = param1;
            _loc5_.y = param2;
            §§pop().zpp_inner = _loc5_;
            _loc3_.zpp_inner.outer = _loc3_;
         }
         else
         {
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc3_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(param1 != param1 || param2 != param2)
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
            _loc5_ = _loc3_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            if(_loc3_.zpp_inner.x == param1)
            {
               §§pop();
               if(_loc3_ != null && _loc3_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = _loc3_.zpp_inner;
               if(_loc5_._validate != null)
               {
                  _loc5_._validate();
               }
               §§push(_loc3_.zpp_inner.y == param2);
            }
            if(!§§pop())
            {
               _loc3_.zpp_inner.x = param1;
               _loc3_.zpp_inner.y = param2;
               _loc5_ = _loc3_.zpp_inner;
               if(_loc5_._invalidate != null)
               {
                  _loc5_._invalidate(_loc5_);
               }
            }
            _loc3_;
         }
         _loc3_.zpp_inner.weak = true;
         return _loc3_;
      }
      
      public static function get(param1:Number = 0, param2:Number = 0, param3:Boolean = false) : Vec2
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         if(param1 != param1 || param2 != param2)
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
            _loc6_.x = param1;
            _loc6_.y = param2;
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
            if(param1 != param1 || param2 != param2)
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
            if(_loc4_.zpp_inner.x == param1)
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
               §§push(_loc4_.zpp_inner.y == param2);
            }
            if(!§§pop())
            {
               _loc4_.zpp_inner.x = param1;
               _loc4_.zpp_inner.y = param2;
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc4_;
         }
         _loc4_.zpp_inner.weak = param3;
         return _loc4_;
      }
      
      public static function fromPoint(param1:Point, param2:Boolean = false) : Vec2
      {
         var _loc5_:* = null as Vec2;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZPP_Vec2;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot create Vec2 from null Point object";
         }
         if(param1.x != param1.x || param1.y != param1.y)
         {
            Boot.lastError = new Error();
            throw "Error: Error: Vec2 components cannot be NaN";
         }
         var _loc3_:Number = param1.x;
         var _loc4_:Number = param1.y;
         if(_loc3_ != _loc3_ || _loc4_ != _loc4_)
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
            _loc7_.x = _loc3_;
            _loc7_.y = _loc4_;
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
            if(_loc3_ != _loc3_ || _loc4_ != _loc4_)
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
            if(_loc5_.zpp_inner.x == _loc3_)
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
               §§push(_loc5_.zpp_inner.y == _loc4_);
            }
            if(!§§pop())
            {
               _loc5_.zpp_inner.x = _loc3_;
               _loc5_.zpp_inner.y = _loc4_;
               _loc7_ = _loc5_.zpp_inner;
               if(_loc7_._invalidate != null)
               {
                  _loc7_._invalidate(_loc7_);
               }
            }
            _loc5_;
         }
         _loc5_.zpp_inner.weak = param2;
         return _loc5_;
      }
      
      public static function fromPolar(param1:Number, param2:Number, param3:Boolean = false) : Vec2
      {
         var _loc6_:* = null as Vec2;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as ZPP_Vec2;
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2::length cannot be NaN";
         }
         if(param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2::angle cannot be NaN";
         }
         var _loc4_:Number = param1 * Math.cos(param2);
         var _loc5_:Number = param1 * Math.sin(param2);
         if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
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
            _loc8_.x = _loc4_;
            _loc8_.y = _loc5_;
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
            if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
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
            if(_loc6_.zpp_inner.x == _loc4_)
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
               §§push(_loc6_.zpp_inner.y == _loc5_);
            }
            if(!§§pop())
            {
               _loc6_.zpp_inner.x = _loc4_;
               _loc6_.zpp_inner.y = _loc5_;
               _loc8_ = _loc6_.zpp_inner;
               if(_loc8_._invalidate != null)
               {
                  _loc8_._invalidate(_loc8_);
               }
            }
            _loc6_;
         }
         _loc6_.zpp_inner.weak = param3;
         return _loc6_;
      }
      
      public static function dsq(param1:Vec2, param2:Vec2) : Number
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null || param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot compute squared distance between null Vec2";
         }
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.x);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc4_ = §§pop() - param2.zpp_inner.x;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.y);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc5_ = §§pop() - param2.zpp_inner.y;
         var _loc3_:Number = _loc4_ * _loc4_ + _loc5_ * _loc5_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = param1.zpp_inner;
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
            _loc8_ = _loc6_;
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
         if(param2.zpp_inner.weak)
         {
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(param2.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = param2.zpp_inner;
            param2.zpp_inner.outer = null;
            param2.zpp_inner = null;
            _loc7_ = param2;
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
            _loc8_ = _loc6_;
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
         return _loc3_;
      }
      
      public static function distance(param1:Vec2, param2:Vec2) : Number
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null || param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot compute squared distance between null Vec2";
         }
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         §§push(Math);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.x);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc4_ = §§pop() - param2.zpp_inner.x;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.y);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc5_ = §§pop() - param2.zpp_inner.y;
         var _loc3_:Number = Number(§§pop().sqrt(_loc4_ * _loc4_ + _loc5_ * _loc5_));
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = param1.zpp_inner;
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
            _loc8_ = _loc6_;
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
         if(param2.zpp_inner.weak)
         {
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param2.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(param2.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = param2.zpp_inner;
            param2.zpp_inner.outer = null;
            param2.zpp_inner = null;
            _loc7_ = param2;
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
            _loc8_ = _loc6_;
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
         return _loc3_;
      }
      
      public function unit(param1:Boolean = false) : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as Vec2;
         var _loc7_:Boolean = false;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.y)) == 0)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot normalise vector of length 0";
         }
         §§push(1);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc4_:Number = §§pop() + §§pop() * zpp_inner.y;
         var _loc3_:Number = §§pop() / (_loc4_ == 0 ? 0 : (sf32(_loc4_,0), si32(1597463007 - (li32(0) >> 1),0), _loc5_ = lf32(0), 1 / (_loc5_ * (1.5 - 0.5 * _loc4_ * _loc5_ * _loc5_))));
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc4_ = zpp_inner.x * _loc3_;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc5_ = zpp_inner.y * _loc3_;
         if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
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
               _loc2_ = new ZPP_Vec2();
            }
            else
            {
               _loc2_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc2_.next;
               _loc2_.next = null;
            }
            _loc2_.weak = false;
            _loc2_._immutable = _loc7_;
            _loc2_.x = _loc4_;
            _loc2_.y = _loc5_;
            §§pop().zpp_inner = _loc2_;
            _loc6_.zpp_inner.outer = _loc6_;
         }
         else
         {
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = _loc6_.zpp_inner;
            if(_loc2_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc2_._isimmutable != null)
            {
               _loc2_._isimmutable();
            }
            if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
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
            _loc2_ = _loc6_.zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            if(_loc6_.zpp_inner.x == _loc4_)
            {
               §§pop();
               if(_loc6_ != null && _loc6_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc2_ = _loc6_.zpp_inner;
               if(_loc2_._validate != null)
               {
                  _loc2_._validate();
               }
               §§push(_loc6_.zpp_inner.y == _loc5_);
            }
            if(!§§pop())
            {
               _loc6_.zpp_inner.x = _loc4_;
               _loc6_.zpp_inner.y = _loc5_;
               _loc2_ = _loc6_.zpp_inner;
               if(_loc2_._invalidate != null)
               {
                  _loc2_._invalidate(_loc2_);
               }
            }
            _loc6_;
         }
         _loc6_.zpp_inner.weak = param1;
         return _loc6_;
      }
      
      public function toString() : String
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.toString();
      }
      
      public function toPoint(param1:Point = undefined) : Point
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            param1 = new Point();
         }
         §§push(param1);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc2_:ZPP_Vec2 = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§pop().x = zpp_inner.x;
         §§push(param1);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§pop().y = zpp_inner.y;
         return param1;
      }
      
      public function subeq(param1:Vec2) : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot subtract null vectors";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc3_:Number = §§pop() - param1.zpp_inner.x;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.y);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc4_:Number = §§pop() - param1.zpp_inner.y;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(_loc3_ != _loc3_ || _loc4_ != _loc4_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         §§push(false);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.x == _loc3_)
         {
            §§pop();
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(zpp_inner.y == _loc4_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc3_;
            zpp_inner.y = _loc4_;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = param1.zpp_inner;
            if(_loc2_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc2_._isimmutable != null)
            {
               _loc2_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc2_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc5_ = param1;
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
            _loc6_ = _loc2_;
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
         return this;
      }
      
      public function sub(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot subtract null vectors";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         §§push(zpp_inner.x);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc4_:Number = §§pop() - param1.zpp_inner.x;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         §§push(zpp_inner.y);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc6_:Number = §§pop() - param1.zpp_inner.y;
         if(_loc4_ != _loc4_ || _loc6_ != _loc6_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc7_ = new Vec2();
         }
         else
         {
            _loc7_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc7_.zpp_pool;
            _loc7_.zpp_pool = null;
            _loc7_.zpp_disp = false;
            if(_loc7_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc7_.zpp_inner == null)
         {
            _loc8_ = false;
            §§push(_loc7_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc5_ = new ZPP_Vec2();
            }
            else
            {
               _loc5_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            _loc5_.weak = false;
            _loc5_._immutable = _loc8_;
            _loc5_.x = _loc4_;
            _loc5_.y = _loc6_;
            §§pop().zpp_inner = _loc5_;
            _loc7_.zpp_inner.outer = _loc7_;
         }
         else
         {
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc7_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc4_ != _loc4_ || _loc6_ != _loc6_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc7_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            if(_loc7_.zpp_inner.x == _loc4_)
            {
               §§pop();
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = _loc7_.zpp_inner;
               if(_loc5_._validate != null)
               {
                  _loc5_._validate();
               }
               §§push(_loc7_.zpp_inner.y == _loc6_);
            }
            if(!§§pop())
            {
               _loc7_.zpp_inner.x = _loc4_;
               _loc7_.zpp_inner.y = _loc6_;
               _loc5_ = _loc7_.zpp_inner;
               if(_loc5_._invalidate != null)
               {
                  _loc5_._invalidate(_loc5_);
               }
            }
            _loc7_;
         }
         _loc7_.zpp_inner.weak = param2;
         var _loc3_:Vec2 = _loc7_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param1.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = param1.zpp_inner;
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
            _loc9_ = _loc5_;
            if(_loc9_.outer != null)
            {
               _loc9_.outer.zpp_inner = null;
               _loc9_.outer = null;
            }
            _loc9_._isimmutable = null;
            _loc9_._validate = null;
            _loc9_._invalidate = null;
            _loc9_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc9_;
         }
         return _loc3_;
      }
      
      public function setxy(param1:Number, param2:Number) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc3_._isimmutable != null)
         {
            _loc3_._isimmutable();
         }
         if(param1 != param1 || param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         §§push(false);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(zpp_inner.x == param1)
         {
            §§pop();
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(zpp_inner.y == param2);
         }
         if(!§§pop())
         {
            zpp_inner.x = param1;
            zpp_inner.y = param2;
            _loc3_ = zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         return this;
      }
      
      public function set y(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.y != param1)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2::" + "y" + " cannot be NaN";
            }
            zpp_inner.y = param1;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.y;
      }
      
      public function set x(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.x != param1)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2::" + "x" + " cannot be NaN";
            }
            zpp_inner.x = param1;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.x;
      }
      
      public function set length(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2::length cannot be NaN";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(§§pop() + §§pop() * zpp_inner.y == 0)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set length of a zero vector";
         }
         §§push(param1);
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc3_:Number = §§pop() / Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.y));
         var _loc4_:Vec2 = this;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc4_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc5_:Number = _loc4_.zpp_inner.x * _loc3_;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc4_.zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc4_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(_loc4_.zpp_inner.x != _loc5_)
         {
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2::" + "x" + " cannot be NaN";
            }
            _loc4_.zpp_inner.x = _loc5_;
            _loc2_ = _loc4_.zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc4_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc4_.zpp_inner.x;
         _loc4_ = this;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc4_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc5_ = _loc4_.zpp_inner.y * _loc3_;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc4_.zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc4_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(_loc4_.zpp_inner.y != _loc5_)
         {
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2::" + "y" + " cannot be NaN";
            }
            _loc4_.zpp_inner.y = _loc5_;
            _loc2_ = _loc4_.zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc4_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc4_.zpp_inner.y;
         _loc2_ = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate(_loc2_);
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.y));
      }
      
      public function set angle(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2::angle cannot be NaN";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc3_:Number = Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.y));
         var _loc4_:Number = _loc3_ * Math.cos(param1);
         var _loc5_:Number = _loc3_ * Math.sin(param1);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         §§push(false);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.x == _loc4_)
         {
            §§pop();
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(zpp_inner.y == _loc5_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc4_;
            zpp_inner.y = _loc5_;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         §§push(false);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(§§pop() == zpp_inner.y)
         {
            §§pop();
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(zpp_inner.x == 0);
         }
         if(§§pop())
         {
            §§push(0);
         }
         else
         {
            §§push(Math);
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(zpp_inner.y);
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(Number(§§pop().atan2(§§pop(),zpp_inner.x)));
         }
         return §§pop();
      }
      
      public function set(param1:Vec2) : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
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
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc4_:Number = param1.zpp_inner.x;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc5_:Number = param1.zpp_inner.y;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         §§push(false);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.x == _loc4_)
         {
            §§pop();
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(zpp_inner.y == _loc5_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc4_;
            zpp_inner.y = _loc5_;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         var _loc3_:Vec2 = this;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = param1.zpp_inner;
            if(_loc2_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc2_._isimmutable != null)
            {
               _loc2_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc2_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc6_ = param1;
            _loc6_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc6_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc6_;
            }
            ZPP_PubPool.nextVec2 = _loc6_;
            _loc6_.zpp_disp = true;
            _loc7_ = _loc2_;
            if(_loc7_.outer != null)
            {
               _loc7_.outer.zpp_inner = null;
               _loc7_.outer = null;
            }
            _loc7_._isimmutable = null;
            _loc7_._validate = null;
            _loc7_._invalidate = null;
            _loc7_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc7_;
         }
         return _loc3_;
      }
      
      public function rotate(param1:Number) : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot rotate Vec2 by NaN";
         }
         if(param1 % (Math.PI * 2) != 0)
         {
            _loc3_ = Math.sin(param1);
            _loc4_ = Math.cos(param1);
            _loc5_ = _loc4_ * zpp_inner.x - _loc3_ * zpp_inner.y;
            zpp_inner.y = zpp_inner.x * _loc3_ + zpp_inner.y * _loc4_;
            zpp_inner.x = _loc5_;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         return this;
      }
      
      public function reflect(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.y)) == 0)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot reflect in zero vector";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc5_:Number = zpp_inner.x;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc6_:Number = zpp_inner.y;
         if(_loc5_ != _loc5_ || _loc6_ != _loc6_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc7_ = new Vec2();
         }
         else
         {
            _loc7_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc7_.zpp_pool;
            _loc7_.zpp_pool = null;
            _loc7_.zpp_disp = false;
            if(_loc7_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc7_.zpp_inner == null)
         {
            _loc8_ = false;
            §§push(_loc7_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc3_ = new ZPP_Vec2();
            }
            else
            {
               _loc3_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc3_.next;
               _loc3_.next = null;
            }
            _loc3_.weak = false;
            _loc3_._immutable = _loc8_;
            _loc3_.x = _loc5_;
            _loc3_.y = _loc6_;
            §§pop().zpp_inner = _loc3_;
            _loc7_.zpp_inner.outer = _loc7_;
         }
         else
         {
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = _loc7_.zpp_inner;
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
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = _loc7_.zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            if(_loc7_.zpp_inner.x == _loc5_)
            {
               §§pop();
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc3_ = _loc7_.zpp_inner;
               if(_loc3_._validate != null)
               {
                  _loc3_._validate();
               }
               §§push(_loc7_.zpp_inner.y == _loc6_);
            }
            if(!§§pop())
            {
               _loc7_.zpp_inner.x = _loc5_;
               _loc7_.zpp_inner.y = _loc6_;
               _loc3_ = _loc7_.zpp_inner;
               if(_loc3_._invalidate != null)
               {
                  _loc3_._invalidate(_loc3_);
               }
            }
            _loc7_;
         }
         _loc7_.zpp_inner.weak = true;
         var _loc4_:Vec2 = _loc7_.normalise();
         _loc7_ = param1.sub(_loc4_.muleq(2 * _loc4_.dot(param1)),param2);
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
            _loc9_ = param1;
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
            _loc10_ = _loc3_;
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
         return _loc7_;
      }
      
      public function perp(param1:Boolean = false) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc5_:* = null as Vec2;
         var _loc6_:Boolean = false;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = -zpp_inner.y;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc4_:Number = zpp_inner.x;
         if(_loc2_ != _loc2_ || _loc4_ != _loc4_)
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
               _loc3_ = new ZPP_Vec2();
            }
            else
            {
               _loc3_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc3_.next;
               _loc3_.next = null;
            }
            _loc3_.weak = false;
            _loc3_._immutable = _loc6_;
            _loc3_.x = _loc2_;
            _loc3_.y = _loc4_;
            §§pop().zpp_inner = _loc3_;
            _loc5_.zpp_inner.outer = _loc5_;
         }
         else
         {
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = _loc5_.zpp_inner;
            if(_loc3_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc3_._isimmutable != null)
            {
               _loc3_._isimmutable();
            }
            if(_loc2_ != _loc2_ || _loc4_ != _loc4_)
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
            _loc3_ = _loc5_.zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            if(_loc5_.zpp_inner.x == _loc2_)
            {
               §§pop();
               if(_loc5_ != null && _loc5_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc3_ = _loc5_.zpp_inner;
               if(_loc3_._validate != null)
               {
                  _loc3_._validate();
               }
               §§push(_loc5_.zpp_inner.y == _loc4_);
            }
            if(!§§pop())
            {
               _loc5_.zpp_inner.x = _loc2_;
               _loc5_.zpp_inner.y = _loc4_;
               _loc3_ = _loc5_.zpp_inner;
               if(_loc3_._invalidate != null)
               {
                  _loc3_._invalidate(_loc3_);
               }
            }
            _loc5_;
         }
         _loc5_.zpp_inner.weak = param1;
         return _loc5_;
      }
      
      public function normalise() : Vec2
      {
         var _loc1_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc1_._isimmutable != null)
         {
            _loc1_._isimmutable();
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         if(Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.y)) == 0)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot normalise vector of length 0";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         var _loc2_:Number = §§pop() + §§pop() * zpp_inner.y;
         var _loc3_:Number = 1 / Math.sqrt(_loc2_);
         var _loc4_:Number = _loc3_;
         var _loc5_:Vec2 = this;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = _loc5_.zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         var _loc6_:Number = _loc5_.zpp_inner.x * _loc4_;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = _loc5_.zpp_inner;
         if(_loc1_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc1_._isimmutable != null)
         {
            _loc1_._isimmutable();
         }
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = _loc5_.zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         if(_loc5_.zpp_inner.x != _loc6_)
         {
            if(_loc6_ != _loc6_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2::" + "x" + " cannot be NaN";
            }
            _loc5_.zpp_inner.x = _loc6_;
            _loc1_ = _loc5_.zpp_inner;
            if(_loc1_._invalidate != null)
            {
               _loc1_._invalidate(_loc1_);
            }
         }
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = _loc5_.zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc5_.zpp_inner.x;
         _loc5_ = this;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = _loc5_.zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc6_ = _loc5_.zpp_inner.y * _loc4_;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = _loc5_.zpp_inner;
         if(_loc1_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc1_._isimmutable != null)
         {
            _loc1_._isimmutable();
         }
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = _loc5_.zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         if(_loc5_.zpp_inner.y != _loc6_)
         {
            if(_loc6_ != _loc6_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2::" + "y" + " cannot be NaN";
            }
            _loc5_.zpp_inner.y = _loc6_;
            _loc1_ = _loc5_.zpp_inner;
            if(_loc1_._invalidate != null)
            {
               _loc1_._invalidate(_loc1_);
            }
         }
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = _loc5_.zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc5_.zpp_inner.y;
         _loc1_ = zpp_inner;
         if(_loc1_._invalidate != null)
         {
            _loc1_._invalidate(_loc1_);
         }
         return this;
      }
      
      public function muleq(param1:Number) : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot multiply with NaN";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc3_:Number = zpp_inner.x * param1;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc4_:Number = zpp_inner.y * param1;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(_loc3_ != _loc3_ || _loc4_ != _loc4_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         §§push(false);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.x == _loc3_)
         {
            §§pop();
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(zpp_inner.y == _loc4_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc3_;
            zpp_inner.y = _loc4_;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         return this;
      }
      
      public function mul(param1:Number, param2:Boolean = false) : Vec2
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:Boolean = false;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot multiply with NaN";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Number = zpp_inner.x * param1;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc5_:Number = zpp_inner.y * param1;
         if(_loc3_ != _loc3_ || _loc5_ != _loc5_)
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
               _loc4_ = new ZPP_Vec2();
            }
            else
            {
               _loc4_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc4_.next;
               _loc4_.next = null;
            }
            _loc4_.weak = false;
            _loc4_._immutable = _loc7_;
            _loc4_.x = _loc3_;
            _loc4_.y = _loc5_;
            §§pop().zpp_inner = _loc4_;
            _loc6_.zpp_inner.outer = _loc6_;
         }
         else
         {
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc6_.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            if(_loc3_ != _loc3_ || _loc5_ != _loc5_)
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
            _loc4_ = _loc6_.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            if(_loc6_.zpp_inner.x == _loc3_)
            {
               §§pop();
               if(_loc6_ != null && _loc6_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc4_ = _loc6_.zpp_inner;
               if(_loc4_._validate != null)
               {
                  _loc4_._validate();
               }
               §§push(_loc6_.zpp_inner.y == _loc5_);
            }
            if(!§§pop())
            {
               _loc6_.zpp_inner.x = _loc3_;
               _loc6_.zpp_inner.y = _loc5_;
               _loc4_ = _loc6_.zpp_inner;
               if(_loc4_._invalidate != null)
               {
                  _loc4_._invalidate(_loc4_);
               }
            }
            _loc6_;
         }
         _loc6_.zpp_inner.weak = param2;
         return _loc6_;
      }
      
      public function lsq() : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return §§pop() + §§pop() * zpp_inner.y;
      }
      
      public function get y() : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.y;
      }
      
      public function get x() : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.x;
      }
      
      public function get length() : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.y));
      }
      
      public function get angle() : Number
      {
         var _loc1_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         §§push(false);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         if(§§pop() == zpp_inner.y)
         {
            §§pop();
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc1_ = zpp_inner;
            if(_loc1_._validate != null)
            {
               _loc1_._validate();
            }
            §§push(zpp_inner.x == 0);
         }
         if(§§pop())
         {
            return 0;
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return Number(§§pop().atan2(§§pop(),zpp_inner.x));
      }
      
      public function dot(param1:Vec2) : Number
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot take dot product with null vector";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         §§push(zpp_inner.x);
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
         §§push(§§pop() * param1.zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         §§push(zpp_inner.y);
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
         var _loc2_:Number = §§pop() + §§pop() * param1.zpp_inner.y;
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
            _loc4_ = param1;
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
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc1_._isimmutable != null)
         {
            _loc1_._isimmutable();
         }
         if(zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc1_ = zpp_inner;
         zpp_inner.outer = null;
         zpp_inner = null;
         var _loc2_:Vec2 = this;
         _loc2_.zpp_pool = null;
         if(ZPP_PubPool.nextVec2 != null)
         {
            ZPP_PubPool.nextVec2.zpp_pool = _loc2_;
         }
         else
         {
            ZPP_PubPool.poolVec2 = _loc2_;
         }
         ZPP_PubPool.nextVec2 = _loc2_;
         _loc2_.zpp_disp = true;
         var _loc3_:ZPP_Vec2 = _loc1_;
         if(_loc3_.outer != null)
         {
            _loc3_.outer.zpp_inner = null;
            _loc3_.outer = null;
         }
         _loc3_._isimmutable = null;
         _loc3_._validate = null;
         _loc3_._invalidate = null;
         _loc3_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc3_;
      }
      
      public function cross(param1:Vec2) : Number
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot take cross product with null vector";
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
         §§push(param1.zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         §§push(§§pop() * zpp_inner.x);
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
         §§push(param1.zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = §§pop() - §§pop() * zpp_inner.y;
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
            _loc4_ = param1;
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
         }
         return _loc2_;
      }
      
      public function copy(param1:Boolean = false) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc5_:* = null as Vec2;
         var _loc6_:Boolean = false;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = zpp_inner.x;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc4_:Number = zpp_inner.y;
         if(_loc2_ != _loc2_ || _loc4_ != _loc4_)
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
               _loc3_ = new ZPP_Vec2();
            }
            else
            {
               _loc3_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc3_.next;
               _loc3_.next = null;
            }
            _loc3_.weak = false;
            _loc3_._immutable = _loc6_;
            _loc3_.x = _loc2_;
            _loc3_.y = _loc4_;
            §§pop().zpp_inner = _loc3_;
            _loc5_.zpp_inner.outer = _loc5_;
         }
         else
         {
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = _loc5_.zpp_inner;
            if(_loc3_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc3_._isimmutable != null)
            {
               _loc3_._isimmutable();
            }
            if(_loc2_ != _loc2_ || _loc4_ != _loc4_)
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
            _loc3_ = _loc5_.zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            if(_loc5_.zpp_inner.x == _loc2_)
            {
               §§pop();
               if(_loc5_ != null && _loc5_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc3_ = _loc5_.zpp_inner;
               if(_loc3_._validate != null)
               {
                  _loc3_._validate();
               }
               §§push(_loc5_.zpp_inner.y == _loc4_);
            }
            if(!§§pop())
            {
               _loc5_.zpp_inner.x = _loc2_;
               _loc5_.zpp_inner.y = _loc4_;
               _loc3_ = _loc5_.zpp_inner;
               if(_loc3_._invalidate != null)
               {
                  _loc3_._invalidate(_loc3_);
               }
            }
            _loc5_;
         }
         _loc5_.zpp_inner.weak = param1;
         return _loc5_;
      }
      
      public function addeq(param1:Vec2) : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot add null vectors";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc3_:Number = §§pop() + param1.zpp_inner.x;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.y);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc4_:Number = §§pop() + param1.zpp_inner.y;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(_loc3_ != _loc3_ || _loc4_ != _loc4_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         §§push(false);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.x == _loc3_)
         {
            §§pop();
            if(zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(zpp_inner.y == _loc4_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc3_;
            zpp_inner.y = _loc4_;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = param1.zpp_inner;
            if(_loc2_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc2_._isimmutable != null)
            {
               _loc2_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc2_ = param1.zpp_inner;
            param1.zpp_inner.outer = null;
            param1.zpp_inner = null;
            _loc5_ = param1;
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
            _loc6_ = _loc2_;
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
         return this;
      }
      
      public function addMul(param1:Vec2, param2:Number, param3:Boolean = false) : Vec2
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:Boolean = false;
         var _loc10_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot add null vectors";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(zpp_inner.x);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc5_:Number = §§pop() + param1.zpp_inner.x * param2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(zpp_inner.y);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc7_:Number = §§pop() + param1.zpp_inner.y * param2;
         if(_loc5_ != _loc5_ || _loc7_ != _loc7_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc8_ = new Vec2();
         }
         else
         {
            _loc8_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc8_.zpp_pool;
            _loc8_.zpp_pool = null;
            _loc8_.zpp_disp = false;
            if(_loc8_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc8_.zpp_inner == null)
         {
            _loc9_ = false;
            §§push(_loc8_);
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
            _loc6_._immutable = _loc9_;
            _loc6_.x = _loc5_;
            _loc6_.y = _loc7_;
            §§pop().zpp_inner = _loc6_;
            _loc8_.zpp_inner.outer = _loc8_;
         }
         else
         {
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc8_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc5_ != _loc5_ || _loc7_ != _loc7_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc8_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            if(_loc8_.zpp_inner.x == _loc5_)
            {
               §§pop();
               if(_loc8_ != null && _loc8_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc8_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               §§push(_loc8_.zpp_inner.y == _loc7_);
            }
            if(!§§pop())
            {
               _loc8_.zpp_inner.x = _loc5_;
               _loc8_.zpp_inner.y = _loc7_;
               _loc6_ = _loc8_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc8_;
         }
         _loc8_.zpp_inner.weak = param3;
         var _loc4_:Vec2 = _loc8_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = param1.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc6_ = param1.zpp_inner;
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
            _loc10_ = _loc6_;
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
         return _loc4_;
      }
      
      public function add(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot add null vectors";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         §§push(zpp_inner.x);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc4_:Number = §§pop() + param1.zpp_inner.x;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         §§push(zpp_inner.y);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc6_:Number = §§pop() + param1.zpp_inner.y;
         if(_loc4_ != _loc4_ || _loc6_ != _loc6_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc7_ = new Vec2();
         }
         else
         {
            _loc7_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc7_.zpp_pool;
            _loc7_.zpp_pool = null;
            _loc7_.zpp_disp = false;
            if(_loc7_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc7_.zpp_inner == null)
         {
            _loc8_ = false;
            §§push(_loc7_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc5_ = new ZPP_Vec2();
            }
            else
            {
               _loc5_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            _loc5_.weak = false;
            _loc5_._immutable = _loc8_;
            _loc5_.x = _loc4_;
            _loc5_.y = _loc6_;
            §§pop().zpp_inner = _loc5_;
            _loc7_.zpp_inner.outer = _loc7_;
         }
         else
         {
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc7_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc4_ != _loc4_ || _loc6_ != _loc6_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc7_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            if(_loc7_.zpp_inner.x == _loc4_)
            {
               §§pop();
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = _loc7_.zpp_inner;
               if(_loc5_._validate != null)
               {
                  _loc5_._validate();
               }
               §§push(_loc7_.zpp_inner.y == _loc6_);
            }
            if(!§§pop())
            {
               _loc7_.zpp_inner.x = _loc4_;
               _loc7_.zpp_inner.y = _loc6_;
               _loc5_ = _loc7_.zpp_inner;
               if(_loc5_._invalidate != null)
               {
                  _loc5_._invalidate(_loc5_);
               }
            }
            _loc7_;
         }
         _loc7_.zpp_inner.weak = param2;
         var _loc3_:Vec2 = _loc7_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param1.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = param1.zpp_inner;
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
            _loc9_ = _loc5_;
            if(_loc9_.outer != null)
            {
               _loc9_.outer.zpp_inner = null;
               _loc9_.outer = null;
            }
            _loc9_._isimmutable = null;
            _loc9_._validate = null;
            _loc9_._invalidate = null;
            _loc9_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc9_;
         }
         return _loc3_;
      }
   }
}
