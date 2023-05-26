package zpp_nape.constraint
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.Config;
   import nape.constraint.Constraint;
   import nape.constraint.PivotJoint;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.util.Debug;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_PivotJoint extends ZPP_Constraint
   {
       
      
      public var wrap_a2:Vec2;
      
      public var wrap_a1:Vec2;
      
      public var stepped:Boolean;
      
      public var outer_zn:PivotJoint;
      
      public var kMassc:Number;
      
      public var kMassb:Number;
      
      public var kMassa:Number;
      
      public var jMax:Number;
      
      public var jAccy:Number;
      
      public var jAccx:Number;
      
      public var gamma:Number;
      
      public var biasy:Number;
      
      public var biasx:Number;
      
      public var b2:ZPP_Body;
      
      public var b1:ZPP_Body;
      
      public var a2rely:Number;
      
      public var a2relx:Number;
      
      public var a2localy:Number;
      
      public var a2localx:Number;
      
      public var a1rely:Number;
      
      public var a1relx:Number;
      
      public var a1localy:Number;
      
      public var a1localx:Number;
      
      public function ZPP_PivotJoint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         stepped = false;
         biasy = 0;
         biasx = 0;
         gamma = 0;
         jMax = 0;
         jAccy = 0;
         jAccx = 0;
         kMassc = 0;
         kMassb = 0;
         kMassa = 0;
         wrap_a2 = null;
         a2rely = 0;
         a2relx = 0;
         a2localy = 0;
         a2localx = 0;
         b2 = null;
         wrap_a1 = null;
         a1rely = 0;
         a1relx = 0;
         a1localy = 0;
         a1localx = 0;
         b1 = null;
         outer_zn = null;
         super();
         stepped = false;
         jAccx = 0;
         jAccy = 0;
         jMax = 1.79e+308;
         a1localx = 0;
         a1localy = 0;
         a1relx = 0;
         a1rely = 0;
         a2localx = 0;
         a2localy = 0;
         a2relx = 0;
         a2rely = 0;
      }
      
      override public function warmStart() : void
      {
         var _loc1_:Number = b1.imass;
         b1.velx -= jAccx * _loc1_;
         b1.vely -= jAccy * _loc1_;
         _loc1_ = b2.imass;
         b2.velx += jAccx * _loc1_;
         b2.vely += jAccy * _loc1_;
         b1.angvel -= (jAccy * a1relx - jAccx * a1rely) * b1.iinertia;
         b2.angvel += (jAccy * a2relx - jAccx * a2rely) * b2.iinertia;
      }
      
      override public function wake_connected() : void
      {
         if(b1 != null && b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            b1.wake();
         }
         if(b2 != null && b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            b2.wake();
         }
      }
      
      public function validate_a2() : void
      {
         wrap_a2.zpp_inner.x = a2localx;
         wrap_a2.zpp_inner.y = a2localy;
      }
      
      public function validate_a1() : void
      {
         wrap_a1.zpp_inner.x = a1localx;
         wrap_a1.zpp_inner.y = a1localy;
      }
      
      override public function validate() : void
      {
         if(b1 == null || b2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: PivotJoint cannot be simulated null bodies";
         }
         if(b1 == b2)
         {
            Boot.lastError = new Error();
            throw "Error: PivotJoint cannot be simulated with body1 == body2 (body1=body2=" + b1.outer.toString() + ")";
         }
         if(b1.space != space || b2.space != space)
         {
            Boot.lastError = new Error();
            throw "Error: Constraints must have each body within the same space to which the constraint has been assigned (body1=" + b1.outer.toString() + ", body2=" + b2.outer.toString() + ")";
         }
         if(b1.type != ZPP_Flags.id_BodyType_DYNAMIC && b2.type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            Boot.lastError = new Error();
            throw "Error: Constraints cannot have both bodies non-dynamic (body1=" + b1.outer.toString() + ", body2=" + b2.outer.toString() + ")";
         }
      }
      
      public function setup_a2() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = a2localx;
         var _loc2_:Number = a2localy;
         §§push(§§findproperty(wrap_a2));
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
         _loc4_.zpp_inner.weak = false;
         §§pop().wrap_a2 = _loc4_;
         wrap_a2.zpp_inner._inuse = true;
         wrap_a2.zpp_inner._validate = validate_a2;
         wrap_a2.zpp_inner._invalidate = invalidate_a2;
      }
      
      public function setup_a1() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = a1localx;
         var _loc2_:Number = a1localy;
         §§push(§§findproperty(wrap_a1));
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
         _loc4_.zpp_inner.weak = false;
         §§pop().wrap_a1 = _loc4_;
         wrap_a1.zpp_inner._inuse = true;
         wrap_a1.zpp_inner._validate = validate_a1;
         wrap_a1.zpp_inner._invalidate = invalidate_a1;
      }
      
      override public function preStep(param1:Number) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:int = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(pre_dt == -1)
         {
            pre_dt = param1;
         }
         var _loc2_:Number = param1 / pre_dt;
         pre_dt = param1;
         stepped = true;
         a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
         a1rely = a1localx * b1.axisx + a1localy * b1.axisy;
         a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
         a2rely = a2localx * b2.axisx + a2localy * b2.axisy;
         _loc3_ = b1.smass + b2.smass;
         kMassa = _loc3_;
         kMassb = 0;
         kMassc = _loc3_;
         if(b1.sinertia != 0)
         {
            _loc4_ = a1relx * b1.sinertia;
            _loc5_ = a1rely * b1.sinertia;
            kMassa += _loc5_ * a1rely;
            kMassb += -_loc5_ * a1relx;
            kMassc += _loc4_ * a1relx;
         }
         if(b2.sinertia != 0)
         {
            _loc4_ = a2relx * b2.sinertia;
            _loc5_ = a2rely * b2.sinertia;
            kMassa += _loc5_ * a2rely;
            kMassb += -_loc5_ * a2relx;
            kMassc += _loc4_ * a2relx;
         }
         _loc3_ = kMassa * kMassc - kMassb * kMassb;
         if(_loc3_ != _loc3_)
         {
            kMassa = kMassb = kMassc = 0;
            §§push(3);
         }
         else if(_loc3_ == 0)
         {
            _loc7_ = 0;
            if(kMassa != 0)
            {
               kMassa = 1 / kMassa;
            }
            else
            {
               kMassa = 0;
               _loc7_ |= 1;
            }
            if(kMassc != 0)
            {
               kMassc = 1 / kMassc;
            }
            else
            {
               kMassc = 0;
               _loc7_ |= 2;
            }
            kMassb = 0;
            §§push(_loc7_);
         }
         else
         {
            _loc3_ = 1 / _loc3_;
            _loc4_ = kMassc * _loc3_;
            kMassc = kMassa * _loc3_;
            kMassa = _loc4_;
            kMassb *= -_loc3_;
            §§push(0);
         }
         var _loc6_:int = §§pop();
         if((_loc6_ & 1) != 0)
         {
            jAccx = 0;
         }
         if((_loc6_ & 2) != 0)
         {
            jAccy = 0;
         }
         if(!stiff)
         {
            _loc5_ = 2 * Math.PI * frequency;
            gamma = 1 / (param1 * _loc5_ * (2 * damping + _loc5_ * param1));
            _loc8_ = 1 / (1 + gamma);
            _loc3_ = param1 * _loc5_ * _loc5_ * gamma;
            gamma *= _loc8_;
            _loc4_ = _loc8_;
            kMassa *= _loc4_;
            kMassb *= _loc4_;
            kMassc *= _loc4_;
            biasx = b2.posx + a2relx - (b1.posx + a1relx);
            biasy = b2.posy + a2rely - (b1.posy + a1rely);
            if(breakUnderError && biasx * biasx + biasy * biasy > maxError * maxError)
            {
               return true;
            }
            _loc4_ = -_loc3_;
            biasx *= _loc4_;
            biasy *= _loc4_;
            _loc4_ = maxError;
            _loc5_ = biasx * biasx + biasy * biasy;
            if(_loc5_ > _loc4_ * _loc4_)
            {
               sf32(_loc5_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc9_ = lf32(0);
               _loc8_ = _loc4_ * (_loc9_ * (1.5 - 0.5 * _loc5_ * _loc9_ * _loc9_));
               biasx *= _loc8_;
               biasy *= _loc8_;
            }
         }
         else
         {
            biasx = 0;
            biasy = 0;
            gamma = 0;
         }
         _loc3_ = _loc2_;
         jAccx *= _loc3_;
         jAccy *= _loc3_;
         jMax = maxForce * param1;
         return false;
      }
      
      override public function pair_exists(param1:int, param2:int) : Boolean
      {
         return b1.id == param1 && b2.id == param2 || b1.id == param2 && b2.id == param1;
      }
      
      public function invalidate_a2(param1:ZPP_Vec2) : void
      {
         immutable_midstep("Constraint::" + "a2");
         a2localx = param1.x;
         a2localy = param1.y;
         wake();
      }
      
      public function invalidate_a1(param1:ZPP_Vec2) : void
      {
         immutable_midstep("Constraint::" + "a1");
         a1localx = param1.x;
         a1localy = param1.y;
         wake();
      }
      
      override public function inactiveBodies() : void
      {
         if(b1 != null)
         {
            b1.constraints.remove(this);
         }
         if(b2 != b1)
         {
            if(b2 != null)
            {
               b2.constraints.remove(this);
            }
         }
      }
      
      override public function forest() : void
      {
         var _loc1_:* = null as ZPP_Component;
         var _loc2_:* = null as ZPP_Component;
         var _loc3_:* = null as ZPP_Component;
         var _loc4_:* = null as ZPP_Component;
         var _loc5_:* = null as ZPP_Component;
         if(b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            if(b1.component == b1.component.parent)
            {
               §§push(b1.component);
            }
            else
            {
               _loc2_ = b1.component;
               _loc3_ = null;
               while(_loc2_ != _loc2_.parent)
               {
                  _loc4_ = _loc2_.parent;
                  _loc2_.parent = _loc3_;
                  _loc3_ = _loc2_;
                  _loc2_ = _loc4_;
               }
               while(_loc3_ != null)
               {
                  _loc4_ = _loc3_.parent;
                  _loc3_.parent = _loc2_;
                  _loc3_ = _loc4_;
               }
               §§push(_loc2_);
            }
            _loc1_ = §§pop();
            if(component == component.parent)
            {
               §§push(component);
            }
            else
            {
               _loc3_ = component;
               _loc4_ = null;
               while(_loc3_ != _loc3_.parent)
               {
                  _loc5_ = _loc3_.parent;
                  _loc3_.parent = _loc4_;
                  _loc4_ = _loc3_;
                  _loc3_ = _loc5_;
               }
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_.parent;
                  _loc4_.parent = _loc3_;
                  _loc4_ = _loc5_;
               }
               §§push(_loc3_);
            }
            _loc2_ = §§pop();
            if(_loc1_ != _loc2_)
            {
               if(_loc1_.rank < _loc2_.rank)
               {
                  _loc1_.parent = _loc2_;
               }
               else if(_loc1_.rank > _loc2_.rank)
               {
                  _loc2_.parent = _loc1_;
               }
               else
               {
                  _loc2_.parent = _loc1_;
                  _loc1_.rank = _loc1_.rank + 1;
               }
            }
         }
         if(b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            if(b2.component == b2.component.parent)
            {
               §§push(b2.component);
            }
            else
            {
               _loc2_ = b2.component;
               _loc3_ = null;
               while(_loc2_ != _loc2_.parent)
               {
                  _loc4_ = _loc2_.parent;
                  _loc2_.parent = _loc3_;
                  _loc3_ = _loc2_;
                  _loc2_ = _loc4_;
               }
               while(_loc3_ != null)
               {
                  _loc4_ = _loc3_.parent;
                  _loc3_.parent = _loc2_;
                  _loc3_ = _loc4_;
               }
               §§push(_loc2_);
            }
            _loc1_ = §§pop();
            if(component == component.parent)
            {
               §§push(component);
            }
            else
            {
               _loc3_ = component;
               _loc4_ = null;
               while(_loc3_ != _loc3_.parent)
               {
                  _loc5_ = _loc3_.parent;
                  _loc3_.parent = _loc4_;
                  _loc4_ = _loc3_;
                  _loc3_ = _loc5_;
               }
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_.parent;
                  _loc4_.parent = _loc3_;
                  _loc4_ = _loc5_;
               }
               §§push(_loc3_);
            }
            _loc2_ = §§pop();
            if(_loc1_ != _loc2_)
            {
               if(_loc1_.rank < _loc2_.rank)
               {
                  _loc1_.parent = _loc2_;
               }
               else if(_loc1_.rank > _loc2_.rank)
               {
                  _loc2_.parent = _loc1_;
               }
               else
               {
                  _loc2_.parent = _loc1_;
                  _loc1_.rank = _loc1_.rank + 1;
               }
            }
         }
      }
      
      override public function draw(param1:Debug) : void
      {
         var _loc5_:* = null as Vec2;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc2_:PivotJoint = outer_zn;
         §§push(_loc2_.zpp_inner_zn.b1 == null ? null : _loc2_.zpp_inner_zn.b1.outer);
         if(_loc2_.zpp_inner_zn.wrap_a1 == null)
         {
            _loc2_.zpp_inner_zn.setup_a1();
         }
         var _loc3_:Vec2 = §§pop().localPointToWorld(_loc2_.zpp_inner_zn.wrap_a1);
         §§push(_loc2_.zpp_inner_zn.b2 == null ? null : _loc2_.zpp_inner_zn.b2.outer);
         if(_loc2_.zpp_inner_zn.wrap_a2 == null)
         {
            _loc2_.zpp_inner_zn.setup_a2();
         }
         var _loc4_:Vec2 = §§pop().localPointToWorld(_loc2_.zpp_inner_zn.wrap_a2);
         if(!stiff)
         {
            _loc5_ = _loc4_.sub(_loc3_);
            if(_loc5_ != null && _loc5_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            §§push(Math);
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
            §§push(_loc5_.zpp_inner.x);
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
            §§push(§§pop() * _loc5_.zpp_inner.x);
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
            §§push(_loc5_.zpp_inner.y);
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
            _loc6_ = Number(§§pop().sqrt(§§pop() + §§pop() * _loc5_.zpp_inner.y));
            if(_loc6_ != 0)
            {
               param1.drawSpring(_loc3_,_loc4_,16711935);
            }
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
         }
         param1.drawFilledCircle(_loc3_,2,255);
         param1.drawFilledCircle(_loc4_,2,16711680);
         if(_loc3_ != null && _loc3_.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         _loc7_ = _loc3_.zpp_inner;
         if(_loc7_._immutable)
         {
            Boot.lastError = new Error();
            throw "Error: Vec2 is immutable";
         }
         if(_loc7_._isimmutable != null)
         {
            _loc7_._isimmutable();
         }
         if(_loc3_.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: This Vec2 is not disposable";
         }
         _loc7_ = _loc3_.zpp_inner;
         _loc3_.zpp_inner.outer = null;
         _loc3_.zpp_inner = null;
         _loc5_ = _loc3_;
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
      
      override public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
      {
         var ret:PivotJoint;
         var _loc4_:* = null as Body;
         var _loc5_:int = 0;
         var _loc6_:* = null as ZPP_CopyHelper;
         var _loc3_:PivotJoint = outer_zn;
         §§push(§§newactivation());
         §§push(§§findproperty(PivotJoint));
         §§push(null);
         §§push(null);
         if(_loc3_.zpp_inner_zn.wrap_a1 == null)
         {
            _loc3_.zpp_inner_zn.setup_a1();
         }
         _loc3_ = outer_zn;
         §§push(_loc3_.zpp_inner_zn.wrap_a1);
         if(_loc3_.zpp_inner_zn.wrap_a2 == null)
         {
            _loc3_.zpp_inner_zn.setup_a2();
         }
         §§pop().§§slot[1] = new §§pop().PivotJoint(§§pop(),§§pop(),§§pop(),_loc3_.zpp_inner_zn.wrap_a2);
         copyto(ret);
         if(param1 != null && b1 != null)
         {
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc6_ = param1[_loc5_];
               _loc5_++;
               if(_loc6_.id == b1.id)
               {
                  _loc4_ = _loc6_.bc;
                  break;
               }
            }
            if(_loc4_ != null)
            {
               ret.zpp_inner_zn.b1 = _loc4_.zpp_inner;
            }
            else
            {
               param2.push(ZPP_CopyHelper.todo(b1.id,function(param1:Body):void
               {
                  ret.zpp_inner_zn.b1 = param1.zpp_inner;
               }));
            }
         }
         if(param1 != null && b2 != null)
         {
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < param1.length)
            {
               _loc6_ = param1[_loc5_];
               _loc5_++;
               if(_loc6_.id == b2.id)
               {
                  _loc4_ = _loc6_.bc;
                  break;
               }
            }
            if(_loc4_ != null)
            {
               ret.zpp_inner_zn.b2 = _loc4_.zpp_inner;
            }
            else
            {
               param2.push(ZPP_CopyHelper.todo(b2.id,function(param1:Body):void
               {
                  ret.zpp_inner_zn.b2 = param1.zpp_inner;
               }));
            }
         }
         return ret;
      }
      
      override public function clearcache() : void
      {
         jAccx = 0;
         jAccy = 0;
         pre_dt = -1;
      }
      
      public function bodyImpulse(param1:ZPP_Body) : Vec3
      {
         if(stepped)
         {
            if(param1 == b1)
            {
               return Vec3.get(-jAccx,-jAccy,-(jAccy * a1relx - jAccx * a1rely));
            }
            return Vec3.get(jAccx,jAccy,jAccy * a2relx - jAccx * a2rely);
         }
         return Vec3.get(0,0,0);
      }
      
      override public function applyImpulseVel() : Boolean
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         _loc1_ = b2.velx + b2.kinvelx - a2rely * (b2.angvel + b2.kinangvel) - (b1.velx + b1.kinvelx - a1rely * (b1.angvel + b1.kinangvel));
         _loc2_ = b2.vely + b2.kinvely + a2relx * (b2.angvel + b2.kinangvel) - (b1.vely + b1.kinvely + a1relx * (b1.angvel + b1.kinangvel));
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         _loc3_ = biasx - _loc1_;
         _loc4_ = biasy - _loc2_;
         var _loc5_:Number = kMassa * _loc3_ + kMassb * _loc4_;
         _loc4_ = kMassb * _loc3_ + kMassc * _loc4_;
         _loc3_ = _loc5_;
         _loc5_ = gamma;
         _loc3_ -= jAccx * _loc5_;
         _loc4_ -= jAccy * _loc5_;
         _loc5_ = 0;
         var _loc6_:Number = 0;
         _loc5_ = jAccx;
         _loc6_ = jAccy;
         _loc7_ = 1;
         jAccx += _loc3_ * _loc7_;
         jAccy += _loc4_ * _loc7_;
         if(breakUnderForce)
         {
            if(jAccx * jAccx + jAccy * jAccy > jMax * jMax)
            {
               return true;
            }
         }
         else if(!stiff)
         {
            _loc7_ = jMax;
            _loc8_ = jAccx * jAccx + jAccy * jAccy;
            if(_loc8_ > _loc7_ * _loc7_)
            {
               sf32(_loc8_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc10_ = lf32(0);
               _loc9_ = _loc7_ * (_loc10_ * (1.5 - 0.5 * _loc8_ * _loc10_ * _loc10_));
               jAccx *= _loc9_;
               jAccy *= _loc9_;
            }
         }
         _loc3_ = jAccx - _loc5_;
         _loc4_ = jAccy - _loc6_;
         _loc5_ = b1.imass;
         b1.velx -= _loc3_ * _loc5_;
         b1.vely -= _loc4_ * _loc5_;
         _loc5_ = b2.imass;
         b2.velx += _loc3_ * _loc5_;
         b2.vely += _loc4_ * _loc5_;
         b1.angvel -= (_loc4_ * a1relx - _loc3_ * a1rely) * b1.iinertia;
         b2.angvel += (_loc4_ * a2relx - _loc3_ * a2rely) * b2.iinertia;
         return false;
      }
      
      override public function applyImpulsePos() : Boolean
      {
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         _loc1_ = b1.axisy * a1localx - b1.axisx * a1localy;
         _loc2_ = a1localx * b1.axisx + a1localy * b1.axisy;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         _loc3_ = b2.axisy * a2localx - b2.axisx * a2localy;
         _loc4_ = a2localx * b2.axisx + a2localy * b2.axisy;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         _loc5_ = b2.posx + _loc3_ - (b1.posx + _loc1_);
         _loc6_ = b2.posy + _loc4_ - (b1.posy + _loc2_);
         if(breakUnderError && _loc5_ * _loc5_ + _loc6_ * _loc6_ > maxError * maxError)
         {
            return true;
         }
         if(_loc5_ * _loc5_ + _loc6_ * _loc6_ < Config.constraintLinearSlop * Config.constraintLinearSlop)
         {
            return false;
         }
         var _loc7_:Number = 0.5;
         _loc5_ *= _loc7_;
         _loc6_ *= _loc7_;
         _loc7_ = 0;
         var _loc8_:Number = 0;
         if(_loc5_ * _loc5_ + _loc6_ * _loc6_ > 6)
         {
            _loc9_ = b1.smass + b2.smass;
            if(_loc9_ > Config.epsilon)
            {
               _loc9_ = 0.75 / _loc9_;
               _loc7_ = -_loc5_ * _loc9_;
               _loc8_ = -_loc6_ * _loc9_;
               _loc10_ = 20;
               _loc11_ = _loc7_ * _loc7_ + _loc8_ * _loc8_;
               if(_loc11_ > _loc10_ * _loc10_)
               {
                  sf32(_loc11_,0);
                  si32(1597463007 - (li32(0) >> 1),0);
                  _loc13_ = lf32(0);
                  _loc12_ = _loc10_ * (_loc13_ * (1.5 - 0.5 * _loc11_ * _loc13_ * _loc13_));
                  _loc7_ *= _loc12_;
                  _loc8_ *= _loc12_;
               }
               _loc11_ = b1.imass;
               b1.posx -= _loc7_ * _loc11_;
               b1.posy -= _loc8_ * _loc11_;
               _loc11_ = b2.imass;
               b2.posx += _loc7_ * _loc11_;
               b2.posy += _loc8_ * _loc11_;
               _loc5_ = b2.posx + _loc3_ - (b1.posx + _loc1_);
               _loc6_ = b2.posy + _loc4_ - (b1.posy + _loc2_);
               _loc11_ = 0.5;
               _loc5_ *= _loc11_;
               _loc6_ *= _loc11_;
            }
         }
         _loc9_ = 0;
         _loc11_ = 0;
         _loc12_ = 0;
         _loc13_ = b1.smass + b2.smass;
         _loc9_ = _loc13_;
         _loc11_ = 0;
         _loc12_ = _loc13_;
         if(b1.sinertia != 0)
         {
            _loc14_ = _loc1_ * b1.sinertia;
            _loc15_ = _loc2_ * b1.sinertia;
            _loc9_ += _loc15_ * _loc2_;
            _loc11_ += -_loc15_ * _loc1_;
            _loc12_ += _loc14_ * _loc1_;
         }
         if(b2.sinertia != 0)
         {
            _loc14_ = _loc3_ * b2.sinertia;
            _loc15_ = _loc4_ * b2.sinertia;
            _loc9_ += _loc15_ * _loc4_;
            _loc11_ += -_loc15_ * _loc3_;
            _loc12_ += _loc14_ * _loc3_;
         }
         _loc7_ = -_loc5_;
         _loc8_ = -_loc6_;
         _loc10_ = 6;
         _loc13_ = _loc7_ * _loc7_ + _loc8_ * _loc8_;
         if(_loc13_ > _loc10_ * _loc10_)
         {
            sf32(_loc13_,0);
            si32(1597463007 - (li32(0) >> 1),0);
            _loc15_ = lf32(0);
            _loc14_ = _loc10_ * (_loc15_ * (1.5 - 0.5 * _loc13_ * _loc15_ * _loc15_));
            _loc7_ *= _loc14_;
            _loc8_ *= _loc14_;
         }
         _loc13_ = _loc9_ * _loc12_ - _loc11_ * _loc11_;
         if(_loc13_ != _loc13_)
         {
            _loc7_ = _loc8_ = 0;
         }
         else if(_loc13_ == 0)
         {
            if(_loc9_ != 0)
            {
               _loc7_ /= _loc9_;
            }
            else
            {
               _loc7_ = 0;
            }
            if(_loc12_ != 0)
            {
               _loc8_ /= _loc12_;
            }
            else
            {
               _loc8_ = 0;
            }
         }
         else
         {
            _loc13_ = 1 / _loc13_;
            _loc14_ = _loc13_ * (_loc12_ * _loc7_ - _loc11_ * _loc8_);
            _loc8_ = _loc13_ * (_loc9_ * _loc8_ - _loc11_ * _loc7_);
            _loc7_ = _loc14_;
         }
         _loc13_ = b1.imass;
         b1.posx -= _loc7_ * _loc13_;
         b1.posy -= _loc8_ * _loc13_;
         _loc13_ = b2.imass;
         b2.posx += _loc7_ * _loc13_;
         b2.posy += _loc8_ * _loc13_;
         var _loc16_:ZPP_Body = b1;
         _loc13_ = -(_loc8_ * _loc1_ - _loc7_ * _loc2_) * b1.iinertia;
         _loc16_.rot += _loc13_;
         if(_loc13_ * _loc13_ > 0.0001)
         {
            _loc16_.axisx = Math.sin(_loc16_.rot);
            _loc16_.axisy = Math.cos(_loc16_.rot);
         }
         else
         {
            _loc14_ = _loc13_ * _loc13_;
            _loc15_ = 1 - 0.5 * _loc14_;
            _loc17_ = 1 - _loc14_ * _loc14_ / 8;
            _loc18_ = (_loc15_ * _loc16_.axisx + _loc13_ * _loc16_.axisy) * _loc17_;
            _loc16_.axisy = (_loc15_ * _loc16_.axisy - _loc13_ * _loc16_.axisx) * _loc17_;
            _loc16_.axisx = _loc18_;
         }
         _loc16_ = b2;
         _loc13_ = (_loc8_ * _loc3_ - _loc7_ * _loc4_) * b2.iinertia;
         _loc16_.rot += _loc13_;
         if(_loc13_ * _loc13_ > 0.0001)
         {
            _loc16_.axisx = Math.sin(_loc16_.rot);
            _loc16_.axisy = Math.cos(_loc16_.rot);
         }
         else
         {
            _loc14_ = _loc13_ * _loc13_;
            _loc15_ = 1 - 0.5 * _loc14_;
            _loc17_ = 1 - _loc14_ * _loc14_ / 8;
            _loc18_ = (_loc15_ * _loc16_.axisx + _loc13_ * _loc16_.axisy) * _loc17_;
            _loc16_.axisy = (_loc15_ * _loc16_.axisy - _loc13_ * _loc16_.axisx) * _loc17_;
            _loc16_.axisx = _loc18_;
         }
         return false;
      }
      
      override public function activeBodies() : void
      {
         if(b1 != null)
         {
            b1.constraints.add(this);
         }
         if(b2 != b1)
         {
            if(b2 != null)
            {
               b2.constraints.add(this);
            }
         }
      }
   }
}
