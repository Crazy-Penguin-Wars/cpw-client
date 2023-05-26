package nape.constraint
{
   import flash.Boot;
   import nape.geom.MatMN;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.space.Space;
   import zpp_nape.constraint.ZPP_PivotJoint;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class PivotJoint extends Constraint
   {
       
      
      public var zpp_inner_zn:ZPP_PivotJoint;
      
      public function PivotJoint(param1:Body, param2:Body, param3:Vec2, param4:Vec2)
      {
         var _loc6_:* = null;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc13_:* = null as Vec2;
         var _loc14_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner_zn = null;
         zpp_inner_zn = new ZPP_PivotJoint();
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
         zpp_inner_zn.outer_zn = this;
         try
         {
            super();
         }
         catch(_loc_e_:*)
         {
            zpp_inner.immutable_midstep("Constraint::" + "body1");
            var _loc7_:ZPP_Body = param1 == null ? null : param1.zpp_inner;
            if(_loc7_ != zpp_inner_zn.b1)
            {
               if(zpp_inner_zn.b1 != null)
               {
                  if(false)
                  {
                     if(zpp_inner_zn.b1 != null)
                     {
                        zpp_inner_zn.b1.constraints.remove(zpp_inner);
                     }
                  }
                  if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
                  {
                     zpp_inner_zn.b1.wake();
                  }
               }
               zpp_inner_zn.b1 = _loc7_;
               if(false && zpp_inner_zn.b2 != _loc7_)
               {
                  if(_loc7_ != null)
                  {
                     _loc7_.constraints.add(zpp_inner);
                  }
               }
               if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
               {
                  zpp_inner.wake();
                  if(_loc7_ != null)
                  {
                     _loc7_.wake();
                  }
               }
            }
            if(zpp_inner_zn.b1 != null)
            {
               zpp_inner_zn.b1.outer;
            }
            zpp_inner.immutable_midstep("Constraint::" + "body2");
            _loc7_ = param2 == null ? null : param2.zpp_inner;
            if(_loc7_ != zpp_inner_zn.b2)
            {
               if(zpp_inner_zn.b2 != null)
               {
                  if(false)
                  {
                     if(zpp_inner_zn.b2 != null)
                     {
                        zpp_inner_zn.b2.constraints.remove(zpp_inner);
                     }
                  }
                  if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
                  {
                     zpp_inner_zn.b2.wake();
                  }
               }
               zpp_inner_zn.b2 = _loc7_;
               if(false && zpp_inner_zn.b1 != _loc7_)
               {
                  if(_loc7_ != null)
                  {
                     _loc7_.constraints.add(zpp_inner);
                  }
               }
               if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
               {
                  zpp_inner.wake();
                  if(_loc7_ != null)
                  {
                     _loc7_.wake();
                  }
               }
            }
            if(zpp_inner_zn.b2 != null)
            {
               zpp_inner_zn.b2.outer;
            }
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(param3 == null)
            {
               Boot.lastError = new Error();
               throw "Error: Constraint::" + "anchor1" + " cannot be null";
            }
            if(zpp_inner_zn.wrap_a1 == null)
            {
               zpp_inner_zn.setup_a1();
            }
            var _loc8_:Vec2 = zpp_inner_zn.wrap_a1;
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc9_ = _loc8_.zpp_inner;
            if(_loc9_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc9_._isimmutable != null)
            {
               _loc9_._isimmutable();
            }
            if(param3 == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot assign null Vec2";
            }
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc9_ = param3.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            var _loc11_:Number = param3.zpp_inner.x;
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc9_ = param3.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            var _loc12_:Number = param3.zpp_inner.y;
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc9_ = _loc8_.zpp_inner;
            if(_loc9_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc9_._isimmutable != null)
            {
               _loc9_._isimmutable();
            }
            if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
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
            _loc9_ = _loc8_.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            if(_loc8_.zpp_inner.x == _loc11_)
            {
               §§pop();
               if(_loc8_ != null && _loc8_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc9_ = _loc8_.zpp_inner;
               if(_loc9_._validate != null)
               {
                  _loc9_._validate();
               }
               §§push(_loc8_.zpp_inner.y == _loc12_);
            }
            if(!§§pop())
            {
               _loc8_.zpp_inner.x = _loc11_;
               _loc8_.zpp_inner.y = _loc12_;
               _loc9_ = _loc8_.zpp_inner;
               if(_loc9_._invalidate != null)
               {
                  _loc9_._invalidate(_loc9_);
               }
            }
            var _loc10_:Vec2 = _loc8_;
            if(param3.zpp_inner.weak)
            {
               if(param3 != null && param3.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc9_ = param3.zpp_inner;
               if(_loc9_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc9_._isimmutable != null)
               {
                  _loc9_._isimmutable();
               }
               if(param3.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc9_ = param3.zpp_inner;
               param3.zpp_inner.outer = null;
               param3.zpp_inner = null;
               _loc13_ = param3;
               _loc13_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc13_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc13_;
               }
               ZPP_PubPool.nextVec2 = _loc13_;
               _loc13_.zpp_disp = true;
               _loc14_ = _loc9_;
               if(_loc14_.outer != null)
               {
                  _loc14_.outer.zpp_inner = null;
                  _loc14_.outer = null;
               }
               _loc14_._isimmutable = null;
               _loc14_._validate = null;
               _loc14_._invalidate = null;
               _loc14_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc14_;
            }
            _loc10_;
            if(zpp_inner_zn.wrap_a1 == null)
            {
               zpp_inner_zn.setup_a1();
            }
            zpp_inner_zn.wrap_a1;
            if(param4 != null && param4.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(param4 == null)
            {
               Boot.lastError = new Error();
               throw "Error: Constraint::" + "anchor2" + " cannot be null";
            }
            if(zpp_inner_zn.wrap_a2 == null)
            {
               zpp_inner_zn.setup_a2();
            }
            _loc8_ = zpp_inner_zn.wrap_a2;
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(param4 != null && param4.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc9_ = _loc8_.zpp_inner;
            if(_loc9_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc9_._isimmutable != null)
            {
               _loc9_._isimmutable();
            }
            if(param4 == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot assign null Vec2";
            }
            if(param4 != null && param4.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc9_ = param4.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            _loc11_ = param4.zpp_inner.x;
            if(param4 != null && param4.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc9_ = param4.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            _loc12_ = param4.zpp_inner.y;
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc9_ = _loc8_.zpp_inner;
            if(_loc9_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc9_._isimmutable != null)
            {
               _loc9_._isimmutable();
            }
            if(_loc11_ != _loc11_ || _loc12_ != _loc12_)
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
            _loc9_ = _loc8_.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            if(_loc8_.zpp_inner.x == _loc11_)
            {
               §§pop();
               if(_loc8_ != null && _loc8_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc9_ = _loc8_.zpp_inner;
               if(_loc9_._validate != null)
               {
                  _loc9_._validate();
               }
               §§push(_loc8_.zpp_inner.y == _loc12_);
            }
            if(!§§pop())
            {
               _loc8_.zpp_inner.x = _loc11_;
               _loc8_.zpp_inner.y = _loc12_;
               _loc9_ = _loc8_.zpp_inner;
               if(_loc9_._invalidate != null)
               {
                  _loc9_._invalidate(_loc9_);
               }
            }
            _loc10_ = _loc8_;
            if(param4.zpp_inner.weak)
            {
               if(param4 != null && param4.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc9_ = param4.zpp_inner;
               if(_loc9_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc9_._isimmutable != null)
               {
                  _loc9_._isimmutable();
               }
               if(param4.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc9_ = param4.zpp_inner;
               param4.zpp_inner.outer = null;
               param4.zpp_inner = null;
               _loc13_ = param4;
               _loc13_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc13_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc13_;
               }
               ZPP_PubPool.nextVec2 = _loc13_;
               _loc13_.zpp_disp = true;
               _loc14_ = _loc9_;
               if(_loc14_.outer != null)
               {
                  _loc14_.outer.zpp_inner = null;
                  _loc14_.outer = null;
               }
               _loc14_._isimmutable = null;
               _loc14_._validate = null;
               _loc14_._invalidate = null;
               _loc14_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc14_;
            }
            _loc10_;
            if(zpp_inner_zn.wrap_a2 == null)
            {
               zpp_inner_zn.setup_a2();
            }
            zpp_inner_zn.wrap_a2;
            return;
         }
      }
      
      override public function visitBodies(param1:Function) : void
      {
         if(false)
         {
            param1(zpp_inner_zn.b2 == null ? null : zpp_inner_zn.b2.outer);
         }
      }
      
      public function set body2(param1:Body) : Body
      {
         zpp_inner.immutable_midstep("Constraint::" + "body2");
         var _loc2_:ZPP_Body = param1 == null ? null : param1.zpp_inner;
         if(_loc2_ != zpp_inner_zn.b2)
         {
            if(zpp_inner_zn.b2 != null)
            {
               if(false)
               {
                  if(zpp_inner_zn.b2 != null)
                  {
                     zpp_inner_zn.b2.constraints.remove(zpp_inner);
                  }
               }
               if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
               {
                  zpp_inner_zn.b2.wake();
               }
            }
            zpp_inner_zn.b2 = _loc2_;
            if(false && zpp_inner_zn.b1 != _loc2_)
            {
               if(_loc2_ != null)
               {
                  _loc2_.constraints.add(zpp_inner);
               }
            }
            if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
            {
               zpp_inner.wake();
               if(_loc2_ != null)
               {
                  _loc2_.wake();
               }
            }
         }
         return zpp_inner_zn.b2 == null ? null : zpp_inner_zn.b2.outer;
      }
      
      public function set body1(param1:Body) : Body
      {
         zpp_inner.immutable_midstep("Constraint::" + "body1");
         var _loc2_:ZPP_Body = param1 == null ? null : param1.zpp_inner;
         if(_loc2_ != zpp_inner_zn.b1)
         {
            if(zpp_inner_zn.b1 != null)
            {
               if(false)
               {
                  if(zpp_inner_zn.b1 != null)
                  {
                     zpp_inner_zn.b1.constraints.remove(zpp_inner);
                  }
               }
               if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
               {
                  zpp_inner_zn.b1.wake();
               }
            }
            zpp_inner_zn.b1 = _loc2_;
            if(false && zpp_inner_zn.b2 != _loc2_)
            {
               if(_loc2_ != null)
               {
                  _loc2_.constraints.add(zpp_inner);
               }
            }
            if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
            {
               zpp_inner.wake();
               if(_loc2_ != null)
               {
                  _loc2_.wake();
               }
            }
         }
         return zpp_inner_zn.b1 == null ? null : zpp_inner_zn.b1.outer;
      }
      
      public function set anchor2(param1:Vec2) : Vec2
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
            throw "Error: Constraint::" + "anchor2" + " cannot be null";
         }
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         var _loc2_:Vec2 = zpp_inner_zn.wrap_a2;
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
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         return zpp_inner_zn.wrap_a2;
      }
      
      public function set anchor1(param1:Vec2) : Vec2
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
            throw "Error: Constraint::" + "anchor1" + " cannot be null";
         }
         if(zpp_inner_zn.wrap_a1 == null)
         {
            zpp_inner_zn.setup_a1();
         }
         var _loc2_:Vec2 = zpp_inner_zn.wrap_a1;
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
         if(zpp_inner_zn.wrap_a1 == null)
         {
            zpp_inner_zn.setup_a1();
         }
         return zpp_inner_zn.wrap_a1;
      }
      
      override public function impulse() : MatMN
      {
         var _loc1_:MatMN = new MatMN(2,1);
         if(0 >= _loc1_.zpp_inner.m || 0 >= _loc1_.zpp_inner.n)
         {
            Boot.lastError = new Error();
            throw "Error: MatMN indices out of range";
         }
         _loc1_.zpp_inner.x[0 * _loc1_.zpp_inner.n] = zpp_inner_zn.jAccx;
         if(1 >= _loc1_.zpp_inner.m || 0 >= _loc1_.zpp_inner.n)
         {
            Boot.lastError = new Error();
            throw "Error: MatMN indices out of range";
         }
         _loc1_.zpp_inner.x[_loc1_.zpp_inner.n] = zpp_inner_zn.jAccy;
         return _loc1_;
      }
      
      public function get body2() : Body
      {
         return zpp_inner_zn.b2 == null ? null : zpp_inner_zn.b2.outer;
      }
      
      public function get body1() : Body
      {
         return zpp_inner_zn.b1 == null ? null : zpp_inner_zn.b1.outer;
      }
      
      public function get anchor2() : Vec2
      {
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         return zpp_inner_zn.wrap_a2;
      }
      
      public function get anchor1() : Vec2
      {
         if(zpp_inner_zn.wrap_a1 == null)
         {
            zpp_inner_zn.setup_a1();
         }
         return zpp_inner_zn.wrap_a1;
      }
      
      override public function bodyImpulse(param1:Body) : Vec3
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate impulse on null body";
         }
         if(param1 != (zpp_inner_zn.b1 == null ? null : zpp_inner_zn.b1.outer) && param1 != (zpp_inner_zn.b2 == null ? null : zpp_inner_zn.b2.outer))
         {
            Boot.lastError = new Error();
            throw "Error: Body is not linked to this constraint";
         }
         if(!zpp_inner.active)
         {
            return Vec3.get();
         }
         return zpp_inner_zn.bodyImpulse(param1.zpp_inner);
      }
   }
}
