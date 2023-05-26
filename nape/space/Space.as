package nape.space
{
   import flash.Boot;
   import nape.callbacks.InteractionType;
   import nape.callbacks.ListenerList;
   import nape.constraint.Constraint;
   import nape.constraint.ConstraintIterator;
   import nape.constraint.ConstraintList;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.InteractionFilter;
   import nape.geom.AABB;
   import nape.geom.ConvexResult;
   import nape.geom.ConvexResultList;
   import nape.geom.Ray;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyIterator;
   import nape.phys.BodyList;
   import nape.phys.Compound;
   import nape.phys.CompoundIterator;
   import nape.phys.CompoundList;
   import nape.shape.Shape;
   import nape.shape.ShapeIterator;
   import nape.shape.ShapeList;
   import nape.shape.ValidationResult;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.dynamics.ZPP_InteractionGroup;
   import zpp_nape.dynamics.ZPP_SpaceArbiterList;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class Space
   {
       
      
      public var zpp_inner:ZPP_Space;
      
      public function Space(param1:Vec2 = undefined, param2:Broadphase = undefined)
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
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
         zpp_inner = new ZPP_Space(param1 == null ? null : param1.zpp_inner,param2);
         zpp_inner.outer = this;
         if(param1 != null)
         {
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
               _loc4_ = param1;
               _loc4_.zpp_pool = null;
               if(ZPP_PubPool.nextVec2 != null)
               {
                  ZPP_PubPool.nextVec2.zpp_pool = _loc4_;
               }
               else
               {
                  ZPP_PubPool.poolVec2 = _loc4_;
               }
               ZPP_PubPool.nextVec2 = _loc4_;
               _loc4_.zpp_disp = true;
               _loc5_ = _loc3_;
               if(_loc5_.outer != null)
               {
                  _loc5_.outer.zpp_inner = null;
                  _loc5_.outer = null;
               }
               _loc5_._isimmutable = null;
               _loc5_._validate = null;
               _loc5_._invalidate = null;
               _loc5_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc5_;
            }
         }
      }
      
      public function visitConstraints(param1:Function) : void
      {
         var _loc3_:* = null as ConstraintList;
         var _loc4_:* = null as Constraint;
         var _loc5_:int = 0;
         var _loc7_:* = null as CompoundList;
         var _loc8_:* = null as Compound;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: lambda cannot be null for Space::visitConstraints";
         }
         _loc3_ = zpp_inner.wrap_constraints;
         _loc3_.zpp_inner.valmod();
         var _loc2_:ConstraintIterator = ConstraintIterator.get(_loc3_);
         while(true)
         {
            _loc2_.zpp_inner.zpp_inner.valmod();
            _loc3_ = _loc2_.zpp_inner;
            _loc3_.zpp_inner.valmod();
            if(_loc3_.zpp_inner.zip_length)
            {
               _loc3_.zpp_inner.zip_length = false;
               _loc3_.zpp_inner.user_length = _loc3_.zpp_inner.inner.length;
            }
            _loc5_ = _loc3_.zpp_inner.user_length;
            _loc2_.zpp_critical = true;
            if(!(_loc2_.zpp_i < _loc5_ ? true : (_loc2_.zpp_next = ConstraintIterator.zpp_pool, ConstraintIterator.zpp_pool = _loc2_, _loc2_.zpp_inner = null, false)))
            {
               break;
            }
            _loc2_.zpp_critical = false;
            _loc2_.zpp_i = (_loc5_ = _loc2_.zpp_i) + 1;
            _loc4_ = _loc2_.zpp_inner.at(_loc5_);
            param1(_loc4_);
         }
         _loc7_ = zpp_inner.wrap_compounds;
         _loc7_.zpp_inner.valmod();
         var _loc6_:CompoundIterator = CompoundIterator.get(_loc7_);
         while(true)
         {
            _loc6_.zpp_inner.zpp_inner.valmod();
            _loc7_ = _loc6_.zpp_inner;
            _loc7_.zpp_inner.valmod();
            if(_loc7_.zpp_inner.zip_length)
            {
               _loc7_.zpp_inner.zip_length = false;
               _loc7_.zpp_inner.user_length = _loc7_.zpp_inner.inner.length;
            }
            _loc5_ = _loc7_.zpp_inner.user_length;
            _loc6_.zpp_critical = true;
            if(!(_loc6_.zpp_i < _loc5_ ? true : (_loc6_.zpp_next = CompoundIterator.zpp_pool, CompoundIterator.zpp_pool = _loc6_, _loc6_.zpp_inner = null, false)))
            {
               break;
            }
            _loc6_.zpp_critical = false;
            _loc6_.zpp_i = (_loc5_ = _loc6_.zpp_i) + 1;
            _loc8_ = _loc6_.zpp_inner.at(_loc5_);
            _loc8_.visitConstraints(param1);
         }
      }
      
      public function visitCompounds(param1:Function) : void
      {
         var _loc3_:* = null as CompoundList;
         var _loc4_:* = null as Compound;
         var _loc5_:int = 0;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: lambda cannot be null for Space::visitCompounds";
         }
         _loc3_ = zpp_inner.wrap_compounds;
         _loc3_.zpp_inner.valmod();
         var _loc2_:CompoundIterator = CompoundIterator.get(_loc3_);
         while(true)
         {
            _loc2_.zpp_inner.zpp_inner.valmod();
            _loc3_ = _loc2_.zpp_inner;
            _loc3_.zpp_inner.valmod();
            if(_loc3_.zpp_inner.zip_length)
            {
               _loc3_.zpp_inner.zip_length = false;
               _loc3_.zpp_inner.user_length = _loc3_.zpp_inner.inner.length;
            }
            _loc5_ = _loc3_.zpp_inner.user_length;
            _loc2_.zpp_critical = true;
            if(!(_loc2_.zpp_i < _loc5_ ? true : (_loc2_.zpp_next = CompoundIterator.zpp_pool, CompoundIterator.zpp_pool = _loc2_, _loc2_.zpp_inner = null, false)))
            {
               break;
            }
            _loc2_.zpp_critical = false;
            _loc2_.zpp_i = (_loc5_ = _loc2_.zpp_i) + 1;
            _loc4_ = _loc2_.zpp_inner.at(_loc5_);
            param1(_loc4_);
            _loc4_.visitCompounds(param1);
         }
      }
      
      public function visitBodies(param1:Function) : void
      {
         var _loc3_:* = null as BodyList;
         var _loc4_:* = null as Body;
         var _loc5_:int = 0;
         var _loc7_:* = null as CompoundList;
         var _loc8_:* = null as Compound;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: lambda cannot be null for Space::visitBodies";
         }
         _loc3_ = zpp_inner.wrap_bodies;
         _loc3_.zpp_inner.valmod();
         var _loc2_:BodyIterator = BodyIterator.get(_loc3_);
         while(true)
         {
            _loc2_.zpp_inner.zpp_inner.valmod();
            _loc3_ = _loc2_.zpp_inner;
            _loc3_.zpp_inner.valmod();
            if(_loc3_.zpp_inner.zip_length)
            {
               _loc3_.zpp_inner.zip_length = false;
               _loc3_.zpp_inner.user_length = _loc3_.zpp_inner.inner.length;
            }
            _loc5_ = _loc3_.zpp_inner.user_length;
            _loc2_.zpp_critical = true;
            if(!(_loc2_.zpp_i < _loc5_ ? true : (_loc2_.zpp_next = BodyIterator.zpp_pool, BodyIterator.zpp_pool = _loc2_, _loc2_.zpp_inner = null, false)))
            {
               break;
            }
            _loc2_.zpp_critical = false;
            _loc2_.zpp_i = (_loc5_ = _loc2_.zpp_i) + 1;
            _loc4_ = _loc2_.zpp_inner.at(_loc5_);
            param1(_loc4_);
         }
         _loc7_ = zpp_inner.wrap_compounds;
         _loc7_.zpp_inner.valmod();
         var _loc6_:CompoundIterator = CompoundIterator.get(_loc7_);
         while(true)
         {
            _loc6_.zpp_inner.zpp_inner.valmod();
            _loc7_ = _loc6_.zpp_inner;
            _loc7_.zpp_inner.valmod();
            if(_loc7_.zpp_inner.zip_length)
            {
               _loc7_.zpp_inner.zip_length = false;
               _loc7_.zpp_inner.user_length = _loc7_.zpp_inner.inner.length;
            }
            _loc5_ = _loc7_.zpp_inner.user_length;
            _loc6_.zpp_critical = true;
            if(!(_loc6_.zpp_i < _loc5_ ? true : (_loc6_.zpp_next = CompoundIterator.zpp_pool, CompoundIterator.zpp_pool = _loc6_, _loc6_.zpp_inner = null, false)))
            {
               break;
            }
            _loc6_.zpp_critical = false;
            _loc6_.zpp_i = (_loc5_ = _loc6_.zpp_i) + 1;
            _loc8_ = _loc6_.zpp_inner.at(_loc5_);
            _loc8_.visitBodies(param1);
         }
      }
      
      public function step(param1:Number, param2:int = 10, param3:int = 10) : void
      {
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: deltaTime cannot be NaN";
         }
         if(param1 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: deltaTime must be strictly positive";
         }
         if(param2 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: must use atleast one velocity iteration";
         }
         if(param3 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: must use atleast one position iteration";
         }
         zpp_inner.step(param1,param2,param3);
      }
      
      public function shapesUnderPoint(param1:Vec2, param2:InteractionFilter = undefined, param3:ShapeList = undefined) : ShapeList
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate shapes under a null point :)";
         }
         §§push(zpp_inner);
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
         §§push(param1.zpp_inner.x);
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
         var _loc4_:ShapeList = §§pop().shapesUnderPoint(§§pop(),param1.zpp_inner.y,param2 == null ? null : param2.zpp_inner,param3);
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
         return _loc4_;
      }
      
      public function shapesInShape(param1:Shape, param2:Boolean = false, param3:InteractionFilter = undefined, param4:ShapeList = undefined) : ShapeList
      {
         var _loc5_:* = null as ValidationResult;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate shapes in a null shapes :)";
         }
         Boot.lastError = new Error();
         throw "Error: Query shape needs to be inside a Body to be well defined :)";
      }
      
      public function shapesInCircle(param1:Vec2, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined, param5:ShapeList = undefined) : ShapeList
      {
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate shapes at null circle :)";
         }
         if(param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Circle radius cannot be NaN";
         }
         if(param2 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Circle radius must be strictly positive";
         }
         var _loc6_:ShapeList = zpp_inner.shapesInCircle(param1,param2,param3,param4 == null ? null : param4.zpp_inner,param5);
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
         }
         return _loc6_;
      }
      
      public function shapesInBody(param1:Body, param2:InteractionFilter = undefined, param3:ShapeList = undefined) : ShapeList
      {
         var _loc6_:* = null as ShapeList;
         var _loc7_:* = null as Shape;
         var _loc8_:int = 0;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate shapes in null body";
         }
         var _loc4_:ShapeList = param3 == null ? new ShapeList() : param3;
         _loc6_ = param1.zpp_inner.wrap_shapes;
         _loc6_.zpp_inner.valmod();
         var _loc5_:ShapeIterator = ShapeIterator.get(_loc6_);
         while(true)
         {
            _loc5_.zpp_inner.zpp_inner.valmod();
            _loc6_ = _loc5_.zpp_inner;
            _loc6_.zpp_inner.valmod();
            if(_loc6_.zpp_inner.zip_length)
            {
               _loc6_.zpp_inner.zip_length = false;
               _loc6_.zpp_inner.user_length = _loc6_.zpp_inner.inner.length;
            }
            _loc8_ = _loc6_.zpp_inner.user_length;
            _loc5_.zpp_critical = true;
            if(!(_loc5_.zpp_i < _loc8_ ? true : (_loc5_.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc5_, _loc5_.zpp_inner = null, false)))
            {
               break;
            }
            _loc5_.zpp_critical = false;
            _loc5_.zpp_i = (_loc8_ = _loc5_.zpp_i) + 1;
            _loc7_ = _loc5_.zpp_inner.at(_loc8_);
            _loc6_ = shapesInShape(_loc7_,false,param2,_loc4_);
         }
         return _loc4_;
      }
      
      public function shapesInAABB(param1:AABB, param2:Boolean = false, param3:Boolean = true, param4:InteractionFilter = undefined, param5:ShapeList = undefined) : ShapeList
      {
         var _loc6_:* = null as ZPP_AABB;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate shapes in a null AABB :)";
         }
         _loc6_ = param1.zpp_inner;
         §§push(true);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_.maxx - _loc6_.minx != 0)
         {
            §§pop();
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc6_ = param1.zpp_inner;
            §§push(_loc6_.maxy - _loc6_.miny == 0);
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate shapes in degenerate AABB :/";
         }
         return zpp_inner.shapesInAABB(param1,param3,param2,param4 == null ? null : param4.zpp_inner,param5);
      }
      
      public function set worldLinearDrag(param1:Number) : Number
      {
         var _loc2_:Number = param1;
         if(_loc2_ != _loc2_)
         {
            Boot.lastError = new Error();
            throw "Error: Space::worldLinearDrag cannot be NaN";
         }
         zpp_inner.global_lin_drag = _loc2_;
         return zpp_inner.global_lin_drag;
      }
      
      public function set worldAngularDrag(param1:Number) : Number
      {
         var _loc2_:Number = param1;
         if(_loc2_ != _loc2_)
         {
            Boot.lastError = new Error();
            throw "Error: Space::worldAngularDrag cannot be NaN";
         }
         zpp_inner.global_ang_drag = _loc2_;
         return zpp_inner.global_ang_drag;
      }
      
      public function set sortContacts(param1:Boolean) : Boolean
      {
         zpp_inner.sortcontacts = param1;
         return zpp_inner.sortcontacts;
      }
      
      public function set gravity(param1:Vec2) : Vec2
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
            throw "Error: Space::gravity cannot be null";
         }
         if(zpp_inner.wrap_gravity == null)
         {
            zpp_inner.getgravity();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_gravity;
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
         if(zpp_inner.wrap_gravity == null)
         {
            zpp_inner.getgravity();
         }
         return zpp_inner.wrap_gravity;
      }
      
      public function rayMultiCast(param1:Ray, param2:Boolean = false, param3:InteractionFilter = undefined, param4:RayResultList = undefined) : RayResultList
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot cast null ray :)";
         }
         return zpp_inner.rayMultiCast(param1,param2,param3,param4);
      }
      
      public function rayCast(param1:Ray, param2:Boolean = false, param3:InteractionFilter = undefined) : RayResult
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot cast null ray :)";
         }
         return zpp_inner.rayCast(param1,param2,param3);
      }
      
      public function interactionType(param1:Shape, param2:Shape) : InteractionType
      {
         var _loc9_:* = null as ZPP_Constraint;
         var _loc10_:* = null as ZPP_InteractionGroup;
         var _loc11_:* = null as ZPP_Interactor;
         var _loc12_:* = null as ZPP_InteractionGroup;
         var _loc13_:Boolean = false;
         var _loc14_:* = null as ZPP_InteractionFilter;
         var _loc15_:* = null as ZPP_InteractionFilter;
         if(param1 == null || param2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate interaction type for null shapes";
         }
         if(true)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate interaction type for shapes not part of a Body";
         }
         if((param1.zpp_inner.body != null ? param1.zpp_inner.body.outer : null).zpp_inner.type == ZPP_Flags.id_BodyType_STATIC && (param2.zpp_inner.body != null ? param2.zpp_inner.body.outer : null).zpp_inner.type == ZPP_Flags.id_BodyType_STATIC)
         {
            return null;
         }
         if((param1.zpp_inner.body != null ? param1.zpp_inner.body.outer : null) == (param2.zpp_inner.body != null ? param2.zpp_inner.body.outer : null))
         {
            return null;
         }
         var _loc3_:ZPP_Shape = param1.zpp_inner;
         var _loc4_:ZPP_Shape = param2.zpp_inner;
         var _loc5_:ZPP_Body = _loc3_.body;
         var _loc6_:ZPP_Body = _loc4_.body;
         var _loc7_:Boolean = false;
         var _loc8_:ZNPNode_ZPP_Constraint = _loc5_.constraints.head;
         while(_loc8_ != null)
         {
            _loc9_ = _loc8_.elt;
            if(_loc9_.ignore && _loc9_.pair_exists(_loc5_.id,_loc6_.id))
            {
               _loc7_ = true;
               break;
            }
            _loc8_ = _loc8_.next;
         }
         switch(!_loc7_ && !§§pop() ? ((_loc3_.sensorEnabled || _loc4_.sensorEnabled) && ((_loc14_.sensorMask & _loc15_.sensorGroup) != 0 && (_loc15_.sensorMask & _loc14_.sensorGroup) != 0) ? 2 : ((_loc3_.fluidEnabled || _loc4_.fluidEnabled) && ((_loc14_.fluidMask & _loc15_.fluidGroup) != 0 && (_loc15_.fluidMask & _loc14_.fluidGroup) != 0) && !(_loc5_.imass == 0 && _loc6_.imass == 0 && _loc5_.iinertia == 0 && _loc6_.iinertia == 0) ? 0 : (_loc14_ = _loc3_.filter, _loc15_ = _loc4_.filter, (_loc14_.collisionMask & _loc15_.collisionGroup) != 0 && (_loc15_.collisionMask & _loc14_.collisionGroup) != 0 && !(_loc5_.imass == 0 && _loc6_.imass == 0 && _loc5_.iinertia == 0 && _loc6_.iinertia == 0) ? 1 : -1))) : -1)
         {
            case 0:
               if(ZPP_Flags.InteractionType_FLUID == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_FLUID = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               break;
            case 1:
               §§push(ZPP_Flags.InteractionType_FLUID);
               if(ZPP_Flags.InteractionType_COLLISION == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               break;
            case 2:
               §§push(ZPP_Flags.InteractionType_COLLISION);
               if(ZPP_Flags.InteractionType_SENSOR == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
         }
         ZPP_Flags.InteractionType_SENSOR;
         return null;
      }
      
      public function get worldLinearDrag() : Number
      {
         return zpp_inner.global_lin_drag;
      }
      
      public function get worldAngularDrag() : Number
      {
         return zpp_inner.global_ang_drag;
      }
      
      public function get world() : Body
      {
         return zpp_inner.__static;
      }
      
      public function get userData() : *
      {
         if(zpp_inner.userData == null)
         {
            zpp_inner.userData = {};
         }
         return zpp_inner.userData;
      }
      
      public function get timeStamp() : int
      {
         return zpp_inner.stamp;
      }
      
      public function get sortContacts() : Boolean
      {
         return zpp_inner.sortcontacts;
      }
      
      public function get liveConstraints() : ConstraintList
      {
         return zpp_inner.wrap_livecon;
      }
      
      public function get liveBodies() : BodyList
      {
         return zpp_inner.wrap_live;
      }
      
      public function get listeners() : ListenerList
      {
         return zpp_inner.wrap_listeners;
      }
      
      public function get gravity() : Vec2
      {
         if(zpp_inner.wrap_gravity == null)
         {
            zpp_inner.getgravity();
         }
         return zpp_inner.wrap_gravity;
      }
      
      public function get elapsedTime() : Number
      {
         return zpp_inner.time;
      }
      
      public function get constraints() : ConstraintList
      {
         return zpp_inner.wrap_constraints;
      }
      
      public function get compounds() : CompoundList
      {
         return zpp_inner.wrap_compounds;
      }
      
      public function get broadphase() : Broadphase
      {
         if(zpp_inner.bphase.is_sweep)
         {
            if(ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Broadphase_SWEEP_AND_PRUNE);
         }
         else
         {
            if(ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE = new Broadphase();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE);
         }
         return §§pop();
      }
      
      public function get bodies() : BodyList
      {
         return zpp_inner.wrap_bodies;
      }
      
      public function get arbiters() : ArbiterList
      {
         var _loc1_:* = null as ZPP_SpaceArbiterList;
         if(zpp_inner.wrap_arbiters == null)
         {
            _loc1_ = new ZPP_SpaceArbiterList();
            _loc1_.space = zpp_inner;
            zpp_inner.wrap_arbiters = _loc1_;
         }
         return zpp_inner.wrap_arbiters;
      }
      
      public function convexMultiCast(param1:Shape, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined, param5:ConvexResultList = undefined) : ConvexResultList
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot cast null shape :)";
         }
         Boot.lastError = new Error();
         throw "Error: Shape must belong to a body to be cast.";
      }
      
      public function convexCast(param1:Shape, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined) : ConvexResult
      {
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot cast null shape :)";
         }
         Boot.lastError = new Error();
         throw "Error: Shape must belong to a body to be cast.";
      }
      
      public function clear() : void
      {
         if(zpp_inner.midstep)
         {
            Boot.lastError = new Error();
            throw "Error: Space::clear() cannot be called during space step()";
         }
         zpp_inner.clear();
      }
      
      public function bodiesUnderPoint(param1:Vec2, param2:InteractionFilter = undefined, param3:BodyList = undefined) : BodyList
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate objects under a null point :)";
         }
         §§push(zpp_inner);
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
         §§push(param1.zpp_inner.x);
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
         var _loc4_:BodyList = §§pop().bodiesUnderPoint(§§pop(),param1.zpp_inner.y,param2 == null ? null : param2.zpp_inner,param3);
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
         return _loc4_;
      }
      
      public function bodiesInShape(param1:Shape, param2:Boolean = false, param3:InteractionFilter = undefined, param4:BodyList = undefined) : BodyList
      {
         var _loc5_:* = null as ValidationResult;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate bodies in a null shapes :)";
         }
         Boot.lastError = new Error();
         throw "Error: Query shape needs to be inside a Body to be well defined :)";
      }
      
      public function bodiesInCircle(param1:Vec2, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined, param5:BodyList = undefined) : BodyList
      {
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate objects at null circle :)";
         }
         if(param2 != param2)
         {
            Boot.lastError = new Error();
            throw "Error: Circle radius cannot be NaN";
         }
         if(param2 <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Circle radius must be strictly positive";
         }
         var _loc6_:BodyList = zpp_inner.bodiesInCircle(param1,param2,param3,param4 == null ? null : param4.zpp_inner,param5);
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
         }
         return _loc6_;
      }
      
      public function bodiesInBody(param1:Body, param2:InteractionFilter = undefined, param3:BodyList = undefined) : BodyList
      {
         var _loc6_:* = null as ShapeList;
         var _loc7_:* = null as Shape;
         var _loc8_:int = 0;
         var _loc9_:* = null as BodyList;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate shapes in null body";
         }
         var _loc4_:BodyList = param3 == null ? new BodyList() : param3;
         _loc6_ = param1.zpp_inner.wrap_shapes;
         _loc6_.zpp_inner.valmod();
         var _loc5_:ShapeIterator = ShapeIterator.get(_loc6_);
         while(true)
         {
            _loc5_.zpp_inner.zpp_inner.valmod();
            _loc6_ = _loc5_.zpp_inner;
            _loc6_.zpp_inner.valmod();
            if(_loc6_.zpp_inner.zip_length)
            {
               _loc6_.zpp_inner.zip_length = false;
               _loc6_.zpp_inner.user_length = _loc6_.zpp_inner.inner.length;
            }
            _loc8_ = _loc6_.zpp_inner.user_length;
            _loc5_.zpp_critical = true;
            if(!(_loc5_.zpp_i < _loc8_ ? true : (_loc5_.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc5_, _loc5_.zpp_inner = null, false)))
            {
               break;
            }
            _loc5_.zpp_critical = false;
            _loc5_.zpp_i = (_loc8_ = _loc5_.zpp_i) + 1;
            _loc7_ = _loc5_.zpp_inner.at(_loc8_);
            _loc9_ = bodiesInShape(_loc7_,false,param2,_loc4_);
         }
         return _loc4_;
      }
      
      public function bodiesInAABB(param1:AABB, param2:Boolean = false, param3:Boolean = true, param4:InteractionFilter = undefined, param5:BodyList = undefined) : BodyList
      {
         var _loc6_:* = null as ZPP_AABB;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate objects in a null AABB :)";
         }
         _loc6_ = param1.zpp_inner;
         §§push(true);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc6_ = param1.zpp_inner;
         if(_loc6_.maxx - _loc6_.minx != 0)
         {
            §§pop();
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc6_ = param1.zpp_inner;
            §§push(_loc6_.maxy - _loc6_.miny == 0);
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: Cannot evaluate objects in degenerate AABB :/";
         }
         return zpp_inner.bodiesInAABB(param1,param3,param2,param4 == null ? null : param4.zpp_inner,param5);
      }
   }
}
