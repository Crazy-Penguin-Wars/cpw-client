package zpp_nape.geom
{
   import flash.Boot;
   import nape.geom.AABB;
   import nape.geom.Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_AABB
   {
      
      public static var zpp_pool:ZPP_AABB = null;
       
      
      public var wrap_min:Vec2;
      
      public var wrap_max:Vec2;
      
      public var outer:AABB;
      
      public var next:ZPP_AABB;
      
      public var miny:Number;
      
      public var minx:Number;
      
      public var maxy:Number;
      
      public var maxx:Number;
      
      public var _validate:Object;
      
      public var _invalidate:Object;
      
      public var _immutable:Boolean;
      
      public function ZPP_AABB()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         wrap_max = null;
         maxy = 0;
         maxx = 0;
         wrap_min = null;
         miny = 0;
         minx = 0;
         next = null;
         outer = null;
         _immutable = false;
         _validate = null;
         _invalidate = null;
      }
      
      public static function get(param1:Number, param2:Number, param3:Number, param4:Number) : ZPP_AABB
      {
         var _loc5_:* = null as ZPP_AABB;
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
         _loc5_.maxx = param3;
         _loc5_.maxy = param4;
         return _loc5_;
      }
      
      public function wrapper() : AABB
      {
         var _loc1_:* = null as ZPP_AABB;
         var _loc2_:* = null as Vec2;
         if(outer == null)
         {
            outer = new AABB();
            _loc1_ = outer.zpp_inner;
            if(_loc1_.outer != null)
            {
               _loc1_.outer.zpp_inner = null;
               _loc1_.outer = null;
            }
            _loc1_.wrap_min = _loc1_.wrap_max = null;
            _loc1_._invalidate = null;
            _loc1_._validate = null;
            _loc1_.next = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc1_;
            outer.zpp_inner = this;
         }
         return outer;
      }
      
      public function toString() : String
      {
         return "{ x: " + minx + " y: " + miny + " w: " + (maxx - minx) + " h: " + (maxy - miny) + " }";
      }
      
      public function mod_min(param1:ZPP_Vec2) : void
      {
         if(param1.x != minx || param1.y != miny)
         {
            minx = param1.x;
            miny = param1.y;
            if(_invalidate != null)
            {
               _invalidate(this);
            }
         }
      }
      
      public function mod_max(param1:ZPP_Vec2) : void
      {
         if(param1.x != maxx || param1.y != maxy)
         {
            maxx = param1.x;
            maxy = param1.y;
            if(_invalidate != null)
            {
               _invalidate(this);
            }
         }
      }
      
      public function getmin() : Vec2
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         if(wrap_min == null)
         {
            _loc1_ = minx;
            _loc2_ = miny;
            _loc3_ = false;
            §§push(§§findproperty(wrap_min));
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
            _loc4_.zpp_inner.weak = _loc3_;
            §§pop().wrap_min = _loc4_;
            wrap_min.zpp_inner._inuse = true;
            if(_immutable)
            {
               wrap_min.zpp_inner._immutable = true;
            }
            else
            {
               wrap_min.zpp_inner._invalidate = mod_min;
            }
            wrap_min.zpp_inner._validate = dom_min;
         }
         return wrap_min;
      }
      
      public function getmax() : Vec2
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         if(wrap_max == null)
         {
            _loc1_ = maxx;
            _loc2_ = maxy;
            _loc3_ = false;
            §§push(§§findproperty(wrap_max));
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
            _loc4_.zpp_inner.weak = _loc3_;
            §§pop().wrap_max = _loc4_;
            wrap_max.zpp_inner._inuse = true;
            if(_immutable)
            {
               wrap_max.zpp_inner._immutable = true;
            }
            else
            {
               wrap_max.zpp_inner._invalidate = mod_max;
            }
            wrap_max.zpp_inner._validate = dom_max;
         }
         return wrap_max;
      }
      
      public function dom_min() : void
      {
         if(_validate != null)
         {
            _validate();
         }
         wrap_min.zpp_inner.x = minx;
         wrap_min.zpp_inner.y = miny;
      }
      
      public function dom_max() : void
      {
         if(_validate != null)
         {
            _validate();
         }
         wrap_max.zpp_inner.x = maxx;
         wrap_max.zpp_inner.y = maxy;
      }
   }
}
