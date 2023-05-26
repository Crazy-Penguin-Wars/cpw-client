package nape.geom
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_GeomVertexIterator;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public class GeomVertexIterator
   {
       
      
      public var zpp_inner:ZPP_GeomVertexIterator;
      
      public function GeomVertexIterator()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_GeomVertexIterator.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate GeomVertexIterator";
         }
      }
      
      public function next() : Vec2
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as Vec2;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as ZPP_Vec2;
         if(zpp_inner == null)
         {
            Boot.lastError = new Error();
            throw "Error: Iterator has been disposed";
         }
         var _loc2_:ZPP_GeomVert = zpp_inner.ptr;
         if(_loc2_.wrap == null)
         {
            _loc3_ = _loc2_.x;
            _loc4_ = _loc2_.y;
            _loc5_ = false;
            §§push(_loc2_);
            if(_loc3_ != _loc3_ || _loc4_ != _loc4_)
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
               _loc8_.x = _loc3_;
               _loc8_.y = _loc4_;
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
               if(_loc3_ != _loc3_ || _loc4_ != _loc4_)
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
               if(_loc6_.zpp_inner.x == _loc3_)
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
                  §§push(_loc6_.zpp_inner.y == _loc4_);
               }
               if(!§§pop())
               {
                  _loc6_.zpp_inner.x = _loc3_;
                  _loc6_.zpp_inner.y = _loc4_;
                  _loc8_ = _loc6_.zpp_inner;
                  if(_loc8_._invalidate != null)
                  {
                     _loc8_._invalidate(_loc8_);
                  }
               }
               _loc6_;
            }
            _loc6_.zpp_inner.weak = _loc5_;
            §§pop().wrap = _loc6_;
            _loc2_.wrap.zpp_inner._inuse = true;
            _loc2_.wrap.zpp_inner._invalidate = _loc2_.modwrap;
            _loc2_.wrap.zpp_inner._validate = _loc2_.getwrap;
         }
         var _loc1_:Vec2 = _loc2_.wrap;
         zpp_inner.ptr = zpp_inner.forward ? zpp_inner.ptr.next : zpp_inner.ptr.prev;
         return _loc1_;
      }
      
      public function hasNext() : Boolean
      {
         var _loc2_:* = null as ZPP_GeomVertexIterator;
         var _loc3_:* = null as ZPP_GeomVert;
         if(zpp_inner == null)
         {
            Boot.lastError = new Error();
            throw "Error: Iterator has been disposed";
         }
         var _loc1_:Boolean = zpp_inner.ptr != zpp_inner.start || zpp_inner.first;
         zpp_inner.first = false;
         if(!_loc1_)
         {
            _loc2_ = zpp_inner;
            _loc2_.outer.zpp_inner = null;
            _loc2_.ptr = _loc2_.start = null;
            _loc2_.next = ZPP_GeomVertexIterator.zpp_pool;
            ZPP_GeomVertexIterator.zpp_pool = _loc2_;
         }
         return _loc1_;
      }
   }
}
