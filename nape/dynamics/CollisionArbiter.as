package nape.dynamics
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.shape.Edge;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_ColArbiter;
   import zpp_nape.geom.ZPP_Vec3;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.util.ZPP_Flags;
   
   public final class CollisionArbiter extends Arbiter
   {
       
      
      public function CollisionArbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(!ZPP_Arbiter.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate CollisionArbiter derp!";
         }
         super();
      }
      
      override public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc7_:* = null as Vec3;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Vec3;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         §§push(false);
         §§push(false);
         if(param1 != null)
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b2.outer : zpp_inner.b1.outer));
         }
         if(§§pop())
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b1.outer : zpp_inner.b2.outer));
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter does not relate to body";
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZPP_ColArbiter = zpp_inner.colarb;
         if(!param2 || _loc6_.oc1.fresh)
         {
            _loc7_ = _loc6_.oc1.wrapper().totalImpulse(param1);
            _loc8_ = 1;
            _loc9_ = _loc8_;
            §§push(_loc3_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc7_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc3_ = §§pop() + _loc7_.zpp_inner.x * _loc9_;
            §§push(_loc4_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc7_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc4_ = §§pop() + _loc7_.zpp_inner.y * _loc9_;
            §§push(_loc5_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc7_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc5_ = §§pop() + _loc7_.zpp_inner.z * _loc8_;
            _loc7_.dispose();
         }
         if(_loc6_.hc2)
         {
            if(!param2 || _loc6_.oc2.fresh)
            {
               _loc7_ = _loc6_.oc2.wrapper().totalImpulse(param1);
               _loc8_ = 1;
               _loc9_ = _loc8_;
               §§push(_loc3_);
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc7_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc3_ = §§pop() + _loc7_.zpp_inner.x * _loc9_;
               §§push(_loc4_);
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc7_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc4_ = §§pop() + _loc7_.zpp_inner.y * _loc9_;
               §§push(_loc5_);
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc7_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc5_ = §§pop() + _loc7_.zpp_inner.z * _loc8_;
               _loc7_.dispose();
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function tangentImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc7_:* = null as Vec3;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Vec3;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         §§push(false);
         §§push(false);
         if(param1 != null)
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b2.outer : zpp_inner.b1.outer));
         }
         if(§§pop())
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b1.outer : zpp_inner.b2.outer));
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter does not relate to body";
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZPP_ColArbiter = zpp_inner.colarb;
         if(!param2 || _loc6_.oc1.fresh)
         {
            _loc7_ = _loc6_.oc1.wrapper().tangentImpulse(param1);
            _loc8_ = 1;
            _loc9_ = _loc8_;
            §§push(_loc3_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc7_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc3_ = §§pop() + _loc7_.zpp_inner.x * _loc9_;
            §§push(_loc4_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc7_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc4_ = §§pop() + _loc7_.zpp_inner.y * _loc9_;
            §§push(_loc5_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc7_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc5_ = §§pop() + _loc7_.zpp_inner.z * _loc8_;
            _loc7_.dispose();
         }
         if(_loc6_.hc2)
         {
            if(!param2 || _loc6_.oc2.fresh)
            {
               _loc7_ = _loc6_.oc2.wrapper().tangentImpulse(param1);
               _loc8_ = 1;
               _loc9_ = _loc8_;
               §§push(_loc3_);
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc7_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc3_ = §§pop() + _loc7_.zpp_inner.x * _loc9_;
               §§push(_loc4_);
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc7_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc4_ = §§pop() + _loc7_.zpp_inner.y * _loc9_;
               §§push(_loc5_);
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc7_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc5_ = §§pop() + _loc7_.zpp_inner.z * _loc8_;
               _loc7_.dispose();
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function set staticFriction(param1:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(!zpp_inner.colarb.mutable)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "staticFriction" + " is only mutable during a pre-handler";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "staticFriction" + " cannot be NaN";
         }
         if(param1 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "staticFriction" + " cannot be negative";
         }
         var _loc2_:ZPP_ColArbiter = zpp_inner.colarb;
         _loc2_.stat_fric = param1;
         _loc2_.userdef_stat_fric = true;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         _loc2_ = zpp_inner.colarb;
         if(_loc2_.invalidated)
         {
            _loc2_.invalidated = false;
            if(!_loc2_.userdef_restitution)
            {
               if(_loc2_.s1.material.elasticity <= -1.79e+308 || _loc2_.s2.material.elasticity <= -1.79e+308)
               {
                  _loc2_.restitution = 0;
               }
               else if(_loc2_.s1.material.elasticity >= 1.79e+308 || _loc2_.s2.material.elasticity >= 1.79e+308)
               {
                  _loc2_.restitution = 1;
               }
               else
               {
                  _loc2_.restitution = (_loc2_.s1.material.elasticity + _loc2_.s2.material.elasticity) / 2;
               }
               if(_loc2_.restitution < 0)
               {
                  _loc2_.restitution = 0;
               }
               if(_loc2_.restitution > 1)
               {
                  _loc2_.restitution = 1;
               }
            }
            if(!_loc2_.userdef_dyn_fric)
            {
               _loc3_ = _loc2_.s1.material.dynamicFriction * _loc2_.s2.material.dynamicFriction;
               _loc2_.dyn_fric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
            if(!_loc2_.userdef_stat_fric)
            {
               _loc3_ = _loc2_.s1.material.staticFriction * _loc2_.s2.material.staticFriction;
               _loc2_.stat_fric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
            if(!_loc2_.userdef_rfric)
            {
               _loc3_ = _loc2_.s1.material.rollingFriction * _loc2_.s2.material.rollingFriction;
               _loc2_.rfric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
         }
         return _loc2_.stat_fric;
      }
      
      public function set rollingFriction(param1:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(!zpp_inner.colarb.mutable)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "rollingFriction" + " is only mutable during a pre-handler";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "rollingFriction" + " cannot be NaN";
         }
         if(param1 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "rollingFriction" + " cannot be negative";
         }
         var _loc2_:ZPP_ColArbiter = zpp_inner.colarb;
         _loc2_.rfric = param1;
         _loc2_.userdef_rfric = true;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         _loc2_ = zpp_inner.colarb;
         if(_loc2_.invalidated)
         {
            _loc2_.invalidated = false;
            if(!_loc2_.userdef_restitution)
            {
               if(_loc2_.s1.material.elasticity <= -1.79e+308 || _loc2_.s2.material.elasticity <= -1.79e+308)
               {
                  _loc2_.restitution = 0;
               }
               else if(_loc2_.s1.material.elasticity >= 1.79e+308 || _loc2_.s2.material.elasticity >= 1.79e+308)
               {
                  _loc2_.restitution = 1;
               }
               else
               {
                  _loc2_.restitution = (_loc2_.s1.material.elasticity + _loc2_.s2.material.elasticity) / 2;
               }
               if(_loc2_.restitution < 0)
               {
                  _loc2_.restitution = 0;
               }
               if(_loc2_.restitution > 1)
               {
                  _loc2_.restitution = 1;
               }
            }
            if(!_loc2_.userdef_dyn_fric)
            {
               _loc3_ = _loc2_.s1.material.dynamicFriction * _loc2_.s2.material.dynamicFriction;
               _loc2_.dyn_fric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
            if(!_loc2_.userdef_stat_fric)
            {
               _loc3_ = _loc2_.s1.material.staticFriction * _loc2_.s2.material.staticFriction;
               _loc2_.stat_fric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
            if(!_loc2_.userdef_rfric)
            {
               _loc3_ = _loc2_.s1.material.rollingFriction * _loc2_.s2.material.rollingFriction;
               _loc2_.rfric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
         }
         return _loc2_.rfric;
      }
      
      public function set elasticity(param1:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(!zpp_inner.colarb.mutable)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "elasticity" + " is only mutable during a pre-handler";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "elasticity" + " cannot be NaN";
         }
         if(param1 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "elasticity" + " cannot be negative";
         }
         var _loc2_:ZPP_ColArbiter = zpp_inner.colarb;
         _loc2_.restitution = param1;
         _loc2_.userdef_restitution = true;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         _loc2_ = zpp_inner.colarb;
         if(_loc2_.invalidated)
         {
            _loc2_.invalidated = false;
            if(!_loc2_.userdef_restitution)
            {
               if(_loc2_.s1.material.elasticity <= -1.79e+308 || _loc2_.s2.material.elasticity <= -1.79e+308)
               {
                  _loc2_.restitution = 0;
               }
               else if(_loc2_.s1.material.elasticity >= 1.79e+308 || _loc2_.s2.material.elasticity >= 1.79e+308)
               {
                  _loc2_.restitution = 1;
               }
               else
               {
                  _loc2_.restitution = (_loc2_.s1.material.elasticity + _loc2_.s2.material.elasticity) / 2;
               }
               if(_loc2_.restitution < 0)
               {
                  _loc2_.restitution = 0;
               }
               if(_loc2_.restitution > 1)
               {
                  _loc2_.restitution = 1;
               }
            }
            if(!_loc2_.userdef_dyn_fric)
            {
               _loc3_ = _loc2_.s1.material.dynamicFriction * _loc2_.s2.material.dynamicFriction;
               _loc2_.dyn_fric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
            if(!_loc2_.userdef_stat_fric)
            {
               _loc3_ = _loc2_.s1.material.staticFriction * _loc2_.s2.material.staticFriction;
               _loc2_.stat_fric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
            if(!_loc2_.userdef_rfric)
            {
               _loc3_ = _loc2_.s1.material.rollingFriction * _loc2_.s2.material.rollingFriction;
               _loc2_.rfric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
         }
         return _loc2_.restitution;
      }
      
      public function set dynamicFriction(param1:Number) : Number
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(!zpp_inner.colarb.mutable)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "dynamicFriction" + " is only mutable during a pre-handler";
         }
         if(param1 != param1)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "dynamicFriction" + " cannot be NaN";
         }
         if(param1 < 0)
         {
            Boot.lastError = new Error();
            throw "Error: CollisionArbiter::" + "dynamicFriction" + " cannot be negative";
         }
         var _loc2_:ZPP_ColArbiter = zpp_inner.colarb;
         _loc2_.dyn_fric = param1;
         _loc2_.userdef_dyn_fric = true;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         _loc2_ = zpp_inner.colarb;
         if(_loc2_.invalidated)
         {
            _loc2_.invalidated = false;
            if(!_loc2_.userdef_restitution)
            {
               if(_loc2_.s1.material.elasticity <= -1.79e+308 || _loc2_.s2.material.elasticity <= -1.79e+308)
               {
                  _loc2_.restitution = 0;
               }
               else if(_loc2_.s1.material.elasticity >= 1.79e+308 || _loc2_.s2.material.elasticity >= 1.79e+308)
               {
                  _loc2_.restitution = 1;
               }
               else
               {
                  _loc2_.restitution = (_loc2_.s1.material.elasticity + _loc2_.s2.material.elasticity) / 2;
               }
               if(_loc2_.restitution < 0)
               {
                  _loc2_.restitution = 0;
               }
               if(_loc2_.restitution > 1)
               {
                  _loc2_.restitution = 1;
               }
            }
            if(!_loc2_.userdef_dyn_fric)
            {
               _loc3_ = _loc2_.s1.material.dynamicFriction * _loc2_.s2.material.dynamicFriction;
               _loc2_.dyn_fric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
            if(!_loc2_.userdef_stat_fric)
            {
               _loc3_ = _loc2_.s1.material.staticFriction * _loc2_.s2.material.staticFriction;
               _loc2_.stat_fric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
            if(!_loc2_.userdef_rfric)
            {
               _loc3_ = _loc2_.s1.material.rollingFriction * _loc2_.s2.material.rollingFriction;
               _loc2_.rfric = _loc3_ == 0 ? 0 : (sf32(_loc3_,0), si32(1597463007 - (li32(0) >> 1),0), _loc4_ = lf32(0), 1 / (_loc4_ * (1.5 - 0.5 * _loc3_ * _loc4_ * _loc4_)));
            }
         }
         return _loc2_.dyn_fric;
      }
      
      public function secondVertex() : Boolean
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         var _loc1_:Boolean = zpp_inner.colarb.__ref_edge1 != null != (zpp_inner.colarb.__ref_edge2 != null);
         return _loc1_ ? zpp_inner.colarb.__ref_vertex == 1 : false;
      }
      
      public function rollingImpulse(param1:Body = undefined, param2:Boolean = false) : Number
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         §§push(false);
         §§push(false);
         if(param1 != null)
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b2.outer : zpp_inner.b1.outer));
         }
         if(§§pop())
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b1.outer : zpp_inner.b2.outer));
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter does not relate to body";
         }
         var _loc3_:ZPP_ColArbiter = zpp_inner.colarb;
         if(!param2 || _loc3_.oc1.fresh)
         {
            return _loc3_.oc1.wrapper().rollingImpulse(param1);
         }
         return 0;
      }
      
      public function normalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc7_:* = null as Vec3;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Vec3;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         §§push(false);
         §§push(false);
         if(param1 != null)
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b2.outer : zpp_inner.b1.outer));
         }
         if(§§pop())
         {
            §§pop();
            §§push(param1);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            §§push(§§pop() != (zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.b1.outer : zpp_inner.b2.outer));
         }
         if(§§pop())
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter does not relate to body";
         }
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZPP_ColArbiter = zpp_inner.colarb;
         if(!param2 || _loc6_.oc1.fresh)
         {
            _loc7_ = _loc6_.oc1.wrapper().normalImpulse(param1);
            _loc8_ = 1;
            _loc9_ = _loc8_;
            §§push(_loc3_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc7_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc3_ = §§pop() + _loc7_.zpp_inner.x * _loc9_;
            §§push(_loc4_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc7_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc4_ = §§pop() + _loc7_.zpp_inner.y * _loc9_;
            §§push(_loc5_);
            if(_loc7_ != null && _loc7_.zpp_disp)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
            }
            _loc10_ = _loc7_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc5_ = §§pop() + _loc7_.zpp_inner.z * _loc8_;
            _loc7_.dispose();
         }
         if(_loc6_.hc2)
         {
            if(!param2 || _loc6_.oc2.fresh)
            {
               _loc7_ = _loc6_.oc2.wrapper().normalImpulse(param1);
               _loc8_ = 1;
               _loc9_ = _loc8_;
               §§push(_loc3_);
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc7_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc3_ = §§pop() + _loc7_.zpp_inner.x * _loc9_;
               §§push(_loc4_);
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc7_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc4_ = §§pop() + _loc7_.zpp_inner.y * _loc9_;
               §§push(_loc5_);
               if(_loc7_ != null && _loc7_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec3" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc7_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc5_ = §§pop() + _loc7_.zpp_inner.z * _loc8_;
               _loc7_.dispose();
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function get staticFriction() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         var _loc1_:ZPP_ColArbiter = zpp_inner.colarb;
         if(_loc1_.invalidated)
         {
            _loc1_.invalidated = false;
            if(!_loc1_.userdef_restitution)
            {
               if(_loc1_.s1.material.elasticity <= -1.79e+308 || _loc1_.s2.material.elasticity <= -1.79e+308)
               {
                  _loc1_.restitution = 0;
               }
               else if(_loc1_.s1.material.elasticity >= 1.79e+308 || _loc1_.s2.material.elasticity >= 1.79e+308)
               {
                  _loc1_.restitution = 1;
               }
               else
               {
                  _loc1_.restitution = (_loc1_.s1.material.elasticity + _loc1_.s2.material.elasticity) / 2;
               }
               if(_loc1_.restitution < 0)
               {
                  _loc1_.restitution = 0;
               }
               if(_loc1_.restitution > 1)
               {
                  _loc1_.restitution = 1;
               }
            }
            if(!_loc1_.userdef_dyn_fric)
            {
               _loc2_ = _loc1_.s1.material.dynamicFriction * _loc1_.s2.material.dynamicFriction;
               _loc1_.dyn_fric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            if(!_loc1_.userdef_stat_fric)
            {
               _loc2_ = _loc1_.s1.material.staticFriction * _loc1_.s2.material.staticFriction;
               _loc1_.stat_fric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            if(!_loc1_.userdef_rfric)
            {
               _loc2_ = _loc1_.s1.material.rollingFriction * _loc1_.s2.material.rollingFriction;
               _loc1_.rfric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
         }
         return _loc1_.stat_fric;
      }
      
      public function get rollingFriction() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         var _loc1_:ZPP_ColArbiter = zpp_inner.colarb;
         if(_loc1_.invalidated)
         {
            _loc1_.invalidated = false;
            if(!_loc1_.userdef_restitution)
            {
               if(_loc1_.s1.material.elasticity <= -1.79e+308 || _loc1_.s2.material.elasticity <= -1.79e+308)
               {
                  _loc1_.restitution = 0;
               }
               else if(_loc1_.s1.material.elasticity >= 1.79e+308 || _loc1_.s2.material.elasticity >= 1.79e+308)
               {
                  _loc1_.restitution = 1;
               }
               else
               {
                  _loc1_.restitution = (_loc1_.s1.material.elasticity + _loc1_.s2.material.elasticity) / 2;
               }
               if(_loc1_.restitution < 0)
               {
                  _loc1_.restitution = 0;
               }
               if(_loc1_.restitution > 1)
               {
                  _loc1_.restitution = 1;
               }
            }
            if(!_loc1_.userdef_dyn_fric)
            {
               _loc2_ = _loc1_.s1.material.dynamicFriction * _loc1_.s2.material.dynamicFriction;
               _loc1_.dyn_fric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            if(!_loc1_.userdef_stat_fric)
            {
               _loc2_ = _loc1_.s1.material.staticFriction * _loc1_.s2.material.staticFriction;
               _loc1_.stat_fric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            if(!_loc1_.userdef_rfric)
            {
               _loc2_ = _loc1_.s1.material.rollingFriction * _loc1_.s2.material.rollingFriction;
               _loc1_.rfric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
         }
         return _loc1_.rfric;
      }
      
      public function get referenceEdge2() : Edge
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         var _loc1_:ZPP_Edge = zpp_inner.colarb.__ref_edge1;
         §§push(false);
         if(_loc1_ != null)
         {
            §§pop();
            §§push(true);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            if((zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.ws1.outer : zpp_inner.ws2.outer).zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               §§pop();
               if(!zpp_inner.active)
               {
                  Boot.lastError = new Error();
                  throw "Error: Arbiter not currently in use";
               }
               §§push((zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.ws1.outer : zpp_inner.ws2.outer).zpp_inner != _loc1_.polygon);
            }
            §§push(§§pop());
         }
         if(§§pop())
         {
            _loc1_ = zpp_inner.colarb.__ref_edge2;
         }
         return _loc1_ == null ? null : _loc1_.wrapper();
      }
      
      public function get referenceEdge1() : Edge
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         var _loc1_:ZPP_Edge = zpp_inner.colarb.__ref_edge1;
         §§push(false);
         if(_loc1_ != null)
         {
            §§pop();
            §§push(true);
            if(!zpp_inner.active)
            {
               Boot.lastError = new Error();
               throw "Error: Arbiter not currently in use";
            }
            if((zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.ws2.outer : zpp_inner.ws1.outer).zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               §§pop();
               if(!zpp_inner.active)
               {
                  Boot.lastError = new Error();
                  throw "Error: Arbiter not currently in use";
               }
               §§push((zpp_inner.ws1.id > zpp_inner.ws2.id ? zpp_inner.ws2.outer : zpp_inner.ws1.outer).zpp_inner != _loc1_.polygon);
            }
            §§push(§§pop());
         }
         if(§§pop())
         {
            _loc1_ = zpp_inner.colarb.__ref_edge2;
         }
         return _loc1_ == null ? null : _loc1_.wrapper();
      }
      
      public function get radius() : Number
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         return zpp_inner.colarb.radius;
      }
      
      public function get normal() : Vec2
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         if(zpp_inner.colarb.wrap_normal == null)
         {
            zpp_inner.colarb.getnormal();
         }
         return zpp_inner.colarb.wrap_normal;
      }
      
      public function get elasticity() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         var _loc1_:ZPP_ColArbiter = zpp_inner.colarb;
         if(_loc1_.invalidated)
         {
            _loc1_.invalidated = false;
            if(!_loc1_.userdef_restitution)
            {
               if(_loc1_.s1.material.elasticity <= -1.79e+308 || _loc1_.s2.material.elasticity <= -1.79e+308)
               {
                  _loc1_.restitution = 0;
               }
               else if(_loc1_.s1.material.elasticity >= 1.79e+308 || _loc1_.s2.material.elasticity >= 1.79e+308)
               {
                  _loc1_.restitution = 1;
               }
               else
               {
                  _loc1_.restitution = (_loc1_.s1.material.elasticity + _loc1_.s2.material.elasticity) / 2;
               }
               if(_loc1_.restitution < 0)
               {
                  _loc1_.restitution = 0;
               }
               if(_loc1_.restitution > 1)
               {
                  _loc1_.restitution = 1;
               }
            }
            if(!_loc1_.userdef_dyn_fric)
            {
               _loc2_ = _loc1_.s1.material.dynamicFriction * _loc1_.s2.material.dynamicFriction;
               _loc1_.dyn_fric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            if(!_loc1_.userdef_stat_fric)
            {
               _loc2_ = _loc1_.s1.material.staticFriction * _loc1_.s2.material.staticFriction;
               _loc1_.stat_fric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            if(!_loc1_.userdef_rfric)
            {
               _loc2_ = _loc1_.s1.material.rollingFriction * _loc1_.s2.material.rollingFriction;
               _loc1_.rfric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
         }
         return _loc1_.restitution;
      }
      
      public function get dynamicFriction() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         var _loc1_:ZPP_ColArbiter = zpp_inner.colarb;
         if(_loc1_.invalidated)
         {
            _loc1_.invalidated = false;
            if(!_loc1_.userdef_restitution)
            {
               if(_loc1_.s1.material.elasticity <= -1.79e+308 || _loc1_.s2.material.elasticity <= -1.79e+308)
               {
                  _loc1_.restitution = 0;
               }
               else if(_loc1_.s1.material.elasticity >= 1.79e+308 || _loc1_.s2.material.elasticity >= 1.79e+308)
               {
                  _loc1_.restitution = 1;
               }
               else
               {
                  _loc1_.restitution = (_loc1_.s1.material.elasticity + _loc1_.s2.material.elasticity) / 2;
               }
               if(_loc1_.restitution < 0)
               {
                  _loc1_.restitution = 0;
               }
               if(_loc1_.restitution > 1)
               {
                  _loc1_.restitution = 1;
               }
            }
            if(!_loc1_.userdef_dyn_fric)
            {
               _loc2_ = _loc1_.s1.material.dynamicFriction * _loc1_.s2.material.dynamicFriction;
               _loc1_.dyn_fric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            if(!_loc1_.userdef_stat_fric)
            {
               _loc2_ = _loc1_.s1.material.staticFriction * _loc1_.s2.material.staticFriction;
               _loc1_.stat_fric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            if(!_loc1_.userdef_rfric)
            {
               _loc2_ = _loc1_.s1.material.rollingFriction * _loc1_.s2.material.rollingFriction;
               _loc1_.rfric = _loc2_ == 0 ? 0 : (sf32(_loc2_,0), si32(1597463007 - (li32(0) >> 1),0), _loc3_ = lf32(0), 1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
         }
         return _loc1_.dyn_fric;
      }
      
      public function get contacts() : ContactList
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         if(zpp_inner.colarb.wrap_contacts == null)
         {
            zpp_inner.colarb.setupcontacts();
         }
         return zpp_inner.colarb.wrap_contacts;
      }
      
      public function firstVertex() : Boolean
      {
         if(!zpp_inner.active)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         var _loc1_:Boolean = zpp_inner.colarb.__ref_edge1 != null != (zpp_inner.colarb.__ref_edge2 != null);
         return _loc1_ ? zpp_inner.colarb.__ref_vertex == -1 : false;
      }
   }
}
