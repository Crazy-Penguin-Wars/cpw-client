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
   import nape.constraint.WeldJoint;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.space.Space;
   import nape.util.Debug;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_WeldJoint extends ZPP_Constraint
   {
       
      
      public var wrap_a2:Vec2;
      
      public var wrap_a1:Vec2;
      
      public var stepped:Boolean;
      
      public var phase:Number;
      
      public var outer_zn:WeldJoint;
      
      public var kMassf:Number;
      
      public var kMasse:Number;
      
      public var kMassd:Number;
      
      public var kMassc:Number;
      
      public var kMassb:Number;
      
      public var kMassa:Number;
      
      public var jMax:Number;
      
      public var jAccz:Number;
      
      public var jAccy:Number;
      
      public var jAccx:Number;
      
      public var gamma:Number;
      
      public var biasz:Number;
      
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
      
      public function ZPP_WeldJoint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         stepped = false;
         biasz = 0;
         biasy = 0;
         biasx = 0;
         gamma = 0;
         jMax = 0;
         jAccz = 0;
         jAccy = 0;
         jAccx = 0;
         kMassf = 0;
         kMasse = 0;
         kMassc = 0;
         kMassd = 0;
         kMassb = 0;
         kMassa = 0;
         phase = 0;
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
         phase = 0;
         jAccx = 0;
         jAccy = 0;
         jAccz = 0;
         jMax = 1.79e+308;
         stepped = false;
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
         b1.angvel -= (jAccy * a1relx - jAccx * a1rely + jAccz) * b1.iinertia;
         b2.angvel += (jAccy * a2relx - jAccx * a2rely + jAccz) * b2.iinertia;
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
            throw "Error: AngleJoint cannot be simulated null bodies";
         }
         if(b1 == b2)
         {
            Boot.lastError = new Error();
            throw "Error: WeldJoint cannot be simulated with body1 == body2";
         }
         if(b1.space != space || b2.space != space)
         {
            Boot.lastError = new Error();
            throw "Error: Constraints must have each body within the same space to which the constraint has been assigned";
         }
         if(b1.type != ZPP_Flags.id_BodyType_DYNAMIC && b2.type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            Boot.lastError = new Error();
            throw "Error: Constraints cannot have both bodies non-dynamic";
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
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
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
         kMassd = _loc3_;
         kMassc = 0;
         kMasse = 0;
         kMassf = 0;
         if(b1.sinertia != 0)
         {
            _loc4_ = a1relx * b1.sinertia;
            _loc5_ = a1rely * b1.sinertia;
            kMassa += _loc5_ * a1rely;
            kMassb += -_loc5_ * a1relx;
            kMassd += _loc4_ * a1relx;
            kMassc += -_loc5_;
            kMasse += _loc4_;
            kMassf += b1.sinertia;
         }
         if(b2.sinertia != 0)
         {
            _loc4_ = a2relx * b2.sinertia;
            _loc5_ = a2rely * b2.sinertia;
            kMassa += _loc5_ * a2rely;
            kMassb += -_loc5_ * a2relx;
            kMassd += _loc4_ * a2relx;
            kMassc += -_loc5_;
            kMasse += _loc4_;
            kMassf += b2.sinertia;
         }
         _loc3_ = kMassa * (kMassd * kMassf - kMasse * kMasse) + kMassb * (kMassc * kMasse - kMassb * kMassf) + kMassc * (kMassb * kMasse - kMassc * kMassd);
         if(_loc3_ != _loc3_)
         {
            kMassa = 0;
            kMassb = 0;
            kMassd = 0;
            kMassc = 0;
            kMasse = 0;
            kMassf = 0;
            §§push(7);
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
            if(kMassd != 0)
            {
               kMassd = 1 / kMassd;
            }
            else
            {
               kMassd = 0;
               _loc7_ |= 2;
            }
            if(kMassf != 0)
            {
               kMassf = 1 / kMassf;
            }
            else
            {
               kMassf = 0;
               _loc7_ |= 4;
            }
            kMassb = kMassc = kMasse = 0;
            §§push(_loc7_);
         }
         else
         {
            _loc3_ = 1 / _loc3_;
            _loc4_ = _loc3_ * (kMassd * kMassf - kMasse * kMasse);
            _loc5_ = _loc3_ * (kMasse * kMassc - kMassb * kMassf);
            _loc8_ = _loc3_ * (kMassa * kMassf - kMassc * kMassc);
            _loc9_ = _loc3_ * (kMassb * kMasse - kMassc * kMassd);
            _loc10_ = _loc3_ * (kMassb * kMassc - kMassa * kMasse);
            _loc11_ = _loc3_ * (kMassa * kMassd - kMassb * kMassb);
            kMassa = _loc4_;
            kMassb = _loc5_;
            kMassd = _loc8_;
            kMassc = _loc9_;
            kMasse = _loc10_;
            kMassf = _loc11_;
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
         if((_loc6_ & 4) != 0)
         {
            jAccz = 0;
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
            kMassd *= _loc4_;
            kMassc *= _loc4_;
            kMasse *= _loc4_;
            kMassf *= _loc4_;
            biasx = b2.posx + a2relx - (b1.posx + a1relx);
            biasy = b2.posy + a2rely - (b1.posy + a1rely);
            biasz = b2.rot - b1.rot - phase;
            if(breakUnderError && biasx * biasx + biasy * biasy + biasz * biasz > maxError * maxError)
            {
               return true;
            }
            _loc4_ = -_loc3_;
            _loc5_ = _loc4_;
            biasx *= _loc5_;
            biasy *= _loc5_;
            biasz *= _loc4_;
            _loc4_ = maxError;
            _loc5_ = biasx * biasx + biasy * biasy + biasz * biasz;
            if(_loc5_ > _loc4_ * _loc4_)
            {
               sf32(_loc5_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc9_ = lf32(0);
               _loc8_ = _loc4_ * (_loc9_ * (1.5 - 0.5 * _loc5_ * _loc9_ * _loc9_));
               _loc9_ = _loc8_;
               biasx *= _loc9_;
               biasy *= _loc9_;
               biasz *= _loc8_;
            }
         }
         else
         {
            biasx = 0;
            biasy = 0;
            biasz = 0;
            gamma = 0;
         }
         _loc3_ = _loc2_;
         _loc4_ = _loc3_;
         jAccx *= _loc4_;
         jAccy *= _loc4_;
         jAccz *= _loc3_;
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
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as Body;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc2_:WeldJoint = outer_zn;
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
            _loc10_ = 10;
            _loc11_ = 5 / Math.PI / 2;
            _loc12_ = _loc2_.zpp_inner_zn.b1 == null ? null : _loc2_.zpp_inner_zn.b1.outer;
            if((_loc2_.zpp_inner_zn.b1 == null ? null : _loc2_.zpp_inner_zn.b1.outer) != (_loc12_.zpp_inner.space == null ? null : _loc12_.zpp_inner.space.outer).zpp_inner.__static)
            {
               _loc13_ = (_loc2_.zpp_inner_zn.b2 == null ? null : _loc2_.zpp_inner_zn.b2.outer).zpp_inner.rot - _loc2_.zpp_inner_zn.phase;
               _loc14_ = (_loc2_.zpp_inner_zn.b1 == null ? null : _loc2_.zpp_inner_zn.b1.outer).zpp_inner.rot;
               if(_loc14_ > _loc13_)
               {
                  _loc15_ = _loc14_;
                  _loc14_ = _loc13_;
                  _loc13_ = _loc15_;
               }
               _loc12_ = _loc2_.zpp_inner_zn.b1 == null ? null : _loc2_.zpp_inner_zn.b1.outer;
               §§push(ZPP_AngleDraw);
               §§push(param1);
               if(_loc12_.zpp_inner.wrap_pos == null)
               {
                  _loc12_.zpp_inner.setupPosition();
               }
               §§pop().drawSpiralSpring(§§pop(),_loc12_.zpp_inner.wrap_pos,_loc14_,_loc13_,_loc10_ + (_loc14_ - _loc14_) * _loc11_,_loc10_ + (_loc13_ - _loc14_) * _loc11_,16711808);
               _loc12_ = _loc2_.zpp_inner_zn.b1 == null ? null : _loc2_.zpp_inner_zn.b1.outer;
               §§push(ZPP_AngleDraw);
               §§push(param1);
               if(_loc12_.zpp_inner.wrap_pos == null)
               {
                  _loc12_.zpp_inner.setupPosition();
               }
               §§pop().indicator(§§pop(),_loc12_.zpp_inner.wrap_pos,(_loc2_.zpp_inner_zn.b1 == null ? null : _loc2_.zpp_inner_zn.b1.outer).zpp_inner.rot,_loc10_ + ((_loc2_.zpp_inner_zn.b1 == null ? null : _loc2_.zpp_inner_zn.b1.outer).zpp_inner.rot - _loc14_) * _loc11_,16711808);
            }
            _loc12_ = _loc2_.zpp_inner_zn.b2 == null ? null : _loc2_.zpp_inner_zn.b2.outer;
            if((_loc2_.zpp_inner_zn.b2 == null ? null : _loc2_.zpp_inner_zn.b2.outer) != (_loc12_.zpp_inner.space == null ? null : _loc12_.zpp_inner.space.outer).zpp_inner.__static)
            {
               _loc13_ = _loc2_.zpp_inner_zn.phase + (_loc2_.zpp_inner_zn.b1 == null ? null : _loc2_.zpp_inner_zn.b1.outer).zpp_inner.rot;
               _loc14_ = (_loc2_.zpp_inner_zn.b2 == null ? null : _loc2_.zpp_inner_zn.b2.outer).zpp_inner.rot;
               if(_loc14_ > _loc13_)
               {
                  _loc15_ = _loc14_;
                  _loc14_ = _loc13_;
                  _loc13_ = _loc15_;
               }
               _loc12_ = _loc2_.zpp_inner_zn.b2 == null ? null : _loc2_.zpp_inner_zn.b2.outer;
               §§push(ZPP_AngleDraw);
               §§push(param1);
               if(_loc12_.zpp_inner.wrap_pos == null)
               {
                  _loc12_.zpp_inner.setupPosition();
               }
               §§pop().drawSpiralSpring(§§pop(),_loc12_.zpp_inner.wrap_pos,_loc14_,_loc13_,_loc10_ + (_loc14_ - _loc14_) * _loc11_,_loc10_ + (_loc13_ - _loc14_) * _loc11_,8388863);
               _loc12_ = _loc2_.zpp_inner_zn.b2 == null ? null : _loc2_.zpp_inner_zn.b2.outer;
               §§push(ZPP_AngleDraw);
               §§push(param1);
               if(_loc12_.zpp_inner.wrap_pos == null)
               {
                  _loc12_.zpp_inner.setupPosition();
               }
               §§pop().indicator(§§pop(),_loc12_.zpp_inner.wrap_pos,(_loc2_.zpp_inner_zn.b2 == null ? null : _loc2_.zpp_inner_zn.b2.outer).zpp_inner.rot,_loc10_ + ((_loc2_.zpp_inner_zn.b2 == null ? null : _loc2_.zpp_inner_zn.b2.outer).zpp_inner.rot - _loc14_) * _loc11_,8388863);
            }
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
         var _loc3_:WeldJoint = outer_zn;
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
         jAccz = 0;
         pre_dt = -1;
      }
      
      public function bodyImpulse(param1:ZPP_Body) : Vec3
      {
         if(stepped)
         {
            if(param1 == b1)
            {
               return Vec3.get(-jAccx,-jAccy,-(jAccy * a1relx - jAccx * a1rely + jAccz));
            }
            return Vec3.get(jAccx,jAccy,jAccy * a2relx - jAccx * a2rely + jAccz);
         }
         return Vec3.get(0,0,0);
      }
      
      override public function applyImpulseVel() : Boolean
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         _loc1_ = b2.velx + b2.kinvelx - a2rely * (b2.angvel + b2.kinangvel) - (b1.velx + b1.kinvelx - a1rely * (b1.angvel + b1.kinangvel));
         _loc2_ = b2.vely + b2.kinvely + a2relx * (b2.angvel + b2.kinangvel) - (b1.vely + b1.kinvely + a1relx * (b1.angvel + b1.kinangvel));
         _loc3_ = b2.angvel + b2.kinangvel - b1.angvel - b1.kinangvel;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         _loc4_ = biasx - _loc1_;
         _loc5_ = biasy - _loc2_;
         _loc6_ = biasz - _loc3_;
         var _loc7_:Number = kMassa * _loc4_ + kMassb * _loc5_ + kMassc * _loc6_;
         var _loc8_:Number = kMassb * _loc4_ + kMassd * _loc5_ + kMasse * _loc6_;
         _loc6_ = kMassc * _loc4_ + kMasse * _loc5_ + kMassf * _loc6_;
         _loc4_ = _loc7_;
         _loc5_ = _loc8_;
         _loc7_ = gamma;
         _loc8_ = _loc7_;
         _loc4_ -= jAccx * _loc8_;
         _loc5_ -= jAccy * _loc8_;
         _loc6_ -= jAccz * _loc7_;
         _loc7_ = 0;
         _loc8_ = 0;
         var _loc9_:Number = 0;
         _loc7_ = jAccx;
         _loc8_ = jAccy;
         _loc9_ = jAccz;
         jAccx += _loc4_ * 1;
         jAccy += _loc5_ * 1;
         jAccz += _loc6_ * 1;
         if(breakUnderForce)
         {
            if(jAccx * jAccx + jAccy * jAccy + jAccz * jAccz > jMax * jMax)
            {
               return true;
            }
         }
         else if(!stiff)
         {
            _loc12_ = jMax;
            _loc13_ = jAccx * jAccx + jAccy * jAccy + jAccz * jAccz;
            if(_loc13_ > _loc12_ * _loc12_)
            {
               sf32(_loc13_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc15_ = lf32(0);
               _loc14_ = _loc12_ * (_loc15_ * (1.5 - 0.5 * _loc13_ * _loc15_ * _loc15_));
               _loc15_ = _loc14_;
               jAccx *= _loc15_;
               jAccy *= _loc15_;
               jAccz *= _loc14_;
            }
         }
         _loc4_ = jAccx - _loc7_;
         _loc5_ = jAccy - _loc8_;
         _loc6_ = jAccz - _loc9_;
         _loc7_ = b1.imass;
         b1.velx -= _loc4_ * _loc7_;
         b1.vely -= _loc5_ * _loc7_;
         _loc7_ = b2.imass;
         b2.velx += _loc4_ * _loc7_;
         b2.vely += _loc5_ * _loc7_;
         b1.angvel -= (_loc5_ * a1relx - _loc4_ * a1rely + _loc6_) * b1.iinertia;
         b2.angvel += (_loc5_ * a2relx - _loc4_ * a2rely + _loc6_) * b2.iinertia;
         return false;
      }
      
      override public function applyImpulsePos() : Boolean
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
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
         var _loc7_:Number = 0;
         _loc5_ = b2.posx + _loc3_ - (b1.posx + _loc1_);
         _loc6_ = b2.posy + _loc4_ - (b1.posy + _loc2_);
         _loc7_ = b2.rot - b1.rot - phase;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         var _loc10_:Number = 0;
         if(breakUnderError && _loc5_ * _loc5_ + _loc6_ * _loc6_ + _loc7_ * _loc7_ > maxError * maxError)
         {
            return true;
         }
         var _loc11_:Boolean = true;
         if(_loc5_ * _loc5_ + _loc6_ * _loc6_ < Config.constraintLinearSlop * Config.constraintLinearSlop)
         {
            _loc11_ = false;
            _loc5_ = 0;
            _loc6_ = 0;
         }
         _loc12_ = Config.constraintAngularSlop;
         if(_loc7_ * _loc7_ < _loc12_ * _loc12_)
         {
            if(!_loc11_)
            {
               return false;
            }
            _loc7_ = 0;
         }
         _loc12_ = 0.5;
         _loc13_ = _loc12_;
         _loc5_ *= _loc13_;
         _loc6_ *= _loc13_;
         _loc7_ *= _loc12_;
         if(_loc5_ * _loc5_ + _loc6_ * _loc6_ > 6)
         {
            _loc12_ = b1.smass + b2.smass;
            if(_loc12_ > Config.epsilon)
            {
               _loc12_ = 0.75 / _loc12_;
               _loc8_ = -_loc5_ * _loc12_;
               _loc9_ = -_loc6_ * _loc12_;
               _loc14_ = 20;
               _loc13_ = _loc8_ * _loc8_ + _loc9_ * _loc9_;
               if(_loc13_ > _loc14_ * _loc14_)
               {
                  sf32(_loc13_,0);
                  si32(1597463007 - (li32(0) >> 1),0);
                  _loc16_ = lf32(0);
                  _loc15_ = _loc14_ * (_loc16_ * (1.5 - 0.5 * _loc13_ * _loc16_ * _loc16_));
                  _loc8_ *= _loc15_;
                  _loc9_ *= _loc15_;
               }
               _loc13_ = b1.imass;
               b1.posx -= _loc8_ * _loc13_;
               b1.posy -= _loc9_ * _loc13_;
               _loc13_ = b2.imass;
               b2.posx += _loc8_ * _loc13_;
               b2.posy += _loc9_ * _loc13_;
               _loc5_ = b2.posx + _loc3_ - (b1.posx + _loc1_);
               _loc6_ = b2.posy + _loc4_ - (b1.posy + _loc2_);
               _loc7_ = b2.rot - b1.rot - phase;
               _loc13_ = 0.5;
               _loc15_ = _loc13_;
               _loc5_ *= _loc15_;
               _loc6_ *= _loc15_;
               _loc7_ *= _loc13_;
            }
         }
         _loc12_ = 0;
         _loc13_ = 0;
         _loc15_ = 0;
         _loc16_ = 0;
         var _loc17_:Number = 0;
         var _loc18_:Number = 0;
         var _loc19_:Number = b1.smass + b2.smass;
         _loc12_ = _loc19_;
         _loc13_ = 0;
         _loc15_ = _loc19_;
         _loc16_ = 0;
         _loc17_ = 0;
         _loc18_ = 0;
         if(b1.sinertia != 0)
         {
            _loc20_ = _loc1_ * b1.sinertia;
            _loc21_ = _loc2_ * b1.sinertia;
            _loc12_ += _loc21_ * _loc2_;
            _loc13_ += -_loc21_ * _loc1_;
            _loc15_ += _loc20_ * _loc1_;
            _loc16_ += -_loc21_;
            _loc17_ += _loc20_;
            _loc18_ += b1.sinertia;
         }
         if(b2.sinertia != 0)
         {
            _loc20_ = _loc3_ * b2.sinertia;
            _loc21_ = _loc4_ * b2.sinertia;
            _loc12_ += _loc21_ * _loc4_;
            _loc13_ += -_loc21_ * _loc3_;
            _loc15_ += _loc20_ * _loc3_;
            _loc16_ += -_loc21_;
            _loc17_ += _loc20_;
            _loc18_ += b2.sinertia;
         }
         _loc8_ = -_loc5_;
         _loc9_ = -_loc6_;
         _loc10_ = -_loc7_;
         _loc14_ = 6;
         _loc19_ = _loc8_ * _loc8_ + _loc9_ * _loc9_;
         if(_loc19_ > _loc14_ * _loc14_)
         {
            sf32(_loc19_,0);
            si32(1597463007 - (li32(0) >> 1),0);
            _loc21_ = lf32(0);
            _loc20_ = _loc14_ * (_loc21_ * (1.5 - 0.5 * _loc19_ * _loc21_ * _loc21_));
            _loc8_ *= _loc20_;
            _loc9_ *= _loc20_;
         }
         _loc19_ = -0.25;
         if(_loc10_ < _loc19_)
         {
            _loc19_;
         }
         else if(_loc10_ <= 0.25)
         {
            _loc10_;
         }
         _loc19_ = _loc12_ * (_loc15_ * _loc18_ - _loc17_ * _loc17_) + _loc13_ * (_loc16_ * _loc17_ - _loc13_ * _loc18_) + _loc16_ * (_loc13_ * _loc17_ - _loc16_ * _loc15_);
         if(_loc19_ != _loc19_)
         {
            _loc8_ = _loc9_ = _loc10_ = 0;
         }
         else if(_loc19_ == 0)
         {
            if(_loc12_ != 0)
            {
               _loc8_ /= _loc12_;
            }
            else
            {
               _loc8_ = 0;
            }
            if(_loc15_ != 0)
            {
               _loc9_ /= _loc15_;
            }
            else
            {
               _loc9_ = 0;
            }
            if(_loc18_ != 0)
            {
               _loc10_ /= _loc18_;
            }
            else
            {
               _loc10_ = 0;
            }
         }
         else
         {
            _loc19_ = 1 / _loc19_;
            _loc20_ = _loc17_ * _loc16_ - _loc13_ * _loc18_;
            _loc21_ = _loc13_ * _loc17_ - _loc16_ * _loc15_;
            _loc22_ = _loc13_ * _loc16_ - _loc12_ * _loc17_;
            _loc23_ = _loc19_ * (_loc8_ * (_loc15_ * _loc18_ - _loc17_ * _loc17_) + _loc9_ * _loc20_ + _loc10_ * _loc21_);
            _loc24_ = _loc19_ * (_loc8_ * _loc20_ + _loc9_ * (_loc12_ * _loc18_ - _loc16_ * _loc16_) + _loc10_ * _loc22_);
            _loc10_ = _loc19_ * (_loc8_ * _loc21_ + _loc9_ * _loc22_ + _loc10_ * (_loc12_ * _loc15_ - _loc13_ * _loc13_));
            _loc8_ = _loc23_;
            _loc9_ = _loc24_;
         }
         _loc19_ = b1.imass;
         b1.posx -= _loc8_ * _loc19_;
         b1.posy -= _loc9_ * _loc19_;
         _loc19_ = b2.imass;
         b2.posx += _loc8_ * _loc19_;
         b2.posy += _loc9_ * _loc19_;
         var _loc25_:ZPP_Body = b1;
         _loc19_ = -(_loc9_ * _loc1_ - _loc8_ * _loc2_ + _loc10_) * b1.iinertia;
         _loc25_.rot += _loc19_;
         if(_loc19_ * _loc19_ > 0.0001)
         {
            _loc25_.axisx = Math.sin(_loc25_.rot);
            _loc25_.axisy = Math.cos(_loc25_.rot);
         }
         else
         {
            _loc20_ = _loc19_ * _loc19_;
            _loc21_ = 1 - 0.5 * _loc20_;
            _loc22_ = 1 - _loc20_ * _loc20_ / 8;
            _loc23_ = (_loc21_ * _loc25_.axisx + _loc19_ * _loc25_.axisy) * _loc22_;
            _loc25_.axisy = (_loc21_ * _loc25_.axisy - _loc19_ * _loc25_.axisx) * _loc22_;
            _loc25_.axisx = _loc23_;
         }
         _loc25_ = b2;
         _loc19_ = (_loc9_ * _loc3_ - _loc8_ * _loc4_ + _loc10_) * b2.iinertia;
         _loc25_.rot += _loc19_;
         if(_loc19_ * _loc19_ > 0.0001)
         {
            _loc25_.axisx = Math.sin(_loc25_.rot);
            _loc25_.axisy = Math.cos(_loc25_.rot);
         }
         else
         {
            _loc20_ = _loc19_ * _loc19_;
            _loc21_ = 1 - 0.5 * _loc20_;
            _loc22_ = 1 - _loc20_ * _loc20_ / 8;
            _loc23_ = (_loc21_ * _loc25_.axisx + _loc19_ * _loc25_.axisy) * _loc22_;
            _loc25_.axisy = (_loc21_ * _loc25_.axisy - _loc19_ * _loc25_.axisx) * _loc22_;
            _loc25_.axisx = _loc23_;
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
