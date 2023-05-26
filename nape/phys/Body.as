package nape.phys
{
   import flash.Boot;
   import nape.callbacks.InteractionType;
   import nape.constraint.Constraint;
   import nape.constraint.ConstraintList;
   import nape.dynamics.Arbiter;
   import nape.dynamics.ArbiterIterator;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.FluidArbiter;
   import nape.dynamics.InteractionFilter;
   import nape.geom.AABB;
   import nape.geom.Mat23;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.shape.Shape;
   import nape.shape.ShapeList;
   import nape.space.Space;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.geom.ZPP_Vec3;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.phys.ZPP_FluidProperties;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_Arbiter;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZPP_ArbiterList;
   import zpp_nape.util.ZPP_ConstraintList;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class Body extends Interactor
   {
       
      
      public var zpp_inner:ZPP_Body;
      
      public var debugDraw:Boolean;
      
      public function Body(param1:BodyType = undefined, param2:Vec2 = undefined)
      {
         var _loc4_:* = null;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc7_:int = 0;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         debugDraw = true;
         zpp_inner = null;
         try
         {
            super();
         }
         catch(_loc_e_:*)
         {
            zpp_inner = new ZPP_Body();
            zpp_inner.outer = this;
            zpp_inner.outer_i = this;
            zpp_inner_i = zpp_inner;
            if(param2 != null)
            {
               if(param2 != null && param2.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               §§push(zpp_inner);
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
               §§pop().posx = param2.zpp_inner.x;
               §§push(zpp_inner);
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
               §§pop().posy = param2.zpp_inner.y;
            }
            else
            {
               zpp_inner.posx = 0;
               zpp_inner.posy = 0;
            }
            if(param1 == null)
            {
               if(ZPP_Flags.BodyType_DYNAMIC == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                  ZPP_Flags.§internal§ = false;
               }
               §§push(ZPP_Flags.BodyType_DYNAMIC);
            }
            else
            {
               §§push(param1);
            }
            var _loc6_:BodyType = §§pop();
            zpp_inner.immutable_midstep("Body::type");
            if(zpp_inner.world)
            {
               Boot.lastError = new Error();
               throw "Error: Space::world is immutable";
            }
            §§push(null);
            if(ZPP_Flags.BodyType_STATIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_STATIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.BodyType_STATIC);
            if(ZPP_Flags.BodyType_DYNAMIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_DYNAMIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.BodyType_DYNAMIC);
            if(ZPP_Flags.BodyType_KINEMATIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_KINEMATIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            if(null[zpp_inner.type] != _loc6_)
            {
               if(_loc6_ == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Cannot use null BodyType";
               }
               §§push(_loc6_);
               if(ZPP_Flags.BodyType_DYNAMIC == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.BodyType_DYNAMIC = new BodyType();
                  ZPP_Flags.§internal§ = false;
               }
               if(§§pop() == ZPP_Flags.BodyType_DYNAMIC)
               {
                  §§push(ZPP_Flags.id_BodyType_DYNAMIC);
               }
               else
               {
                  §§push(_loc6_);
                  if(ZPP_Flags.BodyType_KINEMATIC == null)
                  {
                     ZPP_Flags.§internal§ = true;
                     ZPP_Flags.BodyType_KINEMATIC = new BodyType();
                     ZPP_Flags.§internal§ = false;
                  }
                  §§push(§§pop() == ZPP_Flags.BodyType_KINEMATIC ? ZPP_Flags.id_BodyType_KINEMATIC : ZPP_Flags.id_BodyType_STATIC);
               }
               _loc7_ = §§pop();
               if(_loc7_ == ZPP_Flags.id_BodyType_STATIC && zpp_inner.space != null)
               {
                  zpp_inner.velx = 0;
                  zpp_inner.vely = 0;
                  zpp_inner.angvel = 0;
               }
               zpp_inner.invalidate_type();
               if(zpp_inner.space != null)
               {
                  zpp_inner.space.transmitType(zpp_inner,_loc7_);
               }
               else
               {
                  zpp_inner.type = _loc7_;
               }
            }
            §§push(null);
            if(ZPP_Flags.BodyType_STATIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_STATIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.BodyType_STATIC);
            if(ZPP_Flags.BodyType_DYNAMIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_DYNAMIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.BodyType_DYNAMIC);
            if(ZPP_Flags.BodyType_KINEMATIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_KINEMATIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            null[zpp_inner.type];
            if(param2 != null)
            {
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
            zpp_inner_i.insert_cbtype(ZPP_CbType.ANY_BODY.zpp_inner);
            return;
         }
      }
      
      public function worldVectorToLocal(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:Boolean = false;
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
         var _loc3_:ZPP_Body = zpp_inner;
         if(_loc3_.zip_axis)
         {
            _loc3_.zip_axis = false;
            _loc3_.axisx = Math.sin(_loc3_.rot);
            _loc3_.axisy = Math.cos(_loc3_.rot);
         }
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
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
         §§push(param1.zpp_inner.x * zpp_inner.axisy);
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
         _loc4_ = §§pop() + param1.zpp_inner.y * zpp_inner.axisx;
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
         §§push(param1.zpp_inner.y * zpp_inner.axisy);
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
         _loc5_ = §§pop() - param1.zpp_inner.x * zpp_inner.axisx;
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
            _loc8_ = _loc6_;
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
         if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc7_ = new Vec2();
         }
         else
         {
            _loc7_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc7_.zpp_pool;
            _loc7_.zpp_pool = null;
            _loc7_.zpp_disp = false;
            if(_loc7_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc7_.zpp_inner == null)
         {
            _loc9_ = false;
            §§push(_loc7_);
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
            _loc6_.x = _loc4_;
            _loc6_.y = _loc5_;
            §§pop().zpp_inner = _loc6_;
            _loc7_.zpp_inner.outer = _loc7_;
         }
         else
         {
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            if(_loc7_.zpp_inner.x == _loc4_)
            {
               §§pop();
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc7_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               §§push(_loc7_.zpp_inner.y == _loc5_);
            }
            if(!§§pop())
            {
               _loc7_.zpp_inner.x = _loc4_;
               _loc7_.zpp_inner.y = _loc5_;
               _loc6_ = _loc7_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc7_;
         }
         _loc7_.zpp_inner.weak = param2;
         return _loc7_;
      }
      
      public function worldPointToLocal(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:Boolean = false;
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
         var _loc3_:ZPP_Body = zpp_inner;
         if(_loc3_.zip_axis)
         {
            _loc3_.zip_axis = false;
            _loc3_.axisx = Math.sin(_loc3_.rot);
            _loc3_.axisy = Math.cos(_loc3_.rot);
         }
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
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
         _loc6_ = param1.zpp_inner.x - zpp_inner.posx;
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
         _loc7_ = param1.zpp_inner.y - zpp_inner.posy;
         _loc4_ = _loc6_ * zpp_inner.axisy + _loc7_ * zpp_inner.axisx;
         _loc5_ = _loc7_ * zpp_inner.axisy - _loc6_ * zpp_inner.axisx;
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
         if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
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
            _loc11_ = false;
            §§push(_loc9_);
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
            _loc8_._immutable = _loc11_;
            _loc8_.x = _loc4_;
            _loc8_.y = _loc5_;
            §§pop().zpp_inner = _loc8_;
            _loc9_.zpp_inner.outer = _loc9_;
         }
         else
         {
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc8_ = _loc9_.zpp_inner;
            if(_loc8_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc8_._isimmutable != null)
            {
               _loc8_._isimmutable();
            }
            if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
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
            _loc8_ = _loc9_.zpp_inner;
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            if(_loc9_.zpp_inner.x == _loc4_)
            {
               §§pop();
               if(_loc9_ != null && _loc9_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc8_ = _loc9_.zpp_inner;
               if(_loc8_._validate != null)
               {
                  _loc8_._validate();
               }
               §§push(_loc9_.zpp_inner.y == _loc5_);
            }
            if(!§§pop())
            {
               _loc9_.zpp_inner.x = _loc4_;
               _loc9_.zpp_inner.y = _loc5_;
               _loc8_ = _loc9_.zpp_inner;
               if(_loc8_._invalidate != null)
               {
                  _loc8_._invalidate(_loc8_);
               }
            }
            _loc9_;
         }
         _loc9_.zpp_inner.weak = param2;
         return _loc9_;
      }
      
      public function translateShapes(param1:Vec2) : Body
      {
         var _loc4_:* = null as ZPP_Shape;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         zpp_inner.immutable_midstep("Body::translateShapes()");
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot displace by null Vec2";
         }
         var _loc2_:Boolean = param1.zpp_inner.weak;
         param1.zpp_inner.weak = false;
         var _loc3_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            _loc4_.outer.translate(param1);
            _loc3_ = _loc3_.next;
         }
         param1.zpp_inner.weak = _loc2_;
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
         return this;
      }
      
      public function transformShapes(param1:Mat23) : Body
      {
         var _loc3_:* = null as ZPP_Shape;
         zpp_inner.immutable_midstep("Body::transformShapes()");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc3_.outer.transform(param1);
            _loc2_ = _loc2_.next;
         }
         return this;
      }
      
      public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc8_:* = null as Arbiter;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as Vec3;
         var _loc12_:int = 0;
         var _loc13_:* = null as ZPP_Vec3;
         var _loc15_:* = null as ZPP_Constraint;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc7_:ArbiterIterator = zpp_inner.wrap_arbiters.iterator();
         while(true)
         {
            _loc7_.zpp_inner.zpp_inner.valmod();
            _loc9_ = _loc7_.zpp_inner.zpp_gl();
            _loc7_.zpp_critical = true;
            if(!(_loc7_.zpp_i < _loc9_ ? true : (_loc7_.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc7_, _loc7_.zpp_inner = null, false)))
            {
               break;
            }
            _loc7_.zpp_critical = false;
            _loc7_.zpp_i = (_loc9_ = _loc7_.zpp_i) + 1;
            _loc8_ = _loc7_.zpp_inner.at(_loc9_);
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_.type != ZPP_Arbiter.SENSOR)
            {
               if(!(param1 != null && _loc10_.b2 != param1.zpp_inner && _loc10_.b1 != param1.zpp_inner))
               {
                  _loc11_ = _loc10_.wrapper().totalImpulse(this,param2);
                  _loc9_ = 1;
                  _loc12_ = _loc9_;
                  §§push(_loc3_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc11_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc3_ = §§pop() + _loc11_.zpp_inner.x * _loc12_;
                  §§push(_loc4_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc11_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc4_ = §§pop() + _loc11_.zpp_inner.y * _loc12_;
                  §§push(_loc5_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc11_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc5_ = §§pop() + _loc11_.zpp_inner.z * _loc9_;
                  _loc11_.dispose();
               }
            }
         }
         var _loc14_:ZNPNode_ZPP_Constraint = zpp_inner.constraints.head;
         while(_loc14_ != null)
         {
            _loc15_ = _loc14_.elt;
            if(_loc15_.active)
            {
               _loc11_ = _loc15_.outer.bodyImpulse(this);
               _loc9_ = 1;
               _loc12_ = _loc9_;
               §§push(_loc3_);
               if(_loc11_ != null && _loc11_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc13_ = _loc11_.zpp_inner;
               if(_loc13_._validate != null)
               {
                  _loc13_._validate();
               }
               _loc3_ = §§pop() + _loc11_.zpp_inner.x * _loc12_;
               §§push(_loc4_);
               if(_loc11_ != null && _loc11_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc13_ = _loc11_.zpp_inner;
               if(_loc13_._validate != null)
               {
                  _loc13_._validate();
               }
               _loc4_ = §§pop() + _loc11_.zpp_inner.y * _loc12_;
               §§push(_loc5_);
               if(_loc11_ != null && _loc11_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc13_ = _loc11_.zpp_inner;
               if(_loc13_._validate != null)
               {
                  _loc13_._validate();
               }
               _loc5_ = §§pop() + _loc11_.zpp_inner.z * _loc9_;
               _loc11_.dispose();
            }
            _loc14_ = _loc14_.next;
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function totalFluidImpulse(param1:Body = undefined) : Vec3
      {
         var _loc7_:* = null as Arbiter;
         var _loc8_:int = 0;
         var _loc9_:* = null as ZPP_Arbiter;
         var _loc10_:* = null as Vec3;
         var _loc11_:* = null as Arbiter;
         var _loc12_:int = 0;
         var _loc13_:* = null as ZPP_Vec3;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc6_:ArbiterIterator = zpp_inner.wrap_arbiters.iterator();
         while(true)
         {
            _loc6_.zpp_inner.zpp_inner.valmod();
            _loc8_ = _loc6_.zpp_inner.zpp_gl();
            _loc6_.zpp_critical = true;
            if(!(_loc6_.zpp_i < _loc8_ ? true : (_loc6_.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc6_, _loc6_.zpp_inner = null, false)))
            {
               break;
            }
            _loc6_.zpp_critical = false;
            _loc6_.zpp_i = (_loc8_ = _loc6_.zpp_i) + 1;
            _loc7_ = _loc6_.zpp_inner.at(_loc8_);
            _loc9_ = _loc7_.zpp_inner;
            if(_loc9_.type == ZPP_Arbiter.FLUID)
            {
               if(!(param1 != null && _loc9_.b2 != param1.zpp_inner && _loc9_.b1 != param1.zpp_inner))
               {
                  _loc11_ = _loc9_.wrapper();
                  _loc10_ = (_loc11_.zpp_inner.type == ZPP_Arbiter.FLUID ? _loc11_.zpp_inner.fluidarb.outer_zn : null).totalImpulse(this);
                  _loc8_ = 1;
                  _loc12_ = _loc8_;
                  §§push(_loc2_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc10_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc2_ = §§pop() + _loc10_.zpp_inner.x * _loc12_;
                  §§push(_loc3_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc10_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc3_ = §§pop() + _loc10_.zpp_inner.y * _loc12_;
                  §§push(_loc4_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc10_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc4_ = §§pop() + _loc10_.zpp_inner.z * _loc8_;
                  _loc10_.dispose();
               }
            }
         }
         return Vec3.get(_loc2_,_loc3_,_loc4_);
      }
      
      public function totalContactsImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc8_:* = null as Arbiter;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as Vec3;
         var _loc12_:* = null as Arbiter;
         var _loc13_:int = 0;
         var _loc14_:* = null as ZPP_Vec3;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc7_:ArbiterIterator = zpp_inner.wrap_arbiters.iterator();
         while(true)
         {
            _loc7_.zpp_inner.zpp_inner.valmod();
            _loc9_ = _loc7_.zpp_inner.zpp_gl();
            _loc7_.zpp_critical = true;
            if(!(_loc7_.zpp_i < _loc9_ ? true : (_loc7_.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc7_, _loc7_.zpp_inner = null, false)))
            {
               break;
            }
            _loc7_.zpp_critical = false;
            _loc7_.zpp_i = (_loc9_ = _loc7_.zpp_i) + 1;
            _loc8_ = _loc7_.zpp_inner.at(_loc9_);
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_.type == ZPP_Arbiter.COL)
            {
               if(!(param1 != null && _loc10_.b2 != param1.zpp_inner && _loc10_.b1 != param1.zpp_inner))
               {
                  _loc12_ = _loc10_.wrapper();
                  _loc11_ = (_loc12_.zpp_inner.type == ZPP_Arbiter.COL ? _loc12_.zpp_inner.colarb.outer_zn : null).totalImpulse(this,param2);
                  _loc9_ = 1;
                  _loc13_ = _loc9_;
                  §§push(_loc3_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc3_ = §§pop() + _loc11_.zpp_inner.x * _loc13_;
                  §§push(_loc4_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc4_ = §§pop() + _loc11_.zpp_inner.y * _loc13_;
                  §§push(_loc5_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc5_ = §§pop() + _loc11_.zpp_inner.z * _loc9_;
                  _loc11_.dispose();
               }
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      override public function toString() : String
      {
         return (zpp_inner.world ? "(space::world" : "(" + (zpp_inner.type == ZPP_Flags.id_BodyType_DYNAMIC ? "dynamic" : (zpp_inner.type == ZPP_Flags.id_BodyType_STATIC ? "static" : "kinematic"))) + ")#" + zpp_inner_i.id;
      }
      
      public function tangentImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc8_:* = null as Arbiter;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as Vec3;
         var _loc12_:* = null as Arbiter;
         var _loc13_:int = 0;
         var _loc14_:* = null as ZPP_Vec3;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc7_:ArbiterIterator = zpp_inner.wrap_arbiters.iterator();
         while(true)
         {
            _loc7_.zpp_inner.zpp_inner.valmod();
            _loc9_ = _loc7_.zpp_inner.zpp_gl();
            _loc7_.zpp_critical = true;
            if(!(_loc7_.zpp_i < _loc9_ ? true : (_loc7_.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc7_, _loc7_.zpp_inner = null, false)))
            {
               break;
            }
            _loc7_.zpp_critical = false;
            _loc7_.zpp_i = (_loc9_ = _loc7_.zpp_i) + 1;
            _loc8_ = _loc7_.zpp_inner.at(_loc9_);
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_.type == ZPP_Arbiter.COL)
            {
               if(!(param1 != null && _loc10_.b2 != param1.zpp_inner && _loc10_.b1 != param1.zpp_inner))
               {
                  _loc12_ = _loc10_.wrapper();
                  _loc11_ = (_loc12_.zpp_inner.type == ZPP_Arbiter.COL ? _loc12_.zpp_inner.colarb.outer_zn : null).tangentImpulse(this,param2);
                  _loc9_ = 1;
                  _loc13_ = _loc9_;
                  §§push(_loc3_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc3_ = §§pop() + _loc11_.zpp_inner.x * _loc13_;
                  §§push(_loc4_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc4_ = §§pop() + _loc11_.zpp_inner.y * _loc13_;
                  §§push(_loc5_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc5_ = §§pop() + _loc11_.zpp_inner.z * _loc9_;
                  _loc11_.dispose();
               }
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function set velocity(param1:Vec2) : Vec2
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
            throw "Error: Body::" + "velocity" + " cannot be null";
         }
         if(zpp_inner.wrap_vel == null)
         {
            zpp_inner.setupVelocity();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_vel;
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
         if(zpp_inner.wrap_vel == null)
         {
            zpp_inner.setupVelocity();
         }
         return zpp_inner.wrap_vel;
      }
      
      public function set type(param1:BodyType) : BodyType
      {
         var _loc2_:int = 0;
         zpp_inner.immutable_midstep("Body::type");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         §§push(null);
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_STATIC);
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_DYNAMIC);
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         if(null[zpp_inner.type] != param1)
         {
            if(param1 == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot use null BodyType";
            }
            §§push(param1);
            if(ZPP_Flags.BodyType_DYNAMIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_DYNAMIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.BodyType_DYNAMIC)
            {
               §§push(ZPP_Flags.id_BodyType_DYNAMIC);
            }
            else
            {
               §§push(param1);
               if(ZPP_Flags.BodyType_KINEMATIC == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.BodyType_KINEMATIC = new BodyType();
                  ZPP_Flags.§internal§ = false;
               }
               §§push(§§pop() == ZPP_Flags.BodyType_KINEMATIC ? ZPP_Flags.id_BodyType_KINEMATIC : ZPP_Flags.id_BodyType_STATIC);
            }
            _loc2_ = §§pop();
            if(_loc2_ == ZPP_Flags.id_BodyType_STATIC && zpp_inner.space != null)
            {
               zpp_inner.velx = 0;
               zpp_inner.vely = 0;
               zpp_inner.angvel = 0;
            }
            zpp_inner.invalidate_type();
            if(zpp_inner.space != null)
            {
               zpp_inner.space.transmitType(zpp_inner,_loc2_);
            }
            else
            {
               zpp_inner.type = _loc2_;
            }
         }
         §§push(null);
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_STATIC);
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_DYNAMIC);
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.type];
      }
      
      public function set torque(param1:Number) : Number
      {
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(zpp_inner.type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            Boot.lastError = new Error();
            throw "Error: Non-dynamic body cannot have torque applied.";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Body::torque cannot be NaN";
         }
         if(zpp_inner.torque != param1)
         {
            zpp_inner.torque = param1;
            zpp_inner.wake();
         }
         return zpp_inner.torque;
      }
      
      public function set surfaceVel(param1:Vec2) : Vec2
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
            throw "Error: Body::" + "surfaceVel" + " cannot be null";
         }
         if(zpp_inner.wrap_svel == null)
         {
            zpp_inner.setupsvel();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_svel;
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
         if(zpp_inner.wrap_svel == null)
         {
            zpp_inner.setupsvel();
         }
         return zpp_inner.wrap_svel;
      }
      
      public function set space(param1:Space) : Space
      {
         var _loc2_:* = null as BodyList;
         if(zpp_inner.compound != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set the space of a Body belonging to a Compound, only the root Compound space can be set";
         }
         zpp_inner.immutable_midstep("Body::space");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if((zpp_inner.space == null ? null : zpp_inner.space.outer) != param1)
         {
            if(param1 != null)
            {
               _loc2_ = param1.zpp_inner.wrap_bodies;
               if(_loc2_.zpp_inner.reverse_flag)
               {
                  _loc2_.push(this);
               }
               else
               {
                  _loc2_.unshift(this);
               }
            }
         }
         return zpp_inner.space == null ? null : zpp_inner.space.outer;
      }
      
      public function set rotation(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:* = null as ZNPNode_ZPP_Shape;
         var _loc4_:* = null as ZPP_Shape;
         zpp_inner.immutable_midstep("Body::rotation");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(zpp_inner.type == ZPP_Flags.id_BodyType_STATIC && zpp_inner.space != null)
         {
            Boot.lastError = new Error();
            throw "Error: Static objects cannot be rotated once inside a Space";
         }
         if(zpp_inner.rot != param1)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: Body::rotation cannot be NaN";
            }
            zpp_inner.rot = param1;
            _loc2_ = zpp_inner;
            _loc2_.zip_axis = true;
            _loc3_ = _loc2_.shapes.head;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_.elt;
               if(_loc4_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc4_.polygon.invalidate_gverts();
                  _loc4_.polygon.invalidate_gaxi();
               }
               _loc4_.invalidate_worldCOM();
               _loc3_ = _loc3_.next;
            }
            _loc2_.zip_worldCOM = true;
            zpp_inner.wake();
         }
         return zpp_inner.rot;
      }
      
      public function set position(param1:Vec2) : Vec2
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
            throw "Error: Body::" + "position" + " cannot be null";
         }
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_pos;
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
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         return zpp_inner.wrap_pos;
      }
      
      public function set massMode(param1:MassMode) : MassMode
      {
         zpp_inner.immutable_midstep("Body::massMode");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: cannot use null massMode";
         }
         §§push(zpp_inner);
         §§push(param1);
         if(ZPP_Flags.MassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_DEFAULT = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§pop().massMode = §§pop() == ZPP_Flags.MassMode_DEFAULT ? ZPP_Flags.id_MassMode_DEFAULT : ZPP_Flags.id_MassMode_FIXED;
         zpp_inner.invalidate_mass();
         if(ZPP_Flags.MassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_DEFAULT = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.MassMode_DEFAULT);
         if(ZPP_Flags.MassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_FIXED = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.massMode];
      }
      
      public function set mass(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("Body::mass");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Mass cannot be NaN";
         }
         if(param1 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Mass must be strictly positive";
         }
         if(param1 >= 1.79e+308)
         {
            Boot.lastError = new Error();
            throw "Error: Mass cannot be infinite, use allowMovement = false instead";
         }
         zpp_inner.massMode = ZPP_Flags.id_MassMode_FIXED;
         zpp_inner.cmass = param1;
         zpp_inner.invalidate_mass();
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world has no mass";
         }
         zpp_inner.validate_mass();
         if(zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT && zpp_inner.shapes.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: Given current mass mode, Body::mass only makes sense if it contains shapes";
         }
         return zpp_inner.cmass;
      }
      
      public function set kinematicVel(param1:Vec2) : Vec2
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
            throw "Error: Body::" + "kinematicVel" + " cannot be null";
         }
         if(zpp_inner.wrap_kinvel == null)
         {
            zpp_inner.setupkinvel();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_kinvel;
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
         if(zpp_inner.wrap_kinvel == null)
         {
            zpp_inner.setupkinvel();
         }
         return zpp_inner.wrap_kinvel;
      }
      
      public function set kinAngVel(param1:Number) : Number
      {
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(zpp_inner.kinangvel != param1)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: Body::kinAngVel cannot be NaN";
            }
            zpp_inner.kinangvel = param1;
            zpp_inner.wake();
         }
         return zpp_inner.kinangvel;
      }
      
      public function set isBullet(param1:Boolean) : Boolean
      {
         zpp_inner.bulletEnabled = param1;
         return zpp_inner.bulletEnabled;
      }
      
      public function set inertiaMode(param1:InertiaMode) : InertiaMode
      {
         zpp_inner.immutable_midstep("Body::inertiaMode");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot use null InertiaMode";
         }
         §§push(zpp_inner);
         §§push(param1);
         if(ZPP_Flags.InertiaMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         §§pop().inertiaMode = §§pop() == ZPP_Flags.InertiaMode_FIXED ? ZPP_Flags.id_InertiaMode_FIXED : ZPP_Flags.id_InertiaMode_DEFAULT;
         zpp_inner.invalidate_inertia();
         if(ZPP_Flags.InertiaMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.InertiaMode_DEFAULT);
         if(ZPP_Flags.InertiaMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.inertiaMode];
      }
      
      public function set inertia(param1:Number) : Number
      {
         var _loc2_:* = null as ShapeList;
         zpp_inner.immutable_midstep("Body::inertia");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: Inertia cannot be NaN";
         }
         if(param1 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Inertia must be strictly positive";
         }
         if(param1 >= 1.79e+308)
         {
            Boot.lastError = new Error();
            throw "Error: Inertia cannot be infinite, use allowRotation = false instead";
         }
         zpp_inner.inertiaMode = ZPP_Flags.id_InertiaMode_FIXED;
         zpp_inner.cinertia = param1;
         zpp_inner.invalidate_inertia();
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world has no inertia";
         }
         zpp_inner.validate_inertia();
         if(zpp_inner.inertiaMode == ZPP_Flags.id_InertiaMode_DEFAULT && _loc2_.zpp_inner.inner.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: Given current inertia mode flag, Body::inertia only makes sense if Body contains Shapes";
         }
         return zpp_inner.cinertia;
      }
      
      public function set gravMassScale(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("Body::gravMassScale");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: gravMassScale cannot be NaN";
         }
         zpp_inner.gravMassMode = ZPP_Flags.id_GravMassMode_SCALED;
         zpp_inner.gravMassScale = param1;
         zpp_inner.invalidate_gravMassScale();
         zpp_inner.validate_gravMassScale();
         if(zpp_inner.shapes.head == null)
         {
            if(zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT && zpp_inner.gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
            {
               Boot.lastError = new Error();
               throw "Error: Given current mass/gravMass modes; Body::gravMassScale only makes sense if it contains Shapes";
            }
         }
         return zpp_inner.gravMassScale;
      }
      
      public function set gravMassMode(param1:GravMassMode) : GravMassMode
      {
         zpp_inner.immutable_midstep("Body::gravMassMode");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot use null gravMassMode";
         }
         §§push(zpp_inner);
         §§push(param1);
         if(ZPP_Flags.GravMassMode_SCALED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.GravMassMode_SCALED)
         {
            §§push(ZPP_Flags.id_GravMassMode_SCALED);
         }
         else
         {
            §§push(param1);
            if(ZPP_Flags.GravMassMode_DEFAULT == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
               ZPP_Flags.§internal§ = false;
            }
            §§push(§§pop() == ZPP_Flags.GravMassMode_DEFAULT ? ZPP_Flags.id_GravMassMode_DEFAULT : ZPP_Flags.id_GravMassMode_FIXED);
         }
         §§pop().gravMassMode = §§pop();
         zpp_inner.invalidate_gravMass();
         if(ZPP_Flags.GravMassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.GravMassMode_DEFAULT);
         if(ZPP_Flags.GravMassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.GravMassMode_FIXED);
         if(ZPP_Flags.GravMassMode_SCALED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.massMode];
      }
      
      public function set gravMass(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("Body::gravMass");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: gravMass cannot be NaN";
         }
         zpp_inner.gravMassMode = ZPP_Flags.id_GravMassMode_FIXED;
         zpp_inner.gravMass = param1;
         zpp_inner.invalidate_gravMass();
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world has no gravMass";
         }
         zpp_inner.validate_gravMass();
         if(zpp_inner.shapes.head == null)
         {
            if(zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT && zpp_inner.gravMassMode != ZPP_Flags.id_GravMassMode_FIXED)
            {
               Boot.lastError = new Error();
               throw "Error: Given current mass/gravMass modes; Body::gravMass only makes sense if it contains Shapes";
            }
         }
         return zpp_inner.gravMass;
      }
      
      public function set force(param1:Vec2) : Vec2
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
            throw "Error: Body::" + "force" + " cannot be null";
         }
         if(zpp_inner.wrap_force == null)
         {
            zpp_inner.setupForce();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_force;
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
         if(zpp_inner.wrap_force == null)
         {
            zpp_inner.setupForce();
         }
         return zpp_inner.wrap_force;
      }
      
      public function set disableCCD(param1:Boolean) : Boolean
      {
         zpp_inner.disableCCD = param1;
         return zpp_inner.disableCCD;
      }
      
      public function set compound(param1:Compound) : Compound
      {
         var _loc2_:* = null as BodyList;
         if((zpp_inner.compound == null ? null : zpp_inner.compound.outer) != param1)
         {
            if(param1 != null)
            {
               _loc2_ = param1.zpp_inner.wrap_bodies;
               if(_loc2_.zpp_inner.reverse_flag)
               {
                  _loc2_.push(this);
               }
               else
               {
                  _loc2_.unshift(this);
               }
            }
         }
         return zpp_inner.compound == null ? null : zpp_inner.compound.outer;
      }
      
      public function set angularVel(param1:Number) : Number
      {
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(zpp_inner.angvel != param1)
         {
            if(param1 != param1)
            {
               Boot.lastError = new Error();
               throw "Error: Body::angularVel cannot be NaN";
            }
            if(zpp_inner.type == ZPP_Flags.id_BodyType_STATIC)
            {
               Boot.lastError = new Error();
               throw "Error: A static object cannot be given a velocity";
            }
            zpp_inner.angvel = param1;
            zpp_inner.wake();
         }
         return zpp_inner.angvel;
      }
      
      public function set allowRotation(param1:Boolean) : Boolean
      {
         zpp_inner.immutable_midstep("Body::" + Std.string(param1));
         if(!zpp_inner.norotate != param1)
         {
            zpp_inner.norotate = !param1;
            zpp_inner.invalidate_inertia();
         }
         return !zpp_inner.norotate;
      }
      
      public function set allowMovement(param1:Boolean) : Boolean
      {
         zpp_inner.immutable_midstep("Body::" + Std.string(param1));
         if(!zpp_inner.nomove != param1)
         {
            zpp_inner.nomove = !param1;
            zpp_inner.invalidate_mass();
         }
         return !zpp_inner.nomove;
      }
      
      public function setVelocityFromTarget(param1:Vec2, param2:Number, param3:Number) : Body
      {
         var _loc5_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc11_:* = null as Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Cannot set velocity for null target position";
         }
         if(param3 == 0)
         {
            Boot.lastError = new Error();
            throw "deltaTime cannot be 0 for setVelocityFromTarget";
         }
         var _loc4_:Number = 1 / param3;
         if(zpp_inner.wrap_vel == null)
         {
            zpp_inner.setupVelocity();
         }
         _loc5_ = zpp_inner.wrap_vel;
         §§push(param1);
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         var _loc6_:Vec2 = §§pop().sub(zpp_inner.wrap_pos,true).muleq(_loc4_);
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(_loc6_ != null && _loc6_.zpp_disp)
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
         if(_loc6_ == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null Vec2";
         }
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc7_ = _loc6_.zpp_inner;
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         var _loc9_:Number = _loc6_.zpp_inner.x;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc7_ = _loc6_.zpp_inner;
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         var _loc10_:Number = _loc6_.zpp_inner.y;
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
         if(_loc9_ != _loc9_ || _loc10_ != _loc10_)
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
         if(_loc5_.zpp_inner.x == _loc9_)
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
            §§push(_loc5_.zpp_inner.y == _loc10_);
         }
         if(!§§pop())
         {
            _loc5_.zpp_inner.x = _loc9_;
            _loc5_.zpp_inner.y = _loc10_;
            _loc7_ = _loc5_.zpp_inner;
            if(_loc7_._invalidate != null)
            {
               _loc7_._invalidate(_loc7_);
            }
         }
         var _loc8_:Vec2 = _loc5_;
         if(_loc6_.zpp_inner.weak)
         {
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc6_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc6_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc6_.zpp_inner;
            _loc6_.zpp_inner.outer = null;
            _loc6_.zpp_inner = null;
            _loc11_ = _loc6_;
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
            _loc12_ = _loc7_;
            if(_loc12_.outer != null)
            {
               _loc12_.outer.zpp_inner = null;
               _loc12_.outer = null;
            }
            _loc12_._isimmutable = null;
            _loc12_._validate = null;
            _loc12_._invalidate = null;
            _loc12_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc12_;
         }
         _loc8_;
         _loc9_ = (param2 - zpp_inner.rot) * _loc4_;
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(zpp_inner.angvel != _loc9_)
         {
            if(_loc9_ != _loc9_)
            {
               Boot.lastError = new Error();
               throw "Error: Body::angularVel cannot be NaN";
            }
            if(zpp_inner.type == ZPP_Flags.id_BodyType_STATIC)
            {
               Boot.lastError = new Error();
               throw "Error: A static object cannot be given a velocity";
            }
            zpp_inner.angvel = _loc9_;
            zpp_inner.wake();
         }
         zpp_inner.angvel;
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
            _loc5_ = param1;
            _loc5_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc5_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc5_;
            }
            ZPP_PubPool.nextVec2 = _loc5_;
            _loc5_.zpp_disp = true;
            _loc12_ = _loc7_;
            if(_loc12_.outer != null)
            {
               _loc12_.outer.zpp_inner = null;
               _loc12_.outer = null;
            }
            _loc12_._isimmutable = null;
            _loc12_._validate = null;
            _loc12_._invalidate = null;
            _loc12_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc12_;
         }
         return this;
      }
      
      public function setShapeMaterials(param1:Material) : Body
      {
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as Shape;
         zpp_inner.immutable_midstep("Body::setShapeMaterials()");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = _loc3_.outer;
            _loc4_.zpp_inner.immutable_midstep("Shape::material");
            if(param1 == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot assign null as Shape material";
            }
            _loc4_.zpp_inner.setMaterial(param1.zpp_inner);
            _loc4_.zpp_inner.material.wrapper();
            _loc2_ = _loc2_.next;
         }
         return this;
      }
      
      public function setShapeFluidProperties(param1:FluidProperties) : Body
      {
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as Shape;
         zpp_inner.immutable_midstep("Body::setShapeFluidProperties()");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = _loc3_.outer;
            if(param1 == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot assign null as Shape fluidProperties, disable fluids by setting fluidEnabled to false";
            }
            _loc4_.zpp_inner.setFluid(param1.zpp_inner);
            _loc4_.zpp_inner.immutable_midstep("Shape::fluidProperties");
            if(_loc4_.zpp_inner.fluidProperties == null)
            {
               _loc4_.zpp_inner.setFluid(new FluidProperties().zpp_inner);
            }
            _loc4_.zpp_inner.fluidProperties.wrapper();
            _loc2_ = _loc2_.next;
         }
         return this;
      }
      
      public function setShapeFilters(param1:InteractionFilter) : Body
      {
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as Shape;
         zpp_inner.immutable_midstep("Body::setShapeFilters()");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = _loc3_.outer;
            _loc4_.zpp_inner.immutable_midstep("Shape::filter");
            if(param1 == null)
            {
               Boot.lastError = new Error();
               throw "Error: Cannot assign null as Shape filter";
            }
            _loc4_.zpp_inner.setFilter(param1.zpp_inner);
            _loc4_.zpp_inner.filter.wrapper();
            _loc2_ = _loc2_.next;
         }
         return this;
      }
      
      public function scaleShapes(param1:Number, param2:Number) : Body
      {
         var _loc4_:* = null as ZPP_Shape;
         zpp_inner.immutable_midstep("Body::scaleShapes()");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         var _loc3_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            _loc4_.outer.scale(param1,param2);
            _loc3_ = _loc3_.next;
         }
         return this;
      }
      
      public function rotateShapes(param1:Number) : Body
      {
         var _loc3_:* = null as ZPP_Shape;
         zpp_inner.immutable_midstep("Body::rotateShapes()");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc3_.outer.rotate(param1);
            _loc2_ = _loc2_.next;
         }
         return this;
      }
      
      public function rotate(param1:Vec2, param2:Number) : Body
      {
         var _loc5_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc11_:* = null as Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc14_:* = null as ZPP_Body;
         var _loc15_:* = null as ZNPNode_ZPP_Shape;
         var _loc16_:* = null as ZPP_Shape;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot rotate about a null Vec2";
         }
         if(param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot rotate by NaN radians";
         }
         var _loc3_:Boolean = param1.zpp_inner.weak;
         param1.zpp_inner.weak = false;
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         var _loc4_:Vec2 = zpp_inner.wrap_pos.sub(param1);
         _loc4_.rotate(param2);
         _loc5_ = param1.add(_loc4_,true);
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(_loc5_ == null)
         {
            Boot.lastError = new Error();
            throw "Error: Body::" + "position" + " cannot be null";
         }
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         var _loc6_:Vec2 = zpp_inner.wrap_pos;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(_loc5_ != null && _loc5_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc7_ = _loc6_.zpp_inner;
         if(_loc7_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc7_._isimmutable != null)
         {
            _loc7_._isimmutable();
         }
         if(_loc5_ == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot assign null Vec2";
         }
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
         var _loc9_:Number = _loc5_.zpp_inner.x;
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
         var _loc10_:Number = _loc5_.zpp_inner.y;
         if(_loc6_ != null && _loc6_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc7_ = _loc6_.zpp_inner;
         if(_loc7_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc7_._isimmutable != null)
         {
            _loc7_._isimmutable();
         }
         if(_loc9_ != _loc9_ || _loc10_ != _loc10_)
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
         _loc7_ = _loc6_.zpp_inner;
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         if(_loc6_.zpp_inner.x == _loc9_)
         {
            §§pop();
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc6_.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            §§push(_loc6_.zpp_inner.y == _loc10_);
         }
         if(!§§pop())
         {
            _loc6_.zpp_inner.x = _loc9_;
            _loc6_.zpp_inner.y = _loc10_;
            _loc7_ = _loc6_.zpp_inner;
            if(_loc7_._invalidate != null)
            {
               _loc7_._invalidate(_loc7_);
            }
         }
         var _loc8_:Vec2 = _loc6_;
         if(_loc5_.zpp_inner.weak)
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
            if(_loc5_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc5_.zpp_inner;
            _loc5_.zpp_inner.outer = null;
            _loc5_.zpp_inner = null;
            _loc11_ = _loc5_;
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
            _loc12_ = _loc7_;
            if(_loc12_.outer != null)
            {
               _loc12_.outer.zpp_inner = null;
               _loc12_.outer = null;
            }
            _loc12_._isimmutable = null;
            _loc12_._validate = null;
            _loc12_._invalidate = null;
            _loc12_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc12_;
         }
         _loc8_;
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         zpp_inner.wrap_pos;
         if(_loc4_ != null && _loc4_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc7_ = _loc4_.zpp_inner;
         if(_loc7_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc7_._isimmutable != null)
         {
            _loc7_._isimmutable();
         }
         if(_loc4_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc7_ = _loc4_.zpp_inner;
         _loc4_.zpp_inner.outer = null;
         _loc4_.zpp_inner = null;
         _loc5_ = _loc4_;
         _loc5_.zpp_pool = null;
         if(ZPP_PubPool.nextVec2 != null)
         {
            ZPP_PubPool.nextVec2.zpp_pool = _loc5_;
         }
         else
         {
            ZPP_PubPool.poolVec2 = _loc5_;
         }
         ZPP_PubPool.nextVec2 = _loc5_;
         _loc5_.zpp_disp = true;
         _loc12_ = _loc7_;
         if(_loc12_.outer != null)
         {
            _loc12_.outer.zpp_inner = null;
            _loc12_.outer = null;
         }
         _loc12_._isimmutable = null;
         _loc12_._validate = null;
         _loc12_._invalidate = null;
         _loc12_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc12_;
         var _loc13_:Body = this;
         _loc9_ = _loc13_.zpp_inner.rot + param2;
         _loc13_.zpp_inner.immutable_midstep("Body::rotation");
         if(_loc13_.zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(_loc13_.zpp_inner.type == ZPP_Flags.id_BodyType_STATIC && _loc13_.zpp_inner.space != null)
         {
            Boot.lastError = new Error();
            throw "Error: Static objects cannot be rotated once inside a Space";
         }
         if(_loc13_.zpp_inner.rot != _loc9_)
         {
            if(_loc9_ != _loc9_)
            {
               Boot.lastError = new Error();
               throw "Error: Body::rotation cannot be NaN";
            }
            _loc13_.zpp_inner.rot = _loc9_;
            _loc14_ = _loc13_.zpp_inner;
            _loc14_.zip_axis = true;
            _loc15_ = _loc14_.shapes.head;
            while(_loc15_ != null)
            {
               _loc16_ = _loc15_.elt;
               if(_loc16_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc16_.polygon.invalidate_gverts();
                  _loc16_.polygon.invalidate_gaxi();
               }
               _loc16_.invalidate_worldCOM();
               _loc15_ = _loc15_.next;
            }
            _loc14_.zip_worldCOM = true;
            _loc13_.zpp_inner.wake();
         }
         _loc13_.zpp_inner.rot;
         param1.zpp_inner.weak = _loc3_;
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
            _loc5_ = param1;
            _loc5_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc5_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc5_;
            }
            ZPP_PubPool.nextVec2 = _loc5_;
            _loc5_.zpp_disp = true;
            _loc12_ = _loc7_;
            if(_loc12_.outer != null)
            {
               _loc12_.outer.zpp_inner = null;
               _loc12_.outer = null;
            }
            _loc12_._isimmutable = null;
            _loc12_._validate = null;
            _loc12_._invalidate = null;
            _loc12_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc12_;
         }
         return this;
      }
      
      public function rollingImpulse(param1:Body = undefined, param2:Boolean = false) : Number
      {
         var _loc6_:* = null as Arbiter;
         var _loc7_:int = 0;
         var _loc8_:* = null as ZPP_Arbiter;
         var _loc9_:* = null as Arbiter;
         var _loc3_:Number = 0;
         var _loc4_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc5_:ArbiterIterator = zpp_inner.wrap_arbiters.iterator();
         while(true)
         {
            _loc5_.zpp_inner.zpp_inner.valmod();
            _loc7_ = _loc5_.zpp_inner.zpp_gl();
            _loc5_.zpp_critical = true;
            if(!(_loc5_.zpp_i < _loc7_ ? true : (_loc5_.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc5_, _loc5_.zpp_inner = null, false)))
            {
               break;
            }
            _loc5_.zpp_critical = false;
            _loc5_.zpp_i = (_loc7_ = _loc5_.zpp_i) + 1;
            _loc6_ = _loc5_.zpp_inner.at(_loc7_);
            _loc8_ = _loc6_.zpp_inner;
            if(_loc8_.type == ZPP_Arbiter.COL)
            {
               if(!(param1 != null && _loc8_.b2 != param1.zpp_inner && _loc8_.b1 != param1.zpp_inner))
               {
                  _loc9_ = _loc8_.wrapper();
                  _loc3_ += (_loc9_.zpp_inner.type == ZPP_Arbiter.COL ? _loc9_.zpp_inner.colarb.outer_zn : null).rollingImpulse(this,param2);
               }
            }
         }
         return _loc3_;
      }
      
      public function normalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc8_:* = null as Arbiter;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as Vec3;
         var _loc12_:* = null as Arbiter;
         var _loc13_:int = 0;
         var _loc14_:* = null as ZPP_Vec3;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc7_:ArbiterIterator = zpp_inner.wrap_arbiters.iterator();
         while(true)
         {
            _loc7_.zpp_inner.zpp_inner.valmod();
            _loc9_ = _loc7_.zpp_inner.zpp_gl();
            _loc7_.zpp_critical = true;
            if(!(_loc7_.zpp_i < _loc9_ ? true : (_loc7_.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc7_, _loc7_.zpp_inner = null, false)))
            {
               break;
            }
            _loc7_.zpp_critical = false;
            _loc7_.zpp_i = (_loc9_ = _loc7_.zpp_i) + 1;
            _loc8_ = _loc7_.zpp_inner.at(_loc9_);
            _loc10_ = _loc8_.zpp_inner;
            if(_loc10_.type == ZPP_Arbiter.COL)
            {
               if(!(param1 != null && _loc10_.b2 != param1.zpp_inner && _loc10_.b1 != param1.zpp_inner))
               {
                  _loc12_ = _loc10_.wrapper();
                  _loc11_ = (_loc12_.zpp_inner.type == ZPP_Arbiter.COL ? _loc12_.zpp_inner.colarb.outer_zn : null).normalImpulse(this,param2);
                  _loc9_ = 1;
                  _loc13_ = _loc9_;
                  §§push(_loc3_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc3_ = §§pop() + _loc11_.zpp_inner.x * _loc13_;
                  §§push(_loc4_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc4_ = §§pop() + _loc11_.zpp_inner.y * _loc13_;
                  §§push(_loc5_);
                  if(_loc11_ != null && _loc11_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc14_ = _loc11_.zpp_inner;
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc5_ = §§pop() + _loc11_.zpp_inner.z * _loc9_;
                  _loc11_.dispose();
               }
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function localVectorToWorld(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:Boolean = false;
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
         var _loc3_:ZPP_Body = zpp_inner;
         if(_loc3_.zip_axis)
         {
            _loc3_.zip_axis = false;
            _loc3_.axisx = Math.sin(_loc3_.rot);
            _loc3_.axisy = Math.cos(_loc3_.rot);
         }
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         §§push(zpp_inner.axisy);
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
         §§push(§§pop() * param1.zpp_inner.x);
         §§push(zpp_inner.axisx);
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
         _loc4_ = §§pop() - §§pop() * param1.zpp_inner.y;
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
         §§push(param1.zpp_inner.x * zpp_inner.axisx);
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
         _loc5_ = §§pop() + param1.zpp_inner.y * zpp_inner.axisy;
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
            _loc8_ = _loc6_;
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
         if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc7_ = new Vec2();
         }
         else
         {
            _loc7_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc7_.zpp_pool;
            _loc7_.zpp_pool = null;
            _loc7_.zpp_disp = false;
            if(_loc7_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc7_.zpp_inner == null)
         {
            _loc9_ = false;
            §§push(_loc7_);
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
            _loc6_.x = _loc4_;
            _loc6_.y = _loc5_;
            §§pop().zpp_inner = _loc6_;
            _loc7_.zpp_inner.outer = _loc7_;
         }
         else
         {
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc4_ != _loc4_ || _loc5_ != _loc5_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            if(_loc7_.zpp_inner.x == _loc4_)
            {
               §§pop();
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc7_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               §§push(_loc7_.zpp_inner.y == _loc5_);
            }
            if(!§§pop())
            {
               _loc7_.zpp_inner.x = _loc4_;
               _loc7_.zpp_inner.y = _loc5_;
               _loc6_ = _loc7_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc7_;
         }
         _loc7_.zpp_inner.weak = param2;
         return _loc7_;
      }
      
      public function localPointToWorld(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc11_:Boolean = false;
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
         var _loc3_:ZPP_Body = zpp_inner;
         if(_loc3_.zip_axis)
         {
            _loc3_.zip_axis = false;
            _loc3_.axisx = Math.sin(_loc3_.rot);
            _loc3_.axisy = Math.cos(_loc3_.rot);
         }
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         §§push(zpp_inner.axisy);
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
         §§push(§§pop() * param1.zpp_inner.x);
         §§push(zpp_inner.axisx);
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
         _loc4_ = §§pop() - §§pop() * param1.zpp_inner.y;
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
         §§push(param1.zpp_inner.x * zpp_inner.axisx);
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
         _loc5_ = §§pop() + param1.zpp_inner.y * zpp_inner.axisy;
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
            _loc8_ = _loc6_;
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
         var _loc9_:Number = _loc4_ + zpp_inner.posx;
         var _loc10_:Number = _loc5_ + zpp_inner.posy;
         if(_loc9_ != _loc9_ || _loc10_ != _loc10_)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 components cannot be NaN";
         }
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc7_ = new Vec2();
         }
         else
         {
            _loc7_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc7_.zpp_pool;
            _loc7_.zpp_pool = null;
            _loc7_.zpp_disp = false;
            if(_loc7_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc7_.zpp_inner == null)
         {
            _loc11_ = false;
            §§push(_loc7_);
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
            _loc6_._immutable = _loc11_;
            _loc6_.x = _loc9_;
            _loc6_.y = _loc10_;
            §§pop().zpp_inner = _loc6_;
            _loc7_.zpp_inner.outer = _loc7_;
         }
         else
         {
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc6_._isimmutable != null)
            {
               _loc6_._isimmutable();
            }
            if(_loc9_ != _loc9_ || _loc10_ != _loc10_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            §§push(false);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc6_ = _loc7_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            if(_loc7_.zpp_inner.x == _loc9_)
            {
               §§pop();
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc6_ = _loc7_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               §§push(_loc7_.zpp_inner.y == _loc10_);
            }
            if(!§§pop())
            {
               _loc7_.zpp_inner.x = _loc9_;
               _loc7_.zpp_inner.y = _loc10_;
               _loc6_ = _loc7_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc7_;
         }
         _loc7_.zpp_inner.weak = param2;
         return _loc7_;
      }
      
      public function isStatic() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_BodyType_STATIC;
      }
      
      public function isKinematic() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_BodyType_KINEMATIC;
      }
      
      public function isDynamic() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_BodyType_DYNAMIC;
      }
      
      public function interactingBodies(param1:InteractionType = undefined, param2:int = -1, param3:BodyList = undefined) : BodyList
      {
         if(param1 == null)
         {
            §§push(ZPP_Arbiter.COL | ZPP_Arbiter.SENSOR | ZPP_Arbiter.FLUID);
         }
         else
         {
            §§push(param1);
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.InteractionType_COLLISION)
            {
               §§push(ZPP_Arbiter.COL);
            }
            else
            {
               §§push(param1);
               if(ZPP_Flags.InteractionType_SENSOR == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               §§push(§§pop() == ZPP_Flags.InteractionType_SENSOR ? ZPP_Arbiter.SENSOR : ZPP_Arbiter.FLUID);
            }
         }
         var _loc4_:int = §§pop();
         return zpp_inner.interactingBodies(_loc4_,param2,param3);
      }
      
      public function integrate(param1:Number) : Body
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:* = null as ZPP_Shape;
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Cannot integrate by NaN time";
         }
         zpp_inner.immutable_midstep("Body::space");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 == 0)
         {
            return this;
         }
         var _loc2_:ZPP_Body = zpp_inner;
         _loc2_.sweepTime = 0;
         _loc2_.sweep_angvel = _loc2_.angvel;
         var _loc3_:Number = param1 - _loc2_.sweepTime;
         if(_loc3_ != 0)
         {
            _loc2_.sweepTime = param1;
            _loc4_ = _loc3_;
            _loc2_.posx += _loc2_.velx * _loc4_;
            _loc2_.posy += _loc2_.vely * _loc4_;
            if(_loc2_.angvel != 0)
            {
               _loc4_ = _loc2_.sweep_angvel * _loc3_;
               _loc2_.rot += _loc4_;
               if(_loc4_ * _loc4_ > 0.0001)
               {
                  _loc2_.axisx = Math.sin(_loc2_.rot);
                  _loc2_.axisy = Math.cos(_loc2_.rot);
               }
               else
               {
                  _loc5_ = _loc4_ * _loc4_;
                  _loc6_ = 1 - 0.5 * _loc5_;
                  _loc7_ = 1 - _loc5_ * _loc5_ / 8;
                  _loc8_ = (_loc6_ * _loc2_.axisx + _loc4_ * _loc2_.axisy) * _loc7_;
                  _loc2_.axisy = (_loc6_ * _loc2_.axisy - _loc4_ * _loc2_.axisx) * _loc7_;
                  _loc2_.axisx = _loc8_;
               }
            }
         }
         var _loc9_:ZNPNode_ZPP_Shape = _loc2_.shapes.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            if(_loc10_.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc10_.polygon.invalidate_gverts();
               _loc10_.polygon.invalidate_gaxi();
            }
            _loc10_.invalidate_worldCOM();
            _loc9_ = _loc9_.next;
         }
         _loc2_.zip_worldCOM = true;
         _loc2_.zip_axis = true;
         _loc9_ = _loc2_.shapes.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            if(_loc10_.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc10_.polygon.invalidate_gverts();
               _loc10_.polygon.invalidate_gaxi();
            }
            _loc10_.invalidate_worldCOM();
            _loc9_ = _loc9_.next;
         }
         _loc2_.zip_worldCOM = true;
         _loc2_.sweepTime = 0;
         return this;
      }
      
      public function get worldCOM() : Vec2
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world has no " + "worldCOM";
         }
         if(zpp_inner.wrap_worldCOM == null)
         {
            _loc1_ = zpp_inner.worldCOMx;
            _loc2_ = zpp_inner.worldCOMy;
            _loc3_ = false;
            §§push(zpp_inner);
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
            §§pop().wrap_worldCOM = _loc4_;
            zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
            zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
            zpp_inner.wrap_worldCOM.zpp_inner._validate = zpp_inner.getworldCOM;
         }
         return zpp_inner.wrap_worldCOM;
      }
      
      public function get velocity() : Vec2
      {
         if(zpp_inner.wrap_vel == null)
         {
            zpp_inner.setupVelocity();
         }
         return zpp_inner.wrap_vel;
      }
      
      public function get type() : BodyType
      {
         §§push(null);
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_STATIC);
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_DYNAMIC);
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.type];
      }
      
      public function get torque() : Number
      {
         return zpp_inner.torque;
      }
      
      public function get surfaceVel() : Vec2
      {
         if(zpp_inner.wrap_svel == null)
         {
            zpp_inner.setupsvel();
         }
         return zpp_inner.wrap_svel;
      }
      
      public function get space() : Space
      {
         return zpp_inner.space == null ? null : zpp_inner.space.outer;
      }
      
      public function get shapes() : ShapeList
      {
         return zpp_inner.wrap_shapes;
      }
      
      public function get rotation() : Number
      {
         return zpp_inner.rot;
      }
      
      public function get position() : Vec2
      {
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         return zpp_inner.wrap_pos;
      }
      
      public function get massMode() : MassMode
      {
         if(ZPP_Flags.MassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_DEFAULT = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.MassMode_DEFAULT);
         if(ZPP_Flags.MassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_FIXED = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.massMode];
      }
      
      public function get mass() : Number
      {
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world has no mass";
         }
         zpp_inner.validate_mass();
         if(zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT && zpp_inner.shapes.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: Given current mass mode, Body::mass only makes sense if it contains shapes";
         }
         return zpp_inner.cmass;
      }
      
      public function get localCOM() : Vec2
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world has no " + "localCOM";
         }
         if(zpp_inner.wrap_localCOM == null)
         {
            _loc1_ = zpp_inner.localCOMx;
            _loc2_ = zpp_inner.localCOMy;
            _loc3_ = false;
            §§push(zpp_inner);
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
            §§pop().wrap_localCOM = _loc4_;
            zpp_inner.wrap_localCOM.zpp_inner._inuse = true;
            zpp_inner.wrap_localCOM.zpp_inner._immutable = true;
            zpp_inner.wrap_localCOM.zpp_inner._validate = zpp_inner.getlocalCOM;
         }
         return zpp_inner.wrap_localCOM;
      }
      
      public function get kinematicVel() : Vec2
      {
         if(zpp_inner.wrap_kinvel == null)
         {
            zpp_inner.setupkinvel();
         }
         return zpp_inner.wrap_kinvel;
      }
      
      public function get kinAngVel() : Number
      {
         return zpp_inner.kinangvel;
      }
      
      public function get isSleeping() : Boolean
      {
         if(zpp_inner.space == null)
         {
            Boot.lastError = new Error();
            throw "Error: isSleeping makes no sense if the object is not contained within a Space";
         }
         return zpp_inner.component.sleeping;
      }
      
      public function get isBullet() : Boolean
      {
         return zpp_inner.bulletEnabled;
      }
      
      public function get inertiaMode() : InertiaMode
      {
         if(ZPP_Flags.InertiaMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.InertiaMode_DEFAULT);
         if(ZPP_Flags.InertiaMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.inertiaMode];
      }
      
      public function get inertia() : Number
      {
         var _loc1_:* = null as ShapeList;
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world has no inertia";
         }
         zpp_inner.validate_inertia();
         if(zpp_inner.inertiaMode == ZPP_Flags.id_InertiaMode_DEFAULT && _loc1_.zpp_inner.inner.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: Given current inertia mode flag, Body::inertia only makes sense if Body contains Shapes";
         }
         return zpp_inner.cinertia;
      }
      
      public function get gravMassScale() : Number
      {
         zpp_inner.validate_gravMassScale();
         if(zpp_inner.shapes.head == null)
         {
            if(zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT && zpp_inner.gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
            {
               Boot.lastError = new Error();
               throw "Error: Given current mass/gravMass modes; Body::gravMassScale only makes sense if it contains Shapes";
            }
         }
         return zpp_inner.gravMassScale;
      }
      
      public function get gravMassMode() : GravMassMode
      {
         if(ZPP_Flags.GravMassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.GravMassMode_DEFAULT);
         if(ZPP_Flags.GravMassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.GravMassMode_FIXED);
         if(ZPP_Flags.GravMassMode_SCALED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.massMode];
      }
      
      public function get gravMass() : Number
      {
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world has no gravMass";
         }
         zpp_inner.validate_gravMass();
         if(zpp_inner.shapes.head == null)
         {
            if(zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT && zpp_inner.gravMassMode != ZPP_Flags.id_GravMassMode_FIXED)
            {
               Boot.lastError = new Error();
               throw "Error: Given current mass/gravMass modes; Body::gravMass only makes sense if it contains Shapes";
            }
         }
         return zpp_inner.gravMass;
      }
      
      public function get force() : Vec2
      {
         if(zpp_inner.wrap_force == null)
         {
            zpp_inner.setupForce();
         }
         return zpp_inner.wrap_force;
      }
      
      public function get disableCCD() : Boolean
      {
         return zpp_inner.disableCCD;
      }
      
      public function get constraints() : ConstraintList
      {
         if(zpp_inner.wrap_constraints == null)
         {
            zpp_inner.wrap_constraints = ZPP_ConstraintList.get(zpp_inner.constraints,true);
         }
         return zpp_inner.wrap_constraints;
      }
      
      public function get constraintVelocity() : Vec3
      {
         if(zpp_inner.wrapcvel == null)
         {
            zpp_inner.setup_cvel();
         }
         return zpp_inner.wrapcvel;
      }
      
      public function get constraintMass() : Number
      {
         if(!zpp_inner.world)
         {
            zpp_inner.validate_mass();
         }
         return zpp_inner.smass;
      }
      
      public function get constraintInertia() : Number
      {
         if(!zpp_inner.world)
         {
            zpp_inner.validate_inertia();
         }
         return zpp_inner.sinertia;
      }
      
      public function get compound() : Compound
      {
         return zpp_inner.compound == null ? null : zpp_inner.compound.outer;
      }
      
      public function get bounds() : AABB
      {
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world has no bounds";
         }
         return zpp_inner.aabb.wrapper();
      }
      
      public function get arbiters() : ArbiterList
      {
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         return zpp_inner.wrap_arbiters;
      }
      
      public function get angularVel() : Number
      {
         return zpp_inner.angvel;
      }
      
      public function get allowRotation() : Boolean
      {
         return !zpp_inner.norotate;
      }
      
      public function get allowMovement() : Boolean
      {
         return !zpp_inner.nomove;
      }
      
      public function dragImpulse(param1:Body = undefined) : Vec3
      {
         var _loc7_:* = null as Arbiter;
         var _loc8_:int = 0;
         var _loc9_:* = null as ZPP_Arbiter;
         var _loc10_:* = null as Vec3;
         var _loc11_:* = null as Arbiter;
         var _loc12_:int = 0;
         var _loc13_:* = null as ZPP_Vec3;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc6_:ArbiterIterator = zpp_inner.wrap_arbiters.iterator();
         while(true)
         {
            _loc6_.zpp_inner.zpp_inner.valmod();
            _loc8_ = _loc6_.zpp_inner.zpp_gl();
            _loc6_.zpp_critical = true;
            if(!(_loc6_.zpp_i < _loc8_ ? true : (_loc6_.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc6_, _loc6_.zpp_inner = null, false)))
            {
               break;
            }
            _loc6_.zpp_critical = false;
            _loc6_.zpp_i = (_loc8_ = _loc6_.zpp_i) + 1;
            _loc7_ = _loc6_.zpp_inner.at(_loc8_);
            _loc9_ = _loc7_.zpp_inner;
            if(_loc9_.type == ZPP_Arbiter.FLUID)
            {
               if(!(param1 != null && _loc9_.b2 != param1.zpp_inner && _loc9_.b1 != param1.zpp_inner))
               {
                  _loc11_ = _loc9_.wrapper();
                  _loc10_ = (_loc11_.zpp_inner.type == ZPP_Arbiter.FLUID ? _loc11_.zpp_inner.fluidarb.outer_zn : null).dragImpulse(this);
                  _loc8_ = 1;
                  _loc12_ = _loc8_;
                  §§push(_loc2_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc10_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc2_ = §§pop() + _loc10_.zpp_inner.x * _loc12_;
                  §§push(_loc3_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc10_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc3_ = §§pop() + _loc10_.zpp_inner.y * _loc12_;
                  §§push(_loc4_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc10_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc4_ = §§pop() + _loc10_.zpp_inner.z * _loc8_;
                  _loc10_.dispose();
               }
            }
         }
         return Vec3.get(_loc2_,_loc3_,_loc4_);
      }
      
      public function crushFactor() : Number
      {
         var _loc6_:* = null as Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc10_:* = null as Arbiter;
         var _loc12_:* = null as Vec3;
         var _loc13_:* = null as Vec2;
         var _loc14_:* = null as ZPP_Vec2;
         var _loc16_:* = null as ConstraintList;
         var _loc17_:* = null as Constraint;
         Boot.lastError = new Error();
         throw "Error: Makes no sense to see how much an object not taking part in a simulation is being crushed";
      }
      
      public function copy() : Body
      {
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world cannot be copied";
         }
         return zpp_inner.copy();
      }
      
      public function contains(param1:Vec2) : Boolean
      {
         var _loc5_:* = null as ZPP_Shape;
         var _loc6_:* = null as ZPP_Vec2;
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
            throw "Error: Cannot check containment of null point";
         }
         var _loc2_:Boolean = param1.zpp_inner.weak;
         param1.zpp_inner.weak = false;
         var _loc3_:Boolean = false;
         var _loc4_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            if(_loc5_.outer.contains(param1))
            {
               _loc3_ = true;
               break;
            }
            _loc4_ = _loc4_.next;
         }
         param1.zpp_inner.weak = _loc2_;
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
            _loc8_ = _loc6_;
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
         return _loc3_;
      }
      
      public function constraintsImpulse() : Vec3
      {
         var _loc5_:* = null as ZPP_Constraint;
         var _loc6_:* = null as Vec3;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null as ZPP_Vec3;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:ZNPNode_ZPP_Constraint = zpp_inner.constraints.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc6_ = _loc5_.outer.bodyImpulse(this);
            _loc7_ = 1;
            _loc8_ = _loc7_;
            §§push(_loc1_);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc9_ = _loc6_.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            _loc1_ = §§pop() + _loc6_.zpp_inner.x * _loc8_;
            §§push(_loc2_);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc9_ = _loc6_.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            _loc2_ = §§pop() + _loc6_.zpp_inner.y * _loc8_;
            §§push(_loc3_);
            if(_loc6_ != null && _loc6_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc9_ = _loc6_.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            _loc3_ = §§pop() + _loc6_.zpp_inner.z * _loc7_;
            _loc6_.dispose();
            _loc4_ = _loc4_.next;
         }
         return Vec3.get(_loc1_,_loc2_,_loc3_);
      }
      
      public function connectedBodies(param1:int = -1, param2:BodyList = undefined) : BodyList
      {
         return zpp_inner.connectedBodies(param1,param2);
      }
      
      public function buoyancyImpulse(param1:Body = undefined) : Vec3
      {
         var _loc7_:* = null as Arbiter;
         var _loc8_:int = 0;
         var _loc9_:* = null as ZPP_Arbiter;
         var _loc10_:* = null as Vec3;
         var _loc11_:* = null as Arbiter;
         var _loc12_:int = 0;
         var _loc13_:* = null as ZPP_Vec3;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc6_:ArbiterIterator = zpp_inner.wrap_arbiters.iterator();
         while(true)
         {
            _loc6_.zpp_inner.zpp_inner.valmod();
            _loc8_ = _loc6_.zpp_inner.zpp_gl();
            _loc6_.zpp_critical = true;
            if(!(_loc6_.zpp_i < _loc8_ ? true : (_loc6_.zpp_next = ArbiterIterator.zpp_pool, ArbiterIterator.zpp_pool = _loc6_, _loc6_.zpp_inner = null, false)))
            {
               break;
            }
            _loc6_.zpp_critical = false;
            _loc6_.zpp_i = (_loc8_ = _loc6_.zpp_i) + 1;
            _loc7_ = _loc6_.zpp_inner.at(_loc8_);
            _loc9_ = _loc7_.zpp_inner;
            if(_loc9_.type == ZPP_Arbiter.FLUID)
            {
               if(!(param1 != null && _loc9_.b2 != param1.zpp_inner && _loc9_.b1 != param1.zpp_inner))
               {
                  _loc11_ = _loc9_.wrapper();
                  _loc10_ = (_loc11_.zpp_inner.type == ZPP_Arbiter.FLUID ? _loc11_.zpp_inner.fluidarb.outer_zn : null).buoyancyImpulse(this);
                  _loc8_ = 1;
                  _loc12_ = _loc8_;
                  §§push(_loc2_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc10_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc2_ = §§pop() + _loc10_.zpp_inner.x * _loc12_;
                  §§push(_loc3_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc10_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc3_ = §§pop() + _loc10_.zpp_inner.y * _loc12_;
                  §§push(_loc4_);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
                  }
                  _loc13_ = _loc10_.zpp_inner;
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc4_ = §§pop() + _loc10_.zpp_inner.z * _loc8_;
                  _loc10_.dispose();
               }
            }
         }
         return Vec3.get(_loc2_,_loc3_,_loc4_);
      }
      
      public function applyImpulse(param1:Vec2, param2:Vec2 = undefined, param3:Boolean = false) : Body
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
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
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot apply null impulse to Body";
         }
         §§push(false);
         if(param3)
         {
            §§pop();
            if(zpp_inner.space == null)
            {
               Boot.lastError = new Error();
               throw "Error: isSleeping makes no sense if the object is not contained within a Space";
            }
            §§push(zpp_inner.component.sleeping);
         }
         if(§§pop())
         {
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
               _loc5_ = param1;
               _loc5_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc5_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc5_;
               }
               ZPP_PubPool.nextVec2 = _loc5_;
               _loc5_.zpp_disp = true;
               _loc6_ = _loc4_;
               if(_loc6_.outer != null)
               {
                  _loc6_.outer.zpp_inner = null;
                  _loc6_.outer = null;
               }
               _loc6_._isimmutable = null;
               _loc6_._validate = null;
               _loc6_._invalidate = null;
               _loc6_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc6_;
            }
            return this;
         }
         zpp_inner.validate_mass();
         _loc7_ = zpp_inner.imass;
         §§push(zpp_inner);
         §§push(zpp_inner.velx);
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
         §§pop().velx = §§pop() + param1.zpp_inner.x * _loc7_;
         §§push(zpp_inner);
         §§push(zpp_inner.vely);
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
         §§pop().vely = §§pop() + param1.zpp_inner.y * _loc7_;
         if(param2 != null)
         {
            _loc7_ = 0;
            _loc8_ = 0;
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
            _loc7_ = param2.zpp_inner.x - zpp_inner.posx;
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
            _loc8_ = param2.zpp_inner.y - zpp_inner.posy;
            zpp_inner.validate_inertia();
            §§push(zpp_inner);
            §§push(zpp_inner.angvel);
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
            §§push(param1.zpp_inner.y * _loc7_);
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
            §§pop().angvel = §§pop() + (§§pop() - param1.zpp_inner.x * _loc8_) * zpp_inner.iinertia;
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
               _loc5_ = param2;
               _loc5_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc5_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc5_;
               }
               ZPP_PubPool.nextVec2 = _loc5_;
               _loc5_.zpp_disp = true;
               _loc6_ = _loc4_;
               if(_loc6_.outer != null)
               {
                  _loc6_.outer.zpp_inner = null;
                  _loc6_.outer = null;
               }
               _loc6_._isimmutable = null;
               _loc6_._validate = null;
               _loc6_._invalidate = null;
               _loc6_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc6_;
            }
         }
         if(!param3)
         {
            if(zpp_inner.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
               zpp_inner.wake();
            }
         }
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
            _loc5_ = param1;
            _loc5_.zpp_pool = null;
            if(ZPP_PubPool.nextVec2 != null)
            {
               ZPP_PubPool.nextVec2.zpp_pool = _loc5_;
            }
            else
            {
               ZPP_PubPool.poolVec2 = _loc5_;
            }
            ZPP_PubPool.nextVec2 = _loc5_;
            _loc5_.zpp_disp = true;
            _loc6_ = _loc4_;
            if(_loc6_.outer != null)
            {
               _loc6_.outer.zpp_inner = null;
               _loc6_.outer = null;
            }
            _loc6_._isimmutable = null;
            _loc6_._validate = null;
            _loc6_._invalidate = null;
            _loc6_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc6_;
         }
         return this;
      }
      
      public function applyAngularImpulse(param1:Number, param2:Boolean = false) : Body
      {
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         §§push(false);
         if(param2)
         {
            §§pop();
            if(zpp_inner.space == null)
            {
               Boot.lastError = new Error();
               throw "Error: isSleeping makes no sense if the object is not contained within a Space";
            }
            §§push(zpp_inner.component.sleeping);
         }
         if(§§pop())
         {
            return this;
         }
         zpp_inner.validate_inertia();
         zpp_inner.angvel += param1 * zpp_inner.iinertia;
         if(!param2)
         {
            if(zpp_inner.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
               zpp_inner.wake();
            }
         }
         return this;
      }
      
      public function align() : Body
      {
         var _loc2_:Number = NaN;
         var _loc5_:* = null as Vec2;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZPP_Vec2;
         zpp_inner.immutable_midstep("Body::align()");
         if(zpp_inner.world)
         {
            Boot.lastError = new Error();
            throw "Error: Space::world is immutable";
         }
         if(zpp_inner.shapes.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot align empty Body";
         }
         zpp_inner.validate_localCOM();
         _loc2_ = -zpp_inner.localCOMx;
         var _loc3_:Number = -zpp_inner.localCOMy;
         if(_loc2_ != _loc2_ || _loc3_ != _loc3_)
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
            _loc7_.y = _loc3_;
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
            if(_loc2_ != _loc2_ || _loc3_ != _loc3_)
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
               §§push(_loc5_.zpp_inner.y == _loc3_);
            }
            if(!§§pop())
            {
               _loc5_.zpp_inner.x = _loc2_;
               _loc5_.zpp_inner.y = _loc3_;
               _loc7_ = _loc5_.zpp_inner;
               if(_loc7_._invalidate != null)
               {
                  _loc7_._invalidate(_loc7_);
               }
            }
            _loc5_;
         }
         _loc5_.zpp_inner.weak = false;
         var _loc1_:Vec2 = _loc5_;
         translateShapes(_loc1_);
         _loc5_ = localVectorToWorld(_loc1_);
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         zpp_inner.wrap_pos.subeq(_loc5_);
         if(zpp_inner.pre_posx < 1.79e+308)
         {
            _loc2_ = 1;
            §§push(zpp_inner);
            §§push(zpp_inner.pre_posx);
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
            §§pop().pre_posx = §§pop() - _loc5_.zpp_inner.x * _loc2_;
            §§push(zpp_inner);
            §§push(zpp_inner.pre_posy);
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
            §§pop().pre_posy = §§pop() - _loc5_.zpp_inner.y * _loc2_;
         }
         if(_loc1_ != null && _loc1_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc7_ = _loc1_.zpp_inner;
         if(_loc7_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc7_._isimmutable != null)
         {
            _loc7_._isimmutable();
         }
         if(_loc1_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc7_ = _loc1_.zpp_inner;
         _loc1_.zpp_inner.outer = null;
         _loc1_.zpp_inner = null;
         var _loc8_:Vec2 = _loc1_;
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
         var _loc9_:ZPP_Vec2 = _loc7_;
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
         if(_loc5_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc7_ = _loc5_.zpp_inner;
         _loc5_.zpp_inner.outer = null;
         _loc5_.zpp_inner = null;
         _loc8_ = _loc5_;
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
         _loc9_ = _loc7_;
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
         return this;
      }
   }
}
