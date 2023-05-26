package nape.geom
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Ray;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class Ray
   {
       
      
      public var zpp_inner:ZPP_Ray;
      
      public function Ray(param1:Vec2, param2:Vec2)
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
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
         zpp_inner = new ZPP_Ray();
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Ray::origin cannot be null";
         }
         var _loc3_:Vec2 = zpp_inner.origin;
         if(_loc3_ != null && _loc3_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
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
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc6_:Number = param1.zpp_inner.x;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc7_:Number = param1.zpp_inner.y;
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
         if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
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
         if(_loc3_.zpp_inner.x == _loc6_)
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
            §§push(_loc3_.zpp_inner.y == _loc7_);
         }
         if(!§§pop())
         {
            _loc3_.zpp_inner.x = _loc6_;
            _loc3_.zpp_inner.y = _loc7_;
            _loc4_ = _loc3_.zpp_inner;
            if(_loc4_._invalidate != null)
            {
               _loc4_._invalidate(_loc4_);
            }
         }
         var _loc5_:Vec2 = _loc3_;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = param1.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc4_ = param1.zpp_inner;
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
            _loc9_ = _loc4_;
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
         _loc5_;
         zpp_inner.origin;
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Ray::direction cannot be null";
         }
         _loc3_ = zpp_inner.direction;
         if(_loc3_ != null && _loc3_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param2 != null && param2.zpp_disp)
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
         if(param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null Vec2";
         }
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = param2.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc6_ = param2.zpp_inner.x;
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc4_ = param2.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc7_ = param2.zpp_inner.y;
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
         if(_loc6_ != _loc6_ || _loc7_ != _loc7_)
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
         if(_loc3_.zpp_inner.x == _loc6_)
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
            §§push(_loc3_.zpp_inner.y == _loc7_);
         }
         if(!§§pop())
         {
            _loc3_.zpp_inner.x = _loc6_;
            _loc3_.zpp_inner.y = _loc7_;
            _loc4_ = _loc3_.zpp_inner;
            if(_loc4_._invalidate != null)
            {
               _loc4_._invalidate(_loc4_);
            }
         }
         _loc5_ = _loc3_;
         if(param2.zpp_inner.weak)
         {
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = param2.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            if(param2.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc4_ = param2.zpp_inner;
            param2.zpp_inner.outer = null;
            param2.zpp_inner = null;
            _loc8_ = param2;
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
            _loc9_ = _loc4_;
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
         _loc5_;
         zpp_inner.zip_dir = true;
         zpp_inner.direction;
         zpp_inner.maxdist = 1.79e+308;
      }
      
      public static function fromSegment(param1:Vec2, param2:Vec2) : Ray
      {
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as ZPP_Vec2;
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
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Ray::fromSegment::start is null";
         }
         if(param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Ray::fromSegment::end is null";
         }
         var _loc3_:Vec2 = param2.sub(param1,true);
         var _loc4_:Ray = new Ray(param1,_loc3_);
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         §§push(Math);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = param1.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         §§push(param1.zpp_inner.x);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = param2.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc6_ = §§pop() - param2.zpp_inner.x;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = param1.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         §§push(param1.zpp_inner.y);
         if(param2 != null && param2.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc8_ = param2.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         _loc7_ = §§pop() - param2.zpp_inner.y;
         var _loc5_:Number = Number(§§pop().sqrt(_loc6_ * _loc6_ + _loc7_ * _loc7_));
         if(_loc5_ != _loc5_)
         {
            Boot.lastError = new Error();
            throw "Error: maxDistance cannot be NaN";
         }
         _loc4_.zpp_inner.maxdist = _loc5_;
         _loc4_.zpp_inner.maxdist;
         if(param1.zpp_inner.weak)
         {
            if(param1 != null && param1.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = param1.zpp_inner;
            if(_loc8_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc8_._isimmutable != null)
            {
               _loc8_._isimmutable();
            }
            if(param1.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc8_ = param1.zpp_inner;
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
         if(param2.zpp_inner.weak)
         {
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = param2.zpp_inner;
            if(_loc8_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc8_._isimmutable != null)
            {
               _loc8_._isimmutable();
            }
            if(param2.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc8_ = param2.zpp_inner;
            param2.zpp_inner.outer = null;
            param2.zpp_inner = null;
            _loc9_ = param2;
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
         return _loc4_;
      }
      
      public function set origin(param1:Vec2) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Ray::origin cannot be null";
         }
         var _loc2_:Vec2 = zpp_inner.origin;
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
         return zpp_inner.origin;
      }
      
      public function set maxDistance(param1:Number) : Number
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: maxDistance cannot be NaN";
         }
         zpp_inner.maxdist = param1;
         return zpp_inner.maxdist;
      }
      
      public function set direction(param1:Vec2) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Ray::direction cannot be null";
         }
         var _loc2_:Vec2 = zpp_inner.direction;
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
         zpp_inner.zip_dir = true;
         return zpp_inner.direction;
      }
      
      public function get userData() : *
      {
         if(zpp_inner.userData == null)
         {
            zpp_inner.userData = {};
         }
         return zpp_inner.userData;
      }
      
      public function get origin() : Vec2
      {
         return zpp_inner.origin;
      }
      
      public function get maxDistance() : Number
      {
         return zpp_inner.maxdist;
      }
      
      public function get direction() : Vec2
      {
         return zpp_inner.direction;
      }
      
      public function copy() : Ray
      {
         var _loc1_:Ray = new Ray(zpp_inner.origin,zpp_inner.direction);
         var _loc2_:Number = zpp_inner.maxdist;
         if(_loc2_ != _loc2_)
         {
            Boot.lastError = new Error();
            throw "Error: maxDistance cannot be NaN";
         }
         _loc1_.zpp_inner.maxdist = _loc2_;
         _loc1_.zpp_inner.maxdist;
         return _loc1_;
      }
      
      public function at(param1:Number, param2:Boolean = false) : Vec2
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc7_:Boolean = false;
         zpp_inner.validate_dir();
         _loc4_ = zpp_inner.origin;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = _loc4_.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc3_:Number = _loc4_.zpp_inner.x + param1 * zpp_inner.dirx;
         _loc4_ = zpp_inner.origin;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc5_ = _loc4_.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc6_:Number = _loc4_.zpp_inner.y + param1 * zpp_inner.diry;
         if(_loc3_ != _loc3_ || _loc6_ != _loc6_)
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
            _loc7_ = false;
            §§push(_loc4_);
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
            _loc5_._immutable = _loc7_;
            _loc5_.x = _loc3_;
            _loc5_.y = _loc6_;
            §§pop().zpp_inner = _loc5_;
            _loc4_.zpp_inner.outer = _loc4_;
         }
         else
         {
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc3_ != _loc3_ || _loc6_ != _loc6_)
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
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            if(_loc4_.zpp_inner.x == _loc3_)
            {
               §§pop();
               if(_loc4_ != null && _loc4_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = _loc4_.zpp_inner;
               if(_loc5_._validate != null)
               {
                  _loc5_._validate();
               }
               §§push(_loc4_.zpp_inner.y == _loc6_);
            }
            if(!§§pop())
            {
               _loc4_.zpp_inner.x = _loc3_;
               _loc4_.zpp_inner.y = _loc6_;
               _loc5_ = _loc4_.zpp_inner;
               if(_loc5_._invalidate != null)
               {
                  _loc5_._invalidate(_loc5_);
               }
            }
            _loc4_;
         }
         _loc4_.zpp_inner.weak = param2;
         return _loc4_;
      }
      
      public function aabb() : AABB
      {
         return zpp_inner.rayAABB().wrapper();
      }
   }
}
