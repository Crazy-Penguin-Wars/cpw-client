package nape.phys
{
   import flash.Boot;
   import nape.constraint.Constraint;
   import nape.constraint.ConstraintIterator;
   import nape.constraint.ConstraintList;
   import nape.geom.Vec2;
   import nape.shape.ShapeList;
   import nape.space.Space;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public final class Compound extends Interactor
   {
       
      
      public var zpp_inner:ZPP_Compound;
      
      public function Compound()
      {
         var _loc2_:* = null;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         try
         {
            super();
         }
         catch(_loc_e_:*)
         {
            zpp_inner = new ZPP_Compound();
            zpp_inner.outer = this;
            zpp_inner.outer_i = this;
            zpp_inner_i = zpp_inner;
            zpp_inner.insert_cbtype(ZPP_CbType.ANY_COMPOUND.zpp_inner);
            return;
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
            throw "Error: lambda cannot be null for Compound::visitConstraints";
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
            throw "Error: lambda cannot be null for Compound::visitConstraints";
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
            throw "Error: lambda cannot be null for Compound::visitBodies";
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
      
      public function translate(param1:Vec2) : Compound
      {
         var translation:Vec2;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         translation = param1;
         if(translation != null && translation.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(translation == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot translate by null Vec2";
         }
         var _loc2_:Boolean = translation.zpp_inner.weak;
         translation.zpp_inner.weak = false;
         visitBodies(function(param1:Body):void
         {
            if(param1.zpp_inner.wrap_pos == null)
            {
               param1.zpp_inner.setupPosition();
            }
            param1.zpp_inner.wrap_pos.addeq(translation);
         });
         translation.zpp_inner.weak = _loc2_;
         if(translation.zpp_inner.weak)
         {
            if(translation != null && translation.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc3_ = translation.zpp_inner;
            if(_loc3_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc3_._isimmutable != null)
            {
               _loc3_._isimmutable();
            }
            if(translation.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc3_ = translation.zpp_inner;
            translation.zpp_inner.outer = null;
            translation.zpp_inner = null;
            _loc4_ = translation;
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
         return this;
      }
      
      override public function toString() : String
      {
         return "Compound" + zpp_inner_i.id;
      }
      
      public function set space(param1:Space) : Space
      {
         var _loc2_:* = null as CompoundList;
         if(zpp_inner.compound != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set the space of an inner Compound, only the root Compound space can be set";
         }
         zpp_inner.immutable_midstep("Compound::space");
         if((zpp_inner.space == null ? null : zpp_inner.space.outer) != param1)
         {
            if(param1 != null)
            {
               _loc2_ = param1.zpp_inner.wrap_compounds;
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
      
      public function set compound(param1:Compound) : Compound
      {
         var _loc2_:* = null as CompoundList;
         zpp_inner.immutable_midstep("Compound::compound");
         if((zpp_inner.compound == null ? null : zpp_inner.compound.outer) != param1)
         {
            if(param1 != null)
            {
               _loc2_ = param1.zpp_inner.wrap_compounds;
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
      
      public function rotate(param1:Vec2, param2:Number) : Compound
      {
         var angle:Number;
         var centre:Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         centre = param1;
         angle = param2;
         if(centre != null && centre.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         if(centre == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot rotate about a null Vec2";
         }
         if(angle != angle)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot rotate by NaN radians";
         }
         var _loc3_:Boolean = centre.zpp_inner.weak;
         centre.zpp_inner.weak = false;
         visitBodies(function(param1:Body):void
         {
            param1.rotate(centre,angle);
         });
         centre.zpp_inner.weak = _loc3_;
         if(centre.zpp_inner.weak)
         {
            if(centre != null && centre.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = centre.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            if(centre.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc4_ = centre.zpp_inner;
            centre.zpp_inner.outer = null;
            centre.zpp_inner = null;
            _loc5_ = centre;
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
      
      public function get space() : Space
      {
         return zpp_inner.space == null ? null : zpp_inner.space.outer;
      }
      
      public function get constraints() : ConstraintList
      {
         return zpp_inner.wrap_constraints;
      }
      
      public function get compounds() : CompoundList
      {
         return zpp_inner.wrap_compounds;
      }
      
      public function get compound() : Compound
      {
         return zpp_inner.compound == null ? null : zpp_inner.compound.outer;
      }
      
      public function get bodies() : BodyList
      {
         return zpp_inner.wrap_bodies;
      }
      
      public function copy() : Compound
      {
         return zpp_inner.copy();
      }
      
      public function breakApart() : void
      {
         zpp_inner.breakApart();
      }
      
      public function COM(param1:Boolean = false) : Vec2
      {
         var total:Number;
         var ret:Vec2;
         var _loc2_:* = null as Vec2;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as ZPP_Vec2;
         §§push(§§newactivation());
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc2_ = new Vec2();
         }
         else
         {
            _loc2_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc2_.zpp_pool;
            _loc2_.zpp_pool = null;
            _loc2_.zpp_disp = false;
            if(_loc2_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc2_.zpp_inner == null)
         {
            _loc3_ = false;
            §§push(_loc2_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc4_ = new ZPP_Vec2();
            }
            else
            {
               _loc4_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc4_.next;
               _loc4_.next = null;
            }
            _loc4_.weak = false;
            _loc4_._immutable = _loc3_;
            _loc4_.x = 0;
            _loc4_.y = 0;
            §§pop().zpp_inner = _loc4_;
            _loc2_.zpp_inner.outer = _loc2_;
         }
         else
         {
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc2_.zpp_inner;
            if(_loc4_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc4_._isimmutable != null)
            {
               _loc4_._isimmutable();
            }
            §§push(false);
            if(_loc2_ != null && _loc2_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc4_ = _loc2_.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            if(_loc2_.zpp_inner.x == 0)
            {
               §§pop();
               if(_loc2_ != null && _loc2_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc4_ = _loc2_.zpp_inner;
               if(_loc4_._validate != null)
               {
                  _loc4_._validate();
               }
               §§push(_loc2_.zpp_inner.y == 0);
            }
            if(!§§pop())
            {
               _loc2_.zpp_inner.x = 0;
               _loc2_.zpp_inner.y = 0;
               _loc4_ = _loc2_.zpp_inner;
               if(_loc4_._invalidate != null)
               {
                  _loc4_._invalidate(_loc4_);
               }
            }
            _loc2_;
         }
         _loc2_.zpp_inner.weak = param1;
         §§pop().§§slot[1] = _loc2_;
         total = 0;
         visitBodies(function(param1:Body):void
         {
            var _loc3_:Number = NaN;
            var _loc4_:Number = NaN;
            var _loc5_:Boolean = false;
            var _loc6_:* = null as Vec2;
            var _loc7_:Boolean = false;
            var _loc8_:* = null as ZPP_Vec2;
            var _loc2_:ShapeList = param1.zpp_inner.wrap_shapes;
            if(_loc2_.zpp_inner.inner.head != null)
            {
               §§push(ret);
               if(param1.zpp_inner.world)
               {
                  Boot.lastError = new Error();
                  throw "Error: Space::world has no " + "worldCOM";
               }
               if(param1.zpp_inner.wrap_worldCOM == null)
               {
                  _loc3_ = param1.zpp_inner.worldCOMx;
                  _loc4_ = param1.zpp_inner.worldCOMy;
                  _loc5_ = false;
                  §§push(param1.zpp_inner);
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
                  §§pop().wrap_worldCOM = _loc6_;
                  param1.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                  param1.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                  param1.zpp_inner.wrap_worldCOM.zpp_inner._validate = param1.zpp_inner.getworldCOM;
               }
               §§push(param1.zpp_inner.wrap_worldCOM);
               if(param1.zpp_inner.world)
               {
                  Boot.lastError = new Error();
                  throw "Error: Space::world has no mass";
               }
               param1.zpp_inner.validate_mass();
               if(param1.zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT && param1.zpp_inner.shapes.head == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Given current mass mode, Body::mass only makes sense if it contains shapes";
               }
               §§pop().addeq(§§pop().mul(param1.zpp_inner.cmass,true));
               §§push(§§findproperty(total));
               §§push(total);
               if(param1.zpp_inner.world)
               {
                  Boot.lastError = new Error();
                  throw "Error: Space::world has no mass";
               }
               param1.zpp_inner.validate_mass();
               if(param1.zpp_inner.massMode == ZPP_Flags.id_MassMode_DEFAULT && param1.zpp_inner.shapes.head == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Given current mass mode, Body::mass only makes sense if it contains shapes";
               }
               §§pop().total = §§pop() + param1.zpp_inner.cmass;
            }
         });
         if(total == 0)
         {
            Boot.lastError = new Error();
            throw "Error: COM of an empty Compound is undefined silly";
         }
         ret.muleq(1 / total);
         return ret;
      }
   }
}
