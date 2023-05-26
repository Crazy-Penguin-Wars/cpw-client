package zpp_nape.geom
{
   import flash.Boot;
   import nape.geom.ConvexResult;
   import nape.geom.RayResult;
   import nape.geom.Vec2;
   import nape.shape.Shape;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_ConvexRayResult
   {
      
      public static var convexPool:ZPP_ConvexRayResult = null;
      
      public static var rayPool:ZPP_ConvexRayResult = null;
      
      public static var §internal§:Boolean = false;
       
      
      public var toiDistance:Number;
      
      public var shape:Shape;
      
      public var ray:RayResult;
      
      public var position:Vec2;
      
      public var normal:Vec2;
      
      public var next:ZPP_ConvexRayResult;
      
      public var inner:Boolean;
      
      public var convex:ConvexResult;
      
      public function ZPP_ConvexRayResult()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         toiDistance = 0;
         next = null;
         inner = false;
         ray = null;
         position = null;
         convex = null;
         shape = null;
         normal = null;
      }
      
      public static function getRay(param1:Vec2, param2:Number, param3:Boolean, param4:Shape) : RayResult
      {
         var _loc5_:* = null as RayResult;
         if(ZPP_ConvexRayResult.rayPool == null)
         {
            ZPP_ConvexRayResult.§internal§ = true;
            _loc5_ = new RayResult();
            _loc5_.zpp_inner = new ZPP_ConvexRayResult();
            _loc5_.zpp_inner.ray = _loc5_;
            ZPP_ConvexRayResult.§internal§ = false;
         }
         else
         {
            _loc5_ = ZPP_ConvexRayResult.rayPool.ray;
            ZPP_ConvexRayResult.rayPool = ZPP_ConvexRayResult.rayPool.next;
            _loc5_.zpp_inner.next = null;
         }
         var _loc6_:ZPP_ConvexRayResult = _loc5_.zpp_inner;
         _loc6_.normal = param1;
         param1.zpp_inner._immutable = true;
         _loc6_.toiDistance = param2;
         _loc6_.inner = param3;
         _loc6_.shape = param4;
         return _loc5_;
      }
      
      public static function getConvex(param1:Vec2, param2:Vec2, param3:Number, param4:Shape) : ConvexResult
      {
         var _loc5_:* = null as ConvexResult;
         if(ZPP_ConvexRayResult.convexPool == null)
         {
            ZPP_ConvexRayResult.§internal§ = true;
            _loc5_ = new ConvexResult();
            _loc5_.zpp_inner = new ZPP_ConvexRayResult();
            _loc5_.zpp_inner.convex = _loc5_;
            ZPP_ConvexRayResult.§internal§ = false;
         }
         else
         {
            _loc5_ = ZPP_ConvexRayResult.convexPool.convex;
            ZPP_ConvexRayResult.convexPool = ZPP_ConvexRayResult.convexPool.next;
            _loc5_.zpp_inner.next = null;
         }
         var _loc6_:ZPP_ConvexRayResult = _loc5_.zpp_inner;
         _loc6_.normal = param1;
         _loc6_.position = param2;
         param1.zpp_inner._immutable = true;
         param2.zpp_inner._immutable = true;
         _loc6_.toiDistance = param3;
         _loc6_.shape = param4;
         return _loc5_;
      }
      
      public function free() : void
      {
         var _loc1_:* = null as Vec2;
         var _loc2_:* = null as ZPP_Vec2;
         var _loc3_:* = null as Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         normal.zpp_inner._immutable = false;
         _loc1_ = normal;
         if(_loc1_ != null && _loc1_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc2_ = _loc1_.zpp_inner;
         if(_loc2_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc2_._isimmutable != null)
         {
            _loc2_._isimmutable();
         }
         if(_loc1_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc2_ = _loc1_.zpp_inner;
         _loc1_.zpp_inner.outer = null;
         _loc1_.zpp_inner = null;
         _loc3_ = _loc1_;
         _loc3_.zpp_pool = null;
         if(ZPP_PubPool.nextVec2 != null)
         {
            ZPP_PubPool.nextVec2.zpp_pool = _loc3_;
         }
         else
         {
            ZPP_PubPool.poolVec2 = _loc3_;
         }
         ZPP_PubPool.nextVec2 = _loc3_;
         _loc3_.zpp_disp = true;
         _loc4_ = _loc2_;
         if(_loc4_.outer != null)
         {
            _loc4_.outer.zpp_inner = null;
            _loc4_.outer = null;
         }
         _loc4_._isimmutable = null;
         _loc4_._validate = null;
         _loc4_._invalidate = null;
         _loc4_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc4_;
         if(position != null)
         {
            position.zpp_inner._immutable = false;
            _loc1_ = position;
            if(_loc1_ != null && _loc1_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc2_ = _loc1_.zpp_inner;
            if(_loc2_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc2_._isimmutable != null)
            {
               _loc2_._isimmutable();
            }
            if(_loc1_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc2_ = _loc1_.zpp_inner;
            _loc1_.zpp_inner.outer = null;
            _loc1_.zpp_inner = null;
            _loc3_ = _loc1_;
            _loc3_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc3_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc3_;
            }
            ZPP_PubPool.nextVec2 = _loc3_;
            _loc3_.zpp_disp = true;
            _loc4_ = _loc2_;
            if(_loc4_.outer != null)
            {
               _loc4_.outer.zpp_inner = null;
               _loc4_.outer = null;
            }
            _loc4_._isimmutable = null;
            _loc4_._validate = null;
            _loc4_._invalidate = null;
            _loc4_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc4_;
         }
         shape = null;
         toiDistance = 0;
         if(convex != null)
         {
            next = ZPP_ConvexRayResult.convexPool;
            ZPP_ConvexRayResult.convexPool = this;
         }
         else
         {
            next = ZPP_ConvexRayResult.rayPool;
            ZPP_ConvexRayResult.rayPool = this;
         }
      }
   }
}
