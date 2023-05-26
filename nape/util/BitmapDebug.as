package nape.util
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.constraint.Constraint;
   import nape.geom.AABB;
   import nape.geom.GeomPoly;
   import nape.geom.Vec2;
   import nape.geom.Vec2Iterator;
   import nape.geom.Vec2List;
   import nape.phys.Body;
   import nape.phys.Compound;
   import nape.shape.Shape;
   import nape.space.Space;
   import zpp_nape.ZPP_Const;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZNPList_ZPP_Vec2;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   import zpp_nape.util.ZPP_BitmapDebug;
   import zpp_nape.util.ZPP_Debug;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class BitmapDebug extends Debug
   {
       
      
      public var zpp_inner_zn:ZPP_BitmapDebug;
      
      public function BitmapDebug(param1:int, param2:int, param3:int = 3355443, param4:Boolean = false)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner_zn = null;
         if(param1 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Debug width must be > 0";
         }
         if(param2 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Debug height must be > 0";
         }
         ZPP_Debug.§internal§ = true;
         super();
         ZPP_Debug.§internal§ = false;
         zpp_inner_zn = new ZPP_BitmapDebug(param1,param2,param3,param4);
         zpp_inner_zn.outer_zn = this;
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
      }
      
      public function prepare() : void
      {
         zpp_inner_zn.prepare();
      }
      
      override public function flush() : void
      {
         zpp_inner_zn.flush();
      }
      
      override public function drawSpring(param1:Vec2, param2:Vec2, param3:int, param4:int = 3, param5:Number = 3) : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 4337
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      override public function drawPolygon(param1:*, param2:int) : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 4374
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      override public function drawLine(param1:Vec2, param2:Vec2, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
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
            throw "Error: drawLine::start cannot be null";
         }
         if(param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawLine::end cannot be null";
         }
         if(zpp_inner.xnull)
         {
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
            _loc4_ = param1.zpp_inner.x + 0.5;
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
            _loc6_ = param1.zpp_inner.y + 0.5;
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param2.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc7_ = param2.zpp_inner.x + 0.5;
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param2.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc8_ = param2.zpp_inner.y + 0.5;
            zpp_inner_zn.__line(_loc4_,_loc6_,_loc7_,_loc8_,param3 | -16777216);
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
               _loc10_ = _loc5_;
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
               _loc5_ = param2.zpp_inner;
               if(_loc5_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc5_._isimmutable != null)
               {
                  _loc5_._isimmutable();
               }
               if(param2.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc5_ = param2.zpp_inner;
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
               _loc10_ = _loc5_;
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
         }
         else
         {
            _loc9_ = zpp_inner.xform.outer.transform(param1);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = _loc9_.zpp_inner.x + 0.5;
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = _loc9_.zpp_inner.y + 0.5;
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc9_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc9_.zpp_inner;
            _loc9_.zpp_inner.outer = null;
            _loc9_.zpp_inner = null;
            _loc11_ = _loc9_;
            _loc11_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc11_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc11_;
            }
            ZPP_PubPool.nextVec2 = _loc11_;
            _loc11_.zpp_disp = true;
            _loc10_ = _loc5_;
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
            _loc9_ = zpp_inner.xform.outer.transform(param2);
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc7_ = _loc9_.zpp_inner.x + 0.5;
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc8_ = _loc9_.zpp_inner.y + 0.5;
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc9_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc9_.zpp_inner;
            _loc9_.zpp_inner.outer = null;
            _loc9_.zpp_inner = null;
            _loc11_ = _loc9_;
            _loc11_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc11_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc11_;
            }
            ZPP_PubPool.nextVec2 = _loc11_;
            _loc11_.zpp_disp = true;
            _loc10_ = _loc5_;
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
            zpp_inner_zn.__line(_loc4_,_loc6_,_loc7_,_loc8_,param3 | -16777216);
         }
      }
      
      override public function drawFilledTriangle(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
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
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null || param2 == null || param3 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawFilledTriangle can\'t use null points";
         }
         zpp_inner_zn.__tri(param1,param2,param3,param4);
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
            _loc7_ = _loc5_;
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
         if(param2.zpp_inner.weak)
         {
            if(param2 != null && param2.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param2.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(param2.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = param2.zpp_inner;
            param2.zpp_inner.outer = null;
            param2.zpp_inner = null;
            _loc6_ = param2;
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
            _loc7_ = _loc5_;
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
         if(param3.zpp_inner.weak)
         {
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = param3.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(param3.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = param3.zpp_inner;
            param3.zpp_inner.outer = null;
            param3.zpp_inner = null;
            _loc6_ = param3;
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
            _loc7_ = _loc5_;
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
      }
      
      override public function drawFilledPolygon(param1:*, param2:int) : void
      {
         /*
          * Decompilatie fout
          * Timeout (1 minuut) werd bereikt
          * Instruction count: 4310
          */
         throw new flash.errors.IllegalOperationError("Niet gedecompileerd vanwege timeout");
      }
      
      override public function drawFilledCircle(param1:Vec2, param2:Number, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawFilledCircle::position cannot be null";
         }
         if(param2 != param2 || param2 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: drawFilledCircle::radius must be >=0";
         }
         if(zpp_inner.xnull)
         {
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
            _loc4_ = param1.zpp_inner.x + 0.5;
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
            _loc6_ = param1.zpp_inner.y + 0.5;
            _loc7_ = param2 + 0.5;
            zpp_inner_zn.__fcircle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
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
         }
         else
         {
            _loc8_ = zpp_inner.xform.outer.transform(param1);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = _loc8_.zpp_inner.x + 0.5;
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = _loc8_.zpp_inner.y + 0.5;
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc8_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc8_.zpp_inner;
            _loc8_.zpp_inner.outer = null;
            _loc8_.zpp_inner = null;
            _loc10_ = _loc8_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
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
            _loc7_ = param2 * zpp_inner.xdet + 0.5;
            zpp_inner_zn.__fcircle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
         }
      }
      
      override public function drawCurve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
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
         if(param3 != null && param3.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCurve::start cannot be null";
         }
         if(param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCurve::control cannot be null";
         }
         if(param3 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCurve::end cannot be null";
         }
         if(zpp_inner.xnull)
         {
            zpp_inner_zn.__curve(param1,param2,param3,param4);
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
               _loc7_ = _loc5_;
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
            if(param2.zpp_inner.weak)
            {
               if(param2 != null && param2.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = param2.zpp_inner;
               if(_loc5_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc5_._isimmutable != null)
               {
                  _loc5_._isimmutable();
               }
               if(param2.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc5_ = param2.zpp_inner;
               param2.zpp_inner.outer = null;
               param2.zpp_inner = null;
               _loc6_ = param2;
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
               _loc7_ = _loc5_;
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
            if(param3.zpp_inner.weak)
            {
               if(param3 != null && param3.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc5_ = param3.zpp_inner;
               if(_loc5_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc5_._isimmutable != null)
               {
                  _loc5_._isimmutable();
               }
               if(param3.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc5_ = param3.zpp_inner;
               param3.zpp_inner.outer = null;
               param3.zpp_inner = null;
               _loc6_ = param3;
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
               _loc7_ = _loc5_;
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
         }
         else
         {
            _loc6_ = zpp_inner.xform.outer.transform(param1);
            _loc8_ = zpp_inner.xform.outer.transform(param2);
            _loc9_ = zpp_inner.xform.outer.transform(param3);
            zpp_inner_zn.__curve(_loc6_,_loc8_,_loc9_,param4);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc6_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc6_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc6_.zpp_inner;
            _loc6_.zpp_inner.outer = null;
            _loc6_.zpp_inner = null;
            _loc10_ = _loc6_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
            _loc7_ = _loc5_;
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
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc8_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc8_.zpp_inner;
            _loc8_.zpp_inner.outer = null;
            _loc8_.zpp_inner = null;
            _loc10_ = _loc8_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
            _loc7_ = _loc5_;
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
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc9_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc9_.zpp_inner;
            _loc9_.zpp_inner.outer = null;
            _loc9_.zpp_inner = null;
            _loc10_ = _loc9_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
            _loc7_ = _loc5_;
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
      }
      
      override public function drawCircle(param1:Vec2, param2:Number, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as Vec2;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawCircle::position cannot be null";
         }
         if(param2 != param2 || param2 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: drawCircle::radius must be >=0";
         }
         if(zpp_inner.xnull)
         {
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
            _loc4_ = param1.zpp_inner.x + 0.5;
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
            _loc6_ = param1.zpp_inner.y + 0.5;
            _loc7_ = param2 + 0.5;
            zpp_inner_zn.__circle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
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
         }
         else
         {
            _loc8_ = zpp_inner.xform.outer.transform(param1);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = _loc8_.zpp_inner.x + 0.5;
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = _loc8_.zpp_inner.y + 0.5;
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc5_._isimmutable != null)
            {
               _loc5_._isimmutable();
            }
            if(_loc8_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc5_ = _loc8_.zpp_inner;
            _loc8_.zpp_inner.outer = null;
            _loc8_.zpp_inner = null;
            _loc10_ = _loc8_;
            _loc10_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc10_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc10_;
            }
            ZPP_PubPool.nextVec2 = _loc10_;
            _loc10_.zpp_disp = true;
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
            _loc7_ = param2 * zpp_inner.xdet + 0.5;
            zpp_inner_zn.__circle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
         }
      }
      
      override public function drawAABB(param1:AABB, param2:int) : void
      {
         var _loc3_:* = null as Vec2;
         var _loc4_:* = null as Vec2;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_AABB;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as Vec2;
         var _loc9_:Boolean = false;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as Vec2;
         var _loc12_:* = null as Vec2;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:* = null as Vec2;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:int = 0;
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: drawAABB::aabb cannot be null";
         }
         if(zpp_inner.xnull)
         {
            zpp_inner_zn.__aabb(param1.zpp_inner,param2);
         }
         else
         {
            _loc3_ = zpp_inner.xform.outer.transform(param1.zpp_inner.getmin());
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc6_ = param1.zpp_inner;
            _loc5_ = _loc6_.maxx - _loc6_.minx;
            _loc7_ = false;
            if(_loc5_ != _loc5_)
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
                  _loc10_ = new ZPP_Vec2();
               }
               else
               {
                  _loc10_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc10_.next;
                  _loc10_.next = null;
               }
               _loc10_.weak = false;
               _loc10_._immutable = _loc9_;
               _loc10_.x = _loc5_;
               _loc10_.y = 0;
               §§pop().zpp_inner = _loc10_;
               _loc8_.zpp_inner.outer = _loc8_;
            }
            else
            {
               if(_loc8_ != null && _loc8_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc8_.zpp_inner;
               if(_loc10_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc10_._isimmutable != null)
               {
                  _loc10_._isimmutable();
               }
               if(_loc5_ != _loc5_)
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
               _loc10_ = _loc8_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               if(_loc8_.zpp_inner.x == _loc5_)
               {
                  §§pop();
                  if(_loc8_ != null && _loc8_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc10_ = _loc8_.zpp_inner;
                  if(_loc10_._validate != null)
                  {
                     _loc10_._validate();
                  }
                  §§push(_loc8_.zpp_inner.y == 0);
               }
               if(!§§pop())
               {
                  _loc8_.zpp_inner.x = _loc5_;
                  _loc8_.zpp_inner.y = 0;
                  _loc10_ = _loc8_.zpp_inner;
                  if(_loc10_._invalidate != null)
                  {
                     _loc10_._invalidate(_loc10_);
                  }
               }
               _loc8_;
            }
            _loc8_.zpp_inner.weak = _loc7_;
            _loc4_ = _loc8_;
            _loc8_ = zpp_inner.xform.outer.transform(_loc4_,true);
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc6_ = param1.zpp_inner;
            _loc5_ = _loc6_.maxy - _loc6_.miny;
            _loc7_ = false;
            if(_loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc12_ = new Vec2();
            }
            else
            {
               _loc12_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc12_.zpp_pool;
               _loc12_.zpp_pool = null;
               _loc12_.zpp_disp = false;
               if(_loc12_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc12_.zpp_inner == null)
            {
               _loc9_ = false;
               §§push(_loc12_);
               if(ZPP_Vec2.zpp_pool == null)
               {
                  _loc10_ = new ZPP_Vec2();
               }
               else
               {
                  _loc10_ = ZPP_Vec2.zpp_pool;
                  ZPP_Vec2.zpp_pool = _loc10_.next;
                  _loc10_.next = null;
               }
               _loc10_.weak = false;
               _loc10_._immutable = _loc9_;
               _loc10_.x = 0;
               _loc10_.y = _loc5_;
               §§pop().zpp_inner = _loc10_;
               _loc12_.zpp_inner.outer = _loc12_;
            }
            else
            {
               if(_loc12_ != null && _loc12_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc12_.zpp_inner;
               if(_loc10_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc10_._isimmutable != null)
               {
                  _loc10_._isimmutable();
               }
               if(_loc5_ != _loc5_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc12_ != null && _loc12_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc12_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               if(_loc12_.zpp_inner.x == 0)
               {
                  §§pop();
                  if(_loc12_ != null && _loc12_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc10_ = _loc12_.zpp_inner;
                  if(_loc10_._validate != null)
                  {
                     _loc10_._validate();
                  }
                  §§push(_loc12_.zpp_inner.y == _loc5_);
               }
               if(!§§pop())
               {
                  _loc12_.zpp_inner.x = 0;
                  _loc12_.zpp_inner.y = _loc5_;
                  _loc10_ = _loc12_.zpp_inner;
                  if(_loc10_._invalidate != null)
                  {
                     _loc10_._invalidate(_loc10_);
                  }
               }
               _loc12_;
            }
            _loc12_.zpp_inner.weak = _loc7_;
            _loc11_ = _loc12_;
            _loc12_ = zpp_inner.xform.outer.transform(_loc11_,true);
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc13_ = _loc3_.zpp_inner.x + 0.5;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc14_ = _loc3_.zpp_inner.y + 0.5;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.x);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc15_ = §§pop() + _loc8_.zpp_inner.x + 0.5;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.y);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc16_ = §§pop() + _loc8_.zpp_inner.y + 0.5;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.x);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(§§pop() + _loc8_.zpp_inner.x);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc17_ = §§pop() + _loc12_.zpp_inner.x + 0.5;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.y);
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(§§pop() + _loc8_.zpp_inner.y);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc18_ = §§pop() + _loc12_.zpp_inner.y + 0.5;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.x);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc19_ = §§pop() + _loc12_.zpp_inner.x + 0.5;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§push(_loc3_.zpp_inner.y);
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc20_ = §§pop() + _loc12_.zpp_inner.y + 0.5;
            if(_loc3_ != null && _loc3_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc3_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc3_.zpp_inner;
            _loc3_.zpp_inner.outer = null;
            _loc3_.zpp_inner = null;
            _loc21_ = _loc3_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
            if(_loc4_ != null && _loc4_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc4_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc4_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc4_.zpp_inner;
            _loc4_.zpp_inner.outer = null;
            _loc4_.zpp_inner = null;
            _loc21_ = _loc4_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc8_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc8_.zpp_inner;
            _loc8_.zpp_inner.outer = null;
            _loc8_.zpp_inner = null;
            _loc21_ = _loc8_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
            if(_loc11_ != null && _loc11_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc11_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc11_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc11_.zpp_inner;
            _loc11_.zpp_inner.outer = null;
            _loc11_.zpp_inner = null;
            _loc21_ = _loc11_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc12_.zpp_inner;
            if(_loc10_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc10_._isimmutable != null)
            {
               _loc10_._isimmutable();
            }
            if(_loc12_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc10_ = _loc12_.zpp_inner;
            _loc12_.zpp_inner.outer = null;
            _loc12_.zpp_inner = null;
            _loc21_ = _loc12_;
            _loc21_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc21_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc21_;
            }
            ZPP_PubPool.nextVec2 = _loc21_;
            _loc21_.zpp_disp = true;
            _loc22_ = _loc10_;
            if(_loc22_.outer != null)
            {
               _loc22_.outer.zpp_inner = null;
               _loc22_.outer = null;
            }
            _loc22_._isimmutable = null;
            _loc22_._validate = null;
            _loc22_._invalidate = null;
            _loc22_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc22_;
            _loc23_ = param2 | -16777216;
            zpp_inner_zn.__line(_loc13_,_loc14_,_loc15_,_loc16_,_loc23_);
            zpp_inner_zn.__line(_loc15_,_loc16_,_loc17_,_loc18_,_loc23_);
            zpp_inner_zn.__line(_loc17_,_loc18_,_loc19_,_loc20_,_loc23_);
            zpp_inner_zn.__line(_loc19_,_loc20_,_loc13_,_loc14_,_loc23_);
         }
      }
      
      override public function draw(param1:*) : void
      {
         if(zpp_inner.xform != null && !zpp_inner.xform.outer.equiorthogonal())
         {
            Boot.lastError = new Error();
            throw "Error: Debug draw can only operate with an equiorthogonal transform!";
         }
         if(zpp_inner.xnull)
         {
            if(param1 is Space)
            {
               zpp_inner_zn.draw_space(param1.zpp_inner,null,1,true);
            }
            else if(param1 is Compound)
            {
               zpp_inner_zn.draw_compound(param1.zpp_inner,null,1,true);
            }
            else if(param1 is Body)
            {
               zpp_inner_zn.draw_body(param1.zpp_inner,null,1,true);
            }
            else if(param1 is Shape)
            {
               zpp_inner_zn.draw_shape(param1.zpp_inner,null,1,true);
            }
            else
            {
               if(!(param1 is Constraint))
               {
                  Boot.lastError = new Error();
                  throw "Error: Unhandled object type for Debug draw";
               }
               param1.zpp_inner.draw(this);
            }
         }
         else if(param1 is Space)
         {
            zpp_inner_zn.draw_space(param1.zpp_inner,zpp_inner.xform,zpp_inner.xdet,false);
         }
         else if(param1 is Body)
         {
            zpp_inner_zn.draw_body(param1.zpp_inner,zpp_inner.xform,zpp_inner.xdet,false);
         }
         else if(param1 is Shape)
         {
            zpp_inner_zn.draw_shape(param1.zpp_inner,zpp_inner.xform,zpp_inner.xdet,false);
         }
         else
         {
            if(!(param1 is Constraint))
            {
               Boot.lastError = new Error();
               throw "Error: Unhandled object type for Debug draw";
            }
            param1.zpp_inner.draw(this);
         }
      }
      
      override public function clear() : void
      {
         zpp_inner_zn.clear();
      }
   }
}
