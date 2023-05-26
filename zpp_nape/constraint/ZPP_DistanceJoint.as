package zpp_nape.constraint
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.Config;
   import nape.constraint.Constraint;
   import nape.constraint.DistanceJoint;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.util.Debug;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_DistanceJoint extends ZPP_Constraint
   {
       
      
      public var wrap_a2:Vec2;
      
      public var wrap_a1:Vec2;
      
      public var stepped:Boolean;
      
      public var slack:Boolean;
      
      public var outer_zn:DistanceJoint;
      
      public var ny:Number;
      
      public var nx:Number;
      
      public var kMass:Number;
      
      public var jointMin:Number;
      
      public var jointMax:Number;
      
      public var jMax:Number;
      
      public var jAcc:Number;
      
      public var gamma:Number;
      
      public var equal:Boolean;
      
      public var cx2:Number;
      
      public var cx1:Number;
      
      public var bias:Number;
      
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
      
      public function ZPP_DistanceJoint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         stepped = false;
         bias = 0;
         gamma = 0;
         jMax = 0;
         jAcc = 0;
         kMass = 0;
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
         cx2 = 0;
         cx1 = 0;
         ny = 0;
         nx = 0;
         equal = false;
         slack = false;
         jointMax = 0;
         jointMin = 0;
         outer_zn = null;
         super();
         a1localx = 0;
         a1localy = 0;
         a1relx = 0;
         a1rely = 0;
         a2localx = 0;
         a2localy = 0;
         a2relx = 0;
         a2rely = 0;
         jAcc = 0;
         jMax = 1.79e+308;
         stepped = false;
         cx2 = 0;
         cx1 = 0;
      }
      
      override public function warmStart() : void
      {
         var _loc1_:Number = NaN;
         if(!slack)
         {
            _loc1_ = b1.imass * jAcc;
            b1.velx -= nx * _loc1_;
            b1.vely -= ny * _loc1_;
            _loc1_ = b2.imass * jAcc;
            b2.velx += nx * _loc1_;
            b2.vely += ny * _loc1_;
            b1.angvel -= cx1 * b1.iinertia * jAcc;
            b2.angvel += cx2 * b2.iinertia * jAcc;
         }
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
            throw "Error: DistanceJoint cannot be simulated null bodies";
         }
         if(b1 == b2)
         {
            Boot.lastError = new Error();
            throw "Error: DistanceJoint cannot be simulated with body1 == body2";
         }
         if(b1.space != space || b2.space != space)
         {
            Boot.lastError = new Error();
            throw "Error: Constraints must have each body within the same space to which the constraint has been assigned";
         }
         if(jointMin > jointMax)
         {
            Boot.lastError = new Error();
            throw "Error: DistanceJoint must have jointMin <= jointMax";
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
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(pre_dt == -1)
         {
            pre_dt = param1;
         }
         var _loc2_:Number = param1 / pre_dt;
         pre_dt = param1;
         stepped = true;
         equal = jointMin == jointMax;
         a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
         a1rely = a1localx * b1.axisx + a1localy * b1.axisy;
         a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
         a2rely = a2localx * b2.axisx + a2localy * b2.axisy;
         nx = b2.posx + a2relx - (b1.posx + a1relx);
         ny = b2.posy + a2rely - (b1.posy + a1rely);
         _loc4_ = nx * nx + ny * ny;
         if(_loc4_ < Config.epsilon)
         {
            nx = 0;
            ny = 0;
            _loc4_ = 0;
            slack = true;
         }
         else
         {
            _loc4_ = _loc4_ == 0 ? 0 : (sf32(_loc4_,0), si32(1597463007 - (li32(0) >> 1),0), _loc5_ = lf32(0), 1 / (_loc5_ * (1.5 - 0.5 * _loc4_ * _loc5_ * _loc5_)));
            _loc5_ = 1 / _loc4_;
            nx *= _loc5_;
            ny *= _loc5_;
            if(equal)
            {
               _loc4_ -= jointMax;
               slack = false;
            }
            else if(_loc4_ < jointMin)
            {
               _loc4_ = jointMin - _loc4_;
               nx = -nx;
               ny = -ny;
               slack = false;
            }
            else if(_loc4_ > jointMax)
            {
               _loc4_ -= jointMax;
               slack = false;
            }
            else
            {
               nx = 0;
               ny = 0;
               _loc4_ = 0;
               slack = true;
            }
         }
         var _loc3_:Number = _loc4_;
         if(!slack)
         {
            cx1 = ny * a1relx - nx * a1rely;
            cx2 = ny * a2relx - nx * a2rely;
            kMass = b1.smass + b2.smass + cx1 * cx1 * b1.sinertia + cx2 * cx2 * b2.sinertia;
            if(kMass != 0)
            {
               kMass = 1 / kMass;
            }
            else
            {
               jAcc = 0;
            }
            if(!stiff)
            {
               if(breakUnderError && _loc3_ * _loc3_ > maxError * maxError)
               {
                  return true;
               }
               _loc5_ = 2 * Math.PI * frequency;
               gamma = 1 / (param1 * _loc5_ * (2 * damping + _loc5_ * param1));
               _loc6_ = 1 / (1 + gamma);
               _loc4_ = param1 * _loc5_ * _loc5_ * gamma;
               gamma *= _loc6_;
               kMass *= _loc6_;
               bias = -_loc3_ * _loc4_;
               if(bias < -maxError)
               {
                  bias = -maxError;
               }
               else if(bias > maxError)
               {
                  bias = maxError;
               }
            }
            else
            {
               bias = 0;
               gamma = 0;
            }
            jAcc *= _loc2_;
            jMax = maxForce * param1;
         }
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
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as Vec2;
         var _loc11_:* = null as Vec2;
         var _loc12_:* = null as Vec2;
         var _loc13_:* = null as Vec2;
         var _loc14_:* = null as ZPP_Vec2;
         var _loc2_:DistanceJoint = outer_zn;
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
         var _loc5_:Vec2 = _loc4_.sub(_loc3_);
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
         var _loc6_:Number = Number(§§pop().sqrt(§§pop() + §§pop() * _loc5_.zpp_inner.y));
         if(_loc6_ != 0)
         {
            _loc5_.muleq(1 / _loc6_);
            _loc8_ = _loc3_.add(_loc4_).muleq(0.5);
            _loc9_ = _loc8_.sub(_loc5_.mul(jointMin * 0.5,true));
            _loc10_ = _loc8_.add(_loc5_.mul(jointMin * 0.5,true));
            _loc11_ = _loc8_.sub(_loc5_.mul(jointMax * 0.5,true));
            _loc12_ = _loc8_.add(_loc5_.mul(jointMax * 0.5,true));
            param1.drawLine(_loc9_,_loc10_,16776960);
            param1.drawLine(_loc11_,_loc9_,65535);
            param1.drawLine(_loc12_,_loc10_,65535);
            if(!stiff)
            {
               if(_loc6_ > jointMax)
               {
                  param1.drawSpring(_loc11_,_loc3_,65535);
                  param1.drawSpring(_loc12_,_loc4_,65535);
               }
               else if(_loc6_ < jointMin)
               {
                  param1.drawSpring(_loc9_,_loc3_,16776960);
                  param1.drawSpring(_loc10_,_loc4_,16776960);
               }
            }
            if(_loc8_ != null && _loc8_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc8_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc8_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc8_.zpp_inner;
            _loc8_.zpp_inner.outer = null;
            _loc8_.zpp_inner = null;
            _loc13_ = _loc8_;
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
            _loc14_ = _loc7_;
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
            if(_loc9_ != null && _loc9_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc9_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc9_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc9_.zpp_inner;
            _loc9_.zpp_inner.outer = null;
            _loc9_.zpp_inner = null;
            _loc13_ = _loc9_;
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
            _loc14_ = _loc7_;
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
            if(_loc10_ != null && _loc10_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc10_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc10_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc10_.zpp_inner;
            _loc10_.zpp_inner.outer = null;
            _loc10_.zpp_inner = null;
            _loc13_ = _loc10_;
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
            _loc14_ = _loc7_;
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
            if(_loc11_ != null && _loc11_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc11_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc11_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc11_.zpp_inner;
            _loc11_.zpp_inner.outer = null;
            _loc11_.zpp_inner = null;
            _loc13_ = _loc11_;
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
            _loc14_ = _loc7_;
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
            if(_loc12_ != null && _loc12_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
            }
            _loc7_ = _loc12_.zpp_inner;
            if(_loc7_._immutable)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 is immutable";
            }
            if(_loc7_._isimmutable != null)
            {
               _loc7_._isimmutable();
            }
            if(_loc12_.zpp_inner._inuse)
            {
               Boot.lastError = new Error();
               throw "Error: This Vec2 is not disposable";
            }
            _loc7_ = _loc12_.zpp_inner;
            _loc12_.zpp_inner.outer = null;
            _loc12_.zpp_inner = null;
            _loc13_ = _loc12_;
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
            _loc14_ = _loc7_;
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
         _loc8_ = _loc3_;
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
         _loc14_ = _loc7_;
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
         _loc8_ = _loc4_;
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
         _loc14_ = _loc7_;
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
         _loc14_ = _loc7_;
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
      
      override public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
      {
         var ret:DistanceJoint;
         var _loc4_:* = null as Body;
         var _loc5_:int = 0;
         var _loc6_:* = null as ZPP_CopyHelper;
         var _loc3_:DistanceJoint = outer_zn;
         §§push(§§newactivation());
         §§push(§§findproperty(DistanceJoint));
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
         §§pop().§§slot[1] = new §§pop().DistanceJoint(§§pop(),§§pop(),§§pop(),_loc3_.zpp_inner_zn.wrap_a2,jointMin,jointMax);
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
         jAcc = 0;
         pre_dt = -1;
      }
      
      public function bodyImpulse(param1:ZPP_Body) : Vec3
      {
         if(stepped)
         {
            if(param1 == b1)
            {
               return Vec3.get(-jAcc * nx,-jAcc * ny,-cx1 * jAcc);
            }
            return Vec3.get(jAcc * nx,jAcc * ny,cx2 * jAcc);
         }
         return Vec3.get(0,0,0);
      }
      
      override public function applyImpulseVel() : Boolean
      {
         if(slack)
         {
            return false;
         }
         var _loc1_:Number = nx * (b2.velx + b2.kinvelx - b1.velx - b1.kinvelx) + ny * (b2.vely + b2.kinvely - b1.vely - b1.kinvely) + (b2.angvel + b2.kinangvel) * cx2 - (b1.angvel + b1.kinangvel) * cx1;
         var _loc2_:Number = kMass * (bias - _loc1_) - jAcc * gamma;
         var _loc3_:Number = jAcc;
         jAcc += _loc2_;
         if(!equal && jAcc > 0)
         {
            jAcc = 0;
         }
         if(breakUnderForce && jAcc < -jMax)
         {
            return true;
         }
         if(!stiff)
         {
            if(jAcc < -jMax)
            {
               jAcc = -jMax;
            }
         }
         _loc2_ = jAcc - _loc3_;
         _loc3_ = b1.imass * _loc2_;
         b1.velx -= nx * _loc3_;
         b1.vely -= ny * _loc3_;
         _loc3_ = b2.imass * _loc2_;
         b2.velx += nx * _loc3_;
         b2.vely += ny * _loc3_;
         b1.angvel -= cx1 * b1.iinertia * _loc2_;
         b2.angvel += cx2 * b2.iinertia * _loc2_;
         return false;
      }
      
      override public function applyImpulsePos() : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as ZPP_Body;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         _loc3_ = b1.axisy * a1localx - b1.axisx * a1localy;
         _loc4_ = a1localx * b1.axisx + a1localy * b1.axisy;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         _loc5_ = b2.axisy * a2localx - b2.axisx * a2localy;
         _loc6_ = a2localx * b2.axisx + a2localy * b2.axisy;
         var _loc8_:Number = 0;
         var _loc9_:Number = 0;
         _loc8_ = b2.posx + _loc5_ - (b1.posx + _loc3_);
         _loc9_ = b2.posy + _loc6_ - (b1.posy + _loc4_);
         _loc10_ = _loc8_ * _loc8_ + _loc9_ * _loc9_;
         if(_loc10_ < Config.epsilon)
         {
            _loc8_ = 0;
            _loc9_ = 0;
            _loc10_ = 0;
            _loc7_ = true;
         }
         else
         {
            _loc10_ = _loc10_ == 0 ? 0 : (sf32(_loc10_,0), si32(1597463007 - (li32(0) >> 1),0), _loc11_ = lf32(0), 1 / (_loc11_ * (1.5 - 0.5 * _loc10_ * _loc11_ * _loc11_)));
            _loc11_ = 1 / _loc10_;
            _loc8_ *= _loc11_;
            _loc9_ *= _loc11_;
            if(equal)
            {
               _loc10_ -= jointMax;
               _loc7_ = false;
            }
            else if(_loc10_ < jointMin)
            {
               _loc10_ = jointMin - _loc10_;
               _loc8_ = -_loc8_;
               _loc9_ = -_loc9_;
               _loc7_ = false;
            }
            else if(_loc10_ > jointMax)
            {
               _loc10_ -= jointMax;
               _loc7_ = false;
            }
            else
            {
               _loc8_ = 0;
               _loc9_ = 0;
               _loc10_ = 0;
               _loc7_ = true;
            }
         }
         var _loc1_:Number = _loc10_;
         if(!_loc7_)
         {
            if(breakUnderError && _loc1_ * _loc1_ > maxError * maxError)
            {
               return true;
            }
            if(_loc1_ * _loc1_ < Config.constraintLinearSlop * Config.constraintLinearSlop)
            {
               return false;
            }
            _loc1_ *= 0.5;
            if(_loc1_ * _loc1_ > 6)
            {
               _loc10_ = b1.smass + b2.smass;
               if(_loc10_ > Config.epsilon)
               {
                  _loc10_ = 0.75 / _loc10_;
                  _loc2_ = -_loc1_ * _loc10_;
                  if(equal || _loc2_ < 0)
                  {
                     _loc11_ = _loc2_ * b1.imass;
                     b1.posx -= _loc8_ * _loc11_;
                     b1.posy -= _loc9_ * _loc11_;
                     _loc11_ = _loc2_ * b2.imass;
                     b2.posx += _loc8_ * _loc11_;
                     b2.posy += _loc9_ * _loc11_;
                     _loc8_ = b2.posx + _loc5_ - (b1.posx + _loc3_);
                     _loc9_ = b2.posy + _loc6_ - (b1.posy + _loc4_);
                     _loc11_ = _loc8_ * _loc8_ + _loc9_ * _loc9_;
                     if(_loc11_ < Config.epsilon)
                     {
                        _loc8_ = 0;
                        _loc9_ = 0;
                        _loc11_ = 0;
                        _loc7_ = true;
                     }
                     else
                     {
                        _loc11_ = _loc11_ == 0 ? 0 : (sf32(_loc11_,0), si32(1597463007 - (li32(0) >> 1),0), _loc12_ = lf32(0), 1 / (_loc12_ * (1.5 - 0.5 * _loc11_ * _loc12_ * _loc12_)));
                        _loc12_ = 1 / _loc11_;
                        _loc8_ *= _loc12_;
                        _loc9_ *= _loc12_;
                        if(equal)
                        {
                           _loc11_ -= jointMax;
                           _loc7_ = false;
                        }
                        else if(_loc11_ < jointMin)
                        {
                           _loc11_ = jointMin - _loc11_;
                           _loc8_ = -_loc8_;
                           _loc9_ = -_loc9_;
                           _loc7_ = false;
                        }
                        else if(_loc11_ > jointMax)
                        {
                           _loc11_ -= jointMax;
                           _loc7_ = false;
                        }
                        else
                        {
                           _loc8_ = 0;
                           _loc9_ = 0;
                           _loc11_ = 0;
                           _loc7_ = true;
                        }
                     }
                     _loc1_ = _loc11_;
                     _loc1_ *= 0.5;
                  }
               }
            }
            _loc10_ = _loc9_ * _loc3_ - _loc8_ * _loc4_;
            _loc11_ = _loc9_ * _loc5_ - _loc8_ * _loc6_;
            _loc12_ = b1.smass + b2.smass + _loc10_ * _loc10_ * b1.sinertia + _loc11_ * _loc11_ * b2.sinertia;
            if(_loc12_ != 0)
            {
               _loc12_ = 1 / _loc12_;
            }
            _loc2_ = -_loc1_ * _loc12_;
            if(equal || _loc2_ < 0)
            {
               _loc13_ = b1.imass * _loc2_;
               b1.posx -= _loc8_ * _loc13_;
               b1.posy -= _loc9_ * _loc13_;
               _loc13_ = b2.imass * _loc2_;
               b2.posx += _loc8_ * _loc13_;
               b2.posy += _loc9_ * _loc13_;
               _loc14_ = b1;
               _loc13_ = -_loc10_ * b1.iinertia * _loc2_;
               _loc14_.rot += _loc13_;
               if(_loc13_ * _loc13_ > 0.0001)
               {
                  _loc14_.axisx = Math.sin(_loc14_.rot);
                  _loc14_.axisy = Math.cos(_loc14_.rot);
               }
               else
               {
                  _loc15_ = _loc13_ * _loc13_;
                  _loc16_ = 1 - 0.5 * _loc15_;
                  _loc17_ = 1 - _loc15_ * _loc15_ / 8;
                  _loc18_ = (_loc16_ * _loc14_.axisx + _loc13_ * _loc14_.axisy) * _loc17_;
                  _loc14_.axisy = (_loc16_ * _loc14_.axisy - _loc13_ * _loc14_.axisx) * _loc17_;
                  _loc14_.axisx = _loc18_;
               }
               _loc14_ = b2;
               _loc13_ = _loc11_ * b2.iinertia * _loc2_;
               _loc14_.rot += _loc13_;
               if(_loc13_ * _loc13_ > 0.0001)
               {
                  _loc14_.axisx = Math.sin(_loc14_.rot);
                  _loc14_.axisy = Math.cos(_loc14_.rot);
               }
               else
               {
                  _loc15_ = _loc13_ * _loc13_;
                  _loc16_ = 1 - 0.5 * _loc15_;
                  _loc17_ = 1 - _loc15_ * _loc15_ / 8;
                  _loc18_ = (_loc16_ * _loc14_.axisx + _loc13_ * _loc14_.axisy) * _loc17_;
                  _loc14_.axisy = (_loc16_ * _loc14_.axisy - _loc13_ * _loc14_.axisx) * _loc17_;
                  _loc14_.axisx = _loc18_;
               }
            }
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
