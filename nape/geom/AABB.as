package nape.geom
{
   import flash.Boot;
   import flash.geom.Rectangle;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class AABB
   {
       
      
      public var zpp_inner:ZPP_AABB;
      
      public function AABB(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
      {
         var _loc5_:* = null as ZPP_AABB;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         if(param1 != param1 || param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: AABB position cannot be NaN";
         }
         if(param3 != param3 || param4 != param4)
         {
            Boot.lastError = new Error();
            throw "Error: AABB dimensions cannot be NaN";
         }
         §§push(§§findproperty(zpp_inner));
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc5_ = new ZPP_AABB();
         }
         else
         {
            _loc5_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc5_.next;
            _loc5_.next = null;
         }
         _loc5_.minx = param1;
         _loc5_.miny = param2;
         _loc5_.maxx = param1 + param3;
         _loc5_.maxy = param2 + param4;
         §§pop().zpp_inner = _loc5_;
         zpp_inner.outer = this;
      }
      
      public static function fromRect(param1:Rectangle) : AABB
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot create AABB from null Rectangle";
         }
         return new AABB(param1.x,param1.y,param1.width,param1.height);
      }
      
      public function toString() : String
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.toString();
      }
      
      public function toRect() : Rectangle
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         §§push(§§findproperty(Rectangle));
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(zpp_inner.minx);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(zpp_inner.miny);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         _loc1_ = zpp_inner;
         §§push(_loc1_.maxx - _loc1_.minx);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         return new §§pop().Rectangle(§§pop(),§§pop(),§§pop(),_loc1_.maxy - _loc1_.miny);
      }
      
      public function set y(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_AABB;
         if(zpp_inner._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: AABB is immutable";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.miny != param1)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: AABB::" + "y" + " cannot be NaN";
            }
            zpp_inner.maxy += param1 - zpp_inner.miny;
            zpp_inner.miny = param1;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.miny;
      }
      
      public function set x(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_AABB;
         if(zpp_inner._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: AABB is immutable";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.minx != param1)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: AABB::" + "x" + " cannot be NaN";
            }
            zpp_inner.maxx += param1 - zpp_inner.minx;
            zpp_inner.minx = param1;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.minx;
      }
      
      public function set width(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_AABB;
         if(zpp_inner._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: AABB is immutable";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         if(_loc2_.maxx - _loc2_.minx != param1)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: AABB::" + "width" + " cannot be NaN";
            }
            if(param1 < 0)
            {
               Boot.lastError = new Error();
               throw "Error: AABB::" + "width" + " (" + param1 + ") must be >= 0";
            }
            _loc2_ = zpp_inner;
            §§push(zpp_inner);
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§pop().maxx = zpp_inner.minx + param1;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         return _loc2_.maxx - _loc2_.minx;
      }
      
      public function set min(param1:Vec2) : Vec2
      {
         var _loc2_:* = null as ZPP_AABB;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_inner._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: AABB is immutable";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null to AABB::" + "min";
         }
         _loc2_ = zpp_inner;
         §§push(true);
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         §§push(zpp_inner.minx);
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(§§pop() == zpp_inner.minx)
         {
            §§pop();
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            _loc2_ = zpp_inner;
            §§push(zpp_inner.miny);
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(§§pop() != zpp_inner.miny);
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: AABB::" + "min" + " components cannot be NaN";
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
         var _loc4_:Vec2 = zpp_inner.getmax();
         §§push(param1.zpp_inner.x);
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(§§pop() > _loc4_.zpp_inner.x)
         {
            Boot.lastError = new Error();
            throw "Error: Assignment would cause negative width";
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
         _loc4_ = zpp_inner.getmax();
         §§push(param1.zpp_inner.y);
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(§§pop() > _loc4_.zpp_inner.y)
         {
            Boot.lastError = new Error();
            throw "Error: Assignment would cause negative height";
         }
         _loc4_ = zpp_inner.getmin();
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
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
         var _loc6_:Number = param1.zpp_inner.x;
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
         var _loc7_:Number = param1.zpp_inner.y;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
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
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(_loc4_.zpp_inner.x == _loc6_)
         {
            §§pop();
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = _loc4_.zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(_loc4_.zpp_inner.y == _loc7_);
         }
         if(!§§pop())
         {
            _loc4_.zpp_inner.x = _loc6_;
            _loc4_.zpp_inner.y = _loc7_;
            _loc3_ = _loc4_.zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         var _loc5_:Vec2 = _loc4_;
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
            _loc9_ = _loc3_;
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
         return zpp_inner.getmin();
      }
      
      public function set max(param1:Vec2) : Vec2
      {
         var _loc2_:* = null as ZPP_AABB;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_inner._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: AABB is immutable";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null to AABB::" + "max";
         }
         _loc2_ = zpp_inner;
         §§push(true);
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         §§push(zpp_inner.minx);
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(§§pop() == zpp_inner.minx)
         {
            §§pop();
            _loc2_ = zpp_inner;
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            _loc2_ = zpp_inner;
            §§push(zpp_inner.miny);
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§push(§§pop() != zpp_inner.miny);
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: AABB::" + "max" + " components cannot be NaN";
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
         var _loc4_:Vec2 = zpp_inner.getmin();
         §§push(param1.zpp_inner.x);
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(§§pop() < _loc4_.zpp_inner.x)
         {
            Boot.lastError = new Error();
            throw "Error: Assignment would cause negative width";
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
         _loc4_ = zpp_inner.getmin();
         §§push(param1.zpp_inner.y);
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(§§pop() < _loc4_.zpp_inner.y)
         {
            Boot.lastError = new Error();
            throw "Error: Assignment would cause negative height";
         }
         _loc4_ = zpp_inner.getmax();
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
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
         var _loc6_:Number = param1.zpp_inner.x;
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
         var _loc7_:Number = param1.zpp_inner.y;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
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
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(_loc4_.zpp_inner.x == _loc6_)
         {
            §§pop();
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = _loc4_.zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(_loc4_.zpp_inner.y == _loc7_);
         }
         if(!§§pop())
         {
            _loc4_.zpp_inner.x = _loc6_;
            _loc4_.zpp_inner.y = _loc7_;
            _loc3_ = _loc4_.zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         var _loc5_:Vec2 = _loc4_;
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
            _loc9_ = _loc3_;
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
         return zpp_inner.getmax();
      }
      
      public function set height(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_AABB;
         if(zpp_inner._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: AABB is immutable";
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         if(_loc2_.maxy - _loc2_.miny != param1)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: AABB::" + "height" + " cannot be NaN";
            }
            if(param1 < 0)
            {
               Boot.lastError = new Error();
               throw "Error: AABB::" + "height" + " (" + param1 + ") must be >= 0";
            }
            _loc2_ = zpp_inner;
            §§push(zpp_inner);
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§pop().maxy = zpp_inner.miny + param1;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         return _loc2_.maxy - _loc2_.miny;
      }
      
      public function get y() : Number
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.miny;
      }
      
      public function get x() : Number
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.minx;
      }
      
      public function get width() : Number
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         return _loc1_.maxx - _loc1_.minx;
      }
      
      public function get min() : Vec2
      {
         return zpp_inner.getmin();
      }
      
      public function get max() : Vec2
      {
         return zpp_inner.getmax();
      }
      
      public function get height() : Number
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         return _loc1_.maxy - _loc1_.miny;
      }
      
      public function copy() : AABB
      {
         var _loc2_:* = null as ZPP_AABB;
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc2_ = new ZPP_AABB();
         }
         else
         {
            _loc2_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         _loc2_.minx = _loc1_.minx;
         _loc2_.miny = _loc1_.miny;
         _loc2_.maxx = _loc1_.maxx;
         _loc2_.maxy = _loc1_.maxy;
         return _loc2_.wrapper();
      }
   }
}
