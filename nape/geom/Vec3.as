package nape.geom
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.geom.ZPP_Vec3;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class Vec3
   {
       
      
      public var zpp_pool:Vec3;
      
      public var zpp_inner:ZPP_Vec3;
      
      public var zpp_disp:Boolean;
      
      public function Vec3(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_pool = null;
         zpp_inner = null;
         zpp_inner = new ZPP_Vec3();
         zpp_inner.outer = this;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         zpp_inner.x = param1;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc4_:ZPP_Vec3 = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.x;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         zpp_inner.y = param2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.y;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         zpp_inner.z = param3;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.z;
      }
      
      public static function get(param1:Number = 0, param2:Number = 0, param3:Number = 0) : Vec3
      {
         var _loc4_:* = null as Vec3;
         if(ZPP_PubPool.poolVec3 == null)
         {
            _loc4_ = new Vec3();
         }
         else
         {
            _loc4_ = ZPP_PubPool.poolVec3;
            ZPP_PubPool.poolVec3 = _loc4_.zpp_pool;
            _loc4_.zpp_pool = null;
            _loc4_.zpp_disp = false;
            if(_loc4_ == ZPP_PubPool.nextVec3)
            {
               ZPP_PubPool.nextVec3 = null;
            }
         }
         _loc4_.setxyz(param1,param2,param3);
         _loc4_.zpp_inner.immutable = false;
         _loc4_.zpp_inner._validate = null;
         return _loc4_;
      }
      
      public function xy(param1:Boolean = false) : Vec2
      {
         var _loc5_:* = null as Vec2;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZPP_Vec2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc3_:ZPP_Vec3 = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = zpp_inner.x;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
               §§push(_loc5_.zpp_inner.y == _loc4_);
            }
            if(!§§pop())
            {
               _loc5_.zpp_inner.x = _loc2_;
               _loc5_.zpp_inner.y = _loc4_;
               _loc7_ = _loc5_.zpp_inner;
               if(_loc7_._invalidate != null)
               {
                  _loc7_._invalidate(_loc7_);
               }
            }
            _loc5_;
         }
         _loc5_.zpp_inner.weak = param1;
         return _loc5_;
      }
      
      public function toString() : String
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         §§push("{ x: ");
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(§§pop() + zpp_inner.x + " y: ");
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(§§pop() + zpp_inner.y + " z: ");
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return §§pop() + zpp_inner.z + " }";
      }
      
      public function setxyz(param1:Number, param2:Number, param3:Number) : Vec3
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         zpp_inner.x = param1;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc4_:ZPP_Vec3 = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.x;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         zpp_inner.y = param2;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.y;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         zpp_inner.z = param3;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         zpp_inner.z;
         return this;
      }
      
      public function set z(param1:Number) : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         zpp_inner.z = param1;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc2_:ZPP_Vec3 = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.z;
      }
      
      public function set y(param1:Number) : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         zpp_inner.y = param1;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc2_:ZPP_Vec3 = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.y;
      }
      
      public function set x(param1:Number) : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3 is immutable";
         }
         zpp_inner.x = param1;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc2_:ZPP_Vec3 = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.x;
      }
      
      public function set length(param1:Number) : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Vec3::length cannot be NaN";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc2_:ZPP_Vec3 = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(§§pop() + §§pop() * zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.z);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(§§pop() + §§pop() * zpp_inner.z == 0)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set length of a zero vector";
         }
         §§push(param1);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(§§pop() + §§pop() * zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.z);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         var _loc3_:Number = §§pop() / Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.z));
         var _loc4_:Number = _loc3_;
         var _loc5_:Vec3 = this;
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
         _loc2_ = _loc5_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§pop().x = _loc5_.zpp_inner.x * _loc4_;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc5_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc5_.zpp_inner.x;
         _loc5_ = this;
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
         _loc2_ = _loc5_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§pop().y = _loc5_.zpp_inner.y * _loc4_;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc5_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc5_.zpp_inner.y;
         _loc5_ = this;
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
         _loc2_ = _loc5_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§pop().z = _loc5_.zpp_inner.z * _loc3_;
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc5_.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc5_.zpp_inner.z;
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(§§pop() + §§pop() * zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(zpp_inner.z);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.z));
      }
      
      public function set(param1:Vec3) : Vec3
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null Vec3";
         }
         §§push(§§findproperty(setxyz));
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc2_:ZPP_Vec3 = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(param1.zpp_inner.x);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         §§push(param1.zpp_inner.y);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc2_ = param1.zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return §§pop().setxyz(§§pop(),§§pop(),param1.zpp_inner.z);
      }
      
      public function lsq() : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(§§pop() + §§pop() * zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.z);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return §§pop() + §§pop() * zpp_inner.z;
      }
      
      public function get z() : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.z;
      }
      
      public function get y() : Number
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec3 = zpp_inner;
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec3 = zpp_inner;
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         §§push(Math);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         var _loc1_:ZPP_Vec3 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.x);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
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
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(§§pop() + §§pop() * zpp_inner.y);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         §§push(zpp_inner.z);
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         _loc1_ = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return Number(§§pop().sqrt(§§pop() + §§pop() * zpp_inner.z));
      }
      
      public function dispose() : void
      {
         if(zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec3 is not disposable";
         }
         var _loc1_:Vec3 = this;
         _loc1_.zpp_pool = null;
         if(ZPP_PubPool.nextVec3 != null)
         {
            ZPP_PubPool.nextVec3.zpp_pool = _loc1_;
         }
         else
         {
            ZPP_PubPool.poolVec3 = _loc1_;
         }
         ZPP_PubPool.nextVec3 = _loc1_;
         _loc1_.zpp_disp = true;
      }
   }
}
