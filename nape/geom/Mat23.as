package nape.geom
{
   import flash.Boot;
   import flash.geom.Matrix;
   import nape.Config;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class Mat23
   {
       
      
      public var zpp_inner:ZPP_Mat23;
      
      public function Mat23(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 1, param5:Number = 0, param6:Number = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         zpp_inner = ZPP_Mat23.get();
         zpp_inner.outer = this;
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "a" + " cannot be NaN";
         }
         zpp_inner.a = param1;
         var _loc7_:ZPP_Mat23 = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.a;
         if(param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "b" + " cannot be NaN";
         }
         zpp_inner.b = param2;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.b;
         if(param5 != param5)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "tx" + " cannot be NaN";
         }
         zpp_inner.tx = param5;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.tx;
         if(param3 != param3)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "c" + " cannot be NaN";
         }
         zpp_inner.c = param3;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.c;
         if(param4 != param4)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "d" + " cannot be NaN";
         }
         zpp_inner.d = param4;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.d;
         if(param6 != param6)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "ty" + " cannot be NaN";
         }
         zpp_inner.ty = param6;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.ty;
      }
      
      public static function fromMatrix(param1:Matrix) : Mat23
      {
         var _loc2_:Matrix = param1;
         return new Mat23(_loc2_.a,_loc2_.c,_loc2_.b,_loc2_.d,_loc2_.tx,_loc2_.ty);
      }
      
      public static function rotation(param1:Number) : Mat23
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot create rotation matrix with NaN angle";
         }
         var _loc2_:Number = Math.cos(param1);
         var _loc3_:Number = Math.sin(param1);
         return new Mat23(_loc2_,-_loc3_,_loc3_,_loc2_,0,0);
      }
      
      public static function translation(param1:Number, param2:Number) : Mat23
      {
         return new Mat23(1,0,0,1,param1,param2);
      }
      
      public static function scale(param1:Number, param2:Number) : Mat23
      {
         return new Mat23(param1,0,0,param2,0,0);
      }
      
      public function transpose() : Mat23
      {
         return new Mat23(zpp_inner.a,zpp_inner.c,zpp_inner.b,zpp_inner.d,-zpp_inner.a * zpp_inner.tx - zpp_inner.c * zpp_inner.ty,-zpp_inner.b * zpp_inner.tx - zpp_inner.d * zpp_inner.ty);
      }
      
      public function transform(param1:Vec2, param2:Boolean = false, param3:Boolean = false) : Vec2
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:Number = NaN;
         var _loc8_:* = null as Vec2;
         var _loc9_:Boolean = false;
         var _loc10_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot transform null Vec2";
         }
         if(param2)
         {
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
            §§push(param1.zpp_inner.x * zpp_inner.a);
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
            _loc5_ = §§pop() + param1.zpp_inner.y * zpp_inner.b;
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
            §§push(param1.zpp_inner.x * zpp_inner.c);
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
            _loc7_ = §§pop() + param1.zpp_inner.y * zpp_inner.d;
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
            _loc4_ = _loc8_;
         }
         else
         {
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
            §§push(param1.zpp_inner.x * zpp_inner.a);
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
            _loc5_ = §§pop() + param1.zpp_inner.y * zpp_inner.b + zpp_inner.tx;
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
            §§push(param1.zpp_inner.x * zpp_inner.c);
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
            _loc7_ = §§pop() + param1.zpp_inner.y * zpp_inner.d + zpp_inner.ty;
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
            _loc4_ = _loc8_;
         }
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
      
      public function toString() : String
      {
         return "{ a: " + zpp_inner.a + " b: " + zpp_inner.b + " c: " + zpp_inner.c + " d: " + zpp_inner.d + " tx: " + zpp_inner.tx + " ty: " + zpp_inner.ty + " }";
      }
      
      public function toMatrix(param1:Matrix = undefined) : Matrix
      {
         if(param1 == null)
         {
            param1 = new Matrix();
         }
         param1.a = zpp_inner.a;
         param1.b = zpp_inner.c;
         param1.c = zpp_inner.b;
         param1.d = zpp_inner.d;
         param1.tx = zpp_inner.tx;
         param1.ty = zpp_inner.ty;
         return param1;
      }
      
      public function singular() : Boolean
      {
         var _loc1_:Number = zpp_inner.a * zpp_inner.a + zpp_inner.b * zpp_inner.b + zpp_inner.c * zpp_inner.c + zpp_inner.d * zpp_inner.d;
         var _loc2_:Number = zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c;
         if(_loc2_ < 0)
         {
            _loc2_ = -_loc2_;
         }
         return _loc1_ > Config.illConditionedThreshold * _loc2_;
      }
      
      public function set ty(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "ty" + " cannot be NaN";
         }
         zpp_inner.ty = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.ty;
      }
      
      public function set tx(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "tx" + " cannot be NaN";
         }
         zpp_inner.tx = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.tx;
      }
      
      public function set d(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "d" + " cannot be NaN";
         }
         zpp_inner.d = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.d;
      }
      
      public function set c(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "c" + " cannot be NaN";
         }
         zpp_inner.c = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.c;
      }
      
      public function set b(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "b" + " cannot be NaN";
         }
         zpp_inner.b = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.b;
      }
      
      public function set a(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Mat23::" + "a" + " cannot be NaN";
         }
         zpp_inner.a = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.a;
      }
      
      public function setAs(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 1, param5:Number = 0, param6:Number = 0) : Mat23
      {
         zpp_inner.setas(param1,param2,param3,param4,param5,param6);
         var _loc7_:ZPP_Mat23 = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         return this;
      }
      
      public function set(param1:Mat23) : Mat23
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set form null matrix";
         }
         var _loc2_:ZPP_Mat23 = param1.zpp_inner;
         zpp_inner.setas(_loc2_.a,_loc2_.b,_loc2_.c,_loc2_.d,_loc2_.tx,_loc2_.ty);
         _loc2_ = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return this;
      }
      
      public function reset() : Mat23
      {
         return setAs();
      }
      
      public function orthogonalise() : Mat23
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:* = null as Mat23;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_Mat23;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(!orthogonal())
         {
            _loc1_ = Math.sqrt(zpp_inner.a * zpp_inner.a + zpp_inner.c * zpp_inner.c);
            _loc2_ = Math.sqrt(zpp_inner.b * zpp_inner.b + zpp_inner.d * zpp_inner.d);
            if(_loc1_ * _loc1_ < Config.epsilon || _loc2_ * _loc2_ < Config.epsilon)
            {
               Boot.lastError = new Error();
               throw "Error: Matrix is singular and cannot be " + "orthogonal" + "ised";
            }
            _loc3_ = 1;
            _loc1_ = _loc3_ / _loc1_;
            _loc2_ = _loc3_ / _loc2_;
            _loc4_ = this;
            _loc5_ = _loc4_.zpp_inner.a * _loc1_;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "a" + " cannot be NaN";
            }
            _loc4_.zpp_inner.a = _loc5_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            _loc4_.zpp_inner.a;
            _loc4_ = this;
            _loc5_ = _loc4_.zpp_inner.c * _loc1_;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "c" + " cannot be NaN";
            }
            _loc4_.zpp_inner.c = _loc5_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            _loc4_.zpp_inner.c;
            _loc4_ = this;
            _loc5_ = _loc4_.zpp_inner.b * _loc2_;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "b" + " cannot be NaN";
            }
            _loc4_.zpp_inner.b = _loc5_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            _loc4_.zpp_inner.b;
            _loc4_ = this;
            _loc5_ = _loc4_.zpp_inner.d * _loc2_;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "d" + " cannot be NaN";
            }
            _loc4_.zpp_inner.d = _loc5_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            _loc4_.zpp_inner.d;
            _loc5_ = zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d;
            _loc7_ = 0.25 * Math.PI - 0.5 * Math.acos(_loc5_ / (_loc3_ * _loc3_));
            if(zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c > 0)
            {
               _loc7_ = -_loc7_;
            }
            _loc8_ = Math.sin(_loc7_);
            _loc9_ = Math.cos(_loc7_);
            _loc10_ = zpp_inner.a * _loc9_ - zpp_inner.c * _loc8_;
            _loc11_ = zpp_inner.b * _loc9_ + zpp_inner.d * _loc8_;
            _loc12_ = zpp_inner.c * _loc9_ + zpp_inner.a * _loc8_;
            if(_loc12_ != _loc12_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "c" + " cannot be NaN";
            }
            zpp_inner.c = _loc12_;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            zpp_inner.c;
            if(_loc10_ != _loc10_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "a" + " cannot be NaN";
            }
            zpp_inner.a = _loc10_;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            zpp_inner.a;
            _loc12_ = zpp_inner.d * _loc9_ - zpp_inner.b * _loc8_;
            if(_loc12_ != _loc12_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "d" + " cannot be NaN";
            }
            zpp_inner.d = _loc12_;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            zpp_inner.d;
            if(_loc11_ != _loc11_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "b" + " cannot be NaN";
            }
            zpp_inner.b = _loc11_;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            zpp_inner.b;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
         }
         return this;
      }
      
      public function orthogonal() : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:Number = zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d;
         if(_loc1_ * _loc1_ < Config.epsilon)
         {
            _loc2_ = zpp_inner.a * zpp_inner.a + zpp_inner.b * zpp_inner.b - 1;
            _loc3_ = zpp_inner.c * zpp_inner.c + zpp_inner.d * zpp_inner.d - 1;
            return _loc2_ * _loc2_ < Config.epsilon && _loc3_ * _loc3_ < Config.epsilon;
         }
         return false;
      }
      
      public function inverseTransform(param1:Vec2, param2:Boolean = false, param3:Boolean = false) : Vec2
      {
         var _loc5_:* = null as Vec2;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as Vec2;
         var _loc10_:Boolean = false;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot transform null Vec2";
         }
         if(singular())
         {
            Boot.lastError = new Error();
            throw "Error: Matrix is singular and inverse transformation cannot be performed";
         }
         var _loc4_:Number = 1 / (zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c);
         if(param2)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            §§push(param1.zpp_inner.x * zpp_inner.d);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc6_ = (§§pop() - param1.zpp_inner.y * zpp_inner.b) * _loc4_;
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            §§push(param1.zpp_inner.y * zpp_inner.a);
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc8_ = (§§pop() - param1.zpp_inner.x * zpp_inner.c) * _loc4_;
            if(_loc6_ != _loc6_ || _loc8_ != _loc8_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc9_ = new Vec2();
            }
            else
            {
               _loc9_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc9_.zpp_pool;
               _loc9_.zpp_pool = null;
               _loc9_.zpp_disp = false;
               if(_loc9_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc9_.zpp_inner == null)
            {
               _loc10_ = false;
               §§push(_loc9_);
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
               _loc7_._immutable = _loc10_;
               _loc7_.x = _loc6_;
               _loc7_.y = _loc8_;
               §§pop().zpp_inner = _loc7_;
               _loc9_.zpp_inner.outer = _loc9_;
            }
            else
            {
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc9_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc6_ != _loc6_ || _loc8_ != _loc8_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc9_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc9_.zpp_inner.x == _loc6_)
               {
                  §§pop();
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc7_ = _loc9_.zpp_inner;
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  §§push(_loc9_.zpp_inner.y == _loc8_);
               }
               if(!§§pop())
               {
                  _loc9_.zpp_inner.x = _loc6_;
                  _loc9_.zpp_inner.y = _loc8_;
                  _loc7_ = _loc9_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc9_;
            }
            _loc9_.zpp_inner.weak = param3;
            _loc5_ = _loc9_;
         }
         else
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc6_ = param1.zpp_inner.x - zpp_inner.tx;
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc8_ = param1.zpp_inner.y - zpp_inner.ty;
            _loc11_ = (_loc6_ * zpp_inner.d - _loc8_ * zpp_inner.b) * _loc4_;
            _loc12_ = (_loc8_ * zpp_inner.a - _loc6_ * zpp_inner.c) * _loc4_;
            if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc9_ = new Vec2();
            }
            else
            {
               _loc9_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc9_.zpp_pool;
               _loc9_.zpp_pool = null;
               _loc9_.zpp_disp = false;
               if(_loc9_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc9_.zpp_inner == null)
            {
               _loc10_ = false;
               §§push(_loc9_);
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
               _loc7_._immutable = _loc10_;
               _loc7_.x = _loc11_;
               _loc7_.y = _loc12_;
               §§pop().zpp_inner = _loc7_;
               _loc9_.zpp_inner.outer = _loc9_;
            }
            else
            {
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc9_.zpp_inner;
               if(_loc7_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc7_._isimmutable != null)
               {
                  _loc7_._isimmutable();
               }
               if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc7_ = _loc9_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc9_.zpp_inner.x == _loc11_)
               {
                  §§pop();
                  if(_loc9_ != null && _loc9_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc7_ = _loc9_.zpp_inner;
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  §§push(_loc9_.zpp_inner.y == _loc12_);
               }
               if(!§§pop())
               {
                  _loc9_.zpp_inner.x = _loc11_;
                  _loc9_.zpp_inner.y = _loc12_;
                  _loc7_ = _loc9_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc9_;
            }
            _loc9_.zpp_inner.weak = param3;
            _loc5_ = _loc9_;
         }
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = param1.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = param1.zpp_inner;
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
            _loc13_ = _loc7_;
            if(_loc13_.outer != null)
            {
               _loc13_.outer.zpp_inner = null;
               _loc13_.outer = null;
            }
            _loc13_._isimmutable = null;
            _loc13_._validate = null;
            _loc13_._invalidate = null;
            _loc13_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc13_;
         }
         return _loc5_;
      }
      
      public function inverse() : Mat23
      {
         if(singular())
         {
            Boot.lastError = new Error();
            throw "Error: Matrix is singular and cannot be inverted";
         }
         var _loc1_:Number = 1 / (zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c);
         return new Mat23(zpp_inner.d * _loc1_,-zpp_inner.b * _loc1_,-zpp_inner.c * _loc1_,zpp_inner.a * _loc1_,(zpp_inner.b * zpp_inner.ty - zpp_inner.d * zpp_inner.tx) * _loc1_,(zpp_inner.c * zpp_inner.tx - zpp_inner.a * zpp_inner.ty) * _loc1_);
      }
      
      public function get ty() : Number
      {
         return zpp_inner.ty;
      }
      
      public function get tx() : Number
      {
         return zpp_inner.tx;
      }
      
      public function get determinant() : Number
      {
         return zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c;
      }
      
      public function get d() : Number
      {
         return zpp_inner.d;
      }
      
      public function get c() : Number
      {
         return zpp_inner.c;
      }
      
      public function get b() : Number
      {
         return zpp_inner.b;
      }
      
      public function get a() : Number
      {
         return zpp_inner.a;
      }
      
      public function equiorthogonalise() : Mat23
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as Mat23;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_Mat23;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         if(!equiorthogonal())
         {
            _loc1_ = Math.sqrt(zpp_inner.a * zpp_inner.a + zpp_inner.c * zpp_inner.c);
            _loc2_ = Math.sqrt(zpp_inner.b * zpp_inner.b + zpp_inner.d * zpp_inner.d);
            if(_loc1_ * _loc1_ < Config.epsilon || _loc2_ * _loc2_ < Config.epsilon)
            {
               Boot.lastError = new Error();
               throw "Error: Matrix is singular and cannot be " + "equiorthogonal" + "ised";
            }
            _loc3_ = (_loc1_ + _loc2_) / 2;
            _loc1_ = _loc3_ / _loc1_;
            _loc2_ = _loc3_ / _loc2_;
            _loc4_ = this;
            _loc5_ = _loc4_.zpp_inner.a * _loc1_;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "a" + " cannot be NaN";
            }
            _loc4_.zpp_inner.a = _loc5_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            _loc4_.zpp_inner.a;
            _loc4_ = this;
            _loc5_ = _loc4_.zpp_inner.c * _loc1_;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "c" + " cannot be NaN";
            }
            _loc4_.zpp_inner.c = _loc5_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            _loc4_.zpp_inner.c;
            _loc4_ = this;
            _loc5_ = _loc4_.zpp_inner.b * _loc2_;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "b" + " cannot be NaN";
            }
            _loc4_.zpp_inner.b = _loc5_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            _loc4_.zpp_inner.b;
            _loc4_ = this;
            _loc5_ = _loc4_.zpp_inner.d * _loc2_;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "d" + " cannot be NaN";
            }
            _loc4_.zpp_inner.d = _loc5_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            _loc4_.zpp_inner.d;
            _loc5_ = zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d;
            _loc7_ = 0.25 * Math.PI - 0.5 * Math.acos(_loc5_ / (_loc3_ * _loc3_));
            if(zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c > 0)
            {
               _loc7_ = -_loc7_;
            }
            _loc8_ = Math.sin(_loc7_);
            _loc9_ = Math.cos(_loc7_);
            _loc10_ = zpp_inner.a * _loc9_ - zpp_inner.c * _loc8_;
            _loc11_ = zpp_inner.b * _loc9_ + zpp_inner.d * _loc8_;
            _loc12_ = zpp_inner.c * _loc9_ + zpp_inner.a * _loc8_;
            if(_loc12_ != _loc12_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "c" + " cannot be NaN";
            }
            zpp_inner.c = _loc12_;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            zpp_inner.c;
            if(_loc10_ != _loc10_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "a" + " cannot be NaN";
            }
            zpp_inner.a = _loc10_;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            zpp_inner.a;
            _loc12_ = zpp_inner.d * _loc9_ - zpp_inner.b * _loc8_;
            if(_loc12_ != _loc12_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "d" + " cannot be NaN";
            }
            zpp_inner.d = _loc12_;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            zpp_inner.d;
            if(_loc11_ != _loc11_)
            {
               Boot.lastError = new Error();
               throw "Error: Mat23::" + "b" + " cannot be NaN";
            }
            zpp_inner.b = _loc11_;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
            zpp_inner.b;
            _loc6_ = zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate();
            }
         }
         return this;
      }
      
      public function equiorthogonal() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(singular())
         {
            return false;
         }
         _loc1_ = zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d;
         if(_loc1_ * _loc1_ < Config.epsilon)
         {
            _loc2_ = zpp_inner.a * zpp_inner.a + zpp_inner.b * zpp_inner.b - zpp_inner.c * zpp_inner.c - zpp_inner.d * zpp_inner.d;
            return _loc2_ * _loc2_ < Config.epsilon;
         }
         return false;
      }
      
      public function copy() : Mat23
      {
         return new Mat23(zpp_inner.a,zpp_inner.b,zpp_inner.c,zpp_inner.d,zpp_inner.tx,zpp_inner.ty);
      }
      
      public function concat(param1:Mat23) : Mat23
      {
         var _loc2_:Mat23 = param1;
         if(_loc2_ == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot concatenate with null Mat23";
         }
         return new Mat23(_loc2_.zpp_inner.a * zpp_inner.a + _loc2_.zpp_inner.b * zpp_inner.c,_loc2_.zpp_inner.a * zpp_inner.b + _loc2_.zpp_inner.b * zpp_inner.d,_loc2_.zpp_inner.c * zpp_inner.a + _loc2_.zpp_inner.d * zpp_inner.c,_loc2_.zpp_inner.c * zpp_inner.b + _loc2_.zpp_inner.d * zpp_inner.d,_loc2_.zpp_inner.a * zpp_inner.tx + _loc2_.zpp_inner.b * zpp_inner.ty + _loc2_.zpp_inner.tx,_loc2_.zpp_inner.c * zpp_inner.tx + _loc2_.zpp_inner.d * zpp_inner.ty + _loc2_.zpp_inner.ty);
      }
   }
}
