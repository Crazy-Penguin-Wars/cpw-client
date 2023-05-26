package nape.constraint
{
   import flash.Boot;
   import nape.geom.MatMN;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.space.Space;
   import zpp_nape.constraint.ZPP_DistanceJoint;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class DistanceJoint extends Constraint
   {
       
      
      public var zpp_inner_zn:ZPP_DistanceJoint;
      
      public function DistanceJoint(param1:Body, param2:Body, param3:Vec2, param4:Vec2, param5:Number, param6:Number)
      {
         var _loc8_:* = null;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc15_:* = null as Vec2;
         var _loc16_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner_zn = null;
         zpp_inner_zn = new ZPP_DistanceJoint();
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
            var _loc9_:ZPP_Body = param1 == null ? null : param1.zpp_inner;
            if(_loc9_ != zpp_inner_zn.b1)
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
               zpp_inner_zn.b1 = _loc9_;
               if(false && zpp_inner_zn.b2 != _loc9_)
               {
                  if(_loc9_ != null)
                  {
                     _loc9_.constraints.add(zpp_inner);
                  }
               }
               if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
               {
                  zpp_inner.wake();
                  if(_loc9_ != null)
                  {
                     _loc9_.wake();
                  }
               }
            }
            if(zpp_inner_zn.b1 != null)
            {
               zpp_inner_zn.b1.outer;
            }
            zpp_inner.immutable_midstep("Constraint::" + "body2");
            _loc9_ = param2 == null ? null : param2.zpp_inner;
            if(_loc9_ != zpp_inner_zn.b2)
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
               zpp_inner_zn.b2 = _loc9_;
               if(false && zpp_inner_zn.b1 != _loc9_)
               {
                  if(_loc9_ != null)
                  {
                     _loc9_.constraints.add(zpp_inner);
                  }
               }
               if(zpp_inner.active && (zpp_inner.space == null ? null : zpp_inner.space.outer) != null)
               {
                  zpp_inner.wake();
                  if(_loc9_ != null)
                  {
                     _loc9_.wake();
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
            var _loc10_:Vec2 = zpp_inner_zn.wrap_a1;
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc10_.zpp_inner;
            if(_loc11_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc11_._isimmutable != null)
            {
               _loc11_._isimmutable();
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
            _loc11_ = param3.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            var _loc13_:Number = param3.zpp_inner.x;
            if(param3 != null && param3.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = param3.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            var _loc14_:Number = param3.zpp_inner.y;
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc10_.zpp_inner;
            if(_loc11_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc11_._isimmutable != null)
            {
               _loc11_._isimmutable();
            }
            if(_loc13_ != _loc13_ || _loc14_ != _loc14_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc10_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            if(_loc10_.zpp_inner.x == _loc13_)
            {
               §§pop();
               if(_loc10_ != null && _loc10_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc10_.zpp_inner;
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               §§push(_loc10_.zpp_inner.y == _loc14_);
            }
            if(!§§pop())
            {
               _loc10_.zpp_inner.x = _loc13_;
               _loc10_.zpp_inner.y = _loc14_;
               _loc11_ = _loc10_.zpp_inner;
               if(_loc11_._invalidate != null)
               {
                  _loc11_._invalidate(_loc11_);
               }
            }
            var _loc12_:Vec2 = _loc10_;
            if(param3.zpp_inner.weak)
            {
               if(param3 != null && param3.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = param3.zpp_inner;
               if(_loc11_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc11_._isimmutable != null)
               {
                  _loc11_._isimmutable();
               }
               if(param3.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc11_ = param3.zpp_inner;
               param3.zpp_inner.outer = null;
               param3.zpp_inner = null;
               _loc15_ = param3;
               _loc15_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc15_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc15_;
               }
               ZPP_PubPool.nextVec2 = _loc15_;
               _loc15_.zpp_disp = true;
               _loc16_ = _loc11_;
               if(_loc16_.outer != null)
               {
                  _loc16_.outer.zpp_inner = null;
                  _loc16_.outer = null;
               }
               _loc16_._isimmutable = null;
               _loc16_._validate = null;
               _loc16_._invalidate = null;
               _loc16_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc16_;
            }
            _loc12_;
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
            _loc10_ = zpp_inner_zn.wrap_a2;
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            if(param4 != null && param4.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc10_.zpp_inner;
            if(_loc11_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc11_._isimmutable != null)
            {
               _loc11_._isimmutable();
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
            _loc11_ = param4.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            _loc13_ = param4.zpp_inner.x;
            if(param4 != null && param4.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = param4.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            _loc14_ = param4.zpp_inner.y;
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc10_.zpp_inner;
            if(_loc11_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc11_._isimmutable != null)
            {
               _loc11_._isimmutable();
            }
            if(_loc13_ != _loc13_ || _loc14_ != _loc14_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc11_ = _loc10_.zpp_inner;
            if(_loc11_._validate != null)
            {
               _loc11_._validate();
            }
            if(_loc10_.zpp_inner.x == _loc13_)
            {
               §§pop();
               if(_loc10_ != null && _loc10_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = _loc10_.zpp_inner;
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               §§push(_loc10_.zpp_inner.y == _loc14_);
            }
            if(!§§pop())
            {
               _loc10_.zpp_inner.x = _loc13_;
               _loc10_.zpp_inner.y = _loc14_;
               _loc11_ = _loc10_.zpp_inner;
               if(_loc11_._invalidate != null)
               {
                  _loc11_._invalidate(_loc11_);
               }
            }
            _loc12_ = _loc10_;
            if(param4.zpp_inner.weak)
            {
               if(param4 != null && param4.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc11_ = param4.zpp_inner;
               if(_loc11_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc11_._isimmutable != null)
               {
                  _loc11_._isimmutable();
               }
               if(param4.zpp_inner._inuse)
               {
                  Boot.lastError = new Error();
                  throw "Error: This Vec2 is not disposable";
               }
               _loc11_ = param4.zpp_inner;
               param4.zpp_inner.outer = null;
               param4.zpp_inner = null;
               _loc15_ = param4;
               _loc15_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc15_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc15_;
               }
               ZPP_PubPool.nextVec2 = _loc15_;
               _loc15_.zpp_disp = true;
               _loc16_ = _loc11_;
               if(_loc16_.outer != null)
               {
                  _loc16_.outer.zpp_inner = null;
                  _loc16_.outer = null;
               }
               _loc16_._isimmutable = null;
               _loc16_._validate = null;
               _loc16_._invalidate = null;
               _loc16_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc16_;
            }
            _loc12_;
            if(zpp_inner_zn.wrap_a2 == null)
            {
               zpp_inner_zn.setup_a2();
            }
            zpp_inner_zn.wrap_a2;
            zpp_inner.immutable_midstep("DistanceJoint::jointMin");
            if(param5 != param5)
            {
               Boot.lastError = new Error();
               throw "Error: DistanceJoint::jointMin cannot be NaN";
            }
            if(param5 < 0)
            {
               Boot.lastError = new Error();
               throw "Error: DistanceJoint::jointMin must be >= 0";
            }
            if(zpp_inner_zn.jointMin != param5)
            {
               zpp_inner_zn.jointMin = param5;
               zpp_inner.wake();
            }
            zpp_inner_zn.jointMin;
            zpp_inner.immutable_midstep("DistanceJoint::jointMax");
            if(param6 != param6)
            {
               Boot.lastError = new Error();
               throw "Error: DistanceJoint::jointMax cannot be NaN";
            }
            if(param6 < 0)
            {
               Boot.lastError = new Error();
               throw "Error: DistanceJoint::jointMax must be >= 0";
            }
            if(zpp_inner_zn.jointMax != param6)
            {
               zpp_inner_zn.jointMax = param6;
               zpp_inner.wake();
            }
            zpp_inner_zn.jointMax;
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
      
      public function set jointMin(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("DistanceJoint::jointMin");
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: DistanceJoint::jointMin cannot be NaN";
         }
         if(param1 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: DistanceJoint::jointMin must be >= 0";
         }
         if(zpp_inner_zn.jointMin != param1)
         {
            zpp_inner_zn.jointMin = param1;
            zpp_inner.wake();
         }
         return zpp_inner_zn.jointMin;
      }
      
      public function set jointMax(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("DistanceJoint::jointMax");
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: DistanceJoint::jointMax cannot be NaN";
         }
         if(param1 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: DistanceJoint::jointMax must be >= 0";
         }
         if(zpp_inner_zn.jointMax != param1)
         {
            zpp_inner_zn.jointMax = param1;
            zpp_inner.wake();
         }
         return zpp_inner_zn.jointMax;
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
      
      public function isSlack() : Boolean
      {
         if(true)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot compute slack for DistanceJoint if either body is null.";
         }
         return zpp_inner_zn.slack;
      }
      
      override public function impulse() : MatMN
      {
         var _loc1_:MatMN = new MatMN(1,1);
         if(0 >= _loc1_.zpp_inner.m || 0 >= _loc1_.zpp_inner.n)
         {
            Boot.lastError = new Error();
            throw "Error: MatMN indices out of range";
         }
         _loc1_.zpp_inner.x[0 * _loc1_.zpp_inner.n] = zpp_inner_zn.jAcc;
         return _loc1_;
      }
      
      public function get jointMin() : Number
      {
         return zpp_inner_zn.jointMin;
      }
      
      public function get jointMax() : Number
      {
         return zpp_inner_zn.jointMax;
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
