package zpp_nape.space
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.Config;
   import nape.callbacks.BodyCallback;
   import nape.callbacks.ConstraintCallback;
   import nape.callbacks.InteractionCallback;
   import nape.callbacks.Listener;
   import nape.callbacks.ListenerList;
   import nape.callbacks.PreCallback;
   import nape.callbacks.PreFlag;
   import nape.constraint.Constraint;
   import nape.constraint.ConstraintList;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.ContactList;
   import nape.dynamics.InteractionFilter;
   import nape.geom.AABB;
   import nape.geom.ConvexResult;
   import nape.geom.ConvexResultList;
   import nape.geom.Ray;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.phys.Compound;
   import nape.phys.CompoundList;
   import nape.shape.Shape;
   import nape.shape.ShapeIterator;
   import nape.shape.ShapeList;
   import nape.shape.ValidationResult;
   import nape.space.Broadphase;
   import nape.space.Space;
   import zpp_nape.callbacks.ZPP_BodyListener;
   import zpp_nape.callbacks.ZPP_Callback;
   import zpp_nape.callbacks.ZPP_CbSet;
   import zpp_nape.callbacks.ZPP_CbSetPair;
   import zpp_nape.callbacks.ZPP_ConstraintListener;
   import zpp_nape.callbacks.ZPP_InteractionListener;
   import zpp_nape.callbacks.ZPP_Listener;
   import zpp_nape.callbacks.ZPP_OptionType;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_ColArbiter;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.dynamics.ZPP_FluidArbiter;
   import zpp_nape.dynamics.ZPP_IContact;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.dynamics.ZPP_InteractionGroup;
   import zpp_nape.dynamics.ZPP_SensorArbiter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Collide;
   import zpp_nape.geom.ZPP_ConvexRayResult;
   import zpp_nape.geom.ZPP_SweepDistance;
   import zpp_nape.geom.ZPP_ToiEvent;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPList_ConvexResult;
   import zpp_nape.util.ZNPList_ZPP_Arbiter;
   import zpp_nape.util.ZNPList_ZPP_Body;
   import zpp_nape.util.ZNPList_ZPP_CallbackSet;
   import zpp_nape.util.ZNPList_ZPP_CbSetPair;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPList_ZPP_ColArbiter;
   import zpp_nape.util.ZNPList_ZPP_Component;
   import zpp_nape.util.ZNPList_ZPP_Compound;
   import zpp_nape.util.ZNPList_ZPP_Constraint;
   import zpp_nape.util.ZNPList_ZPP_FluidArbiter;
   import zpp_nape.util.ZNPList_ZPP_InteractionListener;
   import zpp_nape.util.ZNPList_ZPP_Interactor;
   import zpp_nape.util.ZNPList_ZPP_Listener;
   import zpp_nape.util.ZNPList_ZPP_SensorArbiter;
   import zpp_nape.util.ZNPList_ZPP_ToiEvent;
   import zpp_nape.util.ZNPNode_ConvexResult;
   import zpp_nape.util.ZNPNode_ZPP_Arbiter;
   import zpp_nape.util.ZNPNode_ZPP_Body;
   import zpp_nape.util.ZNPNode_ZPP_BodyListener;
   import zpp_nape.util.ZNPNode_ZPP_CallbackSet;
   import zpp_nape.util.ZNPNode_ZPP_CbSetPair;
   import zpp_nape.util.ZNPNode_ZPP_ColArbiter;
   import zpp_nape.util.ZNPNode_ZPP_Component;
   import zpp_nape.util.ZNPNode_ZPP_Compound;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZNPNode_ZPP_ConstraintListener;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZNPNode_ZPP_FluidArbiter;
   import zpp_nape.util.ZNPNode_ZPP_InteractionListener;
   import zpp_nape.util.ZNPNode_ZPP_Interactor;
   import zpp_nape.util.ZNPNode_ZPP_Listener;
   import zpp_nape.util.ZNPNode_ZPP_SensorArbiter;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_ToiEvent;
   import zpp_nape.util.ZPP_BodyList;
   import zpp_nape.util.ZPP_CompoundList;
   import zpp_nape.util.ZPP_ConstraintList;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_ListenerList;
   import zpp_nape.util.ZPP_PubPool;
   import zpp_nape.util.ZPP_Set_ZPP_CbSet;
   
   public class ZPP_Space
   {
      public var wrap_livecon:ConstraintList;
      
      public var wrap_live:BodyList;
      
      public var wrap_listeners:ListenerList;
      
      public var wrap_gravity:Vec2;
      
      public var wrap_constraints:ConstraintList;
      
      public var wrap_compounds:CompoundList;
      
      public var wrap_bodies:BodyList;
      
      public var wrap_arbiters:ArbiterList;
      
      public var userData:*;
      
      public var toiEvents:ZNPList_ZPP_ToiEvent;
      
      public var time:Number;
      
      public var staticsleep:ZNPList_ZPP_Body;
      
      public var stamp:int;
      
      public var sortcontacts:Boolean;
      
      public var s_arbiters:ZNPList_ZPP_SensorArbiter;
      
      public var prelisteners:ZNPList_ZPP_InteractionListener;
      
      public var precb:PreCallback;
      
      public var pre_dt:Number;
      
      public var outer:Space;
      
      public var mrca2:ZNPList_ZPP_Interactor;
      
      public var mrca1:ZNPList_ZPP_Interactor;
      
      public var midstep:Boolean;
      
      public var live_constraints:ZNPList_ZPP_Constraint;
      
      public var live:ZNPList_ZPP_Body;
      
      public var listeners:ZNPList_ZPP_Listener;
      
      public var kinematics:ZNPList_ZPP_Body;
      
      public var islands:ZPP_Island;
      
      public var gravityy:Number;
      
      public var gravityx:Number;
      
      public var global_lin_drag:Number;
      
      public var global_ang_drag:Number;
      
      public var f_arbiters:ZNPList_ZPP_FluidArbiter;
      
      public var convexShapeList:ShapeList;
      
      public var continuous:Boolean;
      
      public var constraints:ZNPList_ZPP_Constraint;
      
      public var compounds:ZNPList_ZPP_Compound;
      
      public var cbsets:ZPP_CbSetManager;
      
      public var callbackset_list:ZPP_CallbackSet;
      
      public var callbacks:ZPP_Callback;
      
      public var c_arbiters_true:ZNPList_ZPP_ColArbiter;
      
      public var c_arbiters_false:ZNPList_ZPP_ColArbiter;
      
      public var bphase:ZPP_Broadphase;
      
      public var bodies:ZNPList_ZPP_Body;
      
      public var __static:Body;
      
      public function ZPP_Space(param1:ZPP_Vec2 = undefined, param2:Broadphase = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         prelisteners = null;
         precb = null;
         continuous = false;
         toiEvents = null;
         pre_dt = 0;
         convexShapeList = null;
         cbsets = null;
         callbackset_list = null;
         callbacks = null;
         wrap_listeners = null;
         listeners = null;
         islands = null;
         staticsleep = null;
         wrap_livecon = null;
         live_constraints = null;
         wrap_live = null;
         live = null;
         wrap_arbiters = null;
         s_arbiters = null;
         f_arbiters = null;
         c_arbiters_false = null;
         c_arbiters_true = null;
         sortcontacts = false;
         time = 0;
         midstep = false;
         stamp = 0;
         global_ang_drag = 0;
         global_lin_drag = 0;
         __static = null;
         bphase = null;
         kinematics = null;
         wrap_constraints = null;
         constraints = null;
         wrap_compounds = null;
         compounds = null;
         wrap_bodies = null;
         bodies = null;
         wrap_gravity = null;
         gravityy = 0;
         gravityx = 0;
         userData = null;
         outer = null;
         toiEvents = new ZNPList_ZPP_ToiEvent();
         global_lin_drag = 0.015;
         global_ang_drag = 0.015;
         ZPP_Callback.§internal§ = true;
         precb = new PreCallback();
         precb.zpp_inner = new ZPP_Callback();
         ZPP_Callback.§internal§ = false;
         sortcontacts = true;
         pre_dt = 0;
         if(param2 == null || §§pop() == ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE)
         {
            bphase = new ZPP_DynAABBPhase(this);
         }
         else
         {
            §§push(param2);
            if(ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.Broadphase_SWEEP_AND_PRUNE)
            {
               bphase = new ZPP_SweepPhase(this);
            }
         }
         time = 0;
         var _loc3_:ZPP_Space = this;
         if(param1 != null)
         {
            gravityx = param1.x;
            gravityy = param1.y;
         }
         else
         {
            gravityx = 0;
            gravityy = 0;
         }
         bodies = new ZNPList_ZPP_Body();
         wrap_bodies = ZPP_BodyList.get(bodies);
         wrap_bodies.zpp_inner.adder = bodies_adder;
         wrap_bodies.zpp_inner.subber = bodies_subber;
         wrap_bodies.zpp_inner._modifiable = bodies_modifiable;
         compounds = new ZNPList_ZPP_Compound();
         wrap_compounds = ZPP_CompoundList.get(compounds);
         wrap_compounds.zpp_inner.adder = compounds_adder;
         wrap_compounds.zpp_inner.subber = compounds_subber;
         wrap_compounds.zpp_inner._modifiable = compounds_modifiable;
         kinematics = new ZNPList_ZPP_Body();
         c_arbiters_true = new ZNPList_ZPP_ColArbiter();
         c_arbiters_false = new ZNPList_ZPP_ColArbiter();
         f_arbiters = new ZNPList_ZPP_FluidArbiter();
         s_arbiters = new ZNPList_ZPP_SensorArbiter();
         islands = new ZPP_Island();
         live = new ZNPList_ZPP_Body();
         wrap_live = ZPP_BodyList.get(live,true);
         staticsleep = new ZNPList_ZPP_Body();
         constraints = new ZNPList_ZPP_Constraint();
         wrap_constraints = ZPP_ConstraintList.get(constraints);
         wrap_constraints.zpp_inner.adder = constraints_adder;
         wrap_constraints.zpp_inner.subber = constraints_subber;
         wrap_constraints.zpp_inner._modifiable = constraints_modifiable;
         live_constraints = new ZNPList_ZPP_Constraint();
         wrap_livecon = ZPP_ConstraintList.get(live_constraints,true);
         __static = ZPP_Body.__static();
         __static.zpp_inner.space = this;
         callbacks = new ZPP_Callback();
         midstep = false;
         listeners = new ZNPList_ZPP_Listener();
         wrap_listeners = ZPP_ListenerList.get(listeners);
         wrap_listeners.zpp_inner.adder = listeners_adder;
         wrap_listeners.zpp_inner.subber = listeners_subber;
         wrap_listeners.zpp_inner._modifiable = listeners_modifiable;
         callbackset_list = new ZPP_CallbackSet();
         mrca1 = new ZNPList_ZPP_Interactor();
         mrca2 = new ZNPList_ZPP_Interactor();
         prelisteners = new ZNPList_ZPP_InteractionListener();
         cbsets = new ZPP_CbSetManager(this);
      }
      
      public function warmStart() : void
      {
         var _loc2_:* = null as ZPP_FluidArbiter;
         var _loc3_:Number = NaN;
         var _loc6_:* = null as ZPP_ColArbiter;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:* = null as ZPP_Constraint;
         var _loc1_:ZNPNode_ZPP_FluidArbiter = f_arbiters.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            if(_loc2_.active && (_loc2_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
            {
               _loc3_ = _loc2_.b1.imass;
               _loc2_.b1.velx -= _loc2_.dampx * _loc3_;
               _loc2_.b1.vely -= _loc2_.dampy * _loc3_;
               _loc3_ = _loc2_.b2.imass;
               _loc2_.b2.velx += _loc2_.dampx * _loc3_;
               _loc2_.b2.vely += _loc2_.dampy * _loc3_;
               _loc2_.b1.angvel -= _loc2_.b1.iinertia * (_loc2_.dampy * _loc2_.r1x - _loc2_.dampx * _loc2_.r1y);
               _loc2_.b2.angvel += _loc2_.b2.iinertia * (_loc2_.dampy * _loc2_.r2x - _loc2_.dampx * _loc2_.r2y);
               _loc2_.b1.angvel -= _loc2_.adamp * _loc2_.b1.iinertia;
               _loc2_.b2.angvel += _loc2_.adamp * _loc2_.b2.iinertia;
            }
            _loc1_ = _loc1_.next;
         }
         var _loc4_:ZNPNode_ZPP_ColArbiter = c_arbiters_false.head;
         var _loc5_:Boolean = true;
         if(_loc4_ == null)
         {
            _loc4_ = c_arbiters_true.head;
            _loc5_ = false;
         }
         while(_loc4_ != null)
         {
            _loc6_ = _loc4_.elt;
            if(_loc6_.active && (_loc6_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
            {
               _loc3_ = _loc6_.nx * _loc6_.c1.jnAcc - _loc6_.ny * _loc6_.c1.jtAcc;
               _loc7_ = _loc6_.ny * _loc6_.c1.jnAcc + _loc6_.nx * _loc6_.c1.jtAcc;
               _loc8_ = _loc6_.b1.imass;
               _loc6_.b1.velx -= _loc3_ * _loc8_;
               _loc6_.b1.vely -= _loc7_ * _loc8_;
               _loc6_.b1.angvel -= _loc6_.b1.iinertia * (_loc7_ * _loc6_.c1.r1x - _loc3_ * _loc6_.c1.r1y);
               _loc8_ = _loc6_.b2.imass;
               _loc6_.b2.velx += _loc3_ * _loc8_;
               _loc6_.b2.vely += _loc7_ * _loc8_;
               _loc6_.b2.angvel += _loc6_.b2.iinertia * (_loc7_ * _loc6_.c1.r2x - _loc3_ * _loc6_.c1.r2y);
               if(_loc6_.hc2)
               {
                  _loc3_ = _loc6_.nx * _loc6_.c2.jnAcc - _loc6_.ny * _loc6_.c2.jtAcc;
                  _loc7_ = _loc6_.ny * _loc6_.c2.jnAcc + _loc6_.nx * _loc6_.c2.jtAcc;
                  _loc8_ = _loc6_.b1.imass;
                  _loc6_.b1.velx -= _loc3_ * _loc8_;
                  _loc6_.b1.vely -= _loc7_ * _loc8_;
                  _loc6_.b1.angvel -= _loc6_.b1.iinertia * (_loc7_ * _loc6_.c2.r1x - _loc3_ * _loc6_.c2.r1y);
                  _loc8_ = _loc6_.b2.imass;
                  _loc6_.b2.velx += _loc3_ * _loc8_;
                  _loc6_.b2.vely += _loc7_ * _loc8_;
                  _loc6_.b2.angvel += _loc6_.b2.iinertia * (_loc7_ * _loc6_.c2.r2x - _loc3_ * _loc6_.c2.r2y);
               }
               _loc6_.b2.angvel += _loc6_.jrAcc * _loc6_.b2.iinertia;
               _loc6_.b1.angvel -= _loc6_.jrAcc * _loc6_.b1.iinertia;
            }
            _loc4_ = _loc4_.next;
            if(_loc5_ && _loc4_ == null)
            {
               _loc4_ = c_arbiters_true.head;
               _loc5_ = false;
            }
         }
         var _loc9_:ZNPNode_ZPP_Constraint = live_constraints.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            _loc10_.warmStart();
            _loc9_ = _loc9_.next;
         }
      }
      
      public function wake_constraint(param1:ZPP_Constraint, param2:Boolean = false) : Boolean
      {
         var _loc3_:* = null as ZNPList_ZPP_Constraint;
         var _loc4_:* = null as ZNPNode_ZPP_Constraint;
         var _loc5_:* = null as ZNPNode_ZPP_Constraint;
         if(param1.active)
         {
            param1.component.waket = stamp + (midstep ? 0 : 1);
            if(param1.component.sleeping)
            {
               if(param1.component.island == null)
               {
                  param1.component.sleeping = false;
                  _loc3_ = live_constraints;
                  if(ZNPNode_ZPP_Constraint.zpp_pool == null)
                  {
                     _loc5_ = new ZNPNode_ZPP_Constraint();
                  }
                  else
                  {
                     _loc5_ = ZNPNode_ZPP_Constraint.zpp_pool;
                     ZNPNode_ZPP_Constraint.zpp_pool = _loc5_.next;
                     _loc5_.next = null;
                  }
                  null;
                  _loc5_.elt = param1;
                  _loc4_ = _loc5_;
                  _loc4_.next = _loc3_.head;
                  _loc3_.head = _loc4_;
                  _loc3_.modified = true;
                  ++_loc3_.length;
                  param1;
                  param1.wake_connected();
                  if(!param2)
                  {
                     constraintCbWake(param1);
                  }
               }
               else
               {
                  wakeIsland(param1.component.island);
               }
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function wakeIsland(param1:ZPP_Island) : void
      {
         var _loc2_:* = null as ZPP_Component;
         var _loc3_:* = null as ZPP_Body;
         var _loc4_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc5_:* = null as ZPP_Arbiter;
         var _loc6_:* = null as ZPP_ColArbiter;
         var _loc7_:* = null as ZNPList_ZPP_ColArbiter;
         var _loc8_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc9_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc10_:* = null as ZNPList_ZPP_FluidArbiter;
         var _loc11_:* = null as ZPP_FluidArbiter;
         var _loc12_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc13_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc14_:* = null as ZNPList_ZPP_SensorArbiter;
         var _loc15_:* = null as ZPP_SensorArbiter;
         var _loc16_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc17_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc18_:* = null as ZNPNode_ZPP_Shape;
         var _loc19_:* = null as ZPP_Shape;
         var _loc20_:* = null as ZPP_Constraint;
         var _loc21_:* = null as ZNPList_ZPP_Constraint;
         var _loc22_:* = null as ZNPNode_ZPP_Constraint;
         var _loc23_:* = null as ZNPNode_ZPP_Constraint;
         while(param1.comps.head != null)
         {
            _loc2_ = param1.comps.pop_unsafe();
            _loc2_.waket = stamp + (midstep ? 0 : 1);
            if(_loc2_.isBody)
            {
               _loc3_ = _loc2_.body;
               live.add(_loc3_);
               _loc4_ = _loc3_.arbiters.head;
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_.elt;
                  if(_loc5_.sleeping)
                  {
                     _loc5_.sleeping = false;
                     _loc5_.up_stamp += stamp - _loc5_.sleep_stamp;
                     if(_loc5_.type == ZPP_Arbiter.COL)
                     {
                        _loc6_ = _loc5_.colarb;
                        if(_loc6_.stat)
                        {
                           _loc7_ = c_arbiters_true;
                           if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                           {
                              _loc9_ = new ZNPNode_ZPP_ColArbiter();
                           }
                           else
                           {
                              _loc9_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                              ZNPNode_ZPP_ColArbiter.zpp_pool = _loc9_.next;
                              _loc9_.next = null;
                           }
                           null;
                           _loc9_.elt = _loc6_;
                           _loc8_ = _loc9_;
                           _loc8_.next = _loc7_.head;
                           _loc7_.head = _loc8_;
                           _loc7_.modified = true;
                           ++_loc7_.length;
                           _loc6_;
                        }
                        else
                        {
                           _loc7_ = c_arbiters_false;
                           if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                           {
                              _loc9_ = new ZNPNode_ZPP_ColArbiter();
                           }
                           else
                           {
                              _loc9_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                              ZNPNode_ZPP_ColArbiter.zpp_pool = _loc9_.next;
                              _loc9_.next = null;
                           }
                           null;
                           _loc9_.elt = _loc6_;
                           _loc8_ = _loc9_;
                           _loc8_.next = _loc7_.head;
                           _loc7_.head = _loc8_;
                           _loc7_.modified = true;
                           ++_loc7_.length;
                           _loc6_;
                        }
                     }
                     else if(_loc5_.type == ZPP_Arbiter.FLUID)
                     {
                        _loc10_ = f_arbiters;
                        _loc11_ = _loc5_.fluidarb;
                        if(ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                        {
                           _loc13_ = new ZNPNode_ZPP_FluidArbiter();
                        }
                        else
                        {
                           _loc13_ = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                           ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc13_.next;
                           _loc13_.next = null;
                        }
                        null;
                        _loc13_.elt = _loc11_;
                        _loc12_ = _loc13_;
                        _loc12_.next = _loc10_.head;
                        _loc10_.head = _loc12_;
                        _loc10_.modified = true;
                        ++_loc10_.length;
                        _loc11_;
                     }
                     else
                     {
                        _loc14_ = s_arbiters;
                        _loc15_ = _loc5_.sensorarb;
                        if(ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                        {
                           _loc17_ = new ZNPNode_ZPP_SensorArbiter();
                        }
                        else
                        {
                           _loc17_ = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                           ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc17_.next;
                           _loc17_.next = null;
                        }
                        null;
                        _loc17_.elt = _loc15_;
                        _loc16_ = _loc17_;
                        _loc16_.next = _loc14_.head;
                        _loc14_.head = _loc16_;
                        _loc14_.modified = true;
                        ++_loc14_.length;
                        _loc15_;
                     }
                  }
                  _loc4_ = _loc4_.next;
               }
               bodyCbWake(_loc3_);
               _loc2_.sleeping = false;
               _loc2_.island = null;
               _loc2_.parent = _loc2_;
               _loc2_.rank = 0;
               if(_loc3_.type != ZPP_Flags.id_BodyType_STATIC)
               {
                  _loc18_ = _loc3_.shapes.head;
                  while(_loc18_ != null)
                  {
                     _loc19_ = _loc18_.elt;
                     if(_loc19_.node != null)
                     {
                        bphase.sync(_loc19_);
                     }
                     _loc18_ = _loc18_.next;
                  }
               }
            }
            else
            {
               _loc20_ = _loc2_.constraint;
               _loc21_ = live_constraints;
               if(ZNPNode_ZPP_Constraint.zpp_pool == null)
               {
                  _loc23_ = new ZNPNode_ZPP_Constraint();
               }
               else
               {
                  _loc23_ = ZNPNode_ZPP_Constraint.zpp_pool;
                  ZNPNode_ZPP_Constraint.zpp_pool = _loc23_.next;
                  _loc23_.next = null;
               }
               null;
               _loc23_.elt = _loc20_;
               _loc22_ = _loc23_;
               _loc22_.next = _loc21_.head;
               _loc21_.head = _loc22_;
               _loc21_.modified = true;
               ++_loc21_.length;
               _loc20_;
               constraintCbWake(_loc20_);
               _loc2_.sleeping = false;
               _loc2_.island = null;
               _loc2_.parent = _loc2_;
               _loc2_.rank = 0;
            }
         }
         var _loc24_:ZPP_Island = param1;
         _loc24_.next = ZPP_Island.zpp_pool;
         ZPP_Island.zpp_pool = _loc24_;
      }
      
      public function wakeCompound(param1:ZPP_Compound) : void
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc4_:* = null as ZPP_Body;
         var _loc6_:* = null as ZPP_Constraint;
         var _loc8_:* = null as ZPP_Compound;
         var _loc2_:ZNPNode_ZPP_Body = param1.bodies.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = _loc3_;
            if(!_loc4_.world)
            {
               _loc4_.component.waket = stamp + (midstep ? 0 : 1);
               if(_loc4_.component.sleeping)
               {
                  really_wake(_loc4_,false);
               }
            }
            _loc2_ = _loc2_.next;
         }
         var _loc5_:ZNPNode_ZPP_Constraint = param1.constraints.head;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_.elt;
            wake_constraint(_loc6_);
            _loc5_ = _loc5_.next;
         }
         var _loc7_:ZNPNode_ZPP_Compound = param1.compounds.head;
         while(_loc7_ != null)
         {
            _loc8_ = _loc7_.elt;
            wakeCompound(_loc8_);
            _loc7_ = _loc7_.next;
         }
      }
      
      public function validation() : void
      {
         var _loc2_:* = null as ZPP_Set_ZPP_CbSet;
         var _loc3_:* = null as ZPP_CbSet;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Shape;
         var _loc7_:* = null as ZPP_Shape;
         var _loc8_:* = null as ZPP_Polygon;
         var _loc9_:* = null as ValidationResult;
         var _loc10_:* = null as ZPP_Body;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Vec2;
         var _loc14_:* = null as ZPP_Vec2;
         var _loc15_:* = null as ZNPNode_ZPP_Edge;
         var _loc16_:* = null as ZPP_Edge;
         var _loc17_:* = null as ZPP_Circle;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:* = null as ZPP_Vec2;
         var _loc21_:* = null as ZPP_AABB;
         var _loc22_:* = null as ZPP_AABB;
         var _loc23_:* = null as ZNPNode_ZPP_BodyListener;
         var _loc24_:* = null as ZPP_BodyListener;
         var _loc25_:* = null as ZPP_Callback;
         var _loc27_:* = null as ZPP_Constraint;
         var _loc28_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc29_:* = null as ZPP_ConstraintListener;
         var _loc1_:ZPP_CbSetManager = cbsets;
         if(!_loc1_.cbsets.empty())
         {
            _loc2_ = _loc1_.cbsets.parent;
            while(_loc2_.prev != null)
            {
               _loc2_ = _loc2_.prev;
            }
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.data;
               _loc3_.validate();
               if(_loc2_.next != null)
               {
                  _loc2_ = _loc2_.next;
                  while(_loc2_.prev != null)
                  {
                     _loc2_ = _loc2_.prev;
                  }
               }
               else
               {
                  while(_loc2_.parent != null && _loc2_ == _loc2_.parent.next)
                  {
                     _loc2_ = _loc2_.parent;
                  }
                  _loc2_ = _loc2_.parent;
               }
            }
         }
         var _loc4_:ZNPNode_ZPP_Body = live.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc5_.sweepRadius = 0;
            _loc6_ = _loc5_.shapes.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               if(_loc7_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc8_ = _loc7_.polygon;
                  if(_loc8_.zip_sanitation)
                  {
                     _loc8_.zip_sanitation = false;
                     _loc8_.splice_collinear_real();
                  }
                  _loc9_ = _loc7_.polygon.valid();
                  §§push(_loc9_);
                  if(ZPP_Flags.ValidationResult_VALID == null)
                  {
                     ZPP_Flags.§internal§ = true;
                     ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                     ZPP_Flags.§internal§ = false;
                  }
                  if(§§pop() != ZPP_Flags.ValidationResult_VALID)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Cannot simulate with an invalid Polygon : " + _loc7_.polygon.outer.toString() + " is invalid : " + _loc9_.toString();
                  }
                  _loc8_ = _loc7_.polygon;
                  if(_loc8_.zip_gaxi)
                  {
                     if(_loc8_.body != null)
                     {
                        _loc8_.zip_gaxi = false;
                        _loc8_.validate_laxi();
                        _loc10_ = _loc8_.body;
                        if(_loc10_.zip_axis)
                        {
                           _loc10_.zip_axis = false;
                           _loc10_.axisx = Math.sin(_loc10_.rot);
                           _loc10_.axisy = Math.cos(_loc10_.rot);
                           null;
                        }
                        if(_loc8_.zip_gverts)
                        {
                           if(_loc8_.body != null)
                           {
                              _loc8_.zip_gverts = false;
                              _loc8_.validate_lverts();
                              _loc10_ = _loc8_.body;
                              if(_loc10_.zip_axis)
                              {
                                 _loc10_.zip_axis = false;
                                 _loc10_.axisx = Math.sin(_loc10_.rot);
                                 _loc10_.axisy = Math.cos(_loc10_.rot);
                                 null;
                              }
                              _loc11_ = _loc8_.lverts.next;
                              _loc12_ = _loc8_.gverts.next;
                              while(_loc12_ != null)
                              {
                                 _loc13_ = _loc12_;
                                 _loc14_ = _loc11_;
                                 _loc11_ = _loc11_.next;
                                 _loc13_.x = _loc8_.body.posx + (_loc8_.body.axisy * _loc14_.x - _loc8_.body.axisx * _loc14_.y);
                                 _loc13_.y = _loc8_.body.posy + (_loc14_.x * _loc8_.body.axisx + _loc14_.y * _loc8_.body.axisy);
                                 _loc12_ = _loc12_.next;
                              }
                           }
                        }
                        _loc15_ = _loc8_.edges.head;
                        _loc11_ = _loc8_.gverts.next;
                        _loc12_ = _loc11_;
                        _loc11_ = _loc11_.next;
                        while(_loc11_ != null)
                        {
                           _loc13_ = _loc11_;
                           _loc16_ = _loc15_.elt;
                           _loc15_ = _loc15_.next;
                           _loc16_.gp0 = _loc12_;
                           _loc16_.gp1 = _loc13_;
                           _loc16_.gnormx = _loc8_.body.axisy * _loc16_.lnormx - _loc8_.body.axisx * _loc16_.lnormy;
                           _loc16_.gnormy = _loc16_.lnormx * _loc8_.body.axisx + _loc16_.lnormy * _loc8_.body.axisy;
                           _loc16_.gprojection = _loc8_.body.posx * _loc16_.gnormx + _loc8_.body.posy * _loc16_.gnormy + _loc16_.lprojection;
                           if(_loc16_.wrap_gnorm != null)
                           {
                              _loc16_.wrap_gnorm.zpp_inner.x = _loc16_.gnormx;
                              _loc16_.wrap_gnorm.zpp_inner.y = _loc16_.gnormy;
                           }
                           _loc16_.tp0 = _loc16_.gp0.y * _loc16_.gnormx - _loc16_.gp0.x * _loc16_.gnormy;
                           _loc16_.tp1 = _loc16_.gp1.y * _loc16_.gnormx - _loc16_.gp1.x * _loc16_.gnormy;
                           _loc12_ = _loc13_;
                           _loc11_ = _loc11_.next;
                        }
                        _loc13_ = _loc8_.gverts.next;
                        _loc16_ = _loc15_.elt;
                        _loc15_ = _loc15_.next;
                        _loc16_.gp0 = _loc12_;
                        _loc16_.gp1 = _loc13_;
                        _loc16_.gnormx = _loc8_.body.axisy * _loc16_.lnormx - _loc8_.body.axisx * _loc16_.lnormy;
                        _loc16_.gnormy = _loc16_.lnormx * _loc8_.body.axisx + _loc16_.lnormy * _loc8_.body.axisy;
                        _loc16_.gprojection = _loc8_.body.posx * _loc16_.gnormx + _loc8_.body.posy * _loc16_.gnormy + _loc16_.lprojection;
                        if(_loc16_.wrap_gnorm != null)
                        {
                           _loc16_.wrap_gnorm.zpp_inner.x = _loc16_.gnormx;
                           _loc16_.wrap_gnorm.zpp_inner.y = _loc16_.gnormy;
                        }
                        _loc16_.tp0 = _loc16_.gp0.y * _loc16_.gnormx - _loc16_.gp0.x * _loc16_.gnormy;
                        _loc16_.tp1 = _loc16_.gp1.y * _loc16_.gnormx - _loc16_.gp1.x * _loc16_.gnormy;
                     }
                  }
               }
               _loc7_.validate_sweepRadius();
               if(_loc7_.sweepRadius > _loc5_.sweepRadius)
               {
                  _loc5_.sweepRadius = _loc7_.sweepRadius;
               }
               _loc6_ = _loc6_.next;
            }
            _loc5_.validate_mass();
            _loc5_.validate_inertia();
            if(_loc5_.shapes.head != null)
            {
               if(_loc5_.shapes.head == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Body bounds only makes sense if it contains shapes";
               }
               if(_loc5_.zip_aabb)
               {
                  _loc5_.zip_aabb = false;
                  _loc5_.aabb.minx = 1.79e+308;
                  _loc5_.aabb.miny = 1.79e+308;
                  _loc5_.aabb.maxx = -1.79e+308;
                  _loc5_.aabb.maxy = -1.79e+308;
                  _loc6_ = _loc5_.shapes.head;
                  while(_loc6_ != null)
                  {
                     _loc7_ = _loc6_.elt;
                     if(_loc7_.zip_aabb)
                     {
                        if(_loc7_.body != null)
                        {
                           _loc7_.zip_aabb = false;
                           if(_loc7_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                           {
                              _loc17_ = _loc7_.circle;
                              if(_loc17_.zip_worldCOM)
                              {
                                 if(_loc17_.body != null)
                                 {
                                    _loc17_.zip_worldCOM = false;
                                    if(_loc17_.zip_localCOM)
                                    {
                                       _loc17_.zip_localCOM = false;
                                       if(_loc17_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                       {
                                          _loc8_ = _loc17_.polygon;
                                          if(_loc8_.lverts.next == null)
                                          {
                                             Boot.lastError = new Error();
                                             throw "Error: An empty polygon has no meaningful localCOM";
                                          }
                                          if(_loc8_.lverts.next.next == null)
                                          {
                                             _loc8_.localCOMx = _loc8_.lverts.next.x;
                                             _loc8_.localCOMy = _loc8_.lverts.next.y;
                                             null;
                                          }
                                          else if(_loc8_.lverts.next.next.next == null)
                                          {
                                             _loc8_.localCOMx = _loc8_.lverts.next.x;
                                             _loc8_.localCOMy = _loc8_.lverts.next.y;
                                             _loc18_ = 1;
                                             _loc8_.localCOMx += _loc8_.lverts.next.next.x * _loc18_;
                                             _loc8_.localCOMy += _loc8_.lverts.next.next.y * _loc18_;
                                             _loc18_ = 0.5;
                                             _loc8_.localCOMx *= _loc18_;
                                             _loc8_.localCOMy *= _loc18_;
                                          }
                                          else
                                          {
                                             _loc8_.localCOMx = 0;
                                             _loc8_.localCOMy = 0;
                                             _loc18_ = 0;
                                             _loc11_ = _loc8_.lverts.next;
                                             _loc12_ = _loc11_;
                                             _loc11_ = _loc11_.next;
                                             _loc13_ = _loc11_;
                                             _loc11_ = _loc11_.next;
                                             while(_loc11_ != null)
                                             {
                                                _loc14_ = _loc11_;
                                                _loc18_ += _loc13_.x * (_loc14_.y - _loc12_.y);
                                                _loc19_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                                                _loc8_.localCOMx += (_loc13_.x + _loc14_.x) * _loc19_;
                                                _loc8_.localCOMy += (_loc13_.y + _loc14_.y) * _loc19_;
                                                _loc12_ = _loc13_;
                                                _loc13_ = _loc14_;
                                                _loc11_ = _loc11_.next;
                                             }
                                             _loc11_ = _loc8_.lverts.next;
                                             _loc14_ = _loc11_;
                                             _loc18_ += _loc13_.x * (_loc14_.y - _loc12_.y);
                                             _loc19_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                                             _loc8_.localCOMx += (_loc13_.x + _loc14_.x) * _loc19_;
                                             _loc8_.localCOMy += (_loc13_.y + _loc14_.y) * _loc19_;
                                             _loc12_ = _loc13_;
                                             _loc13_ = _loc14_;
                                             _loc11_ = _loc11_.next;
                                             _loc20_ = _loc11_;
                                             _loc18_ += _loc13_.x * (_loc20_.y - _loc12_.y);
                                             _loc19_ = _loc20_.y * _loc13_.x - _loc20_.x * _loc13_.y;
                                             _loc8_.localCOMx += (_loc13_.x + _loc20_.x) * _loc19_;
                                             _loc8_.localCOMy += (_loc13_.y + _loc20_.y) * _loc19_;
                                             _loc18_ = 1 / (3 * _loc18_);
                                             _loc19_ = _loc18_;
                                             _loc8_.localCOMx *= _loc19_;
                                             _loc8_.localCOMy *= _loc19_;
                                          }
                                       }
                                    }
                                    _loc10_ = _loc17_.body;
                                    if(_loc10_.zip_axis)
                                    {
                                       _loc10_.zip_axis = false;
                                       _loc10_.axisx = Math.sin(_loc10_.rot);
                                       _loc10_.axisy = Math.cos(_loc10_.rot);
                                       null;
                                    }
                                    _loc17_.worldCOMx = _loc17_.body.posx + (_loc17_.body.axisy * _loc17_.localCOMx - _loc17_.body.axisx * _loc17_.localCOMy);
                                    _loc17_.worldCOMy = _loc17_.body.posy + (_loc17_.localCOMx * _loc17_.body.axisx + _loc17_.localCOMy * _loc17_.body.axisy);
                                 }
                              }
                              _loc18_ = _loc17_.radius;
                              _loc19_ = _loc17_.radius;
                              _loc17_.aabb.minx = _loc17_.worldCOMx - _loc18_;
                              _loc17_.aabb.miny = _loc17_.worldCOMy - _loc19_;
                              _loc17_.aabb.maxx = _loc17_.worldCOMx + _loc18_;
                              _loc17_.aabb.maxy = _loc17_.worldCOMy + _loc19_;
                           }
                           else
                           {
                              _loc8_ = _loc7_.polygon;
                              if(_loc8_.zip_gverts)
                              {
                                 if(_loc8_.body != null)
                                 {
                                    _loc8_.zip_gverts = false;
                                    _loc8_.validate_lverts();
                                    _loc10_ = _loc8_.body;
                                    if(_loc10_.zip_axis)
                                    {
                                       _loc10_.zip_axis = false;
                                       _loc10_.axisx = Math.sin(_loc10_.rot);
                                       _loc10_.axisy = Math.cos(_loc10_.rot);
                                       null;
                                    }
                                    _loc11_ = _loc8_.lverts.next;
                                    _loc12_ = _loc8_.gverts.next;
                                    while(_loc12_ != null)
                                    {
                                       _loc13_ = _loc12_;
                                       _loc14_ = _loc11_;
                                       _loc11_ = _loc11_.next;
                                       _loc13_.x = _loc8_.body.posx + (_loc8_.body.axisy * _loc14_.x - _loc8_.body.axisx * _loc14_.y);
                                       _loc13_.y = _loc8_.body.posy + (_loc14_.x * _loc8_.body.axisx + _loc14_.y * _loc8_.body.axisy);
                                       _loc12_ = _loc12_.next;
                                    }
                                 }
                              }
                              if(_loc8_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful bounds";
                              }
                              _loc11_ = _loc8_.gverts.next;
                              _loc8_.aabb.minx = _loc11_.x;
                              _loc8_.aabb.miny = _loc11_.y;
                              _loc8_.aabb.maxx = _loc11_.x;
                              _loc8_.aabb.maxy = _loc11_.y;
                              _loc12_ = _loc8_.gverts.next.next;
                              while(_loc12_ != null)
                              {
                                 _loc13_ = _loc12_;
                                 if(_loc13_.x < _loc8_.aabb.minx)
                                 {
                                    _loc8_.aabb.minx = _loc13_.x;
                                 }
                                 if(_loc13_.x > _loc8_.aabb.maxx)
                                 {
                                    _loc8_.aabb.maxx = _loc13_.x;
                                 }
                                 if(_loc13_.y < _loc8_.aabb.miny)
                                 {
                                    _loc8_.aabb.miny = _loc13_.y;
                                 }
                                 if(_loc13_.y > _loc8_.aabb.maxy)
                                 {
                                    _loc8_.aabb.maxy = _loc13_.y;
                                 }
                                 _loc12_ = _loc12_.next;
                              }
                           }
                        }
                     }
                     _loc21_ = _loc5_.aabb;
                     _loc22_ = _loc7_.aabb;
                     if(_loc22_.minx < _loc21_.minx)
                     {
                        _loc21_.minx = _loc22_.minx;
                     }
                     if(_loc22_.maxx > _loc21_.maxx)
                     {
                        _loc21_.maxx = _loc22_.maxx;
                     }
                     if(_loc22_.miny < _loc21_.miny)
                     {
                        _loc21_.miny = _loc22_.miny;
                     }
                     if(_loc22_.maxy > _loc21_.maxy)
                     {
                        _loc21_.maxy = _loc22_.maxy;
                     }
                     _loc6_ = _loc6_.next;
                  }
               }
               _loc5_.validate_worldCOM();
            }
            _loc5_.validate_gravMass();
            if(_loc5_.zip_axis)
            {
               _loc5_.zip_axis = false;
               _loc5_.axisx = Math.sin(_loc5_.rot);
               _loc5_.axisy = Math.cos(_loc5_.rot);
               null;
            }
            if(!_loc5_.nomove && _loc5_.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc5_.mass == 0)
            {
               Boot.lastError = new Error();
               throw "Error: Dynamic Body cannot be simulated with 0 mass unless allowMovement is false";
            }
            if(!_loc5_.norotate && _loc5_.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc5_.inertia == 0)
            {
               Boot.lastError = new Error();
               throw "Error: Dynamic Body cannot be simulated with 0 inertia unless allowRotation is false";
            }
            if(_loc5_.component.woken && _loc5_.cbSet != null)
            {
               _loc23_ = _loc5_.cbSet.bodylisteners.head;
               while(_loc23_ != null)
               {
                  _loc24_ = _loc23_.elt;
                  if(_loc24_.event != ZPP_Flags.id_CbEvent_WAKE)
                  {
                     _loc23_ = _loc23_.next;
                  }
                  else
                  {
                     _loc25_ = push_callback(_loc24_);
                     _loc25_.event = ZPP_Flags.id_CbEvent_WAKE;
                     _loc25_.body = _loc5_;
                     _loc23_ = _loc23_.next;
                  }
               }
            }
            _loc5_.component.woken = false;
            _loc6_ = _loc5_.shapes.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               bphase.sync(_loc7_);
               _loc6_ = _loc6_.next;
            }
            _loc4_ = _loc4_.next;
         }
         _loc4_ = kinematics.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc5_.sweepRadius = 0;
            _loc6_ = _loc5_.shapes.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               if(_loc7_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc8_ = _loc7_.polygon;
                  if(_loc8_.zip_sanitation)
                  {
                     _loc8_.zip_sanitation = false;
                     _loc8_.splice_collinear_real();
                  }
                  _loc9_ = _loc7_.polygon.valid();
                  §§push(_loc9_);
                  if(ZPP_Flags.ValidationResult_VALID == null)
                  {
                     ZPP_Flags.§internal§ = true;
                     ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                     ZPP_Flags.§internal§ = false;
                  }
                  if(§§pop() != ZPP_Flags.ValidationResult_VALID)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Cannot simulate with an invalid Polygon : " + _loc7_.polygon.outer.toString() + " is invalid : " + _loc9_.toString();
                  }
                  _loc8_ = _loc7_.polygon;
                  if(_loc8_.zip_gaxi)
                  {
                     if(_loc8_.body != null)
                     {
                        _loc8_.zip_gaxi = false;
                        _loc8_.validate_laxi();
                        _loc10_ = _loc8_.body;
                        if(_loc10_.zip_axis)
                        {
                           _loc10_.zip_axis = false;
                           _loc10_.axisx = Math.sin(_loc10_.rot);
                           _loc10_.axisy = Math.cos(_loc10_.rot);
                           null;
                        }
                        if(_loc8_.zip_gverts)
                        {
                           if(_loc8_.body != null)
                           {
                              _loc8_.zip_gverts = false;
                              _loc8_.validate_lverts();
                              _loc10_ = _loc8_.body;
                              if(_loc10_.zip_axis)
                              {
                                 _loc10_.zip_axis = false;
                                 _loc10_.axisx = Math.sin(_loc10_.rot);
                                 _loc10_.axisy = Math.cos(_loc10_.rot);
                                 null;
                              }
                              _loc11_ = _loc8_.lverts.next;
                              _loc12_ = _loc8_.gverts.next;
                              while(_loc12_ != null)
                              {
                                 _loc13_ = _loc12_;
                                 _loc14_ = _loc11_;
                                 _loc11_ = _loc11_.next;
                                 _loc13_.x = _loc8_.body.posx + (_loc8_.body.axisy * _loc14_.x - _loc8_.body.axisx * _loc14_.y);
                                 _loc13_.y = _loc8_.body.posy + (_loc14_.x * _loc8_.body.axisx + _loc14_.y * _loc8_.body.axisy);
                                 _loc12_ = _loc12_.next;
                              }
                           }
                        }
                        _loc15_ = _loc8_.edges.head;
                        _loc11_ = _loc8_.gverts.next;
                        _loc12_ = _loc11_;
                        _loc11_ = _loc11_.next;
                        while(_loc11_ != null)
                        {
                           _loc13_ = _loc11_;
                           _loc16_ = _loc15_.elt;
                           _loc15_ = _loc15_.next;
                           _loc16_.gp0 = _loc12_;
                           _loc16_.gp1 = _loc13_;
                           _loc16_.gnormx = _loc8_.body.axisy * _loc16_.lnormx - _loc8_.body.axisx * _loc16_.lnormy;
                           _loc16_.gnormy = _loc16_.lnormx * _loc8_.body.axisx + _loc16_.lnormy * _loc8_.body.axisy;
                           _loc16_.gprojection = _loc8_.body.posx * _loc16_.gnormx + _loc8_.body.posy * _loc16_.gnormy + _loc16_.lprojection;
                           if(_loc16_.wrap_gnorm != null)
                           {
                              _loc16_.wrap_gnorm.zpp_inner.x = _loc16_.gnormx;
                              _loc16_.wrap_gnorm.zpp_inner.y = _loc16_.gnormy;
                           }
                           _loc16_.tp0 = _loc16_.gp0.y * _loc16_.gnormx - _loc16_.gp0.x * _loc16_.gnormy;
                           _loc16_.tp1 = _loc16_.gp1.y * _loc16_.gnormx - _loc16_.gp1.x * _loc16_.gnormy;
                           _loc12_ = _loc13_;
                           _loc11_ = _loc11_.next;
                        }
                        _loc13_ = _loc8_.gverts.next;
                        _loc16_ = _loc15_.elt;
                        _loc15_ = _loc15_.next;
                        _loc16_.gp0 = _loc12_;
                        _loc16_.gp1 = _loc13_;
                        _loc16_.gnormx = _loc8_.body.axisy * _loc16_.lnormx - _loc8_.body.axisx * _loc16_.lnormy;
                        _loc16_.gnormy = _loc16_.lnormx * _loc8_.body.axisx + _loc16_.lnormy * _loc8_.body.axisy;
                        _loc16_.gprojection = _loc8_.body.posx * _loc16_.gnormx + _loc8_.body.posy * _loc16_.gnormy + _loc16_.lprojection;
                        if(_loc16_.wrap_gnorm != null)
                        {
                           _loc16_.wrap_gnorm.zpp_inner.x = _loc16_.gnormx;
                           _loc16_.wrap_gnorm.zpp_inner.y = _loc16_.gnormy;
                        }
                        _loc16_.tp0 = _loc16_.gp0.y * _loc16_.gnormx - _loc16_.gp0.x * _loc16_.gnormy;
                        _loc16_.tp1 = _loc16_.gp1.y * _loc16_.gnormx - _loc16_.gp1.x * _loc16_.gnormy;
                     }
                  }
               }
               _loc7_.validate_sweepRadius();
               if(_loc7_.sweepRadius > _loc5_.sweepRadius)
               {
                  _loc5_.sweepRadius = _loc7_.sweepRadius;
               }
               _loc6_ = _loc6_.next;
            }
            _loc5_.validate_mass();
            _loc5_.validate_inertia();
            if(_loc5_.shapes.head != null)
            {
               if(_loc5_.shapes.head == null)
               {
                  Boot.lastError = new Error();
                  throw "Error: Body bounds only makes sense if it contains shapes";
               }
               if(_loc5_.zip_aabb)
               {
                  _loc5_.zip_aabb = false;
                  _loc5_.aabb.minx = 1.79e+308;
                  _loc5_.aabb.miny = 1.79e+308;
                  _loc5_.aabb.maxx = -1.79e+308;
                  _loc5_.aabb.maxy = -1.79e+308;
                  _loc6_ = _loc5_.shapes.head;
                  while(_loc6_ != null)
                  {
                     _loc7_ = _loc6_.elt;
                     if(_loc7_.zip_aabb)
                     {
                        if(_loc7_.body != null)
                        {
                           _loc7_.zip_aabb = false;
                           if(_loc7_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                           {
                              _loc17_ = _loc7_.circle;
                              if(_loc17_.zip_worldCOM)
                              {
                                 if(_loc17_.body != null)
                                 {
                                    _loc17_.zip_worldCOM = false;
                                    if(_loc17_.zip_localCOM)
                                    {
                                       _loc17_.zip_localCOM = false;
                                       if(_loc17_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                       {
                                          _loc8_ = _loc17_.polygon;
                                          if(_loc8_.lverts.next == null)
                                          {
                                             Boot.lastError = new Error();
                                             throw "Error: An empty polygon has no meaningful localCOM";
                                          }
                                          if(_loc8_.lverts.next.next == null)
                                          {
                                             _loc8_.localCOMx = _loc8_.lverts.next.x;
                                             _loc8_.localCOMy = _loc8_.lverts.next.y;
                                             null;
                                          }
                                          else if(_loc8_.lverts.next.next.next == null)
                                          {
                                             _loc8_.localCOMx = _loc8_.lverts.next.x;
                                             _loc8_.localCOMy = _loc8_.lverts.next.y;
                                             _loc18_ = 1;
                                             _loc8_.localCOMx += _loc8_.lverts.next.next.x * _loc18_;
                                             _loc8_.localCOMy += _loc8_.lverts.next.next.y * _loc18_;
                                             _loc18_ = 0.5;
                                             _loc8_.localCOMx *= _loc18_;
                                             _loc8_.localCOMy *= _loc18_;
                                          }
                                          else
                                          {
                                             _loc8_.localCOMx = 0;
                                             _loc8_.localCOMy = 0;
                                             _loc18_ = 0;
                                             _loc11_ = _loc8_.lverts.next;
                                             _loc12_ = _loc11_;
                                             _loc11_ = _loc11_.next;
                                             _loc13_ = _loc11_;
                                             _loc11_ = _loc11_.next;
                                             while(_loc11_ != null)
                                             {
                                                _loc14_ = _loc11_;
                                                _loc18_ += _loc13_.x * (_loc14_.y - _loc12_.y);
                                                _loc19_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                                                _loc8_.localCOMx += (_loc13_.x + _loc14_.x) * _loc19_;
                                                _loc8_.localCOMy += (_loc13_.y + _loc14_.y) * _loc19_;
                                                _loc12_ = _loc13_;
                                                _loc13_ = _loc14_;
                                                _loc11_ = _loc11_.next;
                                             }
                                             _loc11_ = _loc8_.lverts.next;
                                             _loc14_ = _loc11_;
                                             _loc18_ += _loc13_.x * (_loc14_.y - _loc12_.y);
                                             _loc19_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                                             _loc8_.localCOMx += (_loc13_.x + _loc14_.x) * _loc19_;
                                             _loc8_.localCOMy += (_loc13_.y + _loc14_.y) * _loc19_;
                                             _loc12_ = _loc13_;
                                             _loc13_ = _loc14_;
                                             _loc11_ = _loc11_.next;
                                             _loc20_ = _loc11_;
                                             _loc18_ += _loc13_.x * (_loc20_.y - _loc12_.y);
                                             _loc19_ = _loc20_.y * _loc13_.x - _loc20_.x * _loc13_.y;
                                             _loc8_.localCOMx += (_loc13_.x + _loc20_.x) * _loc19_;
                                             _loc8_.localCOMy += (_loc13_.y + _loc20_.y) * _loc19_;
                                             _loc18_ = 1 / (3 * _loc18_);
                                             _loc19_ = _loc18_;
                                             _loc8_.localCOMx *= _loc19_;
                                             _loc8_.localCOMy *= _loc19_;
                                          }
                                       }
                                    }
                                    _loc10_ = _loc17_.body;
                                    if(_loc10_.zip_axis)
                                    {
                                       _loc10_.zip_axis = false;
                                       _loc10_.axisx = Math.sin(_loc10_.rot);
                                       _loc10_.axisy = Math.cos(_loc10_.rot);
                                       null;
                                    }
                                    _loc17_.worldCOMx = _loc17_.body.posx + (_loc17_.body.axisy * _loc17_.localCOMx - _loc17_.body.axisx * _loc17_.localCOMy);
                                    _loc17_.worldCOMy = _loc17_.body.posy + (_loc17_.localCOMx * _loc17_.body.axisx + _loc17_.localCOMy * _loc17_.body.axisy);
                                 }
                              }
                              _loc18_ = _loc17_.radius;
                              _loc19_ = _loc17_.radius;
                              _loc17_.aabb.minx = _loc17_.worldCOMx - _loc18_;
                              _loc17_.aabb.miny = _loc17_.worldCOMy - _loc19_;
                              _loc17_.aabb.maxx = _loc17_.worldCOMx + _loc18_;
                              _loc17_.aabb.maxy = _loc17_.worldCOMy + _loc19_;
                           }
                           else
                           {
                              _loc8_ = _loc7_.polygon;
                              if(_loc8_.zip_gverts)
                              {
                                 if(_loc8_.body != null)
                                 {
                                    _loc8_.zip_gverts = false;
                                    _loc8_.validate_lverts();
                                    _loc10_ = _loc8_.body;
                                    if(_loc10_.zip_axis)
                                    {
                                       _loc10_.zip_axis = false;
                                       _loc10_.axisx = Math.sin(_loc10_.rot);
                                       _loc10_.axisy = Math.cos(_loc10_.rot);
                                       null;
                                    }
                                    _loc11_ = _loc8_.lverts.next;
                                    _loc12_ = _loc8_.gverts.next;
                                    while(_loc12_ != null)
                                    {
                                       _loc13_ = _loc12_;
                                       _loc14_ = _loc11_;
                                       _loc11_ = _loc11_.next;
                                       _loc13_.x = _loc8_.body.posx + (_loc8_.body.axisy * _loc14_.x - _loc8_.body.axisx * _loc14_.y);
                                       _loc13_.y = _loc8_.body.posy + (_loc14_.x * _loc8_.body.axisx + _loc14_.y * _loc8_.body.axisy);
                                       _loc12_ = _loc12_.next;
                                    }
                                 }
                              }
                              if(_loc8_.lverts.next == null)
                              {
                                 Boot.lastError = new Error();
                                 throw "Error: An empty polygon has no meaningful bounds";
                              }
                              _loc11_ = _loc8_.gverts.next;
                              _loc8_.aabb.minx = _loc11_.x;
                              _loc8_.aabb.miny = _loc11_.y;
                              _loc8_.aabb.maxx = _loc11_.x;
                              _loc8_.aabb.maxy = _loc11_.y;
                              _loc12_ = _loc8_.gverts.next.next;
                              while(_loc12_ != null)
                              {
                                 _loc13_ = _loc12_;
                                 if(_loc13_.x < _loc8_.aabb.minx)
                                 {
                                    _loc8_.aabb.minx = _loc13_.x;
                                 }
                                 if(_loc13_.x > _loc8_.aabb.maxx)
                                 {
                                    _loc8_.aabb.maxx = _loc13_.x;
                                 }
                                 if(_loc13_.y < _loc8_.aabb.miny)
                                 {
                                    _loc8_.aabb.miny = _loc13_.y;
                                 }
                                 if(_loc13_.y > _loc8_.aabb.maxy)
                                 {
                                    _loc8_.aabb.maxy = _loc13_.y;
                                 }
                                 _loc12_ = _loc12_.next;
                              }
                           }
                        }
                     }
                     _loc21_ = _loc5_.aabb;
                     _loc22_ = _loc7_.aabb;
                     if(_loc22_.minx < _loc21_.minx)
                     {
                        _loc21_.minx = _loc22_.minx;
                     }
                     if(_loc22_.maxx > _loc21_.maxx)
                     {
                        _loc21_.maxx = _loc22_.maxx;
                     }
                     if(_loc22_.miny < _loc21_.miny)
                     {
                        _loc21_.miny = _loc22_.miny;
                     }
                     if(_loc22_.maxy > _loc21_.maxy)
                     {
                        _loc21_.maxy = _loc22_.maxy;
                     }
                     _loc6_ = _loc6_.next;
                  }
               }
               _loc5_.validate_worldCOM();
            }
            _loc5_.validate_gravMass();
            if(_loc5_.zip_axis)
            {
               _loc5_.zip_axis = false;
               _loc5_.axisx = Math.sin(_loc5_.rot);
               _loc5_.axisy = Math.cos(_loc5_.rot);
               null;
            }
            if(!_loc5_.nomove && _loc5_.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc5_.mass == 0)
            {
               Boot.lastError = new Error();
               throw "Error: Dynamic Body cannot be simulated with 0 mass unless allowMovement is false";
            }
            if(!_loc5_.norotate && _loc5_.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc5_.inertia == 0)
            {
               Boot.lastError = new Error();
               throw "Error: Dynamic Body cannot be simulated with 0 inertia unless allowRotation is false";
            }
            _loc6_ = _loc5_.shapes.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               bphase.sync(_loc7_);
               _loc6_ = _loc6_.next;
            }
            _loc4_ = _loc4_.next;
         }
         var _loc26_:ZNPNode_ZPP_Constraint = live_constraints.head;
         while(_loc26_ != null)
         {
            _loc27_ = _loc26_.elt;
            if(_loc27_.active)
            {
               _loc27_.validate();
               if(_loc27_.component.woken && _loc27_.cbSet != null)
               {
                  _loc28_ = _loc27_.cbSet.conlisteners.head;
                  while(_loc28_ != null)
                  {
                     _loc29_ = _loc28_.elt;
                     if(_loc29_.event != ZPP_Flags.id_CbEvent_WAKE)
                     {
                        _loc28_ = _loc28_.next;
                     }
                     else
                     {
                        _loc25_ = push_callback(_loc29_);
                        _loc25_.event = ZPP_Flags.id_CbEvent_WAKE;
                        _loc25_.constraint = _loc27_;
                        _loc28_ = _loc28_.next;
                     }
                  }
               }
               _loc27_.component.woken = false;
            }
            _loc26_ = _loc26_.next;
         }
      }
      
      public function updateVel(param1:Number) : void
      {
         var _loc6_:* = null as ZPP_Body;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc2_:ZNPNode_ZPP_Body = null;
         var _loc3_:Number = 1 - param1 * global_lin_drag;
         var _loc4_:Number = 1 - param1 * global_ang_drag;
         var _loc5_:ZNPNode_ZPP_Body = live.head;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_.elt;
            if(_loc6_.smass != 0)
            {
               _loc7_ = param1 * _loc6_.imass;
               _loc6_.velx = _loc3_ * _loc6_.velx + (_loc6_.forcex + gravityx * _loc6_.gravMass) * _loc7_;
               _loc6_.vely = _loc3_ * _loc6_.vely + (_loc6_.forcey + gravityy * _loc6_.gravMass) * _loc7_;
            }
            if(_loc6_.sinertia != 0)
            {
               _loc7_ = 0;
               _loc8_ = 0;
               _loc7_ = _loc6_.worldCOMx - _loc6_.posx;
               _loc8_ = _loc6_.worldCOMy - _loc6_.posy;
               _loc9_ = _loc6_.torque + (gravityy * _loc7_ - gravityx * _loc8_) * _loc6_.gravMass;
               _loc6_.angvel = _loc4_ * _loc6_.angvel + _loc9_ * param1 * _loc6_.iinertia;
            }
            _loc2_ = _loc5_;
            _loc5_ = _loc5_.next;
         }
      }
      
      public function updatePos(param1:Number) : void
      {
         var _loc4_:* = null as ZPP_Body;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as Array;
         var _loc12_:* = null as ZNPNode_ZPP_Shape;
         var _loc13_:* = null as ZPP_Shape;
         var _loc14_:* = null as ZPP_AABB;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:int = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:* = null as ZPP_Circle;
         var _loc26_:* = null as ZPP_Polygon;
         var _loc27_:* = null as ZPP_Vec2;
         var _loc28_:* = null as ZPP_Vec2;
         var _loc29_:* = null as ZPP_Vec2;
         var _loc30_:* = null as ZPP_Vec2;
         var _loc31_:* = null as ZPP_Vec2;
         var _loc32_:* = null as ZPP_Vec2;
         var _loc33_:int = 0;
         var _loc34_:int = 0;
         var _loc35_:Number = NaN;
         var _loc2_:Number = 2 * Math.PI / param1;
         var _loc3_:ZNPNode_ZPP_Body = live.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            _loc4_.pre_posx = _loc4_.posx;
            _loc4_.pre_posy = _loc4_.posy;
            _loc4_.pre_rot = _loc4_.rot;
            _loc4_.sweepTime = 0;
            _loc4_.sweep_angvel = _loc4_.angvel % _loc2_;
            _loc5_ = param1 - _loc4_.sweepTime;
            if(_loc5_ != 0)
            {
               _loc4_.sweepTime = param1;
               _loc6_ = _loc5_;
               _loc4_.posx += _loc4_.velx * _loc6_;
               _loc4_.posy += _loc4_.vely * _loc6_;
               if(_loc4_.angvel != 0)
               {
                  _loc6_ = _loc4_.sweep_angvel * _loc5_;
                  _loc4_.rot += _loc6_;
                  if(_loc6_ * _loc6_ > 0.0001)
                  {
                     _loc4_.axisx = Math.sin(_loc4_.rot);
                     _loc4_.axisy = Math.cos(_loc4_.rot);
                     null;
                  }
                  else
                  {
                     _loc7_ = _loc6_ * _loc6_;
                     _loc8_ = 1 - 0.5 * _loc7_;
                     _loc9_ = 1 - _loc7_ * _loc7_ / 8;
                     _loc10_ = (_loc8_ * _loc4_.axisx + _loc6_ * _loc4_.axisy) * _loc9_;
                     _loc4_.axisy = (_loc8_ * _loc4_.axisy - _loc6_ * _loc4_.axisx) * _loc9_;
                     _loc4_.axisx = _loc10_;
                  }
               }
            }
            if(!_loc4_.disableCCD)
            {
               _loc5_ = Config.staticCCDLinearThreshold * _loc4_.sweepRadius;
               _loc6_ = Config.staticCCDAngularThreshold;
               if((_loc4_.velx * _loc4_.velx + _loc4_.vely * _loc4_.vely) * param1 * param1 > _loc5_ * _loc5_ || _loc4_.angvel * _loc4_.angvel * param1 * param1 > _loc6_ * _loc6_ || _loc4_.type == ZPP_Flags.id_BodyType_KINEMATIC)
               {
                  _loc11_ = [65280,65535,255,16711935,65280,65535,255,16711935];
                  _loc7_ = _loc4_.sweep_angvel;
                  if(_loc7_ < 0)
                  {
                     _loc7_ = -_loc7_;
                  }
                  _loc8_ = 1 / _loc7_;
                  _loc12_ = _loc4_.shapes.head;
                  while(_loc12_ != null)
                  {
                     _loc13_ = _loc12_.elt;
                     _loc14_ = _loc13_.aabb;
                     _loc9_ = _loc14_.minx;
                     _loc10_ = _loc14_.miny;
                     _loc15_ = _loc14_.maxx;
                     _loc16_ = _loc14_.maxy;
                     _loc17_ = int(_loc7_ * param1 * _loc13_.sweepCoef * (1 / 120));
                     if(_loc17_ > 8)
                     {
                        _loc17_ = 8;
                     }
                     _loc18_ = _loc7_ * param1 / _loc17_;
                     _loc19_ = param1 - _loc4_.sweepTime;
                     if(_loc19_ != 0)
                     {
                        _loc4_.sweepTime = param1;
                        _loc20_ = _loc19_;
                        _loc4_.posx += _loc4_.velx * _loc20_;
                        _loc4_.posy += _loc4_.vely * _loc20_;
                        if(_loc4_.angvel != 0)
                        {
                           _loc20_ = _loc4_.sweep_angvel * _loc19_;
                           _loc4_.rot += _loc20_;
                           if(_loc20_ * _loc20_ > 0.0001)
                           {
                              _loc4_.axisx = Math.sin(_loc4_.rot);
                              _loc4_.axisy = Math.cos(_loc4_.rot);
                              null;
                           }
                           else
                           {
                              _loc21_ = _loc20_ * _loc20_;
                              _loc22_ = 1 - 0.5 * _loc21_;
                              _loc23_ = 1 - _loc21_ * _loc21_ / 8;
                              _loc24_ = (_loc22_ * _loc4_.axisx + _loc20_ * _loc4_.axisy) * _loc23_;
                              _loc4_.axisy = (_loc22_ * _loc4_.axisy - _loc20_ * _loc4_.axisx) * _loc23_;
                              _loc4_.axisx = _loc24_;
                           }
                        }
                     }
                     if(_loc13_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc25_ = _loc13_.circle;
                        _loc25_.worldCOMx = _loc25_.body.posx + (_loc25_.body.axisy * _loc25_.localCOMx - _loc25_.body.axisx * _loc25_.localCOMy);
                        _loc25_.worldCOMy = _loc25_.body.posy + (_loc25_.localCOMx * _loc25_.body.axisx + _loc25_.localCOMy * _loc25_.body.axisy);
                        _loc25_.aabb.minx = _loc25_.worldCOMx - _loc25_.radius;
                        _loc25_.aabb.miny = _loc25_.worldCOMy - _loc25_.radius;
                        _loc25_.aabb.maxx = _loc25_.worldCOMx + _loc25_.radius;
                        _loc25_.aabb.maxy = _loc25_.worldCOMy + _loc25_.radius;
                     }
                     else
                     {
                        _loc26_ = _loc13_.polygon;
                        _loc27_ = _loc26_.lverts.next;
                        _loc28_ = _loc26_.gverts.next;
                        _loc29_ = _loc27_;
                        _loc27_ = _loc27_.next;
                        _loc28_.x = _loc26_.body.posx + (_loc26_.body.axisy * _loc29_.x - _loc26_.body.axisx * _loc29_.y);
                        _loc28_.y = _loc26_.body.posy + (_loc29_.x * _loc26_.body.axisx + _loc29_.y * _loc26_.body.axisy);
                        _loc26_.aabb.minx = _loc28_.x;
                        _loc26_.aabb.miny = _loc28_.y;
                        _loc26_.aabb.maxx = _loc28_.x;
                        _loc26_.aabb.maxy = _loc28_.y;
                        _loc30_ = _loc26_.gverts.next.next;
                        while(_loc30_ != null)
                        {
                           _loc31_ = _loc30_;
                           _loc32_ = _loc27_;
                           _loc27_ = _loc27_.next;
                           _loc31_.x = _loc26_.body.posx + (_loc26_.body.axisy * _loc32_.x - _loc26_.body.axisx * _loc32_.y);
                           _loc31_.y = _loc26_.body.posy + (_loc32_.x * _loc26_.body.axisx + _loc32_.y * _loc26_.body.axisy);
                           if(_loc31_.x < _loc26_.aabb.minx)
                           {
                              _loc26_.aabb.minx = _loc31_.x;
                           }
                           if(_loc31_.x > _loc26_.aabb.maxx)
                           {
                              _loc26_.aabb.maxx = _loc31_.x;
                           }
                           if(_loc31_.y < _loc26_.aabb.miny)
                           {
                              _loc26_.aabb.miny = _loc31_.y;
                           }
                           if(_loc31_.y > _loc26_.aabb.maxy)
                           {
                              _loc26_.aabb.maxy = _loc31_.y;
                           }
                           _loc30_ = _loc30_.next;
                        }
                     }
                     if(_loc9_ < _loc14_.minx)
                     {
                        _loc14_.minx = _loc9_;
                     }
                     else
                     {
                        _loc9_ = _loc14_.minx;
                     }
                     if(_loc10_ < _loc14_.miny)
                     {
                        _loc14_.miny = _loc10_;
                     }
                     else
                     {
                        _loc10_ = _loc14_.miny;
                     }
                     if(_loc15_ > _loc14_.maxx)
                     {
                        _loc14_.maxx = _loc15_;
                     }
                     else
                     {
                        _loc15_ = _loc14_.maxx;
                     }
                     if(_loc16_ > _loc14_.maxy)
                     {
                        _loc14_.maxy = _loc16_;
                     }
                     else
                     {
                        _loc16_ = _loc14_.maxy;
                     }
                     _loc33_ = 1;
                     while(_loc33_ < _loc17_)
                     {
                        _loc34_ = _loc33_++;
                        _loc19_ = _loc18_ * _loc34_ * _loc8_;
                        _loc20_ = _loc19_ - _loc4_.sweepTime;
                        if(_loc20_ != 0)
                        {
                           _loc4_.sweepTime = _loc19_;
                           _loc21_ = _loc20_;
                           _loc4_.posx += _loc4_.velx * _loc21_;
                           _loc4_.posy += _loc4_.vely * _loc21_;
                           if(_loc4_.angvel != 0)
                           {
                              _loc21_ = _loc4_.sweep_angvel * _loc20_;
                              _loc4_.rot += _loc21_;
                              if(_loc21_ * _loc21_ > 0.0001)
                              {
                                 _loc4_.axisx = Math.sin(_loc4_.rot);
                                 _loc4_.axisy = Math.cos(_loc4_.rot);
                                 null;
                              }
                              else
                              {
                                 _loc22_ = _loc21_ * _loc21_;
                                 _loc23_ = 1 - 0.5 * _loc22_;
                                 _loc24_ = 1 - _loc22_ * _loc22_ / 8;
                                 _loc35_ = (_loc23_ * _loc4_.axisx + _loc21_ * _loc4_.axisy) * _loc24_;
                                 _loc4_.axisy = (_loc23_ * _loc4_.axisy - _loc21_ * _loc4_.axisx) * _loc24_;
                                 _loc4_.axisx = _loc35_;
                              }
                           }
                        }
                        if(_loc13_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc25_ = _loc13_.circle;
                           _loc25_.worldCOMx = _loc25_.body.posx + (_loc25_.body.axisy * _loc25_.localCOMx - _loc25_.body.axisx * _loc25_.localCOMy);
                           _loc25_.worldCOMy = _loc25_.body.posy + (_loc25_.localCOMx * _loc25_.body.axisx + _loc25_.localCOMy * _loc25_.body.axisy);
                           _loc25_.aabb.minx = _loc25_.worldCOMx - _loc25_.radius;
                           _loc25_.aabb.miny = _loc25_.worldCOMy - _loc25_.radius;
                           _loc25_.aabb.maxx = _loc25_.worldCOMx + _loc25_.radius;
                           _loc25_.aabb.maxy = _loc25_.worldCOMy + _loc25_.radius;
                        }
                        else
                        {
                           _loc26_ = _loc13_.polygon;
                           _loc27_ = _loc26_.lverts.next;
                           _loc28_ = _loc26_.gverts.next;
                           _loc29_ = _loc27_;
                           _loc27_ = _loc27_.next;
                           _loc28_.x = _loc26_.body.posx + (_loc26_.body.axisy * _loc29_.x - _loc26_.body.axisx * _loc29_.y);
                           _loc28_.y = _loc26_.body.posy + (_loc29_.x * _loc26_.body.axisx + _loc29_.y * _loc26_.body.axisy);
                           _loc26_.aabb.minx = _loc28_.x;
                           _loc26_.aabb.miny = _loc28_.y;
                           _loc26_.aabb.maxx = _loc28_.x;
                           _loc26_.aabb.maxy = _loc28_.y;
                           _loc30_ = _loc26_.gverts.next.next;
                           while(_loc30_ != null)
                           {
                              _loc31_ = _loc30_;
                              _loc32_ = _loc27_;
                              _loc27_ = _loc27_.next;
                              _loc31_.x = _loc26_.body.posx + (_loc26_.body.axisy * _loc32_.x - _loc26_.body.axisx * _loc32_.y);
                              _loc31_.y = _loc26_.body.posy + (_loc32_.x * _loc26_.body.axisx + _loc32_.y * _loc26_.body.axisy);
                              if(_loc31_.x < _loc26_.aabb.minx)
                              {
                                 _loc26_.aabb.minx = _loc31_.x;
                              }
                              if(_loc31_.x > _loc26_.aabb.maxx)
                              {
                                 _loc26_.aabb.maxx = _loc31_.x;
                              }
                              if(_loc31_.y < _loc26_.aabb.miny)
                              {
                                 _loc26_.aabb.miny = _loc31_.y;
                              }
                              if(_loc31_.y > _loc26_.aabb.maxy)
                              {
                                 _loc26_.aabb.maxy = _loc31_.y;
                              }
                              _loc30_ = _loc30_.next;
                           }
                        }
                        if(_loc9_ < _loc14_.minx)
                        {
                           _loc14_.minx = _loc9_;
                        }
                        else
                        {
                           _loc9_ = _loc14_.minx;
                        }
                        if(_loc10_ < _loc14_.miny)
                        {
                           _loc14_.miny = _loc10_;
                        }
                        else
                        {
                           _loc10_ = _loc14_.miny;
                        }
                        if(_loc15_ > _loc14_.maxx)
                        {
                           _loc14_.maxx = _loc15_;
                        }
                        else
                        {
                           _loc15_ = _loc14_.maxx;
                        }
                        if(_loc16_ > _loc14_.maxy)
                        {
                           _loc14_.maxy = _loc16_;
                        }
                        else
                        {
                           _loc16_ = _loc14_.maxy;
                        }
                     }
                     bphase.sync(_loc13_);
                     _loc12_ = _loc12_.next;
                  }
                  _loc4_.sweepFrozen = false;
                  if(_loc4_.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc4_.bulletEnabled)
                  {
                     _loc9_ = Config.bulletCCDLinearThreshold * _loc4_.sweepRadius;
                     _loc10_ = Config.bulletCCDAngularThreshold;
                     if((_loc4_.velx * _loc4_.velx + _loc4_.vely * _loc4_.vely) * param1 * param1 > _loc9_ * _loc9_ || _loc4_.angvel * _loc4_.angvel * param1 * param1 > _loc10_ * _loc10_)
                     {
                        _loc4_.bullet = true;
                     }
                  }
               }
               else
               {
                  _loc4_.sweepFrozen = true;
                  _loc4_.bullet = false;
               }
            }
            else
            {
               _loc4_.sweepFrozen = true;
               _loc4_.bullet = false;
            }
            _loc3_ = _loc3_.next;
         }
         _loc3_ = kinematics.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            _loc4_.pre_posx = _loc4_.posx;
            _loc4_.pre_posy = _loc4_.posy;
            _loc4_.pre_rot = _loc4_.rot;
            _loc4_.sweepTime = 0;
            _loc4_.sweep_angvel = _loc4_.angvel % _loc2_;
            _loc5_ = param1 - _loc4_.sweepTime;
            if(_loc5_ != 0)
            {
               _loc4_.sweepTime = param1;
               _loc6_ = _loc5_;
               _loc4_.posx += _loc4_.velx * _loc6_;
               _loc4_.posy += _loc4_.vely * _loc6_;
               if(_loc4_.angvel != 0)
               {
                  _loc6_ = _loc4_.sweep_angvel * _loc5_;
                  _loc4_.rot += _loc6_;
                  if(_loc6_ * _loc6_ > 0.0001)
                  {
                     _loc4_.axisx = Math.sin(_loc4_.rot);
                     _loc4_.axisy = Math.cos(_loc4_.rot);
                     null;
                  }
                  else
                  {
                     _loc7_ = _loc6_ * _loc6_;
                     _loc8_ = 1 - 0.5 * _loc7_;
                     _loc9_ = 1 - _loc7_ * _loc7_ / 8;
                     _loc10_ = (_loc8_ * _loc4_.axisx + _loc6_ * _loc4_.axisy) * _loc9_;
                     _loc4_.axisy = (_loc8_ * _loc4_.axisy - _loc6_ * _loc4_.axisx) * _loc9_;
                     _loc4_.axisx = _loc10_;
                  }
               }
            }
            if(!_loc4_.disableCCD)
            {
               _loc5_ = Config.staticCCDLinearThreshold * _loc4_.sweepRadius;
               _loc6_ = Config.staticCCDAngularThreshold;
               if((_loc4_.velx * _loc4_.velx + _loc4_.vely * _loc4_.vely) * param1 * param1 > _loc5_ * _loc5_ || _loc4_.angvel * _loc4_.angvel * param1 * param1 > _loc6_ * _loc6_ || _loc4_.type == ZPP_Flags.id_BodyType_KINEMATIC)
               {
                  _loc11_ = [65280,65535,255,16711935,65280,65535,255,16711935];
                  _loc7_ = _loc4_.sweep_angvel;
                  if(_loc7_ < 0)
                  {
                     _loc7_ = -_loc7_;
                  }
                  _loc8_ = 1 / _loc7_;
                  _loc12_ = _loc4_.shapes.head;
                  while(_loc12_ != null)
                  {
                     _loc13_ = _loc12_.elt;
                     _loc14_ = _loc13_.aabb;
                     _loc9_ = _loc14_.minx;
                     _loc10_ = _loc14_.miny;
                     _loc15_ = _loc14_.maxx;
                     _loc16_ = _loc14_.maxy;
                     _loc17_ = int(_loc7_ * param1 * _loc13_.sweepCoef * (1 / 120));
                     if(_loc17_ > 8)
                     {
                        _loc17_ = 8;
                     }
                     _loc18_ = _loc7_ * param1 / _loc17_;
                     _loc19_ = param1 - _loc4_.sweepTime;
                     if(_loc19_ != 0)
                     {
                        _loc4_.sweepTime = param1;
                        _loc20_ = _loc19_;
                        _loc4_.posx += _loc4_.velx * _loc20_;
                        _loc4_.posy += _loc4_.vely * _loc20_;
                        if(_loc4_.angvel != 0)
                        {
                           _loc20_ = _loc4_.sweep_angvel * _loc19_;
                           _loc4_.rot += _loc20_;
                           if(_loc20_ * _loc20_ > 0.0001)
                           {
                              _loc4_.axisx = Math.sin(_loc4_.rot);
                              _loc4_.axisy = Math.cos(_loc4_.rot);
                              null;
                           }
                           else
                           {
                              _loc21_ = _loc20_ * _loc20_;
                              _loc22_ = 1 - 0.5 * _loc21_;
                              _loc23_ = 1 - _loc21_ * _loc21_ / 8;
                              _loc24_ = (_loc22_ * _loc4_.axisx + _loc20_ * _loc4_.axisy) * _loc23_;
                              _loc4_.axisy = (_loc22_ * _loc4_.axisy - _loc20_ * _loc4_.axisx) * _loc23_;
                              _loc4_.axisx = _loc24_;
                           }
                        }
                     }
                     if(_loc13_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc25_ = _loc13_.circle;
                        _loc25_.worldCOMx = _loc25_.body.posx + (_loc25_.body.axisy * _loc25_.localCOMx - _loc25_.body.axisx * _loc25_.localCOMy);
                        _loc25_.worldCOMy = _loc25_.body.posy + (_loc25_.localCOMx * _loc25_.body.axisx + _loc25_.localCOMy * _loc25_.body.axisy);
                        _loc25_.aabb.minx = _loc25_.worldCOMx - _loc25_.radius;
                        _loc25_.aabb.miny = _loc25_.worldCOMy - _loc25_.radius;
                        _loc25_.aabb.maxx = _loc25_.worldCOMx + _loc25_.radius;
                        _loc25_.aabb.maxy = _loc25_.worldCOMy + _loc25_.radius;
                     }
                     else
                     {
                        _loc26_ = _loc13_.polygon;
                        _loc27_ = _loc26_.lverts.next;
                        _loc28_ = _loc26_.gverts.next;
                        _loc29_ = _loc27_;
                        _loc27_ = _loc27_.next;
                        _loc28_.x = _loc26_.body.posx + (_loc26_.body.axisy * _loc29_.x - _loc26_.body.axisx * _loc29_.y);
                        _loc28_.y = _loc26_.body.posy + (_loc29_.x * _loc26_.body.axisx + _loc29_.y * _loc26_.body.axisy);
                        _loc26_.aabb.minx = _loc28_.x;
                        _loc26_.aabb.miny = _loc28_.y;
                        _loc26_.aabb.maxx = _loc28_.x;
                        _loc26_.aabb.maxy = _loc28_.y;
                        _loc30_ = _loc26_.gverts.next.next;
                        while(_loc30_ != null)
                        {
                           _loc31_ = _loc30_;
                           _loc32_ = _loc27_;
                           _loc27_ = _loc27_.next;
                           _loc31_.x = _loc26_.body.posx + (_loc26_.body.axisy * _loc32_.x - _loc26_.body.axisx * _loc32_.y);
                           _loc31_.y = _loc26_.body.posy + (_loc32_.x * _loc26_.body.axisx + _loc32_.y * _loc26_.body.axisy);
                           if(_loc31_.x < _loc26_.aabb.minx)
                           {
                              _loc26_.aabb.minx = _loc31_.x;
                           }
                           if(_loc31_.x > _loc26_.aabb.maxx)
                           {
                              _loc26_.aabb.maxx = _loc31_.x;
                           }
                           if(_loc31_.y < _loc26_.aabb.miny)
                           {
                              _loc26_.aabb.miny = _loc31_.y;
                           }
                           if(_loc31_.y > _loc26_.aabb.maxy)
                           {
                              _loc26_.aabb.maxy = _loc31_.y;
                           }
                           _loc30_ = _loc30_.next;
                        }
                     }
                     if(_loc9_ < _loc14_.minx)
                     {
                        _loc14_.minx = _loc9_;
                     }
                     else
                     {
                        _loc9_ = _loc14_.minx;
                     }
                     if(_loc10_ < _loc14_.miny)
                     {
                        _loc14_.miny = _loc10_;
                     }
                     else
                     {
                        _loc10_ = _loc14_.miny;
                     }
                     if(_loc15_ > _loc14_.maxx)
                     {
                        _loc14_.maxx = _loc15_;
                     }
                     else
                     {
                        _loc15_ = _loc14_.maxx;
                     }
                     if(_loc16_ > _loc14_.maxy)
                     {
                        _loc14_.maxy = _loc16_;
                     }
                     else
                     {
                        _loc16_ = _loc14_.maxy;
                     }
                     _loc33_ = 1;
                     while(_loc33_ < _loc17_)
                     {
                        _loc34_ = _loc33_++;
                        _loc19_ = _loc18_ * _loc34_ * _loc8_;
                        _loc20_ = _loc19_ - _loc4_.sweepTime;
                        if(_loc20_ != 0)
                        {
                           _loc4_.sweepTime = _loc19_;
                           _loc21_ = _loc20_;
                           _loc4_.posx += _loc4_.velx * _loc21_;
                           _loc4_.posy += _loc4_.vely * _loc21_;
                           if(_loc4_.angvel != 0)
                           {
                              _loc21_ = _loc4_.sweep_angvel * _loc20_;
                              _loc4_.rot += _loc21_;
                              if(_loc21_ * _loc21_ > 0.0001)
                              {
                                 _loc4_.axisx = Math.sin(_loc4_.rot);
                                 _loc4_.axisy = Math.cos(_loc4_.rot);
                                 null;
                              }
                              else
                              {
                                 _loc22_ = _loc21_ * _loc21_;
                                 _loc23_ = 1 - 0.5 * _loc22_;
                                 _loc24_ = 1 - _loc22_ * _loc22_ / 8;
                                 _loc35_ = (_loc23_ * _loc4_.axisx + _loc21_ * _loc4_.axisy) * _loc24_;
                                 _loc4_.axisy = (_loc23_ * _loc4_.axisy - _loc21_ * _loc4_.axisx) * _loc24_;
                                 _loc4_.axisx = _loc35_;
                              }
                           }
                        }
                        if(_loc13_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc25_ = _loc13_.circle;
                           _loc25_.worldCOMx = _loc25_.body.posx + (_loc25_.body.axisy * _loc25_.localCOMx - _loc25_.body.axisx * _loc25_.localCOMy);
                           _loc25_.worldCOMy = _loc25_.body.posy + (_loc25_.localCOMx * _loc25_.body.axisx + _loc25_.localCOMy * _loc25_.body.axisy);
                           _loc25_.aabb.minx = _loc25_.worldCOMx - _loc25_.radius;
                           _loc25_.aabb.miny = _loc25_.worldCOMy - _loc25_.radius;
                           _loc25_.aabb.maxx = _loc25_.worldCOMx + _loc25_.radius;
                           _loc25_.aabb.maxy = _loc25_.worldCOMy + _loc25_.radius;
                        }
                        else
                        {
                           _loc26_ = _loc13_.polygon;
                           _loc27_ = _loc26_.lverts.next;
                           _loc28_ = _loc26_.gverts.next;
                           _loc29_ = _loc27_;
                           _loc27_ = _loc27_.next;
                           _loc28_.x = _loc26_.body.posx + (_loc26_.body.axisy * _loc29_.x - _loc26_.body.axisx * _loc29_.y);
                           _loc28_.y = _loc26_.body.posy + (_loc29_.x * _loc26_.body.axisx + _loc29_.y * _loc26_.body.axisy);
                           _loc26_.aabb.minx = _loc28_.x;
                           _loc26_.aabb.miny = _loc28_.y;
                           _loc26_.aabb.maxx = _loc28_.x;
                           _loc26_.aabb.maxy = _loc28_.y;
                           _loc30_ = _loc26_.gverts.next.next;
                           while(_loc30_ != null)
                           {
                              _loc31_ = _loc30_;
                              _loc32_ = _loc27_;
                              _loc27_ = _loc27_.next;
                              _loc31_.x = _loc26_.body.posx + (_loc26_.body.axisy * _loc32_.x - _loc26_.body.axisx * _loc32_.y);
                              _loc31_.y = _loc26_.body.posy + (_loc32_.x * _loc26_.body.axisx + _loc32_.y * _loc26_.body.axisy);
                              if(_loc31_.x < _loc26_.aabb.minx)
                              {
                                 _loc26_.aabb.minx = _loc31_.x;
                              }
                              if(_loc31_.x > _loc26_.aabb.maxx)
                              {
                                 _loc26_.aabb.maxx = _loc31_.x;
                              }
                              if(_loc31_.y < _loc26_.aabb.miny)
                              {
                                 _loc26_.aabb.miny = _loc31_.y;
                              }
                              if(_loc31_.y > _loc26_.aabb.maxy)
                              {
                                 _loc26_.aabb.maxy = _loc31_.y;
                              }
                              _loc30_ = _loc30_.next;
                           }
                        }
                        if(_loc9_ < _loc14_.minx)
                        {
                           _loc14_.minx = _loc9_;
                        }
                        else
                        {
                           _loc9_ = _loc14_.minx;
                        }
                        if(_loc10_ < _loc14_.miny)
                        {
                           _loc14_.miny = _loc10_;
                        }
                        else
                        {
                           _loc10_ = _loc14_.miny;
                        }
                        if(_loc15_ > _loc14_.maxx)
                        {
                           _loc14_.maxx = _loc15_;
                        }
                        else
                        {
                           _loc15_ = _loc14_.maxx;
                        }
                        if(_loc16_ > _loc14_.maxy)
                        {
                           _loc14_.maxy = _loc16_;
                        }
                        else
                        {
                           _loc16_ = _loc14_.maxy;
                        }
                     }
                     bphase.sync(_loc13_);
                     _loc12_ = _loc12_.next;
                  }
                  _loc4_.sweepFrozen = false;
                  if(_loc4_.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc4_.bulletEnabled)
                  {
                     _loc9_ = Config.bulletCCDLinearThreshold * _loc4_.sweepRadius;
                     _loc10_ = Config.bulletCCDAngularThreshold;
                     if((_loc4_.velx * _loc4_.velx + _loc4_.vely * _loc4_.vely) * param1 * param1 > _loc9_ * _loc9_ || _loc4_.angvel * _loc4_.angvel * param1 * param1 > _loc10_ * _loc10_)
                     {
                        _loc4_.bullet = true;
                     }
                  }
               }
               else
               {
                  _loc4_.sweepFrozen = true;
                  _loc4_.bullet = false;
               }
            }
            else
            {
               _loc4_.sweepFrozen = true;
               _loc4_.bullet = false;
            }
            _loc3_ = _loc3_.next;
         }
      }
      
      public function transmitType(param1:ZPP_Body, param2:int) : void
      {
         var _loc3_:ZPP_Body = param1;
         if(!_loc3_.world)
         {
            _loc3_.component.waket = stamp + (midstep ? 0 : 1);
            if(_loc3_.component.sleeping)
            {
               really_wake(_loc3_,false);
            }
         }
         if(param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            live.remove(param1);
         }
         else if(param1.type == ZPP_Flags.id_BodyType_KINEMATIC)
         {
            kinematics.remove(param1);
            staticsleep.remove(param1);
         }
         else if(param1.type == ZPP_Flags.id_BodyType_STATIC)
         {
            staticsleep.remove(param1);
         }
         param1.type = param2;
         if(param1.type == ZPP_Flags.id_BodyType_KINEMATIC)
         {
            kinematics.add(param1);
         }
         if(param1.type == ZPP_Flags.id_BodyType_STATIC)
         {
            static_validation(param1);
         }
         param1.component.sleeping = true;
         _loc3_ = param1;
         if(!_loc3_.world)
         {
            _loc3_.component.waket = stamp + (midstep ? 0 : 1);
            if(_loc3_.component.sleeping)
            {
               really_wake(_loc3_,true);
            }
         }
      }
      
      public function step(param1:Number, param2:int, param3:int) : void
      {
         var _loc5_:* = null as ZNPList_ZPP_ColArbiter;
         var _loc6_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc7_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc8_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc9_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc10_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc16_:* = null as ZPP_Body;
         var _loc17_:Boolean = false;
         var _loc18_:Boolean = false;
         var _loc19_:* = null as ZNPNode_ZPP_Shape;
         var _loc20_:* = null as ZPP_Shape;
         var _loc22_:* = null as ZNPList_ZPP_Body;
         var _loc23_:* = null as ZNPNode_ZPP_Body;
         var _loc24_:* = null as ZNPNode_ZPP_Body;
         var _loc25_:* = null as ZNPNode_ZPP_Body;
         var _loc28_:* = null as ZPP_CallbackSet;
         var _loc29_:* = null as ZPP_CallbackSet;
         var _loc30_:* = null as ZPP_CallbackSet;
         var _loc31_:* = null as ZPP_CallbackSet;
         var _loc32_:* = null as String;
         var _loc33_:* = null as ZPP_Interactor;
         var _loc34_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc35_:* = null as ZPP_Arbiter;
         var _loc36_:* = null as ZPP_CbSet;
         var _loc37_:* = null as ZPP_CbSet;
         var _loc38_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc39_:* = null as ZPP_CbSetPair;
         var _loc40_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc41_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc42_:* = null as ZPP_CbSetPair;
         var _loc43_:* = null as ZPP_InteractionListener;
         var _loc44_:* = null as ZPP_Callback;
         var _loc45_:* = null as ZPP_Interactor;
         var _loc46_:* = null as ZPP_OptionType;
         var _loc47_:* = null as ZNPList_ZPP_CbType;
         var _loc48_:* = null as ZPP_BodyListener;
         var _loc49_:* = null as ZPP_ConstraintListener;
         var _loc50_:* = null as ZPP_Callback;
         var _loc4_:ZPP_Space = this;
         if(midstep)
         {
            Boot.lastError = new Error();
            throw "Error: ... REALLY?? you\'re going to call space.step() inside of space.step()? COME ON!!";
         }
         time += param1;
         pre_dt = param1;
         midstep = true;
         ++stamp;
         validation();
         bphase.broadphase(this,true);
         prestep(param1);
         if(sortcontacts)
         {
            _loc5_ = c_arbiters_false;
            if(_loc5_.head != null && _loc5_.head.next != null)
            {
               _loc6_ = _loc5_.head;
               _loc7_ = null;
               _loc8_ = null;
               _loc9_ = null;
               _loc10_ = null;
               _loc11_ = 1;
               do
               {
                  _loc12_ = 0;
                  _loc8_ = _loc6_;
                  _loc7_ = _loc6_ = null;
                  while(_loc8_ != null)
                  {
                     _loc12_++;
                     _loc9_ = _loc8_;
                     _loc13_ = 0;
                     _loc14_ = _loc11_;
                     while(_loc9_ != null && _loc13_ < _loc11_)
                     {
                        _loc13_++;
                        _loc9_ = _loc9_.next;
                     }
                     while(_loc13_ > 0 || _loc14_ > 0 && _loc9_ != null)
                     {
                        if(_loc13_ == 0)
                        {
                           _loc10_ = _loc9_;
                           _loc9_ = _loc9_.next;
                           _loc14_--;
                        }
                        else if(_loc14_ == 0 || _loc9_ == null)
                        {
                           _loc10_ = _loc8_;
                           _loc8_ = _loc8_.next;
                           _loc13_--;
                        }
                        else if(_loc8_.elt.active && _loc9_.elt.active ? _loc8_.elt.oc1.dist < _loc9_.elt.oc1.dist : true)
                        {
                           _loc10_ = _loc8_;
                           _loc8_ = _loc8_.next;
                           _loc13_--;
                        }
                        else
                        {
                           _loc10_ = _loc9_;
                           _loc9_ = _loc9_.next;
                           _loc14_--;
                        }
                        if(_loc7_ != null)
                        {
                           _loc7_.next = _loc10_;
                        }
                        else
                        {
                           _loc6_ = _loc10_;
                        }
                        _loc7_ = _loc10_;
                     }
                     _loc8_ = _loc9_;
                  }
                  _loc7_.next = null;
                  _loc11_ <<= 1;
               }
               while(_loc12_ > 1);
               
               _loc5_.head = _loc6_;
               _loc5_.modified = true;
               _loc5_.pushmod = true;
            }
         }
         updateVel(param1);
         warmStart();
         iterateVel(param2);
         var _loc15_:ZNPNode_ZPP_Body = kinematics.head;
         while(_loc15_ != null)
         {
            _loc16_ = _loc15_.elt;
            _loc16_.pre_posx = _loc16_.posx;
            _loc16_.pre_posy = _loc16_.posy;
            _loc16_.pre_rot = _loc16_.rot;
            _loc15_ = _loc15_.next;
         }
         _loc15_ = live.head;
         while(_loc15_ != null)
         {
            _loc16_ = _loc15_.elt;
            _loc16_.pre_posx = _loc16_.posx;
            _loc16_.pre_posy = _loc16_.posy;
            _loc16_.pre_rot = _loc16_.rot;
            _loc15_ = _loc15_.next;
         }
         updatePos(param1);
         continuous = true;
         continuousCollisions(param1);
         continuous = false;
         iteratePos(param3);
         _loc15_ = kinematics.head;
         while(_loc15_ != null)
         {
            _loc16_ = _loc15_.elt;
            _loc17_ = !(_loc16_.posx == _loc16_.pre_posx && _loc16_.posy == _loc16_.pre_posy);
            _loc18_ = _loc16_.pre_rot != _loc16_.rot;
            if(_loc17_)
            {
               _loc19_ = _loc16_.shapes.head;
               while(_loc19_ != null)
               {
                  _loc20_ = _loc19_.elt;
                  if(_loc20_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc20_.polygon.invalidate_gverts();
                     _loc20_.polygon.invalidate_gaxi();
                  }
                  _loc20_.invalidate_worldCOM();
                  _loc19_ = _loc19_.next;
               }
               _loc16_.zip_worldCOM = true;
            }
            if(_loc18_)
            {
               _loc16_.zip_axis = true;
               _loc19_ = _loc16_.shapes.head;
               while(_loc19_ != null)
               {
                  _loc20_ = _loc19_.elt;
                  if(_loc20_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc20_.polygon.invalidate_gverts();
                     _loc20_.polygon.invalidate_gaxi();
                  }
                  _loc20_.invalidate_worldCOM();
                  _loc19_ = _loc19_.next;
               }
               _loc16_.zip_worldCOM = true;
            }
            _loc15_ = _loc15_.next;
         }
         _loc15_ = live.head;
         while(_loc15_ != null)
         {
            _loc16_ = _loc15_.elt;
            _loc17_ = !(_loc16_.posx == _loc16_.pre_posx && _loc16_.posy == _loc16_.pre_posy);
            _loc18_ = _loc16_.pre_rot != _loc16_.rot;
            if(_loc17_)
            {
               _loc19_ = _loc16_.shapes.head;
               while(_loc19_ != null)
               {
                  _loc20_ = _loc19_.elt;
                  if(_loc20_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc20_.polygon.invalidate_gverts();
                     _loc20_.polygon.invalidate_gaxi();
                  }
                  _loc20_.invalidate_worldCOM();
                  _loc19_ = _loc19_.next;
               }
               _loc16_.zip_worldCOM = true;
            }
            if(_loc18_)
            {
               _loc16_.zip_axis = true;
               _loc19_ = _loc16_.shapes.head;
               while(_loc19_ != null)
               {
                  _loc20_ = _loc19_.elt;
                  if(_loc20_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc20_.polygon.invalidate_gverts();
                     _loc20_.polygon.invalidate_gaxi();
                  }
                  _loc20_.invalidate_worldCOM();
                  _loc19_ = _loc19_.next;
               }
               _loc16_.zip_worldCOM = true;
            }
            _loc15_ = _loc15_.next;
         }
         _loc15_ = null;
         var _loc21_:ZNPNode_ZPP_Body = staticsleep.head;
         while(_loc21_ != null)
         {
            _loc16_ = _loc21_.elt;
            if(_loc16_.type != ZPP_Flags.id_BodyType_KINEMATIC || _loc16_.velx == 0 && _loc16_.vely == 0 && _loc16_.angvel == 0)
            {
               _loc16_.component.sleeping = true;
               _loc22_ = staticsleep;
               if(_loc15_ == null)
               {
                  _loc23_ = _loc22_.head;
                  _loc24_ = _loc23_.next;
                  _loc22_.head = _loc24_;
                  if(_loc22_.head == null)
                  {
                     _loc22_.pushmod = true;
                  }
               }
               else
               {
                  _loc23_ = _loc15_.next;
                  _loc24_ = _loc23_.next;
                  _loc15_.next = _loc24_;
                  if(_loc24_ == null)
                  {
                     _loc22_.pushmod = true;
                  }
               }
               _loc25_ = _loc23_;
               _loc25_.elt = null;
               _loc25_.next = ZNPNode_ZPP_Body.zpp_pool;
               ZNPNode_ZPP_Body.zpp_pool = _loc25_;
               _loc22_.modified = true;
               --_loc22_.length;
               _loc22_.pushmod = true;
               _loc21_ = _loc24_;
            }
            else
            {
               _loc15_ = _loc21_;
               _loc21_ = _loc21_.next;
            }
         }
         doForests(param1);
         sleepArbiters();
         midstep = false;
         var _loc26_:ZPP_CallbackSet = null;
         var _loc27_:ZPP_CallbackSet = callbackset_list.next;
         while(_loc27_ != null)
         {
            _loc28_ = _loc27_;
            if(_loc28_.arbiters.head == null)
            {
               _loc29_ = callbackset_list;
               if(_loc26_ == null)
               {
                  _loc30_ = _loc29_.next;
                  _loc31_ = _loc30_.next;
                  _loc29_.next = _loc31_;
                  if(_loc29_.next == null)
                  {
                     _loc29_.pushmod = true;
                  }
               }
               else
               {
                  _loc30_ = _loc26_.next;
                  _loc31_ = _loc30_.next;
                  _loc26_.next = _loc31_;
                  if(_loc31_ == null)
                  {
                     _loc29_.pushmod = true;
                  }
               }
               _loc30_._inuse = false;
               _loc29_.modified = true;
               --_loc29_.length;
               _loc29_.pushmod = true;
               _loc27_ = _loc31_;
               _loc32_ = _loc28_.int1.id + " " + _loc28_.int2.id;
               _loc29_ = _loc28_;
               _loc29_.int1 = _loc29_.int2 = null;
               _loc29_.id = _loc29_.di = -1;
               _loc29_.freed = true;
               null;
               _loc29_.next = ZPP_CallbackSet.zpp_pool;
               ZPP_CallbackSet.zpp_pool = _loc29_;
            }
            else
            {
               _loc18_ = true;
               _loc34_ = _loc28_.arbiters.head;
               while(_loc34_ != null)
               {
                  _loc35_ = _loc34_.elt;
                  if(!_loc35_.sleeping)
                  {
                     _loc18_ = false;
                     break;
                  }
                  _loc34_ = _loc34_.next;
               }
               _loc17_ = _loc18_;
               _loc36_ = _loc28_.int1.cbSet;
               _loc37_ = _loc28_.int2.cbSet;
               _loc11_ = ZPP_Flags.id_CbEvent_ONGOING;
               _loc39_ = null;
               _loc40_ = _loc36_.cbpairs.length < _loc37_.cbpairs.length ? _loc36_.cbpairs : _loc37_.cbpairs;
               _loc41_ = _loc40_.head;
               while(_loc41_ != null)
               {
                  _loc42_ = _loc41_.elt;
                  if(_loc42_.a == _loc36_ && _loc42_.b == _loc37_ || _loc42_.a == _loc37_ && _loc42_.b == _loc36_)
                  {
                     _loc39_ = _loc42_;
                     break;
                  }
                  _loc41_ = _loc41_.next;
               }
               if(_loc39_ == null)
               {
                  if(ZPP_CbSetPair.zpp_pool == null)
                  {
                     _loc42_ = new ZPP_CbSetPair();
                  }
                  else
                  {
                     _loc42_ = ZPP_CbSetPair.zpp_pool;
                     ZPP_CbSetPair.zpp_pool = _loc42_.next;
                     _loc42_.next = null;
                  }
                  _loc42_.zip_listeners = true;
                  if(ZPP_CbSet.setlt(_loc36_,_loc37_))
                  {
                     _loc42_.a = _loc36_;
                     _loc42_.b = _loc37_;
                  }
                  else
                  {
                     _loc42_.a = _loc37_;
                     _loc42_.b = _loc36_;
                  }
                  _loc39_ = _loc42_;
                  _loc36_.cbpairs.add(_loc39_);
                  if(_loc37_ != _loc36_)
                  {
                     _loc37_.cbpairs.add(_loc39_);
                  }
               }
               if(_loc39_.zip_listeners)
               {
                  _loc39_.zip_listeners = false;
                  _loc39_.__validate();
               }
               _loc38_ = _loc39_.listeners.head;
               while(_loc38_ != null)
               {
                  _loc43_ = _loc38_.elt;
                  if(_loc43_.event == _loc11_)
                  {
                     if((!_loc17_ || _loc43_.allowSleepingCallbacks) && !_loc28_.empty_arb(_loc43_.itype))
                     {
                        _loc44_ = _loc4_.push_callback(_loc43_);
                        _loc44_.event = ZPP_Flags.id_CbEvent_ONGOING;
                        _loc33_ = _loc28_.int1;
                        _loc45_ = _loc28_.int2;
                        _loc46_ = _loc43_.options1;
                        _loc47_ = _loc33_.cbTypes;
                        if(_loc46_.nonemptyintersection(_loc47_,_loc46_.includes) && !_loc46_.nonemptyintersection(_loc47_,_loc46_.excludes) && (_loc46_.nonemptyintersection(_loc47_,_loc46_.includes) && !_loc46_.nonemptyintersection(_loc47_,_loc46_.excludes)))
                        {
                           _loc44_.int1 = _loc33_;
                           _loc44_.int2 = _loc45_;
                        }
                        else
                        {
                           _loc44_.int1 = _loc45_;
                           _loc44_.int2 = _loc33_;
                        }
                        _loc44_.set = _loc28_;
                     }
                  }
                  _loc38_ = _loc38_.next;
               }
               _loc26_ = _loc27_;
               _loc27_ = _loc27_.next;
            }
         }
         while(!callbacks.empty())
         {
            _loc44_ = callbacks.pop();
            if(_loc44_.listener.type == ZPP_Flags.id_ListenerType_BODY)
            {
               _loc48_ = _loc44_.listener.body;
               _loc48_.handler(_loc44_.wrapper_body());
            }
            else if(_loc44_.listener.type == ZPP_Flags.id_ListenerType_CONSTRAINT)
            {
               _loc49_ = _loc44_.listener.constraint;
               _loc49_.handler(_loc44_.wrapper_con());
            }
            else if(_loc44_.listener.type == ZPP_Flags.id_ListenerType_INTERACTION)
            {
               _loc43_ = _loc44_.listener.interaction;
               _loc43_.handleri(_loc44_.wrapper_int());
            }
            _loc50_ = _loc44_;
            _loc50_.int1 = _loc50_.int2 = null;
            _loc50_.body = null;
            _loc50_.constraint = null;
            _loc50_.listener = null;
            if(_loc50_.wrap_arbiters != null)
            {
               _loc50_.wrap_arbiters.zpp_inner.inner = null;
            }
            _loc50_.set = null;
            _loc50_.next = ZPP_Callback.zpp_pool;
            ZPP_Callback.zpp_pool = _loc50_;
         }
      }
      
      public function static_validation(param1:ZPP_Body) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_Shape;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as ZPP_Circle;
         var _loc5_:* = null as ZPP_Polygon;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Body;
         var _loc14_:* = null as ZPP_AABB;
         var _loc15_:* = null as ZPP_AABB;
         var _loc16_:* = null as ValidationResult;
         var _loc17_:* = null as ZNPNode_ZPP_Edge;
         var _loc18_:* = null as ZPP_Edge;
         if(param1.shapes.head != null)
         {
            if(param1.shapes.head == null)
            {
               Boot.lastError = new Error();
               throw "Error: Body bounds only makes sense if it contains shapes";
            }
            if(param1.zip_aabb)
            {
               param1.zip_aabb = false;
               param1.aabb.minx = 1.79e+308;
               param1.aabb.miny = 1.79e+308;
               param1.aabb.maxx = -1.79e+308;
               param1.aabb.maxy = -1.79e+308;
               _loc2_ = param1.shapes.head;
               while(_loc2_ != null)
               {
                  _loc3_ = _loc2_.elt;
                  if(_loc3_.zip_aabb)
                  {
                     if(_loc3_.body != null)
                     {
                        _loc3_.zip_aabb = false;
                        if(_loc3_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc4_ = _loc3_.circle;
                           if(_loc4_.zip_worldCOM)
                           {
                              if(_loc4_.body != null)
                              {
                                 _loc4_.zip_worldCOM = false;
                                 if(_loc4_.zip_localCOM)
                                 {
                                    _loc4_.zip_localCOM = false;
                                    if(_loc4_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                       _loc5_ = _loc4_.polygon;
                                       if(_loc5_.lverts.next == null)
                                       {
                                          Boot.lastError = new Error();
                                          throw "Error: An empty polygon has no meaningful localCOM";
                                       }
                                       if(_loc5_.lverts.next.next == null)
                                       {
                                          _loc5_.localCOMx = _loc5_.lverts.next.x;
                                          _loc5_.localCOMy = _loc5_.lverts.next.y;
                                          null;
                                       }
                                       else if(_loc5_.lverts.next.next.next == null)
                                       {
                                          _loc5_.localCOMx = _loc5_.lverts.next.x;
                                          _loc5_.localCOMy = _loc5_.lverts.next.y;
                                          _loc6_ = 1;
                                          _loc5_.localCOMx += _loc5_.lverts.next.next.x * _loc6_;
                                          _loc5_.localCOMy += _loc5_.lverts.next.next.y * _loc6_;
                                          _loc6_ = 0.5;
                                          _loc5_.localCOMx *= _loc6_;
                                          _loc5_.localCOMy *= _loc6_;
                                       }
                                       else
                                       {
                                          _loc5_.localCOMx = 0;
                                          _loc5_.localCOMy = 0;
                                          _loc6_ = 0;
                                          _loc7_ = _loc5_.lverts.next;
                                          _loc8_ = _loc7_;
                                          _loc7_ = _loc7_.next;
                                          _loc9_ = _loc7_;
                                          _loc7_ = _loc7_.next;
                                          while(_loc7_ != null)
                                          {
                                             _loc10_ = _loc7_;
                                             _loc6_ += _loc9_.x * (_loc10_.y - _loc8_.y);
                                             _loc11_ = _loc10_.y * _loc9_.x - _loc10_.x * _loc9_.y;
                                             _loc5_.localCOMx += (_loc9_.x + _loc10_.x) * _loc11_;
                                             _loc5_.localCOMy += (_loc9_.y + _loc10_.y) * _loc11_;
                                             _loc8_ = _loc9_;
                                             _loc9_ = _loc10_;
                                             _loc7_ = _loc7_.next;
                                          }
                                          _loc7_ = _loc5_.lverts.next;
                                          _loc10_ = _loc7_;
                                          _loc6_ += _loc9_.x * (_loc10_.y - _loc8_.y);
                                          _loc11_ = _loc10_.y * _loc9_.x - _loc10_.x * _loc9_.y;
                                          _loc5_.localCOMx += (_loc9_.x + _loc10_.x) * _loc11_;
                                          _loc5_.localCOMy += (_loc9_.y + _loc10_.y) * _loc11_;
                                          _loc8_ = _loc9_;
                                          _loc9_ = _loc10_;
                                          _loc7_ = _loc7_.next;
                                          _loc12_ = _loc7_;
                                          _loc6_ += _loc9_.x * (_loc12_.y - _loc8_.y);
                                          _loc11_ = _loc12_.y * _loc9_.x - _loc12_.x * _loc9_.y;
                                          _loc5_.localCOMx += (_loc9_.x + _loc12_.x) * _loc11_;
                                          _loc5_.localCOMy += (_loc9_.y + _loc12_.y) * _loc11_;
                                          _loc6_ = 1 / (3 * _loc6_);
                                          _loc11_ = _loc6_;
                                          _loc5_.localCOMx *= _loc11_;
                                          _loc5_.localCOMy *= _loc11_;
                                       }
                                    }
                                 }
                                 _loc13_ = _loc4_.body;
                                 if(_loc13_.zip_axis)
                                 {
                                    _loc13_.zip_axis = false;
                                    _loc13_.axisx = Math.sin(_loc13_.rot);
                                    _loc13_.axisy = Math.cos(_loc13_.rot);
                                    null;
                                 }
                                 _loc4_.worldCOMx = _loc4_.body.posx + (_loc4_.body.axisy * _loc4_.localCOMx - _loc4_.body.axisx * _loc4_.localCOMy);
                                 _loc4_.worldCOMy = _loc4_.body.posy + (_loc4_.localCOMx * _loc4_.body.axisx + _loc4_.localCOMy * _loc4_.body.axisy);
                              }
                           }
                           _loc6_ = _loc4_.radius;
                           _loc11_ = _loc4_.radius;
                           _loc4_.aabb.minx = _loc4_.worldCOMx - _loc6_;
                           _loc4_.aabb.miny = _loc4_.worldCOMy - _loc11_;
                           _loc4_.aabb.maxx = _loc4_.worldCOMx + _loc6_;
                           _loc4_.aabb.maxy = _loc4_.worldCOMy + _loc11_;
                        }
                        else
                        {
                           _loc5_ = _loc3_.polygon;
                           if(_loc5_.zip_gverts)
                           {
                              if(_loc5_.body != null)
                              {
                                 _loc5_.zip_gverts = false;
                                 _loc5_.validate_lverts();
                                 _loc13_ = _loc5_.body;
                                 if(_loc13_.zip_axis)
                                 {
                                    _loc13_.zip_axis = false;
                                    _loc13_.axisx = Math.sin(_loc13_.rot);
                                    _loc13_.axisy = Math.cos(_loc13_.rot);
                                    null;
                                 }
                                 _loc7_ = _loc5_.lverts.next;
                                 _loc8_ = _loc5_.gverts.next;
                                 while(_loc8_ != null)
                                 {
                                    _loc9_ = _loc8_;
                                    _loc10_ = _loc7_;
                                    _loc7_ = _loc7_.next;
                                    _loc9_.x = _loc5_.body.posx + (_loc5_.body.axisy * _loc10_.x - _loc5_.body.axisx * _loc10_.y);
                                    _loc9_.y = _loc5_.body.posy + (_loc10_.x * _loc5_.body.axisx + _loc10_.y * _loc5_.body.axisy);
                                    _loc8_ = _loc8_.next;
                                 }
                              }
                           }
                           if(_loc5_.lverts.next == null)
                           {
                              Boot.lastError = new Error();
                              throw "Error: An empty polygon has no meaningful bounds";
                           }
                           _loc7_ = _loc5_.gverts.next;
                           _loc5_.aabb.minx = _loc7_.x;
                           _loc5_.aabb.miny = _loc7_.y;
                           _loc5_.aabb.maxx = _loc7_.x;
                           _loc5_.aabb.maxy = _loc7_.y;
                           _loc8_ = _loc5_.gverts.next.next;
                           while(_loc8_ != null)
                           {
                              _loc9_ = _loc8_;
                              if(_loc9_.x < _loc5_.aabb.minx)
                              {
                                 _loc5_.aabb.minx = _loc9_.x;
                              }
                              if(_loc9_.x > _loc5_.aabb.maxx)
                              {
                                 _loc5_.aabb.maxx = _loc9_.x;
                              }
                              if(_loc9_.y < _loc5_.aabb.miny)
                              {
                                 _loc5_.aabb.miny = _loc9_.y;
                              }
                              if(_loc9_.y > _loc5_.aabb.maxy)
                              {
                                 _loc5_.aabb.maxy = _loc9_.y;
                              }
                              _loc8_ = _loc8_.next;
                           }
                        }
                     }
                  }
                  _loc14_ = param1.aabb;
                  _loc15_ = _loc3_.aabb;
                  if(_loc15_.minx < _loc14_.minx)
                  {
                     _loc14_.minx = _loc15_.minx;
                  }
                  if(_loc15_.maxx > _loc14_.maxx)
                  {
                     _loc14_.maxx = _loc15_.maxx;
                  }
                  if(_loc15_.miny < _loc14_.miny)
                  {
                     _loc14_.miny = _loc15_.miny;
                  }
                  if(_loc15_.maxy > _loc14_.maxy)
                  {
                     _loc14_.maxy = _loc15_.maxy;
                  }
                  _loc2_ = _loc2_.next;
               }
            }
         }
         param1.validate_mass();
         param1.validate_inertia();
         if(param1.velx != 0 || param1.vely != 0 || param1.angvel != 0)
         {
            Boot.lastError = new Error();
            throw "Error: Static body cannot have any real velocity, only kinematic or surface velocities";
         }
         _loc2_ = param1.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            if(_loc3_.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc5_ = _loc3_.polygon;
               if(_loc5_.zip_sanitation)
               {
                  _loc5_.zip_sanitation = false;
                  _loc5_.splice_collinear_real();
               }
               _loc16_ = _loc3_.polygon.valid();
               §§push(_loc16_);
               if(ZPP_Flags.ValidationResult_VALID == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.ValidationResult_VALID = new ValidationResult();
                  ZPP_Flags.§internal§ = false;
               }
               if(§§pop() != ZPP_Flags.ValidationResult_VALID)
               {
                  Boot.lastError = new Error();
                  throw "Error: Cannot simulate with an invalid Polygon : " + _loc3_.polygon.outer.toString() + " is invalid : " + _loc16_.toString();
               }
               _loc5_ = _loc3_.polygon;
               if(_loc5_.zip_gaxi)
               {
                  if(_loc5_.body != null)
                  {
                     _loc5_.zip_gaxi = false;
                     _loc5_.validate_laxi();
                     _loc13_ = _loc5_.body;
                     if(_loc13_.zip_axis)
                     {
                        _loc13_.zip_axis = false;
                        _loc13_.axisx = Math.sin(_loc13_.rot);
                        _loc13_.axisy = Math.cos(_loc13_.rot);
                        null;
                     }
                     if(_loc5_.zip_gverts)
                     {
                        if(_loc5_.body != null)
                        {
                           _loc5_.zip_gverts = false;
                           _loc5_.validate_lverts();
                           _loc13_ = _loc5_.body;
                           if(_loc13_.zip_axis)
                           {
                              _loc13_.zip_axis = false;
                              _loc13_.axisx = Math.sin(_loc13_.rot);
                              _loc13_.axisy = Math.cos(_loc13_.rot);
                              null;
                           }
                           _loc7_ = _loc5_.lverts.next;
                           _loc8_ = _loc5_.gverts.next;
                           while(_loc8_ != null)
                           {
                              _loc9_ = _loc8_;
                              _loc10_ = _loc7_;
                              _loc7_ = _loc7_.next;
                              _loc9_.x = _loc5_.body.posx + (_loc5_.body.axisy * _loc10_.x - _loc5_.body.axisx * _loc10_.y);
                              _loc9_.y = _loc5_.body.posy + (_loc10_.x * _loc5_.body.axisx + _loc10_.y * _loc5_.body.axisy);
                              _loc8_ = _loc8_.next;
                           }
                        }
                     }
                     _loc17_ = _loc5_.edges.head;
                     _loc7_ = _loc5_.gverts.next;
                     _loc8_ = _loc7_;
                     _loc7_ = _loc7_.next;
                     while(_loc7_ != null)
                     {
                        _loc9_ = _loc7_;
                        _loc18_ = _loc17_.elt;
                        _loc17_ = _loc17_.next;
                        _loc18_.gp0 = _loc8_;
                        _loc18_.gp1 = _loc9_;
                        _loc18_.gnormx = _loc5_.body.axisy * _loc18_.lnormx - _loc5_.body.axisx * _loc18_.lnormy;
                        _loc18_.gnormy = _loc18_.lnormx * _loc5_.body.axisx + _loc18_.lnormy * _loc5_.body.axisy;
                        _loc18_.gprojection = _loc5_.body.posx * _loc18_.gnormx + _loc5_.body.posy * _loc18_.gnormy + _loc18_.lprojection;
                        if(_loc18_.wrap_gnorm != null)
                        {
                           _loc18_.wrap_gnorm.zpp_inner.x = _loc18_.gnormx;
                           _loc18_.wrap_gnorm.zpp_inner.y = _loc18_.gnormy;
                        }
                        _loc18_.tp0 = _loc18_.gp0.y * _loc18_.gnormx - _loc18_.gp0.x * _loc18_.gnormy;
                        _loc18_.tp1 = _loc18_.gp1.y * _loc18_.gnormx - _loc18_.gp1.x * _loc18_.gnormy;
                        _loc8_ = _loc9_;
                        _loc7_ = _loc7_.next;
                     }
                     _loc9_ = _loc5_.gverts.next;
                     _loc18_ = _loc17_.elt;
                     _loc17_ = _loc17_.next;
                     _loc18_.gp0 = _loc8_;
                     _loc18_.gp1 = _loc9_;
                     _loc18_.gnormx = _loc5_.body.axisy * _loc18_.lnormx - _loc5_.body.axisx * _loc18_.lnormy;
                     _loc18_.gnormy = _loc18_.lnormx * _loc5_.body.axisx + _loc18_.lnormy * _loc5_.body.axisy;
                     _loc18_.gprojection = _loc5_.body.posx * _loc18_.gnormx + _loc5_.body.posy * _loc18_.gnormy + _loc18_.lprojection;
                     if(_loc18_.wrap_gnorm != null)
                     {
                        _loc18_.wrap_gnorm.zpp_inner.x = _loc18_.gnormx;
                        _loc18_.wrap_gnorm.zpp_inner.y = _loc18_.gnormy;
                     }
                     _loc18_.tp0 = _loc18_.gp0.y * _loc18_.gnormx - _loc18_.gp0.x * _loc18_.gnormy;
                     _loc18_.tp1 = _loc18_.gp1.y * _loc18_.gnormx - _loc18_.gp1.x * _loc18_.gnormy;
                  }
               }
            }
            _loc2_ = _loc2_.next;
         }
         param1.sweepFrozen = true;
      }
      
      public function sleepArbiters() : void
      {
         var _loc5_:* = null as ZPP_ColArbiter;
         var _loc6_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc7_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc8_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc12_:* = null as ZPP_FluidArbiter;
         var _loc13_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc14_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc15_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc19_:* = null as ZPP_SensorArbiter;
         var _loc20_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc21_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc22_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc1_:ZNPNode_ZPP_ColArbiter = null;
         var _loc2_:ZNPList_ZPP_ColArbiter = c_arbiters_true;
         var _loc3_:ZNPNode_ZPP_ColArbiter = _loc2_.head;
         var _loc4_:Boolean = c_arbiters_false != null;
         if(_loc4_ && _loc3_ == null)
         {
            _loc4_ = false;
            _loc3_ = c_arbiters_false.head;
            _loc2_ = c_arbiters_false;
            _loc1_ = null;
         }
         while(_loc3_ != null)
         {
            _loc5_ = _loc3_.elt;
            if(_loc5_.b1.component.sleeping && _loc5_.b2.component.sleeping)
            {
               _loc5_.sleep_stamp = stamp;
               _loc5_.sleeping = true;
               if(_loc1_ == null)
               {
                  _loc6_ = _loc2_.head;
                  _loc7_ = _loc6_.next;
                  _loc2_.head = _loc7_;
                  if(_loc2_.head == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               else
               {
                  _loc6_ = _loc1_.next;
                  _loc7_ = _loc6_.next;
                  _loc1_.next = _loc7_;
                  if(_loc7_ == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               _loc8_ = _loc6_;
               _loc8_.elt = null;
               _loc8_.next = ZNPNode_ZPP_ColArbiter.zpp_pool;
               ZNPNode_ZPP_ColArbiter.zpp_pool = _loc8_;
               _loc2_.modified = true;
               --_loc2_.length;
               _loc2_.pushmod = true;
               _loc3_ = _loc7_;
               if(_loc4_ && _loc3_ == null)
               {
                  _loc4_ = false;
                  _loc3_ = c_arbiters_false.head;
                  _loc2_ = c_arbiters_false;
                  _loc1_ = null;
               }
            }
            else
            {
               _loc1_ = _loc3_;
               _loc3_ = _loc3_.next;
               if(_loc4_ && _loc3_ == null)
               {
                  _loc4_ = false;
                  _loc3_ = c_arbiters_false.head;
                  _loc2_ = c_arbiters_false;
                  _loc1_ = null;
               }
            }
         }
         var _loc9_:ZNPNode_ZPP_FluidArbiter = null;
         var _loc10_:ZNPList_ZPP_FluidArbiter = f_arbiters;
         var _loc11_:ZNPNode_ZPP_FluidArbiter = _loc10_.head;
         _loc4_ = false;
         if(_loc4_ && _loc11_ == null)
         {
            _loc4_ = false;
            _loc11_ = null.begin();
            _loc10_ = null;
            _loc9_ = null;
         }
         while(_loc11_ != null)
         {
            _loc12_ = _loc11_.elt;
            if(_loc12_.b1.component.sleeping && _loc12_.b2.component.sleeping)
            {
               _loc12_.sleep_stamp = stamp;
               _loc12_.sleeping = true;
               if(_loc9_ == null)
               {
                  _loc13_ = _loc10_.head;
                  _loc14_ = _loc13_.next;
                  _loc10_.head = _loc14_;
                  if(_loc10_.head == null)
                  {
                     _loc10_.pushmod = true;
                  }
               }
               else
               {
                  _loc13_ = _loc9_.next;
                  _loc14_ = _loc13_.next;
                  _loc9_.next = _loc14_;
                  if(_loc14_ == null)
                  {
                     _loc10_.pushmod = true;
                  }
               }
               _loc15_ = _loc13_;
               _loc15_.elt = null;
               _loc15_.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
               ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc15_;
               _loc10_.modified = true;
               --_loc10_.length;
               _loc10_.pushmod = true;
               _loc11_ = _loc14_;
               if(_loc4_ && _loc11_ == null)
               {
                  _loc4_ = false;
                  _loc11_ = null.begin();
                  _loc10_ = null;
                  _loc9_ = null;
               }
            }
            else
            {
               _loc9_ = _loc11_;
               _loc11_ = _loc11_.next;
               if(_loc4_ && _loc11_ == null)
               {
                  _loc4_ = false;
                  _loc11_ = null.begin();
                  _loc10_ = null;
                  _loc9_ = null;
               }
            }
         }
         var _loc16_:ZNPNode_ZPP_SensorArbiter = null;
         var _loc17_:ZNPList_ZPP_SensorArbiter = s_arbiters;
         var _loc18_:ZNPNode_ZPP_SensorArbiter = _loc17_.head;
         _loc4_ = false;
         if(_loc4_ && _loc18_ == null)
         {
            _loc4_ = false;
            _loc18_ = null.begin();
            _loc17_ = null;
            _loc16_ = null;
         }
         while(_loc18_ != null)
         {
            _loc19_ = _loc18_.elt;
            if(_loc19_.b1.component.sleeping && _loc19_.b2.component.sleeping)
            {
               _loc19_.sleep_stamp = stamp;
               _loc19_.sleeping = true;
               if(_loc16_ == null)
               {
                  _loc20_ = _loc17_.head;
                  _loc21_ = _loc20_.next;
                  _loc17_.head = _loc21_;
                  if(_loc17_.head == null)
                  {
                     _loc17_.pushmod = true;
                  }
               }
               else
               {
                  _loc20_ = _loc16_.next;
                  _loc21_ = _loc20_.next;
                  _loc16_.next = _loc21_;
                  if(_loc21_ == null)
                  {
                     _loc17_.pushmod = true;
                  }
               }
               _loc22_ = _loc20_;
               _loc22_.elt = null;
               _loc22_.next = ZNPNode_ZPP_SensorArbiter.zpp_pool;
               ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc22_;
               _loc17_.modified = true;
               --_loc17_.length;
               _loc17_.pushmod = true;
               _loc18_ = _loc21_;
               if(_loc4_ && _loc18_ == null)
               {
                  _loc4_ = false;
                  _loc18_ = null.begin();
                  _loc17_ = null;
                  _loc16_ = null;
               }
            }
            else
            {
               _loc16_ = _loc18_;
               _loc18_ = _loc18_.next;
               if(_loc4_ && _loc18_ == null)
               {
                  _loc4_ = false;
                  _loc18_ = null.begin();
                  _loc17_ = null;
                  _loc16_ = null;
               }
            }
         }
      }
      
      public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
      {
         return bphase.shapesUnderPoint(param1,param2,param3,param4);
      }
      
      public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:ShapeList) : ShapeList
      {
         return bphase.shapesInShape(param1,param2,param3,param4);
      }
      
      public function shapesInCircle(param1:Vec2, param2:Number, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
      {
         §§push(bphase);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc6_:ZPP_Vec2 = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.x);
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
         return §§pop().shapesInCircle(§§pop(),param1.zpp_inner.y,param2,param3,param4,param5);
      }
      
      public function shapesInAABB(param1:AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:ShapeList) : ShapeList
      {
         return bphase.shapesInAABB(param1.zpp_inner,param2,param3,param4,param5);
      }
      
      public function removed_shape(param1:ZPP_Shape, param2:Boolean = false) : void
      {
         var _loc7_:* = null as ZPP_Arbiter;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as ZNPNode_ZPP_Interactor;
         var _loc10_:* = null as ZPP_Interactor;
         var _loc11_:* = null as ZNPNode_ZPP_Interactor;
         var _loc12_:* = null as ZPP_Interactor;
         var _loc13_:* = null as ZPP_CbSet;
         var _loc14_:* = null as ZPP_CbSet;
         var _loc15_:* = null as ZPP_CbSetPair;
         var _loc16_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc17_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc18_:* = null as ZPP_CbSetPair;
         var _loc19_:* = null as ZPP_CallbackSet;
         var _loc20_:int = 0;
         var _loc21_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc22_:* = null as ZPP_InteractionListener;
         var _loc23_:* = null as ZPP_Callback;
         var _loc24_:* = null as ZPP_Interactor;
         var _loc25_:* = null as ZPP_Interactor;
         var _loc26_:* = null as ZPP_OptionType;
         var _loc27_:* = null as ZNPList_ZPP_CbType;
         var _loc28_:* = null as ZPP_Body;
         var _loc29_:* = null as ZNPList_ZPP_Arbiter;
         var _loc30_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc31_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc32_:Boolean = false;
         var _loc33_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc34_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc35_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc3_:ZPP_Space = this;
         var _loc4_:ZPP_Body = param1.body;
         if(!param2)
         {
            _loc4_.wake();
         }
         var _loc5_:ZNPNode_ZPP_Arbiter = null;
         var _loc6_:ZNPNode_ZPP_Arbiter = _loc4_.arbiters.head;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.elt;
            _loc8_ = _loc7_.ws1 == param1 || _loc7_.ws2 == param1;
            if(_loc8_)
            {
               if(_loc7_.present != 0)
               {
                  MRCA_chains(_loc7_.ws1,_loc7_.ws2);
                  _loc9_ = mrca1.head;
                  while(_loc9_ != null)
                  {
                     _loc10_ = _loc9_.elt;
                     _loc11_ = mrca2.head;
                     while(_loc11_ != null)
                     {
                        _loc12_ = _loc11_.elt;
                        _loc13_ = _loc10_.cbSet;
                        _loc14_ = _loc12_.cbSet;
                        _loc13_.validate();
                        _loc14_.validate();
                        _loc15_ = null;
                        _loc16_ = _loc13_.cbpairs.length < _loc14_.cbpairs.length ? _loc13_.cbpairs : _loc14_.cbpairs;
                        _loc17_ = _loc16_.head;
                        while(_loc17_ != null)
                        {
                           _loc18_ = _loc17_.elt;
                           if(_loc18_.a == _loc13_ && _loc18_.b == _loc14_ || _loc18_.a == _loc14_ && _loc18_.b == _loc13_)
                           {
                              _loc15_ = _loc18_;
                              break;
                           }
                           _loc17_ = _loc17_.next;
                        }
                        if(_loc15_ == null)
                        {
                           if(ZPP_CbSetPair.zpp_pool == null)
                           {
                              _loc18_ = new ZPP_CbSetPair();
                           }
                           else
                           {
                              _loc18_ = ZPP_CbSetPair.zpp_pool;
                              ZPP_CbSetPair.zpp_pool = _loc18_.next;
                              _loc18_.next = null;
                           }
                           _loc18_.zip_listeners = true;
                           if(ZPP_CbSet.setlt(_loc13_,_loc14_))
                           {
                              _loc18_.a = _loc13_;
                              _loc18_.b = _loc14_;
                           }
                           else
                           {
                              _loc18_.a = _loc14_;
                              _loc18_.b = _loc13_;
                           }
                           _loc15_ = _loc18_;
                           _loc13_.cbpairs.add(_loc15_);
                           if(_loc14_ != _loc13_)
                           {
                              _loc14_.cbpairs.add(_loc15_);
                           }
                        }
                        if(_loc15_.zip_listeners)
                        {
                           _loc15_.zip_listeners = false;
                           _loc15_.__validate();
                        }
                        if(_loc15_.listeners.head == null)
                        {
                           _loc11_ = _loc11_.next;
                        }
                        else
                        {
                           _loc19_ = ZPP_Interactor.get(_loc10_,_loc12_);
                           _loc19_.remove_arb(_loc7_);
                           --_loc7_.present;
                           _loc20_ = ZPP_Flags.id_CbEvent_END;
                           _loc15_ = null;
                           _loc16_ = _loc13_.cbpairs.length < _loc14_.cbpairs.length ? _loc13_.cbpairs : _loc14_.cbpairs;
                           _loc17_ = _loc16_.head;
                           while(_loc17_ != null)
                           {
                              _loc18_ = _loc17_.elt;
                              if(_loc18_.a == _loc13_ && _loc18_.b == _loc14_ || _loc18_.a == _loc14_ && _loc18_.b == _loc13_)
                              {
                                 _loc15_ = _loc18_;
                                 break;
                              }
                              _loc17_ = _loc17_.next;
                           }
                           if(_loc15_ == null)
                           {
                              if(ZPP_CbSetPair.zpp_pool == null)
                              {
                                 _loc18_ = new ZPP_CbSetPair();
                              }
                              else
                              {
                                 _loc18_ = ZPP_CbSetPair.zpp_pool;
                                 ZPP_CbSetPair.zpp_pool = _loc18_.next;
                                 _loc18_.next = null;
                              }
                              _loc18_.zip_listeners = true;
                              if(ZPP_CbSet.setlt(_loc13_,_loc14_))
                              {
                                 _loc18_.a = _loc13_;
                                 _loc18_.b = _loc14_;
                              }
                              else
                              {
                                 _loc18_.a = _loc14_;
                                 _loc18_.b = _loc13_;
                              }
                              _loc15_ = _loc18_;
                              _loc13_.cbpairs.add(_loc15_);
                              if(_loc14_ != _loc13_)
                              {
                                 _loc14_.cbpairs.add(_loc15_);
                              }
                           }
                           if(_loc15_.zip_listeners)
                           {
                              _loc15_.zip_listeners = false;
                              _loc15_.__validate();
                           }
                           _loc21_ = _loc15_.listeners.head;
                           while(_loc21_ != null)
                           {
                              _loc22_ = _loc21_.elt;
                              if(_loc22_.event == _loc20_)
                              {
                                 if((_loc22_.itype & _loc7_.type) != 0 && _loc19_.empty_arb(_loc22_.itype))
                                 {
                                    _loc23_ = _loc3_.push_callback(_loc22_);
                                    _loc23_.event = ZPP_Flags.id_CbEvent_END;
                                    _loc24_ = _loc19_.int1;
                                    _loc25_ = _loc19_.int2;
                                    _loc26_ = _loc22_.options1;
                                    _loc27_ = _loc24_.cbTypes;
                                    if(_loc26_.nonemptyintersection(_loc27_,_loc26_.includes) && !_loc26_.nonemptyintersection(_loc27_,_loc26_.excludes) && (_loc26_.nonemptyintersection(_loc27_,_loc26_.includes) && !_loc26_.nonemptyintersection(_loc27_,_loc26_.excludes)))
                                    {
                                       _loc23_.int1 = _loc24_;
                                       _loc23_.int2 = _loc25_;
                                    }
                                    else
                                    {
                                       _loc23_.int1 = _loc25_;
                                       _loc23_.int2 = _loc24_;
                                    }
                                    _loc23_.set = _loc19_;
                                 }
                              }
                              _loc21_ = _loc21_.next;
                           }
                           if(_loc19_.arbiters.head == null)
                           {
                              remove_callbackset(_loc19_);
                           }
                           _loc11_ = _loc11_.next;
                        }
                     }
                     _loc9_ = _loc9_.next;
                  }
               }
               if(_loc7_.b1 != _loc4_ && _loc7_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  _loc28_ = _loc7_.b1;
                  if(!_loc28_.world)
                  {
                     _loc28_.component.waket = stamp + (midstep ? 0 : 1);
                     if(_loc28_.component.sleeping)
                     {
                        really_wake(_loc28_,false);
                     }
                  }
               }
               if(_loc7_.b2 != _loc4_ && _loc7_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  _loc28_ = _loc7_.b2;
                  if(!_loc28_.world)
                  {
                     _loc28_.component.waket = stamp + (midstep ? 0 : 1);
                     if(_loc28_.component.sleeping)
                     {
                        really_wake(_loc28_,false);
                     }
                  }
               }
               _loc7_.cleared = true;
               if(_loc4_ == null || _loc7_.b2 == _loc4_)
               {
                  _loc29_ = _loc7_.b1.arbiters;
                  _loc30_ = null;
                  _loc31_ = _loc29_.head;
                  _loc32_ = false;
                  while(_loc31_ != null)
                  {
                     if(_loc31_.elt == _loc7_)
                     {
                        if(_loc30_ == null)
                        {
                           _loc33_ = _loc29_.head;
                           _loc34_ = _loc33_.next;
                           _loc29_.head = _loc34_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc33_ = _loc30_.next;
                           _loc34_ = _loc33_.next;
                           _loc30_.next = _loc34_;
                           if(_loc34_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc35_ = _loc33_;
                        _loc35_.elt = null;
                        _loc35_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc35_;
                        _loc29_.modified = true;
                        --_loc29_.length;
                        _loc29_.pushmod = true;
                        _loc34_;
                        _loc32_ = true;
                        break;
                     }
                     _loc30_ = _loc31_;
                     _loc31_ = _loc31_.next;
                  }
                  _loc32_;
               }
               if(_loc4_ == null || _loc7_.b1 == _loc4_)
               {
                  _loc29_ = _loc7_.b2.arbiters;
                  _loc30_ = null;
                  _loc31_ = _loc29_.head;
                  _loc32_ = false;
                  while(_loc31_ != null)
                  {
                     if(_loc31_.elt == _loc7_)
                     {
                        if(_loc30_ == null)
                        {
                           _loc33_ = _loc29_.head;
                           _loc34_ = _loc33_.next;
                           _loc29_.head = _loc34_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc33_ = _loc30_.next;
                           _loc34_ = _loc33_.next;
                           _loc30_.next = _loc34_;
                           if(_loc34_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc35_ = _loc33_;
                        _loc35_.elt = null;
                        _loc35_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc35_;
                        _loc29_.modified = true;
                        --_loc29_.length;
                        _loc29_.pushmod = true;
                        _loc34_;
                        _loc32_ = true;
                        break;
                     }
                     _loc30_ = _loc31_;
                     _loc31_ = _loc31_.next;
                  }
                  _loc32_;
               }
               if(_loc7_.pair != null)
               {
                  _loc7_.pair.arb = null;
                  _loc7_.pair = null;
               }
               _loc7_.active = false;
               f_arbiters.modified = true;
               _loc6_ = _loc4_.arbiters.erase(_loc5_);
            }
            else
            {
               _loc5_ = _loc6_;
               _loc6_ = _loc6_.next;
            }
         }
         bphase.remove(param1);
         param1.removedFromSpace();
      }
      
      public function remove_callbackset(param1:ZPP_CallbackSet) : void
      {
         var _loc6_:* = null as ZNPNode_ZPP_CallbackSet;
         var _loc7_:* = null as ZNPNode_ZPP_CallbackSet;
         var _loc8_:* = null as ZNPNode_ZPP_CallbackSet;
         param1.lazydel = true;
         var _loc2_:ZNPList_ZPP_CallbackSet = param1.int1.cbsets;
         var _loc3_:ZNPNode_ZPP_CallbackSet = null;
         var _loc4_:ZNPNode_ZPP_CallbackSet = _loc2_.head;
         var _loc5_:Boolean = false;
         while(_loc4_ != null)
         {
            if(_loc4_.elt == param1)
            {
               if(_loc3_ == null)
               {
                  _loc6_ = _loc2_.head;
                  _loc7_ = _loc6_.next;
                  _loc2_.head = _loc7_;
                  if(_loc2_.head == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               else
               {
                  _loc6_ = _loc3_.next;
                  _loc7_ = _loc6_.next;
                  _loc3_.next = _loc7_;
                  if(_loc7_ == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               _loc8_ = _loc6_;
               _loc8_.elt = null;
               _loc8_.next = ZNPNode_ZPP_CallbackSet.zpp_pool;
               ZNPNode_ZPP_CallbackSet.zpp_pool = _loc8_;
               _loc2_.modified = true;
               --_loc2_.length;
               _loc2_.pushmod = true;
               _loc7_;
               _loc5_ = true;
               break;
            }
            _loc3_ = _loc4_;
            _loc4_ = _loc4_.next;
         }
         _loc5_;
         _loc2_ = param1.int2.cbsets;
         _loc3_ = null;
         _loc4_ = _loc2_.head;
         _loc5_ = false;
         while(_loc4_ != null)
         {
            if(_loc4_.elt == param1)
            {
               if(_loc3_ == null)
               {
                  _loc6_ = _loc2_.head;
                  _loc7_ = _loc6_.next;
                  _loc2_.head = _loc7_;
                  if(_loc2_.head == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               else
               {
                  _loc6_ = _loc3_.next;
                  _loc7_ = _loc6_.next;
                  _loc3_.next = _loc7_;
                  if(_loc7_ == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               _loc8_ = _loc6_;
               _loc8_.elt = null;
               _loc8_.next = ZNPNode_ZPP_CallbackSet.zpp_pool;
               ZNPNode_ZPP_CallbackSet.zpp_pool = _loc8_;
               _loc2_.modified = true;
               --_loc2_.length;
               _loc2_.pushmod = true;
               _loc7_;
               _loc5_ = true;
               break;
            }
            _loc3_ = _loc4_;
            _loc4_ = _loc4_.next;
         }
         _loc5_;
      }
      
      public function remListener(param1:ZPP_Listener) : void
      {
         if(param1.interaction != null)
         {
            null;
         }
         param1.removedFromSpace();
         param1.space = null;
      }
      
      public function remConstraint(param1:ZPP_Constraint) : void
      {
         if(param1.active)
         {
            wake_constraint(param1,true);
            live_constraints.remove(param1);
         }
         param1.removedFromSpace();
         param1.space = null;
      }
      
      public function remCompound(param1:ZPP_Compound) : void
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc5_:* = null as ZPP_Constraint;
         var _loc7_:* = null as ZPP_Compound;
         var _loc2_:ZNPNode_ZPP_Body = param1.bodies.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            remBody(_loc3_);
            _loc2_ = _loc2_.next;
         }
         var _loc4_:ZNPNode_ZPP_Constraint = param1.constraints.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            remConstraint(_loc5_);
            _loc4_ = _loc4_.next;
         }
         var _loc6_:ZNPNode_ZPP_Compound = param1.compounds.head;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.elt;
            remCompound(_loc7_);
            _loc6_ = _loc6_.next;
         }
         param1.removedFromSpace();
         param1.space = null;
      }
      
      public function remBody(param1:ZPP_Body, param2:int = -1) : void
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc5_:* = null as ZPP_Shape;
         if(param1.type == ZPP_Flags.id_BodyType_STATIC)
         {
            _loc3_ = param1;
            if(!_loc3_.world)
            {
               _loc3_.component.waket = stamp + (midstep ? 0 : 1);
               if(_loc3_.component.sleeping)
               {
                  really_wake(_loc3_,true);
               }
            }
            staticsleep.remove(param1);
         }
         else if(param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            _loc3_ = param1;
            if(!_loc3_.world)
            {
               _loc3_.component.waket = stamp + (midstep ? 0 : 1);
               if(_loc3_.component.sleeping)
               {
                  really_wake(_loc3_,true);
               }
            }
            live.remove(param1);
         }
         else
         {
            if(param2 != ZPP_Flags.id_BodyType_KINEMATIC)
            {
               kinematics.remove(param1);
            }
            _loc3_ = param1;
            if(!_loc3_.world)
            {
               _loc3_.component.waket = stamp + (midstep ? 0 : 1);
               if(_loc3_.component.sleeping)
               {
                  really_wake(_loc3_,true);
               }
            }
            staticsleep.remove(param1);
         }
         var _loc4_:ZNPNode_ZPP_Shape = param1.shapes.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            removed_shape(_loc5_,true);
            _loc4_ = _loc4_.next;
         }
         param1.removedFromSpace();
         param1.space = null;
      }
      
      public function really_wake(param1:ZPP_Body, param2:Boolean = false) : void
      {
         var _loc3_:* = null as ZNPList_ZPP_Body;
         var _loc4_:* = null as ZNPNode_ZPP_Body;
         var _loc5_:* = null as ZNPNode_ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Constraint;
         var _loc7_:* = null as ZPP_Constraint;
         var _loc8_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc9_:* = null as ZPP_Arbiter;
         var _loc10_:* = null as ZPP_ColArbiter;
         var _loc11_:* = null as ZNPList_ZPP_ColArbiter;
         var _loc12_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc13_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc14_:* = null as ZNPList_ZPP_FluidArbiter;
         var _loc15_:* = null as ZPP_FluidArbiter;
         var _loc16_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc17_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc18_:* = null as ZNPList_ZPP_SensorArbiter;
         var _loc19_:* = null as ZPP_SensorArbiter;
         var _loc20_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc21_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc22_:* = null as ZPP_Body;
         var _loc23_:* = null as ZNPNode_ZPP_Shape;
         var _loc24_:* = null as ZPP_Shape;
         if(param1.component.island == null)
         {
            param1.component.sleeping = false;
            if(param1.type == ZPP_Flags.id_BodyType_KINEMATIC || param1.type == ZPP_Flags.id_BodyType_STATIC)
            {
               _loc3_ = staticsleep;
               if(ZNPNode_ZPP_Body.zpp_pool == null)
               {
                  _loc5_ = new ZNPNode_ZPP_Body();
               }
               else
               {
                  _loc5_ = ZNPNode_ZPP_Body.zpp_pool;
                  ZNPNode_ZPP_Body.zpp_pool = _loc5_.next;
                  _loc5_.next = null;
               }
               null;
               _loc5_.elt = param1;
               _loc4_ = _loc5_;
               _loc4_.next = _loc3_.head;
               _loc3_.head = _loc4_;
               _loc3_.modified = true;
               ++_loc3_.length;
               param1;
            }
            else
            {
               _loc3_ = live;
               if(ZNPNode_ZPP_Body.zpp_pool == null)
               {
                  _loc5_ = new ZNPNode_ZPP_Body();
               }
               else
               {
                  _loc5_ = ZNPNode_ZPP_Body.zpp_pool;
                  ZNPNode_ZPP_Body.zpp_pool = _loc5_.next;
                  _loc5_.next = null;
               }
               null;
               _loc5_.elt = param1;
               _loc4_ = _loc5_;
               _loc4_.next = _loc3_.head;
               _loc3_.head = _loc4_;
               _loc3_.modified = true;
               ++_loc3_.length;
               param1;
            }
            _loc6_ = param1.constraints.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               if(_loc7_.space == this)
               {
                  wake_constraint(_loc7_);
               }
               _loc6_ = _loc6_.next;
            }
            _loc8_ = param1.arbiters.head;
            while(_loc8_ != null)
            {
               _loc9_ = _loc8_.elt;
               if(_loc9_.sleeping)
               {
                  _loc9_.sleeping = false;
                  _loc9_.up_stamp += stamp + (midstep ? 0 : 1) - _loc9_.sleep_stamp;
                  if(_loc9_.type == ZPP_Arbiter.COL)
                  {
                     _loc10_ = _loc9_.colarb;
                     if(_loc10_.stat)
                     {
                        _loc11_ = c_arbiters_true;
                        if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                        {
                           _loc13_ = new ZNPNode_ZPP_ColArbiter();
                        }
                        else
                        {
                           _loc13_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                           ZNPNode_ZPP_ColArbiter.zpp_pool = _loc13_.next;
                           _loc13_.next = null;
                        }
                        null;
                        _loc13_.elt = _loc10_;
                        _loc12_ = _loc13_;
                        _loc12_.next = _loc11_.head;
                        _loc11_.head = _loc12_;
                        _loc11_.modified = true;
                        ++_loc11_.length;
                        _loc10_;
                     }
                     else
                     {
                        _loc11_ = c_arbiters_false;
                        if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                        {
                           _loc13_ = new ZNPNode_ZPP_ColArbiter();
                        }
                        else
                        {
                           _loc13_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                           ZNPNode_ZPP_ColArbiter.zpp_pool = _loc13_.next;
                           _loc13_.next = null;
                        }
                        null;
                        _loc13_.elt = _loc10_;
                        _loc12_ = _loc13_;
                        _loc12_.next = _loc11_.head;
                        _loc11_.head = _loc12_;
                        _loc11_.modified = true;
                        ++_loc11_.length;
                        _loc10_;
                     }
                  }
                  else if(_loc9_.type == ZPP_Arbiter.FLUID)
                  {
                     _loc14_ = f_arbiters;
                     _loc15_ = _loc9_.fluidarb;
                     if(ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                     {
                        _loc17_ = new ZNPNode_ZPP_FluidArbiter();
                     }
                     else
                     {
                        _loc17_ = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                        ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc17_.next;
                        _loc17_.next = null;
                     }
                     null;
                     _loc17_.elt = _loc15_;
                     _loc16_ = _loc17_;
                     _loc16_.next = _loc14_.head;
                     _loc14_.head = _loc16_;
                     _loc14_.modified = true;
                     ++_loc14_.length;
                     _loc15_;
                  }
                  else
                  {
                     _loc18_ = s_arbiters;
                     _loc19_ = _loc9_.sensorarb;
                     if(ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                     {
                        _loc21_ = new ZNPNode_ZPP_SensorArbiter();
                     }
                     else
                     {
                        _loc21_ = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                        ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc21_.next;
                        _loc21_.next = null;
                     }
                     null;
                     _loc21_.elt = _loc19_;
                     _loc20_ = _loc21_;
                     _loc20_.next = _loc18_.head;
                     _loc18_.head = _loc20_;
                     _loc18_.modified = true;
                     ++_loc18_.length;
                     _loc19_;
                  }
               }
               if(_loc9_.type != ZPP_Arbiter.SENSOR && !_loc9_.cleared && _loc9_.up_stamp >= stamp && (_loc9_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
               {
                  if(_loc9_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc9_.b1.component.sleeping)
                  {
                     _loc22_ = _loc9_.b1;
                     if(!_loc22_.world)
                     {
                        _loc22_.component.waket = stamp + (midstep ? 0 : 1);
                        if(_loc22_.component.sleeping)
                        {
                           really_wake(_loc22_,false);
                        }
                     }
                  }
                  if(_loc9_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc9_.b2.component.sleeping)
                  {
                     _loc22_ = _loc9_.b2;
                     if(!_loc22_.world)
                     {
                        _loc22_.component.waket = stamp + (midstep ? 0 : 1);
                        if(_loc22_.component.sleeping)
                        {
                           really_wake(_loc22_,false);
                        }
                     }
                  }
               }
               _loc8_ = _loc8_.next;
            }
            if(!param2 && param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
               bodyCbWake(param1);
            }
            if(!param2 && !bphase.is_sweep && param1.type != ZPP_Flags.id_BodyType_STATIC)
            {
               _loc23_ = param1.shapes.head;
               while(_loc23_ != null)
               {
                  _loc24_ = _loc23_.elt;
                  if(_loc24_.node != null)
                  {
                     bphase.sync(_loc24_);
                  }
                  _loc23_ = _loc23_.next;
               }
            }
         }
         else
         {
            wakeIsland(param1.component.island);
         }
      }
      
      public function rayMultiCast(param1:Ray, param2:Boolean, param3:InteractionFilter, param4:RayResultList) : RayResultList
      {
         return bphase.rayMultiCast(param1.zpp_inner,param2,param3 == null ? null : param3.zpp_inner,param4);
      }
      
      public function rayCast(param1:Ray, param2:Boolean, param3:InteractionFilter) : RayResult
      {
         return bphase.rayCast(param1.zpp_inner,param2,param3 == null ? null : param3.zpp_inner);
      }
      
      public function push_callback(param1:ZPP_Listener) : ZPP_Callback
      {
         var _loc2_:* = null as ZPP_Callback;
         if(ZPP_Callback.zpp_pool == null)
         {
            _loc2_ = new ZPP_Callback();
         }
         else
         {
            _loc2_ = ZPP_Callback.zpp_pool;
            ZPP_Callback.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         null;
         callbacks.push(_loc2_);
         _loc2_.listener = param1;
         return _loc2_;
      }
      
      public function presteparb(param1:ZPP_Arbiter, param2:Number, param3:Object = undefined) : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZPP_Shape;
         var _loc8_:* = null as ZPP_Shape;
         var _loc9_:* = null as ZNPList_ZPP_Interactor;
         var _loc10_:* = null as ZNPNode_ZPP_Interactor;
         var _loc11_:* = null as ZNPNode_ZPP_Interactor;
         var _loc12_:* = null as ZPP_Interactor;
         var _loc13_:* = null as ZPP_Compound;
         var _loc14_:* = null as ZPP_Compound;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:* = null as ZPP_Interactor;
         var _loc18_:* = null as ZPP_CbSet;
         var _loc19_:* = null as ZPP_CbSet;
         var _loc20_:* = null as ZPP_CbSetPair;
         var _loc21_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc22_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc23_:* = null as ZPP_CbSetPair;
         var _loc24_:* = null as ZPP_CallbackSet;
         var _loc25_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc26_:* = null as ZPP_InteractionListener;
         var _loc27_:* = null as ZPP_Callback;
         var _loc28_:* = null as ZPP_Interactor;
         var _loc29_:* = null as ZPP_Interactor;
         var _loc30_:* = null as ZPP_OptionType;
         var _loc31_:* = null as ZNPList_ZPP_CbType;
         var _loc32_:Boolean = false;
         var _loc33_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc34_:* = null as ZPP_Arbiter;
         var _loc35_:* = null as ZNPList_ZPP_Arbiter;
         var _loc36_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc37_:* = null as ZPP_SensorArbiter;
         var _loc38_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc39_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc40_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc41_:* = null as ZPP_Body;
         var _loc42_:* = null as ZPP_SensorArbiter;
         var _loc43_:* = null as ZPP_FluidArbiter;
         var _loc44_:* = null as ZPP_FluidArbiter;
         var _loc45_:* = null as ZPP_ColArbiter;
         var _loc46_:* = null as ZPP_Contact;
         var _loc47_:* = null as ZPP_Contact;
         var _loc48_:* = null as ZPP_Contact;
         var _loc49_:* = null as ZPP_IContact;
         var _loc50_:* = null as ZPP_IContact;
         var _loc51_:* = null as ZPP_ColArbiter;
         var _loc52_:* = null as ZPP_Edge;
         var _loc53_:Number = NaN;
         var _loc54_:Number = NaN;
         var _loc55_:Number = NaN;
         var _loc56_:* = null as ZPP_Contact;
         var _loc57_:* = null as ZPP_Contact;
         var _loc58_:* = null as ZPP_Contact;
         var _loc59_:* = null as ZPP_IContact;
         var _loc60_:* = null as ZPP_IContact;
         var _loc61_:* = null as ZPP_IContact;
         var _loc62_:Boolean = false;
         var _loc63_:Number = NaN;
         var _loc64_:Number = NaN;
         var _loc65_:Number = NaN;
         var _loc66_:Number = NaN;
         var _loc67_:Number = NaN;
         var _loc68_:Number = NaN;
         var _loc69_:Number = NaN;
         var _loc70_:Number = NaN;
         var _loc71_:Number = NaN;
         var _loc72_:Number = NaN;
         var _loc73_:* = null as ZPP_Polygon;
         var _loc74_:Number = NaN;
         var _loc75_:* = null as ZNPNode_ZPP_Edge;
         var _loc76_:Number = NaN;
         var _loc77_:Number = NaN;
         var _loc78_:Number = NaN;
         var _loc79_:Number = NaN;
         var _loc80_:Number = NaN;
         if(param3 == null)
         {
            param3 = false;
         }
         var _loc4_:ZPP_Space = this;
         if(!param1.cleared && (param1.b1.component.sleeping && param1.b2.component.sleeping))
         {
            param1.sleep_stamp = stamp;
            param1.sleeping = true;
            return true;
         }
         if(!param1.cleared || param1.present != 0 || param1.intchange)
         {
            _loc5_ = !param3 && param1.up_stamp == stamp - 1 && !param1.cleared && !param1.intchange;
            _loc6_ = param1.fresh && !param1.cleared && !param1.intchange;
            if(_loc5_)
            {
               param1.endGenerated = stamp;
            }
            if(_loc6_ || _loc5_ || param1.cleared || param1.intchange)
            {
               _loc7_ = param1.ws1;
               _loc8_ = param1.ws2;
               _loc9_ = mrca1;
               while(_loc9_.head != null)
               {
                  _loc10_ = _loc9_.head;
                  _loc9_.head = _loc10_.next;
                  _loc11_ = _loc10_;
                  _loc11_.elt = null;
                  _loc11_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                  ZNPNode_ZPP_Interactor.zpp_pool = _loc11_;
                  if(_loc9_.head == null)
                  {
                     _loc9_.pushmod = true;
                  }
                  _loc9_.modified = true;
                  --_loc9_.length;
               }
               _loc9_.pushmod = true;
               _loc9_ = mrca2;
               while(_loc9_.head != null)
               {
                  _loc10_ = _loc9_.head;
                  _loc9_.head = _loc10_.next;
                  _loc11_ = _loc10_;
                  _loc11_.elt = null;
                  _loc11_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                  ZNPNode_ZPP_Interactor.zpp_pool = _loc11_;
                  if(_loc9_.head == null)
                  {
                     _loc9_.pushmod = true;
                  }
                  _loc9_.modified = true;
                  --_loc9_.length;
               }
               _loc9_.pushmod = true;
               if(_loc7_.cbSet != null)
               {
                  _loc9_ = mrca1;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc11_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc11_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc11_.next;
                     _loc11_.next = null;
                  }
                  null;
                  _loc11_.elt = _loc7_;
                  _loc10_ = _loc11_;
                  _loc10_.next = _loc9_.head;
                  _loc9_.head = _loc10_;
                  _loc9_.modified = true;
                  ++_loc9_.length;
                  _loc7_;
               }
               if(_loc7_.body.cbSet != null)
               {
                  _loc9_ = mrca1;
                  _loc12_ = _loc7_.body;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc11_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc11_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc11_.next;
                     _loc11_.next = null;
                  }
                  null;
                  _loc11_.elt = _loc12_;
                  _loc10_ = _loc11_;
                  _loc10_.next = _loc9_.head;
                  _loc9_.head = _loc10_;
                  _loc9_.modified = true;
                  ++_loc9_.length;
                  _loc12_;
               }
               if(_loc8_.cbSet != null)
               {
                  _loc9_ = mrca2;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc11_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc11_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc11_.next;
                     _loc11_.next = null;
                  }
                  null;
                  _loc11_.elt = _loc8_;
                  _loc10_ = _loc11_;
                  _loc10_.next = _loc9_.head;
                  _loc9_.head = _loc10_;
                  _loc9_.modified = true;
                  ++_loc9_.length;
                  _loc8_;
               }
               if(_loc8_.body.cbSet != null)
               {
                  _loc9_ = mrca2;
                  _loc12_ = _loc8_.body;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc11_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc11_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc11_.next;
                     _loc11_.next = null;
                  }
                  null;
                  _loc11_.elt = _loc12_;
                  _loc10_ = _loc11_;
                  _loc10_.next = _loc9_.head;
                  _loc9_.head = _loc10_;
                  _loc9_.modified = true;
                  ++_loc9_.length;
                  _loc12_;
               }
               _loc13_ = _loc7_.body.compound;
               _loc14_ = _loc8_.body.compound;
               while(_loc13_ != _loc14_)
               {
                  _loc15_ = _loc13_ == null ? 0 : _loc13_.depth;
                  _loc16_ = _loc14_ == null ? 0 : _loc14_.depth;
                  if(_loc15_ < _loc16_)
                  {
                     if(_loc14_.cbSet != null)
                     {
                        _loc9_ = mrca2;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc11_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc11_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc11_.next;
                           _loc11_.next = null;
                        }
                        null;
                        _loc11_.elt = _loc14_;
                        _loc10_ = _loc11_;
                        _loc10_.next = _loc9_.head;
                        _loc9_.head = _loc10_;
                        _loc9_.modified = true;
                        ++_loc9_.length;
                        _loc14_;
                     }
                     _loc14_ = _loc14_.compound;
                  }
                  else
                  {
                     if(_loc13_.cbSet != null)
                     {
                        _loc9_ = mrca1;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc11_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc11_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc11_.next;
                           _loc11_.next = null;
                        }
                        null;
                        _loc11_.elt = _loc13_;
                        _loc10_ = _loc11_;
                        _loc10_.next = _loc9_.head;
                        _loc9_.head = _loc10_;
                        _loc9_.modified = true;
                        ++_loc9_.length;
                        _loc13_;
                     }
                     _loc13_ = _loc13_.compound;
                  }
               }
               _loc10_ = mrca1.head;
               while(_loc10_ != null)
               {
                  _loc12_ = _loc10_.elt;
                  _loc11_ = mrca2.head;
                  while(_loc11_ != null)
                  {
                     _loc17_ = _loc11_.elt;
                     _loc18_ = _loc12_.cbSet;
                     _loc19_ = _loc17_.cbSet;
                     _loc20_ = null;
                     _loc21_ = _loc18_.cbpairs.length < _loc19_.cbpairs.length ? _loc18_.cbpairs : _loc19_.cbpairs;
                     _loc22_ = _loc21_.head;
                     while(_loc22_ != null)
                     {
                        _loc23_ = _loc22_.elt;
                        if(_loc23_.a == _loc18_ && _loc23_.b == _loc19_ || _loc23_.a == _loc19_ && _loc23_.b == _loc18_)
                        {
                           _loc20_ = _loc23_;
                           break;
                        }
                        _loc22_ = _loc22_.next;
                     }
                     if(_loc20_ == null)
                     {
                        if(ZPP_CbSetPair.zpp_pool == null)
                        {
                           _loc23_ = new ZPP_CbSetPair();
                        }
                        else
                        {
                           _loc23_ = ZPP_CbSetPair.zpp_pool;
                           ZPP_CbSetPair.zpp_pool = _loc23_.next;
                           _loc23_.next = null;
                        }
                        _loc23_.zip_listeners = true;
                        if(ZPP_CbSet.setlt(_loc18_,_loc19_))
                        {
                           _loc23_.a = _loc18_;
                           _loc23_.b = _loc19_;
                        }
                        else
                        {
                           _loc23_.a = _loc19_;
                           _loc23_.b = _loc18_;
                        }
                        _loc20_ = _loc23_;
                        _loc18_.cbpairs.add(_loc20_);
                        if(_loc19_ != _loc18_)
                        {
                           _loc19_.cbpairs.add(_loc20_);
                        }
                     }
                     if(_loc20_.zip_listeners)
                     {
                        _loc20_.zip_listeners = false;
                        _loc20_.__validate();
                     }
                     if(_loc20_.listeners.head == null)
                     {
                        _loc11_ = _loc11_.next;
                     }
                     else
                     {
                        _loc24_ = ZPP_Interactor.get(_loc12_,_loc17_);
                        if(_loc6_ || param1.intchange)
                        {
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_CallbackSet.get(_loc12_,_loc17_);
                              add_callbackset(_loc24_);
                           }
                           _loc15_ = ZPP_Flags.id_CbEvent_BEGIN;
                           _loc20_ = null;
                           _loc21_ = _loc18_.cbpairs.length < _loc19_.cbpairs.length ? _loc18_.cbpairs : _loc19_.cbpairs;
                           _loc22_ = _loc21_.head;
                           while(_loc22_ != null)
                           {
                              _loc23_ = _loc22_.elt;
                              if(_loc23_.a == _loc18_ && _loc23_.b == _loc19_ || _loc23_.a == _loc19_ && _loc23_.b == _loc18_)
                              {
                                 _loc20_ = _loc23_;
                                 break;
                              }
                              _loc22_ = _loc22_.next;
                           }
                           if(_loc20_ == null)
                           {
                              if(ZPP_CbSetPair.zpp_pool == null)
                              {
                                 _loc23_ = new ZPP_CbSetPair();
                              }
                              else
                              {
                                 _loc23_ = ZPP_CbSetPair.zpp_pool;
                                 ZPP_CbSetPair.zpp_pool = _loc23_.next;
                                 _loc23_.next = null;
                              }
                              _loc23_.zip_listeners = true;
                              if(ZPP_CbSet.setlt(_loc18_,_loc19_))
                              {
                                 _loc23_.a = _loc18_;
                                 _loc23_.b = _loc19_;
                              }
                              else
                              {
                                 _loc23_.a = _loc19_;
                                 _loc23_.b = _loc18_;
                              }
                              _loc20_ = _loc23_;
                              _loc18_.cbpairs.add(_loc20_);
                              if(_loc19_ != _loc18_)
                              {
                                 _loc19_.cbpairs.add(_loc20_);
                              }
                           }
                           if(_loc20_.zip_listeners)
                           {
                              _loc20_.zip_listeners = false;
                              _loc20_.__validate();
                           }
                           _loc25_ = _loc20_.listeners.head;
                           while(_loc25_ != null)
                           {
                              _loc26_ = _loc25_.elt;
                              if(_loc26_.event == _loc15_)
                              {
                                 if((_loc26_.itype & param1.type) != 0 && _loc24_.empty_arb(_loc26_.itype))
                                 {
                                    _loc27_ = _loc4_.push_callback(_loc26_);
                                    _loc27_.event = ZPP_Flags.id_CbEvent_BEGIN;
                                    _loc28_ = _loc24_.int1;
                                    _loc29_ = _loc24_.int2;
                                    _loc30_ = _loc26_.options1;
                                    _loc31_ = _loc28_.cbTypes;
                                    if(_loc30_.nonemptyintersection(_loc31_,_loc30_.includes) && !_loc30_.nonemptyintersection(_loc31_,_loc30_.excludes) && (_loc30_.nonemptyintersection(_loc31_,_loc30_.includes) && !_loc30_.nonemptyintersection(_loc31_,_loc30_.excludes)))
                                    {
                                       _loc27_.int1 = _loc28_;
                                       _loc27_.int2 = _loc29_;
                                    }
                                    else
                                    {
                                       _loc27_.int1 = _loc29_;
                                       _loc27_.int2 = _loc28_;
                                    }
                                    _loc27_.set = _loc24_;
                                 }
                              }
                              _loc25_ = _loc25_.next;
                           }
                           _loc32_ = false;
                           _loc33_ = _loc24_.arbiters.head;
                           while(_loc33_ != null)
                           {
                              _loc34_ = _loc33_.elt;
                              if(_loc34_ == param1)
                              {
                                 _loc32_ = true;
                                 break;
                              }
                              _loc33_ = _loc33_.next;
                           }
                           if(!_loc32_)
                           {
                              _loc35_ = _loc24_.arbiters;
                              if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                              {
                                 _loc36_ = new ZNPNode_ZPP_Arbiter();
                              }
                              else
                              {
                                 _loc36_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                                 ZNPNode_ZPP_Arbiter.zpp_pool = _loc36_.next;
                                 _loc36_.next = null;
                              }
                              null;
                              _loc36_.elt = param1;
                              _loc33_ = _loc36_;
                              _loc33_.next = _loc35_.head;
                              _loc35_.head = _loc33_;
                              _loc35_.modified = true;
                              ++_loc35_.length;
                              param1;
                              §§push(true);
                           }
                           else
                           {
                              §§push(false);
                           }
                           if(§§pop())
                           {
                              ++param1.present;
                           }
                        }
                        else
                        {
                           --param1.present;
                           _loc24_.remove_arb(param1);
                           _loc15_ = ZPP_Flags.id_CbEvent_END;
                           _loc20_ = null;
                           _loc21_ = _loc18_.cbpairs.length < _loc19_.cbpairs.length ? _loc18_.cbpairs : _loc19_.cbpairs;
                           _loc22_ = _loc21_.head;
                           while(_loc22_ != null)
                           {
                              _loc23_ = _loc22_.elt;
                              if(_loc23_.a == _loc18_ && _loc23_.b == _loc19_ || _loc23_.a == _loc19_ && _loc23_.b == _loc18_)
                              {
                                 _loc20_ = _loc23_;
                                 break;
                              }
                              _loc22_ = _loc22_.next;
                           }
                           if(_loc20_ == null)
                           {
                              if(ZPP_CbSetPair.zpp_pool == null)
                              {
                                 _loc23_ = new ZPP_CbSetPair();
                              }
                              else
                              {
                                 _loc23_ = ZPP_CbSetPair.zpp_pool;
                                 ZPP_CbSetPair.zpp_pool = _loc23_.next;
                                 _loc23_.next = null;
                              }
                              _loc23_.zip_listeners = true;
                              if(ZPP_CbSet.setlt(_loc18_,_loc19_))
                              {
                                 _loc23_.a = _loc18_;
                                 _loc23_.b = _loc19_;
                              }
                              else
                              {
                                 _loc23_.a = _loc19_;
                                 _loc23_.b = _loc18_;
                              }
                              _loc20_ = _loc23_;
                              _loc18_.cbpairs.add(_loc20_);
                              if(_loc19_ != _loc18_)
                              {
                                 _loc19_.cbpairs.add(_loc20_);
                              }
                           }
                           if(_loc20_.zip_listeners)
                           {
                              _loc20_.zip_listeners = false;
                              _loc20_.__validate();
                           }
                           _loc25_ = _loc20_.listeners.head;
                           while(_loc25_ != null)
                           {
                              _loc26_ = _loc25_.elt;
                              if(_loc26_.event == _loc15_)
                              {
                                 if((_loc26_.itype & param1.type) != 0 && _loc24_.empty_arb(_loc26_.itype))
                                 {
                                    _loc27_ = _loc4_.push_callback(_loc26_);
                                    _loc27_.event = ZPP_Flags.id_CbEvent_END;
                                    _loc28_ = _loc24_.int1;
                                    _loc29_ = _loc24_.int2;
                                    _loc30_ = _loc26_.options1;
                                    _loc31_ = _loc28_.cbTypes;
                                    if(_loc30_.nonemptyintersection(_loc31_,_loc30_.includes) && !_loc30_.nonemptyintersection(_loc31_,_loc30_.excludes) && (_loc30_.nonemptyintersection(_loc31_,_loc30_.includes) && !_loc30_.nonemptyintersection(_loc31_,_loc30_.excludes)))
                                    {
                                       _loc27_.int1 = _loc28_;
                                       _loc27_.int2 = _loc29_;
                                    }
                                    else
                                    {
                                       _loc27_.int1 = _loc29_;
                                       _loc27_.int2 = _loc28_;
                                    }
                                    _loc27_.set = _loc24_;
                                 }
                              }
                              _loc25_ = _loc25_.next;
                           }
                           if(_loc24_.arbiters.head == null)
                           {
                              remove_callbackset(_loc24_);
                           }
                        }
                        _loc11_ = _loc11_.next;
                     }
                  }
                  _loc10_ = _loc10_.next;
               }
            }
            param1.fresh = false;
            param1.intchange = false;
         }
         if(param1.cleared || param1.up_stamp + (param1.type == ZPP_Arbiter.COL ? Config.arbiterExpirationDelay : 0) < stamp)
         {
            if(param1.type == ZPP_Arbiter.SENSOR)
            {
               _loc37_ = param1.sensorarb;
               if(!_loc37_.cleared)
               {
                  _loc35_ = _loc37_.b1.arbiters;
                  _loc33_ = null;
                  _loc36_ = _loc35_.head;
                  _loc5_ = false;
                  while(_loc36_ != null)
                  {
                     if(_loc36_.elt == _loc37_)
                     {
                        if(_loc33_ == null)
                        {
                           _loc38_ = _loc35_.head;
                           _loc39_ = _loc38_.next;
                           _loc35_.head = _loc39_;
                           if(_loc35_.head == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc38_ = _loc33_.next;
                           _loc39_ = _loc38_.next;
                           _loc33_.next = _loc39_;
                           if(_loc39_ == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        _loc40_ = _loc38_;
                        _loc40_.elt = null;
                        _loc40_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc40_;
                        _loc35_.modified = true;
                        --_loc35_.length;
                        _loc35_.pushmod = true;
                        _loc39_;
                        _loc5_ = true;
                        break;
                     }
                     _loc33_ = _loc36_;
                     _loc36_ = _loc36_.next;
                  }
                  _loc5_;
                  _loc35_ = _loc37_.b2.arbiters;
                  _loc33_ = null;
                  _loc36_ = _loc35_.head;
                  _loc5_ = false;
                  while(_loc36_ != null)
                  {
                     if(_loc36_.elt == _loc37_)
                     {
                        if(_loc33_ == null)
                        {
                           _loc38_ = _loc35_.head;
                           _loc39_ = _loc38_.next;
                           _loc35_.head = _loc39_;
                           if(_loc35_.head == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc38_ = _loc33_.next;
                           _loc39_ = _loc38_.next;
                           _loc33_.next = _loc39_;
                           if(_loc39_ == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        _loc40_ = _loc38_;
                        _loc40_.elt = null;
                        _loc40_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc40_;
                        _loc35_.modified = true;
                        --_loc35_.length;
                        _loc35_.pushmod = true;
                        _loc39_;
                        _loc5_ = true;
                        break;
                     }
                     _loc33_ = _loc36_;
                     _loc36_ = _loc36_.next;
                  }
                  _loc5_;
                  if(_loc37_.pair != null)
                  {
                     _loc37_.pair.arb = null;
                     _loc37_.pair = null;
                  }
               }
               _loc37_.b1 = _loc37_.b2 = null;
               _loc37_.active = false;
               _loc37_.intchange = false;
               _loc42_ = _loc37_;
               _loc42_.next = ZPP_SensorArbiter.zpp_pool;
               ZPP_SensorArbiter.zpp_pool = _loc42_;
            }
            else if(param1.type == ZPP_Arbiter.FLUID)
            {
               _loc43_ = param1.fluidarb;
               if(!_loc43_.cleared)
               {
                  _loc35_ = _loc43_.b1.arbiters;
                  _loc33_ = null;
                  _loc36_ = _loc35_.head;
                  _loc5_ = false;
                  while(_loc36_ != null)
                  {
                     if(_loc36_.elt == _loc43_)
                     {
                        if(_loc33_ == null)
                        {
                           _loc38_ = _loc35_.head;
                           _loc39_ = _loc38_.next;
                           _loc35_.head = _loc39_;
                           if(_loc35_.head == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc38_ = _loc33_.next;
                           _loc39_ = _loc38_.next;
                           _loc33_.next = _loc39_;
                           if(_loc39_ == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        _loc40_ = _loc38_;
                        _loc40_.elt = null;
                        _loc40_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc40_;
                        _loc35_.modified = true;
                        --_loc35_.length;
                        _loc35_.pushmod = true;
                        _loc39_;
                        _loc5_ = true;
                        break;
                     }
                     _loc33_ = _loc36_;
                     _loc36_ = _loc36_.next;
                  }
                  _loc5_;
                  _loc35_ = _loc43_.b2.arbiters;
                  _loc33_ = null;
                  _loc36_ = _loc35_.head;
                  _loc5_ = false;
                  while(_loc36_ != null)
                  {
                     if(_loc36_.elt == _loc43_)
                     {
                        if(_loc33_ == null)
                        {
                           _loc38_ = _loc35_.head;
                           _loc39_ = _loc38_.next;
                           _loc35_.head = _loc39_;
                           if(_loc35_.head == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc38_ = _loc33_.next;
                           _loc39_ = _loc38_.next;
                           _loc33_.next = _loc39_;
                           if(_loc39_ == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        _loc40_ = _loc38_;
                        _loc40_.elt = null;
                        _loc40_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc40_;
                        _loc35_.modified = true;
                        --_loc35_.length;
                        _loc35_.pushmod = true;
                        _loc39_;
                        _loc5_ = true;
                        break;
                     }
                     _loc33_ = _loc36_;
                     _loc36_ = _loc36_.next;
                  }
                  _loc5_;
                  if(_loc43_.pair != null)
                  {
                     _loc43_.pair.arb = null;
                     _loc43_.pair = null;
                  }
               }
               _loc43_.b1 = _loc43_.b2 = null;
               _loc43_.active = false;
               _loc43_.intchange = false;
               _loc44_ = _loc43_;
               _loc44_.next = ZPP_FluidArbiter.zpp_pool;
               ZPP_FluidArbiter.zpp_pool = _loc44_;
               _loc43_.pre_dt = -1;
            }
            else
            {
               _loc45_ = param1.colarb;
               if(!_loc45_.cleared)
               {
                  _loc35_ = _loc45_.b1.arbiters;
                  _loc33_ = null;
                  _loc36_ = _loc35_.head;
                  _loc5_ = false;
                  while(_loc36_ != null)
                  {
                     if(_loc36_.elt == _loc45_)
                     {
                        if(_loc33_ == null)
                        {
                           _loc38_ = _loc35_.head;
                           _loc39_ = _loc38_.next;
                           _loc35_.head = _loc39_;
                           if(_loc35_.head == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc38_ = _loc33_.next;
                           _loc39_ = _loc38_.next;
                           _loc33_.next = _loc39_;
                           if(_loc39_ == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        _loc40_ = _loc38_;
                        _loc40_.elt = null;
                        _loc40_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc40_;
                        _loc35_.modified = true;
                        --_loc35_.length;
                        _loc35_.pushmod = true;
                        _loc39_;
                        _loc5_ = true;
                        break;
                     }
                     _loc33_ = _loc36_;
                     _loc36_ = _loc36_.next;
                  }
                  _loc5_;
                  _loc35_ = _loc45_.b2.arbiters;
                  _loc33_ = null;
                  _loc36_ = _loc35_.head;
                  _loc5_ = false;
                  while(_loc36_ != null)
                  {
                     if(_loc36_.elt == _loc45_)
                     {
                        if(_loc33_ == null)
                        {
                           _loc38_ = _loc35_.head;
                           _loc39_ = _loc38_.next;
                           _loc35_.head = _loc39_;
                           if(_loc35_.head == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc38_ = _loc33_.next;
                           _loc39_ = _loc38_.next;
                           _loc33_.next = _loc39_;
                           if(_loc39_ == null)
                           {
                              _loc35_.pushmod = true;
                           }
                        }
                        _loc40_ = _loc38_;
                        _loc40_.elt = null;
                        _loc40_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc40_;
                        _loc35_.modified = true;
                        --_loc35_.length;
                        _loc35_.pushmod = true;
                        _loc39_;
                        _loc5_ = true;
                        break;
                     }
                     _loc33_ = _loc36_;
                     _loc36_ = _loc36_.next;
                  }
                  _loc5_;
                  if(_loc45_.pair != null)
                  {
                     _loc45_.pair.arb = null;
                     _loc45_.pair = null;
                  }
               }
               _loc45_.b1 = _loc45_.b2 = null;
               _loc45_.active = false;
               _loc45_.intchange = false;
               while(_loc45_.contacts.next != null)
               {
                  _loc47_ = _loc45_.contacts;
                  _loc48_ = _loc47_.next;
                  _loc47_.pop();
                  _loc46_ = _loc48_;
                  _loc46_.arbiter = null;
                  _loc46_.next = ZPP_Contact.zpp_pool;
                  ZPP_Contact.zpp_pool = _loc46_;
                  _loc49_ = _loc45_.innards;
                  _loc50_ = _loc49_.next;
                  _loc49_.next = _loc50_.next;
                  _loc50_._inuse = false;
                  if(_loc49_.next == null)
                  {
                     _loc49_.pushmod = true;
                  }
                  _loc49_.modified = true;
                  --_loc49_.length;
               }
               _loc51_ = _loc45_;
               _loc51_.userdef_dyn_fric = false;
               _loc51_.userdef_stat_fric = false;
               _loc51_.userdef_restitution = false;
               _loc51_.userdef_rfric = false;
               _loc51_.__ref_edge1 = _loc51_.__ref_edge2 = null;
               _loc51_.next = ZPP_ColArbiter.zpp_pool;
               ZPP_ColArbiter.zpp_pool = _loc51_;
               _loc45_.pre_dt = -1;
            }
            return true;
         }
         _loc5_ = param1.active;
         param1.active = param1.presentable = param1.up_stamp == stamp;
         if((param1.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
         {
            if(param1.active && param1.type != ZPP_Arbiter.SENSOR)
            {
               if(param1.colarb != null)
               {
                  _loc45_ = param1.colarb;
                  if(_loc45_.invalidated)
                  {
                     _loc45_.invalidated = false;
                     if(!_loc45_.userdef_restitution)
                     {
                        if(_loc45_.s1.material.elasticity <= -1.79e+308 || _loc45_.s2.material.elasticity <= -1.79e+308)
                        {
                           _loc45_.restitution = 0;
                        }
                        else if(_loc45_.s1.material.elasticity >= 1.79e+308 || _loc45_.s2.material.elasticity >= 1.79e+308)
                        {
                           _loc45_.restitution = 1;
                        }
                        else
                        {
                           _loc45_.restitution = (_loc45_.s1.material.elasticity + _loc45_.s2.material.elasticity) / 2;
                        }
                        if(_loc45_.restitution < 0)
                        {
                           _loc45_.restitution = 0;
                        }
                        if(_loc45_.restitution > 1)
                        {
                           _loc45_.restitution = 1;
                        }
                     }
                     if(!_loc45_.userdef_dyn_fric)
                     {
                        _loc53_ = _loc45_.s1.material.dynamicFriction * _loc45_.s2.material.dynamicFriction;
                        _loc45_.dyn_fric = _loc53_ == 0 ? 0 : (sf32(_loc53_,0), si32(1597463007 - (li32(0) >> 1),0), _loc54_ = lf32(0), 1 / (_loc54_ * (1.5 - 0.5 * _loc53_ * _loc54_ * _loc54_)));
                     }
                     if(!_loc45_.userdef_stat_fric)
                     {
                        _loc53_ = _loc45_.s1.material.staticFriction * _loc45_.s2.material.staticFriction;
                        _loc45_.stat_fric = _loc53_ == 0 ? 0 : (sf32(_loc53_,0), si32(1597463007 - (li32(0) >> 1),0), _loc54_ = lf32(0), 1 / (_loc54_ * (1.5 - 0.5 * _loc53_ * _loc54_ * _loc54_)));
                     }
                     if(!_loc45_.userdef_rfric)
                     {
                        _loc53_ = _loc45_.s1.material.rollingFriction * _loc45_.s2.material.rollingFriction;
                        _loc45_.rfric = _loc53_ == 0 ? 0 : (sf32(_loc53_,0), si32(1597463007 - (li32(0) >> 1),0), _loc54_ = lf32(0), 1 / (_loc54_ * (1.5 - 0.5 * _loc53_ * _loc54_ * _loc54_)));
                     }
                  }
                  if(_loc45_.pre_dt == -1)
                  {
                     _loc45_.pre_dt = param2;
                  }
                  _loc53_ = param2 / _loc45_.pre_dt;
                  _loc45_.pre_dt = param2;
                  _loc54_ = _loc45_.b1.smass + _loc45_.b2.smass;
                  _loc45_.hc2 = false;
                  _loc6_ = true;
                  _loc32_ = _loc45_.b1.type != ZPP_Flags.id_BodyType_DYNAMIC || _loc45_.b2.type != ZPP_Flags.id_BodyType_DYNAMIC;
                  _loc55_ = _loc32_ ? (_loc45_.continuous ? Config.contactContinuousStaticBiasCoef : Config.contactStaticBiasCoef) : (_loc45_.continuous ? Config.contactContinuousBiasCoef : Config.contactBiasCoef);
                  _loc45_.biasCoef = _loc55_;
                  _loc45_.continuous = false;
                  _loc46_ = null;
                  _loc49_ = null;
                  _loc50_ = _loc45_.innards.next;
                  _loc47_ = _loc45_.contacts.next;
                  while(_loc47_ != null)
                  {
                     _loc48_ = _loc47_;
                     if(_loc48_.stamp + Config.arbiterExpirationDelay < _loc45_.stamp)
                     {
                        _loc56_ = _loc45_.contacts;
                        if(_loc46_ == null)
                        {
                           _loc57_ = _loc56_.next;
                           _loc58_ = _loc57_.next;
                           _loc56_.next = _loc58_;
                           if(_loc56_.next == null)
                           {
                              _loc56_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc57_ = _loc46_.next;
                           _loc58_ = _loc57_.next;
                           _loc46_.next = _loc58_;
                           if(_loc58_ == null)
                           {
                              _loc56_.pushmod = true;
                           }
                        }
                        _loc57_._inuse = false;
                        _loc56_.modified = true;
                        --_loc56_.length;
                        _loc56_.pushmod = true;
                        _loc47_ = _loc58_;
                        _loc59_ = _loc45_.innards;
                        if(_loc49_ == null)
                        {
                           _loc60_ = _loc59_.next;
                           _loc61_ = _loc60_.next;
                           _loc59_.next = _loc61_;
                           if(_loc59_.next == null)
                           {
                              _loc59_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc60_ = _loc49_.next;
                           _loc61_ = _loc60_.next;
                           _loc49_.next = _loc61_;
                           if(_loc61_ == null)
                           {
                              _loc59_.pushmod = true;
                           }
                        }
                        _loc60_._inuse = false;
                        _loc59_.modified = true;
                        --_loc59_.length;
                        _loc59_.pushmod = true;
                        _loc50_ = _loc61_;
                        _loc56_ = _loc48_;
                        _loc56_.arbiter = null;
                        _loc56_.next = ZPP_Contact.zpp_pool;
                        ZPP_Contact.zpp_pool = _loc56_;
                     }
                     else
                     {
                        _loc59_ = _loc48_.inner;
                        _loc62_ = _loc48_.active;
                        _loc48_.active = _loc48_.stamp == _loc45_.stamp;
                        if(_loc48_.active)
                        {
                           if(_loc6_)
                           {
                              _loc6_ = false;
                              _loc45_.c1 = _loc59_;
                              _loc45_.oc1 = _loc48_;
                           }
                           else
                           {
                              _loc45_.hc2 = true;
                              _loc45_.c2 = _loc59_;
                              _loc45_.oc2 = _loc48_;
                           }
                           _loc59_.r2x = _loc48_.px - _loc45_.b2.posx;
                           _loc59_.r2y = _loc48_.py - _loc45_.b2.posy;
                           _loc59_.r1x = _loc48_.px - _loc45_.b1.posx;
                           _loc59_.r1y = _loc48_.py - _loc45_.b1.posy;
                           _loc64_ = _loc59_.r2x * _loc45_.nx + _loc59_.r2y * _loc45_.ny;
                           _loc63_ = _loc54_ + _loc45_.b2.sinertia * (_loc64_ * _loc64_);
                           _loc64_ = _loc59_.r1x * _loc45_.nx + _loc59_.r1y * _loc45_.ny;
                           _loc63_ += _loc45_.b1.sinertia * (_loc64_ * _loc64_);
                           _loc59_.tMass = _loc63_ < Config.epsilon * Config.epsilon ? 0 : 1 / _loc63_;
                           _loc65_ = _loc45_.ny * _loc59_.r2x - _loc45_.nx * _loc59_.r2y;
                           _loc64_ = _loc54_ + _loc45_.b2.sinertia * (_loc65_ * _loc65_);
                           _loc65_ = _loc45_.ny * _loc59_.r1x - _loc45_.nx * _loc59_.r1y;
                           _loc64_ += _loc45_.b1.sinertia * (_loc65_ * _loc65_);
                           _loc59_.nMass = _loc64_ < Config.epsilon * Config.epsilon ? 0 : 1 / _loc64_;
                           _loc65_ = 0;
                           _loc66_ = 0;
                           _loc67_ = _loc45_.b2.angvel + _loc45_.b2.kinangvel;
                           _loc65_ = _loc45_.b2.velx + _loc45_.b2.kinvelx - _loc59_.r2y * _loc67_;
                           _loc66_ = _loc45_.b2.vely + _loc45_.b2.kinvely + _loc59_.r2x * _loc67_;
                           _loc67_ = _loc45_.b1.angvel + _loc45_.b1.kinangvel;
                           _loc65_ -= _loc45_.b1.velx + _loc45_.b1.kinvelx - _loc59_.r1y * _loc67_;
                           _loc66_ -= _loc45_.b1.vely + _loc45_.b1.kinvely + _loc59_.r1x * _loc67_;
                           _loc67_ = _loc45_.nx * _loc65_ + _loc45_.ny * _loc66_;
                           _loc48_.elasticity = _loc45_.restitution;
                           _loc59_.bounce = _loc67_ * _loc48_.elasticity;
                           if(_loc59_.bounce > -Config.elasticThreshold)
                           {
                              _loc59_.bounce = 0;
                           }
                           _loc67_ = _loc66_ * _loc45_.nx - _loc65_ * _loc45_.ny;
                           _loc68_ = Config.staticFrictionThreshold;
                           if(_loc67_ * _loc67_ > _loc68_ * _loc68_)
                           {
                              _loc59_.friction = _loc45_.dyn_fric;
                           }
                           else
                           {
                              _loc59_.friction = _loc45_.stat_fric;
                           }
                           _loc59_.jnAcc *= _loc53_;
                           _loc59_.jtAcc *= _loc53_;
                        }
                        if(_loc62_ != _loc48_.active)
                        {
                           _loc45_.contacts.modified = true;
                        }
                        _loc46_ = _loc47_;
                        _loc49_ = _loc50_;
                        _loc50_ = _loc50_.next;
                        _loc47_ = _loc47_.next;
                     }
                  }
                  if(_loc45_.hc2)
                  {
                     _loc45_.hpc2 = true;
                     if(_loc45_.oc1.posOnly)
                     {
                        _loc59_ = _loc45_.c1;
                        _loc45_.c1 = _loc45_.c2;
                        _loc45_.c2 = _loc59_;
                        _loc47_ = _loc45_.oc1;
                        _loc45_.oc1 = _loc45_.oc2;
                        _loc45_.oc2 = _loc47_;
                        _loc45_.hc2 = false;
                     }
                     else if(_loc45_.oc2.posOnly)
                     {
                        _loc45_.hc2 = false;
                     }
                     if(_loc45_.oc1.posOnly)
                     {
                        _loc6_ = true;
                     }
                  }
                  else
                  {
                     _loc45_.hpc2 = false;
                  }
                  _loc45_.jrAcc *= _loc53_;
                  if(!_loc6_)
                  {
                     _loc45_.rn1a = _loc45_.ny * _loc45_.c1.r1x - _loc45_.nx * _loc45_.c1.r1y;
                     _loc45_.rt1a = _loc45_.c1.r1x * _loc45_.nx + _loc45_.c1.r1y * _loc45_.ny;
                     _loc45_.rn1b = _loc45_.ny * _loc45_.c1.r2x - _loc45_.nx * _loc45_.c1.r2y;
                     _loc45_.rt1b = _loc45_.c1.r2x * _loc45_.nx + _loc45_.c1.r2y * _loc45_.ny;
                     _loc45_.k1x = _loc45_.b2.kinvelx - _loc45_.c1.r2y * _loc45_.b2.kinangvel - (_loc45_.b1.kinvelx - _loc45_.c1.r1y * _loc45_.b1.kinangvel);
                     _loc45_.k1y = _loc45_.b2.kinvely + _loc45_.c1.r2x * _loc45_.b2.kinangvel - (_loc45_.b1.kinvely + _loc45_.c1.r1x * _loc45_.b1.kinangvel);
                  }
                  if(_loc45_.hc2)
                  {
                     _loc45_.rn2a = _loc45_.ny * _loc45_.c2.r1x - _loc45_.nx * _loc45_.c2.r1y;
                     _loc45_.rt2a = _loc45_.c2.r1x * _loc45_.nx + _loc45_.c2.r1y * _loc45_.ny;
                     _loc45_.rn2b = _loc45_.ny * _loc45_.c2.r2x - _loc45_.nx * _loc45_.c2.r2y;
                     _loc45_.rt2b = _loc45_.c2.r2x * _loc45_.nx + _loc45_.c2.r2y * _loc45_.ny;
                     _loc45_.k2x = _loc45_.b2.kinvelx - _loc45_.c2.r2y * _loc45_.b2.kinangvel - (_loc45_.b1.kinvelx - _loc45_.c2.r1y * _loc45_.b1.kinangvel);
                     _loc45_.k2y = _loc45_.b2.kinvely + _loc45_.c2.r2x * _loc45_.b2.kinangvel - (_loc45_.b1.kinvely + _loc45_.c2.r1x * _loc45_.b1.kinangvel);
                     _loc45_.kMassa = _loc54_ + _loc45_.b1.sinertia * _loc45_.rn1a * _loc45_.rn1a + _loc45_.b2.sinertia * _loc45_.rn1b * _loc45_.rn1b;
                     _loc45_.kMassb = _loc54_ + _loc45_.b1.sinertia * _loc45_.rn1a * _loc45_.rn2a + _loc45_.b2.sinertia * _loc45_.rn1b * _loc45_.rn2b;
                     _loc45_.kMassc = _loc54_ + _loc45_.b1.sinertia * _loc45_.rn2a * _loc45_.rn2a + _loc45_.b2.sinertia * _loc45_.rn2b * _loc45_.rn2b;
                     _loc63_ = _loc45_.kMassa * _loc45_.kMassa + 2 * _loc45_.kMassb * _loc45_.kMassb + _loc45_.kMassc * _loc45_.kMassc;
                     if(_loc63_ < Config.illConditionedThreshold * (_loc45_.kMassa * _loc45_.kMassc - _loc45_.kMassb * _loc45_.kMassb))
                     {
                        _loc45_.Ka = _loc45_.kMassa;
                        _loc45_.Kb = _loc45_.kMassb;
                        _loc45_.Kc = _loc45_.kMassc;
                        _loc64_ = _loc45_.kMassa * _loc45_.kMassc - _loc45_.kMassb * _loc45_.kMassb;
                        if(_loc64_ != _loc64_)
                        {
                           _loc45_.kMassa = _loc45_.kMassb = _loc45_.kMassc = 0;
                           3;
                        }
                        else if(_loc64_ == 0)
                        {
                           _loc15_ = 0;
                           if(_loc45_.kMassa != 0)
                           {
                              _loc45_.kMassa = 1 / _loc45_.kMassa;
                           }
                           else
                           {
                              _loc45_.kMassa = 0;
                              _loc15_ |= 1;
                           }
                           if(_loc45_.kMassc != 0)
                           {
                              _loc45_.kMassc = 1 / _loc45_.kMassc;
                           }
                           else
                           {
                              _loc45_.kMassc = 0;
                              _loc15_ |= 2;
                           }
                           _loc45_.kMassb = 0;
                           _loc15_;
                        }
                        else
                        {
                           _loc64_ = 1 / _loc64_;
                           _loc65_ = _loc45_.kMassc * _loc64_;
                           _loc45_.kMassc = _loc45_.kMassa * _loc64_;
                           _loc45_.kMassa = _loc65_;
                           _loc45_.kMassb *= -_loc64_;
                           0;
                        }
                     }
                     else
                     {
                        _loc45_.hc2 = false;
                        if(_loc45_.oc2.dist < _loc45_.oc1.dist)
                        {
                           _loc59_ = _loc45_.c1;
                           _loc45_.c1 = _loc45_.c2;
                           _loc45_.c2 = _loc59_;
                        }
                        _loc45_.oc2.active = false;
                        _loc45_.contacts.modified = true;
                     }
                  }
                  _loc45_.surfacex = _loc45_.b2.svelx;
                  _loc45_.surfacey = _loc45_.b2.svely;
                  _loc63_ = 1;
                  _loc45_.surfacex += _loc45_.b1.svelx * _loc63_;
                  _loc45_.surfacey += _loc45_.b1.svely * _loc63_;
                  _loc45_.surfacex = -_loc45_.surfacex;
                  _loc45_.surfacey = -_loc45_.surfacey;
                  _loc45_.rMass = _loc45_.b1.sinertia + _loc45_.b2.sinertia;
                  if(_loc45_.rMass != 0)
                  {
                     _loc45_.rMass = 1 / _loc45_.rMass;
                  }
                  if(_loc6_)
                  {
                     param1.active = false;
                  }
               }
               else
               {
                  _loc43_ = param1.fluidarb;
                  if(_loc43_.pre_dt == -1)
                  {
                     _loc43_.pre_dt = param2;
                  }
                  _loc53_ = param2 / _loc43_.pre_dt;
                  _loc43_.pre_dt = param2;
                  _loc43_.r1x = _loc43_.centroidx - _loc43_.b1.posx;
                  _loc43_.r1y = _loc43_.centroidy - _loc43_.b1.posy;
                  _loc43_.r2x = _loc43_.centroidx - _loc43_.b2.posx;
                  _loc43_.r2y = _loc43_.centroidy - _loc43_.b2.posy;
                  _loc54_ = 0;
                  _loc55_ = 0;
                  if(_loc43_.ws1.fluidEnabled && _loc43_.ws1.fluidProperties.wrap_gravity != null)
                  {
                     _loc54_ = _loc43_.ws1.fluidProperties.gravityx;
                     _loc55_ = _loc43_.ws1.fluidProperties.gravityy;
                  }
                  else
                  {
                     _loc54_ = gravityx;
                     _loc55_ = gravityy;
                  }
                  _loc63_ = 0;
                  _loc64_ = 0;
                  if(_loc43_.ws2.fluidEnabled && _loc43_.ws2.fluidProperties.wrap_gravity != null)
                  {
                     _loc63_ = _loc43_.ws2.fluidProperties.gravityx;
                     _loc64_ = _loc43_.ws2.fluidProperties.gravityy;
                  }
                  else
                  {
                     _loc63_ = gravityx;
                     _loc64_ = gravityy;
                  }
                  _loc65_ = 0;
                  _loc66_ = 0;
                  if(_loc43_.ws1.fluidEnabled && _loc43_.ws2.fluidEnabled)
                  {
                     _loc67_ = _loc43_.overlap * _loc43_.ws1.fluidProperties.density;
                     _loc68_ = _loc43_.overlap * _loc43_.ws2.fluidProperties.density;
                     if(_loc67_ > _loc68_)
                     {
                        _loc69_ = _loc67_ + _loc68_;
                        _loc65_ -= _loc54_ * _loc69_;
                        _loc66_ -= _loc55_ * _loc69_;
                     }
                     else if(_loc67_ < _loc68_)
                     {
                        _loc69_ = _loc67_ + _loc68_;
                        _loc65_ += _loc63_ * _loc69_;
                        _loc66_ += _loc64_ * _loc69_;
                     }
                     else
                     {
                        _loc69_ = 0;
                        _loc70_ = 0;
                        _loc69_ = _loc54_ + _loc63_;
                        _loc70_ = _loc55_ + _loc64_;
                        _loc71_ = 0.5;
                        _loc69_ *= _loc71_;
                        _loc70_ *= _loc71_;
                        if(_loc43_.ws1.worldCOMx * _loc69_ + _loc43_.ws1.worldCOMy * _loc70_ > _loc43_.ws2.worldCOMx * _loc69_ + _loc43_.ws2.worldCOMy * _loc70_)
                        {
                           _loc71_ = _loc67_ + _loc68_;
                           _loc65_ -= _loc69_ * _loc71_;
                           _loc66_ -= _loc70_ * _loc71_;
                        }
                        else
                        {
                           _loc71_ = _loc67_ + _loc68_;
                           _loc65_ += _loc69_ * _loc71_;
                           _loc66_ += _loc70_ * _loc71_;
                        }
                     }
                  }
                  else if(_loc43_.ws1.fluidEnabled)
                  {
                     _loc67_ = _loc43_.overlap * _loc43_.ws1.fluidProperties.density;
                     _loc68_ = _loc67_;
                     _loc65_ -= _loc54_ * _loc68_;
                     _loc66_ -= _loc55_ * _loc68_;
                  }
                  else if(_loc43_.ws2.fluidEnabled)
                  {
                     _loc67_ = _loc43_.overlap * _loc43_.ws2.fluidProperties.density;
                     _loc68_ = _loc67_;
                     _loc65_ += _loc63_ * _loc68_;
                     _loc66_ += _loc64_ * _loc68_;
                  }
                  _loc67_ = param2;
                  _loc65_ *= _loc67_;
                  _loc66_ *= _loc67_;
                  _loc43_.buoyx = _loc65_;
                  _loc43_.buoyy = _loc66_;
                  if(_loc43_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                  {
                     _loc67_ = _loc43_.b1.imass;
                     _loc43_.b1.velx -= _loc65_ * _loc67_;
                     _loc43_.b1.vely -= _loc66_ * _loc67_;
                     _loc43_.b1.angvel -= (_loc66_ * _loc43_.r1x - _loc65_ * _loc43_.r1y) * _loc43_.b1.iinertia;
                  }
                  if(_loc43_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
                  {
                     _loc67_ = _loc43_.b2.imass;
                     _loc43_.b2.velx += _loc65_ * _loc67_;
                     _loc43_.b2.vely += _loc66_ * _loc67_;
                     _loc43_.b2.angvel += (_loc66_ * _loc43_.r2x - _loc65_ * _loc43_.r2y) * _loc43_.b2.iinertia;
                  }
                  if((!_loc43_.ws1.fluidEnabled || _loc43_.ws1.fluidProperties.viscosity == 0) && (!_loc43_.ws2.fluidEnabled || _loc43_.ws2.fluidProperties.viscosity == 0))
                  {
                     _loc43_.nodrag = true;
                     _loc43_.dampx = 0;
                     _loc43_.dampy = 0;
                     _loc43_.adamp = 0;
                  }
                  else
                  {
                     _loc43_.nodrag = false;
                     _loc67_ = 0;
                     if(_loc43_.ws1.fluidEnabled)
                     {
                        _loc43_.ws2.validate_angDrag();
                        _loc67_ += _loc43_.ws1.fluidProperties.viscosity * _loc43_.ws2.angDrag * _loc43_.overlap / _loc43_.ws2.area;
                     }
                     if(_loc43_.ws2.fluidEnabled)
                     {
                        _loc43_.ws1.validate_angDrag();
                        _loc67_ += _loc43_.ws2.fluidProperties.viscosity * _loc43_.ws1.angDrag * _loc43_.overlap / _loc43_.ws1.area;
                     }
                     if(_loc67_ != 0)
                     {
                        _loc68_ = _loc43_.b1.sinertia + _loc43_.b2.sinertia;
                        if(_loc68_ != 0)
                        {
                           _loc43_.wMass = 1 / _loc68_;
                        }
                        else
                        {
                           _loc43_.wMass = 0;
                        }
                        _loc67_ *= 0.0004;
                        _loc70_ = 2 * Math.PI * _loc67_;
                        _loc43_.agamma = 1 / (param2 * _loc70_ * (2 + _loc70_ * param2));
                        _loc71_ = 1 / (1 + _loc43_.agamma);
                        _loc69_ = param2 * _loc70_ * _loc70_ * _loc43_.agamma;
                        _loc43_.agamma *= _loc71_;
                        _loc43_.wMass *= _loc71_;
                     }
                     else
                     {
                        _loc43_.wMass = 0;
                        _loc43_.agamma = 0;
                     }
                     _loc68_ = _loc43_.b2.velx + _loc43_.b2.kinvelx - _loc43_.r2y * (_loc43_.b2.angvel + _loc43_.b2.kinangvel) - (_loc43_.b1.velx + _loc43_.b1.kinvelx - _loc43_.r1y * (_loc43_.b2.angvel + _loc43_.b2.kinangvel));
                     _loc69_ = _loc43_.b2.vely + _loc43_.b2.kinvely + _loc43_.r2x * (_loc43_.b2.angvel + _loc43_.b2.kinangvel) - (_loc43_.b1.vely + _loc43_.b1.kinvely + _loc43_.r1x * (_loc43_.b1.angvel + _loc43_.b1.kinangvel));
                     if(_loc68_ * _loc68_ + _loc69_ * _loc69_ >= Config.epsilon * Config.epsilon)
                     {
                        _loc70_ = _loc68_ * _loc68_ + _loc69_ * _loc69_;
                        sf32(_loc70_,0);
                        si32(1597463007 - (li32(0) >> 1),0);
                        _loc72_ = lf32(0);
                        _loc71_ = _loc72_ * (1.5 - 0.5 * _loc70_ * _loc72_ * _loc72_);
                        _loc72_ = _loc71_;
                        _loc68_ *= _loc72_;
                        _loc69_ *= _loc72_;
                        _loc43_.nx = _loc68_;
                        _loc43_.ny = _loc69_;
                     }
                     _loc70_ = 0;
                     if(_loc43_.ws1.fluidEnabled)
                     {
                        _loc71_ = -_loc43_.ws1.fluidProperties.viscosity * _loc43_.overlap / _loc43_.ws2.area;
                        if(_loc43_.ws2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc70_ -= _loc71_ * _loc43_.ws2.circle.radius * Config.fluidLinearDrag / (2 * _loc43_.ws2.circle.radius * Math.PI);
                        }
                        else
                        {
                           _loc73_ = _loc43_.ws2.polygon;
                           _loc72_ = 0;
                           _loc74_ = 0;
                           _loc75_ = _loc73_.edges.head;
                           while(_loc75_ != null)
                           {
                              _loc52_ = _loc75_.elt;
                              _loc72_ += _loc52_.length;
                              _loc76_ = _loc71_ * _loc52_.length * (_loc52_.gnormx * _loc43_.nx + _loc52_.gnormy * _loc43_.ny);
                              if(_loc76_ > 0)
                              {
                                 _loc76_ = _loc76_ *= -Config.fluidVacuumDrag;
                              }
                              _loc74_ -= _loc76_ * 0.5 * Config.fluidLinearDrag;
                              _loc75_ = _loc75_.next;
                           }
                           _loc70_ += _loc74_ / _loc72_;
                        }
                     }
                     if(_loc43_.ws2.fluidEnabled)
                     {
                        _loc71_ = -_loc43_.ws2.fluidProperties.viscosity * _loc43_.overlap / _loc43_.ws1.area;
                        if(_loc43_.ws1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc70_ -= _loc71_ * _loc43_.ws1.circle.radius * Config.fluidLinearDrag / (2 * _loc43_.ws1.circle.radius * Math.PI);
                        }
                        else
                        {
                           _loc73_ = _loc43_.ws1.polygon;
                           _loc72_ = 0;
                           _loc74_ = 0;
                           _loc75_ = _loc73_.edges.head;
                           while(_loc75_ != null)
                           {
                              _loc52_ = _loc75_.elt;
                              _loc72_ += _loc52_.length;
                              _loc76_ = _loc71_ * _loc52_.length * (_loc52_.gnormx * _loc43_.nx + _loc52_.gnormy * _loc43_.ny);
                              if(_loc76_ > 0)
                              {
                                 _loc76_ = _loc76_ *= -Config.fluidVacuumDrag;
                              }
                              _loc74_ -= _loc76_ * 0.5 * Config.fluidLinearDrag;
                              _loc75_ = _loc75_.next;
                           }
                           _loc70_ += _loc74_ / _loc72_;
                        }
                     }
                     if(_loc70_ != 0)
                     {
                        _loc71_ = _loc43_.b1.smass + _loc43_.b2.smass;
                        _loc72_ = 0;
                        _loc74_ = 0;
                        _loc76_ = 0;
                        _loc72_ = _loc71_;
                        _loc74_ = 0;
                        _loc76_ = _loc71_;
                        if(_loc43_.b1.sinertia != 0)
                        {
                           _loc77_ = _loc43_.r1x * _loc43_.b1.sinertia;
                           _loc78_ = _loc43_.r1y * _loc43_.b1.sinertia;
                           _loc72_ += _loc78_ * _loc43_.r1y;
                           _loc74_ += -_loc78_ * _loc43_.r1x;
                           _loc76_ += _loc77_ * _loc43_.r1x;
                        }
                        if(_loc43_.b2.sinertia != 0)
                        {
                           _loc77_ = _loc43_.r2x * _loc43_.b2.sinertia;
                           _loc78_ = _loc43_.r2y * _loc43_.b2.sinertia;
                           _loc72_ += _loc78_ * _loc43_.r2y;
                           _loc74_ += -_loc78_ * _loc43_.r2x;
                           _loc76_ += _loc77_ * _loc43_.r2x;
                        }
                        _loc77_ = _loc72_ * _loc76_ - _loc74_ * _loc74_;
                        if(_loc77_ != _loc77_)
                        {
                           _loc72_ = _loc74_ = _loc76_ = 0;
                           3;
                        }
                        else if(_loc77_ == 0)
                        {
                           _loc15_ = 0;
                           if(_loc72_ != 0)
                           {
                              _loc72_ = 1 / _loc72_;
                           }
                           else
                           {
                              _loc72_ = 0;
                              _loc15_ |= 1;
                           }
                           if(_loc76_ != 0)
                           {
                              _loc76_ = 1 / _loc76_;
                           }
                           else
                           {
                              _loc76_ = 0;
                              _loc15_ |= 2;
                           }
                           _loc74_ = 0;
                           _loc15_;
                        }
                        else
                        {
                           _loc77_ = 1 / _loc77_;
                           _loc78_ = _loc76_ * _loc77_;
                           _loc76_ = _loc72_ * _loc77_;
                           _loc72_ = _loc78_;
                           _loc74_ *= -_loc77_;
                           0;
                        }
                        _loc43_.vMassa = _loc72_;
                        _loc43_.vMassb = _loc74_;
                        _loc43_.vMassc = _loc76_;
                        _loc79_ = 2 * Math.PI * _loc70_;
                        _loc43_.lgamma = 1 / (param2 * _loc79_ * (2 + _loc79_ * param2));
                        _loc80_ = 1 / (1 + _loc43_.lgamma);
                        _loc77_ = param2 * _loc79_ * _loc79_ * _loc43_.lgamma;
                        _loc43_.lgamma *= _loc80_;
                        _loc78_ = _loc80_;
                        _loc43_.vMassa *= _loc78_;
                        _loc43_.vMassb *= _loc78_;
                        _loc43_.vMassc *= _loc78_;
                     }
                     else
                     {
                        _loc43_.vMassa = 0;
                        _loc43_.vMassb = 0;
                        _loc43_.vMassc = 0;
                        _loc43_.lgamma = 0;
                     }
                  }
                  _loc67_ = _loc53_;
                  _loc43_.dampx *= _loc67_;
                  _loc43_.dampy *= _loc67_;
                  _loc43_.adamp *= _loc53_;
               }
            }
         }
         else if(param1.colarb != null)
         {
            _loc45_ = param1.colarb;
            _loc6_ = true;
            _loc46_ = null;
            _loc49_ = null;
            _loc50_ = _loc45_.innards.next;
            _loc45_.hc2 = false;
            _loc47_ = _loc45_.contacts.next;
            while(_loc47_ != null)
            {
               _loc48_ = _loc47_;
               if(_loc48_.stamp + Config.arbiterExpirationDelay < _loc45_.stamp)
               {
                  _loc56_ = _loc45_.contacts;
                  if(_loc46_ == null)
                  {
                     _loc57_ = _loc56_.next;
                     _loc58_ = _loc57_.next;
                     _loc56_.next = _loc58_;
                     if(_loc56_.next == null)
                     {
                        _loc56_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc57_ = _loc46_.next;
                     _loc58_ = _loc57_.next;
                     _loc46_.next = _loc58_;
                     if(_loc58_ == null)
                     {
                        _loc56_.pushmod = true;
                     }
                  }
                  _loc57_._inuse = false;
                  _loc56_.modified = true;
                  --_loc56_.length;
                  _loc56_.pushmod = true;
                  _loc47_ = _loc58_;
                  _loc59_ = _loc45_.innards;
                  if(_loc49_ == null)
                  {
                     _loc60_ = _loc59_.next;
                     _loc61_ = _loc60_.next;
                     _loc59_.next = _loc61_;
                     if(_loc59_.next == null)
                     {
                        _loc59_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc60_ = _loc49_.next;
                     _loc61_ = _loc60_.next;
                     _loc49_.next = _loc61_;
                     if(_loc61_ == null)
                     {
                        _loc59_.pushmod = true;
                     }
                  }
                  _loc60_._inuse = false;
                  _loc59_.modified = true;
                  --_loc59_.length;
                  _loc59_.pushmod = true;
                  _loc50_ = _loc61_;
                  _loc56_ = _loc48_;
                  _loc56_.arbiter = null;
                  _loc56_.next = ZPP_Contact.zpp_pool;
                  ZPP_Contact.zpp_pool = _loc56_;
               }
               else
               {
                  _loc59_ = _loc48_.inner;
                  _loc32_ = _loc48_.active;
                  _loc48_.active = _loc48_.stamp == _loc45_.stamp;
                  if(_loc48_.active)
                  {
                     if(_loc6_)
                     {
                        _loc6_ = false;
                        _loc45_.c1 = _loc59_;
                        _loc45_.oc1 = _loc48_;
                     }
                     else
                     {
                        _loc45_.hc2 = true;
                        _loc45_.c2 = _loc59_;
                        _loc45_.oc2 = _loc48_;
                     }
                  }
                  if(_loc32_ != _loc48_.active)
                  {
                     _loc45_.contacts.modified = true;
                  }
                  _loc46_ = _loc47_;
                  _loc49_ = _loc50_;
                  _loc50_ = _loc50_.next;
                  _loc47_ = _loc47_.next;
               }
            }
            if(_loc45_.hc2)
            {
               _loc45_.hpc2 = true;
               if(_loc45_.oc1.posOnly)
               {
                  _loc59_ = _loc45_.c1;
                  _loc45_.c1 = _loc45_.c2;
                  _loc45_.c2 = _loc59_;
                  _loc47_ = _loc45_.oc1;
                  _loc45_.oc1 = _loc45_.oc2;
                  _loc45_.oc2 = _loc47_;
                  _loc45_.hc2 = false;
               }
               else if(_loc45_.oc2.posOnly)
               {
                  _loc45_.hc2 = false;
               }
               if(_loc45_.oc1.posOnly)
               {
                  _loc6_ = true;
               }
            }
            else
            {
               _loc45_.hpc2 = false;
            }
            if(_loc6_)
            {
               param1.active = false;
            }
         }
         if(_loc5_ != param1.active)
         {
            param1.b1.arbiters.modified = true;
            param1.b2.arbiters.modified = true;
            c_arbiters_true.modified = c_arbiters_false.modified = true;
            s_arbiters.modified = f_arbiters.modified = true;
         }
         return false;
      }
      
      public function prestep(param1:Number) : void
      {
         var _loc4_:* = null as ZPP_Constraint;
         var _loc9_:* = null as ZPP_ColArbiter;
         var _loc10_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc11_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc12_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc16_:* = null as ZPP_FluidArbiter;
         var _loc17_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc18_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc19_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc23_:* = null as ZPP_SensorArbiter;
         var _loc24_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc25_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc26_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc2_:ZNPNode_ZPP_Constraint = null;
         var _loc3_:ZNPNode_ZPP_Constraint = live_constraints.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            if(_loc4_.preStep(param1))
            {
               _loc3_ = live_constraints.erase(_loc2_);
               _loc4_.broken();
               constraintCbBreak(_loc4_);
               if(_loc4_.removeOnBreak)
               {
                  _loc4_.component.sleeping = true;
                  midstep = false;
                  if(_loc4_.compound != null)
                  {
                     _loc4_.compound.wrap_constraints.remove(_loc4_.outer);
                  }
                  else
                  {
                     wrap_constraints.remove(_loc4_.outer);
                  }
                  midstep = true;
               }
               else
               {
                  _loc4_.active = false;
               }
               _loc4_.clearcache();
            }
            else
            {
               _loc2_ = _loc3_;
               _loc3_ = _loc3_.next;
            }
         }
         var _loc5_:ZNPNode_ZPP_ColArbiter = null;
         var _loc6_:ZNPList_ZPP_ColArbiter = c_arbiters_true;
         var _loc7_:ZNPNode_ZPP_ColArbiter = _loc6_.head;
         var _loc8_:Boolean = c_arbiters_false != null;
         if(_loc8_ && _loc7_ == null)
         {
            _loc8_ = false;
            _loc7_ = c_arbiters_false.head;
            _loc6_ = c_arbiters_false;
            _loc5_ = null;
         }
         while(_loc7_ != null)
         {
            _loc9_ = _loc7_.elt;
            if(presteparb(_loc9_,param1))
            {
               if(_loc5_ == null)
               {
                  _loc10_ = _loc6_.head;
                  _loc11_ = _loc10_.next;
                  _loc6_.head = _loc11_;
                  if(_loc6_.head == null)
                  {
                     _loc6_.pushmod = true;
                  }
               }
               else
               {
                  _loc10_ = _loc5_.next;
                  _loc11_ = _loc10_.next;
                  _loc5_.next = _loc11_;
                  if(_loc11_ == null)
                  {
                     _loc6_.pushmod = true;
                  }
               }
               _loc12_ = _loc10_;
               _loc12_.elt = null;
               _loc12_.next = ZNPNode_ZPP_ColArbiter.zpp_pool;
               ZNPNode_ZPP_ColArbiter.zpp_pool = _loc12_;
               _loc6_.modified = true;
               --_loc6_.length;
               _loc6_.pushmod = true;
               _loc7_ = _loc11_;
               if(_loc8_ && _loc7_ == null)
               {
                  _loc8_ = false;
                  _loc7_ = c_arbiters_false.head;
                  _loc6_ = c_arbiters_false;
                  _loc5_ = null;
               }
            }
            else
            {
               _loc5_ = _loc7_;
               _loc7_ = _loc7_.next;
               if(_loc8_ && _loc7_ == null)
               {
                  _loc8_ = false;
                  _loc7_ = c_arbiters_false.head;
                  _loc6_ = c_arbiters_false;
                  _loc5_ = null;
               }
            }
         }
         var _loc13_:ZNPNode_ZPP_FluidArbiter = null;
         var _loc14_:ZNPList_ZPP_FluidArbiter = f_arbiters;
         var _loc15_:ZNPNode_ZPP_FluidArbiter = _loc14_.head;
         _loc8_ = false;
         if(_loc8_ && _loc15_ == null)
         {
            _loc8_ = false;
            _loc15_ = null.begin();
            _loc14_ = null;
            _loc13_ = null;
         }
         while(_loc15_ != null)
         {
            _loc16_ = _loc15_.elt;
            if(presteparb(_loc16_,param1))
            {
               if(_loc13_ == null)
               {
                  _loc17_ = _loc14_.head;
                  _loc18_ = _loc17_.next;
                  _loc14_.head = _loc18_;
                  if(_loc14_.head == null)
                  {
                     _loc14_.pushmod = true;
                  }
               }
               else
               {
                  _loc17_ = _loc13_.next;
                  _loc18_ = _loc17_.next;
                  _loc13_.next = _loc18_;
                  if(_loc18_ == null)
                  {
                     _loc14_.pushmod = true;
                  }
               }
               _loc19_ = _loc17_;
               _loc19_.elt = null;
               _loc19_.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
               ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc19_;
               _loc14_.modified = true;
               --_loc14_.length;
               _loc14_.pushmod = true;
               _loc15_ = _loc18_;
               if(_loc8_ && _loc15_ == null)
               {
                  _loc8_ = false;
                  _loc15_ = null.begin();
                  _loc14_ = null;
                  _loc13_ = null;
               }
            }
            else
            {
               _loc13_ = _loc15_;
               _loc15_ = _loc15_.next;
               if(_loc8_ && _loc15_ == null)
               {
                  _loc8_ = false;
                  _loc15_ = null.begin();
                  _loc14_ = null;
                  _loc13_ = null;
               }
            }
         }
         var _loc20_:ZNPNode_ZPP_SensorArbiter = null;
         var _loc21_:ZNPList_ZPP_SensorArbiter = s_arbiters;
         var _loc22_:ZNPNode_ZPP_SensorArbiter = _loc21_.head;
         _loc8_ = false;
         if(_loc8_ && _loc22_ == null)
         {
            _loc8_ = false;
            _loc22_ = null.begin();
            _loc21_ = null;
            _loc20_ = null;
         }
         while(_loc22_ != null)
         {
            _loc23_ = _loc22_.elt;
            if(presteparb(_loc23_,param1))
            {
               if(_loc20_ == null)
               {
                  _loc24_ = _loc21_.head;
                  _loc25_ = _loc24_.next;
                  _loc21_.head = _loc25_;
                  if(_loc21_.head == null)
                  {
                     _loc21_.pushmod = true;
                  }
               }
               else
               {
                  _loc24_ = _loc20_.next;
                  _loc25_ = _loc24_.next;
                  _loc20_.next = _loc25_;
                  if(_loc25_ == null)
                  {
                     _loc21_.pushmod = true;
                  }
               }
               _loc26_ = _loc24_;
               _loc26_.elt = null;
               _loc26_.next = ZNPNode_ZPP_SensorArbiter.zpp_pool;
               ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc26_;
               _loc21_.modified = true;
               --_loc21_.length;
               _loc21_.pushmod = true;
               _loc22_ = _loc25_;
               if(_loc8_ && _loc22_ == null)
               {
                  _loc8_ = false;
                  _loc22_ = null.begin();
                  _loc21_ = null;
                  _loc20_ = null;
               }
            }
            else
            {
               _loc20_ = _loc22_;
               _loc22_ = _loc22_.next;
               if(_loc8_ && _loc22_ == null)
               {
                  _loc8_ = false;
                  _loc22_ = null.begin();
                  _loc21_ = null;
                  _loc20_ = null;
               }
            }
         }
      }
      
      public function nullListenerType(param1:ZPP_CbSet, param2:ZPP_CbSet) : void
      {
         var _loc4_:* = null as ZNPNode_ZPP_Interactor;
         var _loc5_:* = null as ZPP_Interactor;
         var _loc6_:* = null as ZPP_Compound;
         var _loc7_:* = null as ZNPNode_ZPP_Body;
         var _loc8_:* = null as ZPP_Body;
         var _loc9_:* = null as ZNPNode_ZPP_Compound;
         var _loc10_:* = null as ZPP_Compound;
         var _loc11_:* = null as ZPP_Shape;
         var _loc12_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc13_:* = null as ZPP_Arbiter;
         var _loc14_:* = null as ZPP_Interactor;
         var _loc15_:* = null as ZNPNode_ZPP_Interactor;
         var _loc16_:* = null as ZPP_Interactor;
         var _loc17_:* = null as ZPP_CallbackSet;
         var _loc18_:* = null as ZPP_Arbiter;
         var _loc3_:ZNPList_ZPP_Interactor = new ZNPList_ZPP_Interactor();
         _loc4_ = param1.interactors.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc3_.add(_loc5_);
            _loc4_ = _loc4_.next;
         }
         if(param1 != param2)
         {
            _loc4_ = param2.interactors.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               _loc3_.add(_loc5_);
               _loc4_ = _loc4_.next;
            }
         }
         while(_loc3_.head != null)
         {
            _loc5_ = _loc3_.pop_unsafe();
            if(_loc5_.icompound != null)
            {
               _loc6_ = _loc5_.icompound;
               _loc7_ = _loc6_.bodies.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc3_.add(_loc8_);
                  _loc7_ = _loc7_.next;
               }
               _loc9_ = _loc6_.compounds.head;
               while(_loc9_ != null)
               {
                  _loc10_ = _loc9_.elt;
                  _loc3_.add(_loc10_);
                  _loc9_ = _loc9_.next;
               }
            }
            else
            {
               _loc8_ = _loc5_.ibody != null ? _loc5_.ibody : _loc5_.ishape.body;
               _loc11_ = _loc5_.ishape != null ? _loc5_.ishape : null;
               _loc12_ = _loc8_.arbiters.head;
               while(_loc12_ != null)
               {
                  _loc13_ = _loc12_.elt;
                  if(_loc13_.present == 0)
                  {
                     _loc12_ = _loc12_.next;
                  }
                  else if(_loc11_ != null && !(_loc13_.ws1 == _loc11_ || _loc13_.ws2 == _loc11_))
                  {
                     _loc12_ = _loc12_.next;
                  }
                  else
                  {
                     MRCA_chains(_loc13_.ws1,_loc13_.ws2);
                     _loc4_ = mrca1.head;
                     while(_loc4_ != null)
                     {
                        _loc14_ = _loc4_.elt;
                        if(_loc14_.cbSet != param1 && _loc14_.cbSet != param2)
                        {
                           _loc4_ = _loc4_.next;
                        }
                        else
                        {
                           _loc15_ = mrca2.head;
                           while(_loc15_ != null)
                           {
                              _loc16_ = _loc15_.elt;
                              if(_loc14_.cbSet == param1 && _loc16_.cbSet != param2 || _loc14_.cbSet == param2 && _loc16_.cbSet != param1)
                              {
                                 _loc15_ = _loc15_.next;
                              }
                              else
                              {
                                 _loc17_ = ZPP_Interactor.get(_loc14_,_loc16_);
                                 if(_loc17_ != null)
                                 {
                                    while(_loc17_.arbiters.head != null)
                                    {
                                       _loc18_ = _loc17_.arbiters.pop_unsafe();
                                       --_loc18_.present;
                                    }
                                    remove_callbackset(_loc17_);
                                 }
                                 _loc15_ = _loc15_.next;
                              }
                           }
                           _loc4_ = _loc4_.next;
                        }
                     }
                     _loc12_ = _loc12_.next;
                  }
               }
            }
         }
      }
      
      public function nullInteractorType(param1:ZPP_Interactor, param2:ZPP_Interactor = undefined) : void
      {
         var _loc3_:* = null as ZPP_Compound;
         var _loc4_:* = null as ZNPNode_ZPP_Body;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Compound;
         var _loc7_:* = null as ZPP_Compound;
         var _loc8_:* = null as ZPP_Shape;
         var _loc9_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as ZNPNode_ZPP_Interactor;
         var _loc12_:* = null as ZPP_Interactor;
         var _loc13_:* = null as ZNPNode_ZPP_Interactor;
         var _loc14_:* = null as ZPP_Interactor;
         var _loc15_:* = null as ZPP_CallbackSet;
         if(param2 == null)
         {
            param2 = param1;
         }
         if(param1.icompound != null)
         {
            _loc3_ = param1.icompound;
            _loc4_ = _loc3_.bodies.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               nullInteractorType(_loc5_,param2);
               _loc4_ = _loc4_.next;
            }
            _loc6_ = _loc3_.compounds.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               nullInteractorType(_loc7_,param2);
               _loc6_ = _loc6_.next;
            }
         }
         else
         {
            _loc5_ = param1.ibody != null ? param1.ibody : param1.ishape.body;
            _loc8_ = param1.ishape != null ? param1.ishape : null;
            _loc9_ = _loc5_.arbiters.head;
            while(_loc9_ != null)
            {
               _loc10_ = _loc9_.elt;
               if(_loc10_.present == 0)
               {
                  _loc9_ = _loc9_.next;
               }
               else if(_loc8_ != null && !(_loc10_.ws1 == _loc8_ || _loc10_.ws2 == _loc8_))
               {
                  _loc9_ = _loc9_.next;
               }
               else
               {
                  MRCA_chains(_loc10_.ws1,_loc10_.ws2);
                  _loc11_ = mrca1.head;
                  while(_loc11_ != null)
                  {
                     _loc12_ = _loc11_.elt;
                     _loc13_ = mrca2.head;
                     while(_loc13_ != null)
                     {
                        _loc14_ = _loc13_.elt;
                        if(_loc12_ != param2 && _loc14_ != param2)
                        {
                           _loc13_ = _loc13_.next;
                        }
                        else
                        {
                           _loc15_ = ZPP_Interactor.get(_loc12_,_loc14_);
                           if(_loc15_ != null)
                           {
                              --_loc10_.present;
                              _loc15_.remove_arb(_loc10_);
                              if(_loc15_.arbiters.head == null)
                              {
                                 remove_callbackset(_loc15_);
                              }
                           }
                           _loc13_ = _loc13_.next;
                        }
                     }
                     _loc11_ = _loc11_.next;
                  }
                  _loc9_ = _loc9_.next;
               }
            }
         }
      }
      
      public function non_inlined_wake(param1:ZPP_Body, param2:Boolean = false) : void
      {
         var _loc3_:ZPP_Body = param1;
         if(!_loc3_.world)
         {
            _loc3_.component.waket = stamp + (midstep ? 0 : 1);
            if(_loc3_.component.sleeping)
            {
               really_wake(_loc3_,param2);
            }
         }
      }
      
      public function narrowPhase(param1:ZPP_Shape, param2:ZPP_Shape, param3:Boolean, param4:ZPP_Arbiter, param5:Boolean) : ZPP_Arbiter
      {
         var _loc11_:Boolean = false;
         var _loc13_:* = null as ZPP_Constraint;
         var _loc14_:* = null as ZPP_InteractionGroup;
         var _loc15_:* = null as ZPP_Interactor;
         var _loc16_:* = null as ZPP_InteractionGroup;
         var _loc17_:Boolean = false;
         var _loc18_:* = null as ZPP_InteractionFilter;
         var _loc19_:* = null as ZPP_InteractionFilter;
         var _loc20_:* = null as ZPP_Shape;
         var _loc21_:* = null as ZPP_Shape;
         var _loc22_:* = null as ZPP_Arbiter;
         var _loc23_:* = null as ZPP_Arbiter;
         var _loc24_:* = null as ZPP_Body;
         var _loc25_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc26_:* = null as ZPP_Arbiter;
         var _loc27_:* = null as ZPP_FluidArbiter;
         var _loc28_:Boolean = false;
         var _loc29_:* = null as ZNPList_ZPP_Arbiter;
         var _loc30_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc31_:Boolean = false;
         var _loc32_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc33_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc34_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc35_:int = 0;
         var _loc36_:* = null as ZNPList_ZPP_FluidArbiter;
         var _loc37_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc38_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc39_:* = null as ZNPList_ZPP_Interactor;
         var _loc40_:* = null as ZNPNode_ZPP_Interactor;
         var _loc41_:* = null as ZNPNode_ZPP_Interactor;
         var _loc42_:* = null as ZPP_Compound;
         var _loc43_:* = null as ZPP_Compound;
         var _loc44_:int = 0;
         var _loc45_:int = 0;
         var _loc46_:* = null as ZPP_Interactor;
         var _loc47_:* = null as ZPP_CbSet;
         var _loc48_:* = null as ZPP_CbSet;
         var _loc49_:* = null as ZPP_CbSetPair;
         var _loc50_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc51_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc52_:* = null as ZPP_CbSetPair;
         var _loc53_:* = null as ZPP_CallbackSet;
         var _loc54_:* = null as ZPP_CallbackSet;
         var _loc55_:* = null as ZNPList_ZPP_InteractionListener;
         var _loc56_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc57_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc58_:* = null as ZPP_InteractionListener;
         var _loc59_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc60_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc61_:Boolean = false;
         var _loc62_:Boolean = false;
         var _loc63_:* = null as ZPP_Callback;
         var _loc64_:* = null as ZPP_Interactor;
         var _loc65_:* = null as ZPP_Interactor;
         var _loc66_:* = null as ZPP_OptionType;
         var _loc67_:* = null as ZNPList_ZPP_CbType;
         var _loc68_:* = null as PreFlag;
         var _loc69_:* = null as ZPP_FluidArbiter;
         var _loc70_:* = null as ZNPList_ZPP_ColArbiter;
         var _loc71_:* = null as ZPP_ColArbiter;
         var _loc72_:Number = NaN;
         var _loc73_:Number = NaN;
         var _loc74_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc75_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc76_:Boolean = false;
         var _loc77_:* = null as ZPP_Contact;
         var _loc78_:* = null as ZPP_IContact;
         var _loc79_:* = null as ZPP_IContact;
         var _loc80_:* = null as ZPP_Contact;
         var _loc81_:* = null as ZPP_Contact;
         var _loc82_:* = null as ZPP_Contact;
         var _loc83_:* = null as ZPP_Contact;
         var _loc84_:* = null as ZPP_Contact;
         var _loc85_:* = null as ZPP_IContact;
         var _loc86_:* = null as ZPP_IContact;
         var _loc87_:* = null as ZPP_IContact;
         var _loc88_:Boolean = false;
         var _loc89_:* = null as ZPP_ColArbiter;
         var _loc90_:* = null as ZPP_Edge;
         var _loc91_:* = null as ZPP_SensorArbiter;
         var _loc92_:* = null as ZNPList_ZPP_SensorArbiter;
         var _loc93_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc94_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc95_:* = null as ZPP_SensorArbiter;
         var _loc6_:ZPP_Space = this;
         var _loc7_:ZPP_Arbiter = null;
         var _loc8_:ZPP_Body = param1.body;
         var _loc9_:ZPP_Body = param2.body;
         _loc11_ = false;
         var _loc12_:ZNPNode_ZPP_Constraint = _loc8_.constraints.head;
         while(_loc12_ != null)
         {
            _loc13_ = _loc12_.elt;
            if(_loc13_.ignore && _loc13_.pair_exists(_loc8_.id,_loc9_.id))
            {
               _loc11_ = true;
               break;
            }
            _loc12_ = _loc12_.next;
         }
         var _loc10_:int = !_loc11_ && !§§pop() ? ((param1.sensorEnabled || param2.sensorEnabled) && ((_loc18_.sensorMask & _loc19_.sensorGroup) != 0 && (_loc19_.sensorMask & _loc18_.sensorGroup) != 0) ? 2 : ((param1.fluidEnabled || param2.fluidEnabled) && ((_loc18_.fluidMask & _loc19_.fluidGroup) != 0 && (_loc19_.fluidMask & _loc18_.fluidGroup) != 0) && !(_loc8_.imass == 0 && _loc9_.imass == 0 && _loc8_.iinertia == 0 && _loc9_.iinertia == 0) ? 0 : (_loc18_ = param1.filter, _loc19_ = param2.filter, (_loc18_.collisionMask & _loc19_.collisionGroup) != 0 && (_loc19_.collisionMask & _loc18_.collisionGroup) != 0 && !(_loc8_.imass == 0 && _loc9_.imass == 0 && _loc8_.iinertia == 0 && _loc9_.iinertia == 0) ? 1 : -1))) : -1;
         if(_loc10_ != -1)
         {
            if(param1.type > param2.type)
            {
               _loc20_ = param2;
               _loc21_ = param1;
            }
            else if(param1.type == param2.type)
            {
               if(param1.id < param2.id)
               {
                  _loc20_ = param1;
                  _loc21_ = param2;
               }
               else
               {
                  _loc21_ = param1;
                  _loc20_ = param2;
               }
            }
            else
            {
               _loc20_ = param1;
               _loc21_ = param2;
            }
            _loc11_ = _loc20_ == param2;
            if(_loc10_ == 0)
            {
               if(param4 == null)
               {
                  _loc23_ = null;
                  _loc24_ = _loc8_.arbiters.length < _loc9_.arbiters.length ? _loc8_ : _loc9_;
                  _loc25_ = _loc24_.arbiters.head;
                  while(_loc25_ != null)
                  {
                     _loc26_ = _loc25_.elt;
                     if(_loc26_.id == _loc20_.id && _loc26_.di == _loc21_.id)
                     {
                        _loc23_ = _loc26_;
                        break;
                     }
                     _loc25_ = _loc25_.next;
                  }
                  §§push(_loc23_);
               }
               else
               {
                  §§push(param4);
               }
               _loc22_ = §§pop();
               _loc17_ = _loc22_ == null;
               _loc28_ = false;
               if(_loc17_)
               {
                  if(ZPP_FluidArbiter.zpp_pool == null)
                  {
                     _loc27_ = new ZPP_FluidArbiter();
                  }
                  else
                  {
                     _loc27_ = ZPP_FluidArbiter.zpp_pool;
                     ZPP_FluidArbiter.zpp_pool = _loc27_.next;
                     _loc27_.next = null;
                  }
                  null;
               }
               else if(_loc22_.fluidarb == null)
               {
                  _loc22_.cleared = true;
                  _loc29_ = _loc22_.b1.arbiters;
                  _loc25_ = null;
                  _loc30_ = _loc29_.head;
                  _loc31_ = false;
                  while(_loc30_ != null)
                  {
                     if(_loc30_.elt == _loc22_)
                     {
                        if(_loc25_ == null)
                        {
                           _loc32_ = _loc29_.head;
                           _loc33_ = _loc32_.next;
                           _loc29_.head = _loc33_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc32_ = _loc25_.next;
                           _loc33_ = _loc32_.next;
                           _loc25_.next = _loc33_;
                           if(_loc33_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc34_ = _loc32_;
                        _loc34_.elt = null;
                        _loc34_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc34_;
                        _loc29_.modified = true;
                        --_loc29_.length;
                        _loc29_.pushmod = true;
                        _loc33_;
                        _loc31_ = true;
                        break;
                     }
                     _loc25_ = _loc30_;
                     _loc30_ = _loc30_.next;
                  }
                  _loc31_;
                  _loc29_ = _loc22_.b2.arbiters;
                  _loc25_ = null;
                  _loc30_ = _loc29_.head;
                  _loc31_ = false;
                  while(_loc30_ != null)
                  {
                     if(_loc30_.elt == _loc22_)
                     {
                        if(_loc25_ == null)
                        {
                           _loc32_ = _loc29_.head;
                           _loc33_ = _loc32_.next;
                           _loc29_.head = _loc33_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc32_ = _loc25_.next;
                           _loc33_ = _loc32_.next;
                           _loc25_.next = _loc33_;
                           if(_loc33_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc34_ = _loc32_;
                        _loc34_.elt = null;
                        _loc34_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc34_;
                        _loc29_.modified = true;
                        --_loc29_.length;
                        _loc29_.pushmod = true;
                        _loc33_;
                        _loc31_ = true;
                        break;
                     }
                     _loc25_ = _loc30_;
                     _loc30_ = _loc30_.next;
                  }
                  _loc31_;
                  if(_loc22_.pair != null)
                  {
                     _loc22_.pair.arb = null;
                     _loc22_.pair = null;
                  }
                  _loc22_.active = false;
                  f_arbiters.modified = true;
                  if(ZPP_FluidArbiter.zpp_pool == null)
                  {
                     _loc27_ = new ZPP_FluidArbiter();
                  }
                  else
                  {
                     _loc27_ = ZPP_FluidArbiter.zpp_pool;
                     ZPP_FluidArbiter.zpp_pool = _loc27_.next;
                     _loc27_.next = null;
                  }
                  null;
                  _loc27_.intchange = true;
                  _loc17_ = true;
                  _loc28_ = true;
               }
               else
               {
                  _loc27_ = _loc22_.fluidarb;
               }
               _loc35_ = ZPP_Flags.id_InteractionType_FLUID;
               if(_loc17_ || _loc27_.stamp != stamp || param5)
               {
                  _loc27_.stamp = stamp;
                  if(ZPP_Collide.flowCollide(_loc20_,_loc21_,_loc27_))
                  {
                     if(_loc17_)
                     {
                        _loc27_.b1 = param1.body;
                        _loc27_.ws1 = param1;
                        _loc27_.b2 = param2.body;
                        _loc27_.ws2 = param2;
                        _loc27_.id = _loc20_.id;
                        _loc27_.di = _loc21_.id;
                        _loc29_ = _loc27_.b1.arbiters;
                        if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                        {
                           _loc30_ = new ZNPNode_ZPP_Arbiter();
                        }
                        else
                        {
                           _loc30_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc30_.next;
                           _loc30_.next = null;
                        }
                        null;
                        _loc30_.elt = _loc27_;
                        _loc25_ = _loc30_;
                        _loc25_.next = _loc29_.head;
                        _loc29_.head = _loc25_;
                        _loc29_.modified = true;
                        ++_loc29_.length;
                        _loc27_;
                        _loc29_ = _loc27_.b2.arbiters;
                        if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                        {
                           _loc30_ = new ZNPNode_ZPP_Arbiter();
                        }
                        else
                        {
                           _loc30_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc30_.next;
                           _loc30_.next = null;
                        }
                        null;
                        _loc30_.elt = _loc27_;
                        _loc25_ = _loc30_;
                        _loc25_.next = _loc29_.head;
                        _loc29_.head = _loc25_;
                        _loc29_.modified = true;
                        ++_loc29_.length;
                        _loc27_;
                        _loc27_.active = true;
                        _loc27_.present = 0;
                        _loc27_.cleared = false;
                        _loc27_.sleeping = false;
                        _loc27_.fresh = false;
                        _loc27_.presentable = false;
                        _loc27_.nx = 0;
                        _loc27_.ny = 1;
                        _loc27_.dampx = 0;
                        _loc27_.dampy = 0;
                        _loc27_.adamp = 0;
                        _loc36_ = f_arbiters;
                        if(ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                        {
                           _loc38_ = new ZNPNode_ZPP_FluidArbiter();
                        }
                        else
                        {
                           _loc38_ = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                           ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc38_.next;
                           _loc38_.next = null;
                        }
                        null;
                        _loc38_.elt = _loc27_;
                        _loc37_ = _loc38_;
                        _loc37_.next = _loc36_.head;
                        _loc36_.head = _loc37_;
                        _loc36_.modified = true;
                        ++_loc36_.length;
                        _loc27_;
                        _loc27_.fresh = !_loc28_;
                     }
                     else
                     {
                        _loc27_.fresh = _loc27_.up_stamp < stamp - 1 || _loc27_.endGenerated == stamp && param5;
                     }
                     _loc27_.up_stamp = _loc27_.stamp;
                     if(_loc27_.fresh || (_loc27_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                     {
                        _loc27_.immState = ZPP_Flags.id_ImmState_ACCEPT;
                        _loc31_ = false;
                        _loc39_ = mrca1;
                        while(_loc39_.head != null)
                        {
                           _loc40_ = _loc39_.head;
                           _loc39_.head = _loc40_.next;
                           _loc41_ = _loc40_;
                           _loc41_.elt = null;
                           _loc41_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc41_;
                           if(_loc39_.head == null)
                           {
                              _loc39_.pushmod = true;
                           }
                           _loc39_.modified = true;
                           --_loc39_.length;
                        }
                        _loc39_.pushmod = true;
                        _loc39_ = mrca2;
                        while(_loc39_.head != null)
                        {
                           _loc40_ = _loc39_.head;
                           _loc39_.head = _loc40_.next;
                           _loc41_ = _loc40_;
                           _loc41_.elt = null;
                           _loc41_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc41_;
                           if(_loc39_.head == null)
                           {
                              _loc39_.pushmod = true;
                           }
                           _loc39_.modified = true;
                           --_loc39_.length;
                        }
                        _loc39_.pushmod = true;
                        if(param1.cbSet != null)
                        {
                           _loc39_ = mrca1;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = param1;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           param1;
                        }
                        if(param1.body.cbSet != null)
                        {
                           _loc39_ = mrca1;
                           _loc15_ = param1.body;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = _loc15_;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc15_;
                        }
                        if(param2.cbSet != null)
                        {
                           _loc39_ = mrca2;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = param2;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           param2;
                        }
                        if(param2.body.cbSet != null)
                        {
                           _loc39_ = mrca2;
                           _loc15_ = param2.body;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = _loc15_;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc15_;
                        }
                        _loc42_ = param1.body.compound;
                        _loc43_ = param2.body.compound;
                        while(_loc42_ != _loc43_)
                        {
                           _loc44_ = _loc42_ == null ? 0 : _loc42_.depth;
                           _loc45_ = _loc43_ == null ? 0 : _loc43_.depth;
                           if(_loc44_ < _loc45_)
                           {
                              if(_loc43_.cbSet != null)
                              {
                                 _loc39_ = mrca2;
                                 if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                                 {
                                    _loc41_ = new ZNPNode_ZPP_Interactor();
                                 }
                                 else
                                 {
                                    _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                                    _loc41_.next = null;
                                 }
                                 null;
                                 _loc41_.elt = _loc43_;
                                 _loc40_ = _loc41_;
                                 _loc40_.next = _loc39_.head;
                                 _loc39_.head = _loc40_;
                                 _loc39_.modified = true;
                                 ++_loc39_.length;
                                 _loc43_;
                              }
                              _loc43_ = _loc43_.compound;
                           }
                           else
                           {
                              if(_loc42_.cbSet != null)
                              {
                                 _loc39_ = mrca1;
                                 if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                                 {
                                    _loc41_ = new ZNPNode_ZPP_Interactor();
                                 }
                                 else
                                 {
                                    _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                                    _loc41_.next = null;
                                 }
                                 null;
                                 _loc41_.elt = _loc42_;
                                 _loc40_ = _loc41_;
                                 _loc40_.next = _loc39_.head;
                                 _loc39_.head = _loc40_;
                                 _loc39_.modified = true;
                                 ++_loc39_.length;
                                 _loc42_;
                              }
                              _loc42_ = _loc42_.compound;
                           }
                        }
                        _loc40_ = mrca1.head;
                        while(_loc40_ != null)
                        {
                           _loc15_ = _loc40_.elt;
                           _loc41_ = mrca2.head;
                           while(_loc41_ != null)
                           {
                              _loc46_ = _loc41_.elt;
                              _loc47_ = _loc15_.cbSet;
                              _loc48_ = _loc46_.cbSet;
                              _loc49_ = null;
                              _loc50_ = _loc47_.cbpairs.length < _loc48_.cbpairs.length ? _loc47_.cbpairs : _loc48_.cbpairs;
                              _loc51_ = _loc50_.head;
                              while(_loc51_ != null)
                              {
                                 _loc52_ = _loc51_.elt;
                                 if(_loc52_.a == _loc47_ && _loc52_.b == _loc48_ || _loc52_.a == _loc48_ && _loc52_.b == _loc47_)
                                 {
                                    _loc49_ = _loc52_;
                                    break;
                                 }
                                 _loc51_ = _loc51_.next;
                              }
                              if(_loc49_ == null)
                              {
                                 if(ZPP_CbSetPair.zpp_pool == null)
                                 {
                                    _loc52_ = new ZPP_CbSetPair();
                                 }
                                 else
                                 {
                                    _loc52_ = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc52_.next;
                                    _loc52_.next = null;
                                 }
                                 _loc52_.zip_listeners = true;
                                 if(ZPP_CbSet.setlt(_loc47_,_loc48_))
                                 {
                                    _loc52_.a = _loc47_;
                                    _loc52_.b = _loc48_;
                                 }
                                 else
                                 {
                                    _loc52_.a = _loc48_;
                                    _loc52_.b = _loc47_;
                                 }
                                 _loc49_ = _loc52_;
                                 _loc47_.cbpairs.add(_loc49_);
                                 if(_loc48_ != _loc47_)
                                 {
                                    _loc48_.cbpairs.add(_loc49_);
                                 }
                              }
                              if(_loc49_.zip_listeners)
                              {
                                 _loc49_.zip_listeners = false;
                                 _loc49_.__validate();
                              }
                              if(_loc49_.listeners.head == null)
                              {
                                 _loc41_ = _loc41_.next;
                              }
                              else
                              {
                                 _loc53_ = null;
                                 _loc54_ = null;
                                 _loc55_ = prelisteners;
                                 while(_loc55_.head != null)
                                 {
                                    _loc56_ = _loc55_.head;
                                    _loc55_.head = _loc56_.next;
                                    _loc57_ = _loc56_;
                                    _loc57_.elt = null;
                                    _loc57_.next = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                    ZNPNode_ZPP_InteractionListener.zpp_pool = _loc57_;
                                    if(_loc55_.head == null)
                                    {
                                       _loc55_.pushmod = true;
                                    }
                                    _loc55_.modified = true;
                                    --_loc55_.length;
                                 }
                                 _loc55_.pushmod = true;
                                 _loc56_ = null;
                                 _loc44_ = ZPP_Flags.id_CbEvent_PRE;
                                 _loc49_ = null;
                                 _loc50_ = _loc47_.cbpairs.length < _loc48_.cbpairs.length ? _loc47_.cbpairs : _loc48_.cbpairs;
                                 _loc51_ = _loc50_.head;
                                 while(_loc51_ != null)
                                 {
                                    _loc52_ = _loc51_.elt;
                                    if(_loc52_.a == _loc47_ && _loc52_.b == _loc48_ || _loc52_.a == _loc48_ && _loc52_.b == _loc47_)
                                    {
                                       _loc49_ = _loc52_;
                                       break;
                                    }
                                    _loc51_ = _loc51_.next;
                                 }
                                 if(_loc49_ == null)
                                 {
                                    if(ZPP_CbSetPair.zpp_pool == null)
                                    {
                                       _loc52_ = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                       _loc52_ = ZPP_CbSetPair.zpp_pool;
                                       ZPP_CbSetPair.zpp_pool = _loc52_.next;
                                       _loc52_.next = null;
                                    }
                                    _loc52_.zip_listeners = true;
                                    if(ZPP_CbSet.setlt(_loc47_,_loc48_))
                                    {
                                       _loc52_.a = _loc47_;
                                       _loc52_.b = _loc48_;
                                    }
                                    else
                                    {
                                       _loc52_.a = _loc48_;
                                       _loc52_.b = _loc47_;
                                    }
                                    _loc49_ = _loc52_;
                                    _loc47_.cbpairs.add(_loc49_);
                                    if(_loc48_ != _loc47_)
                                    {
                                       _loc48_.cbpairs.add(_loc49_);
                                    }
                                 }
                                 if(_loc49_.zip_listeners)
                                 {
                                    _loc49_.zip_listeners = false;
                                    _loc49_.__validate();
                                 }
                                 _loc57_ = _loc49_.listeners.head;
                                 while(_loc57_ != null)
                                 {
                                    _loc58_ = _loc57_.elt;
                                    if(_loc58_.event == _loc44_)
                                    {
                                       if((_loc58_.itype & _loc35_) != 0)
                                       {
                                          _loc55_ = _loc6_.prelisteners;
                                          if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                                          {
                                             _loc60_ = new ZNPNode_ZPP_InteractionListener();
                                          }
                                          else
                                          {
                                             _loc60_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                             ZNPNode_ZPP_InteractionListener.zpp_pool = _loc60_.next;
                                             _loc60_.next = null;
                                          }
                                          null;
                                          _loc60_.elt = _loc58_;
                                          _loc59_ = _loc60_;
                                          if(_loc56_ == null)
                                          {
                                             _loc59_.next = _loc55_.head;
                                             _loc55_.head = _loc59_;
                                          }
                                          else
                                          {
                                             _loc59_.next = _loc56_.next;
                                             _loc56_.next = _loc59_;
                                          }
                                          _loc55_.pushmod = _loc55_.modified = true;
                                          ++_loc55_.length;
                                          _loc56_ = _loc59_;
                                          _loc31_ ||= !_loc58_.pure;
                                       }
                                    }
                                    _loc57_ = _loc57_.next;
                                 }
                                 if(prelisteners.head == null)
                                 {
                                    _loc41_ = _loc41_.next;
                                 }
                                 else
                                 {
                                    _loc53_ = ZPP_Interactor.get(_loc15_,_loc46_);
                                    if(_loc53_ == null)
                                    {
                                       _loc54_ = ZPP_CallbackSet.get(_loc15_,_loc46_);
                                       add_callbackset(_loc54_);
                                    }
                                    if(_loc53_ == null || (_loc53_.FLUIDstamp != stamp || param5) && (_loc53_.FLUIDstate & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                    {
                                       if(_loc54_ != null)
                                       {
                                          _loc53_ = _loc54_;
                                       }
                                       if(_loc53_ != null)
                                       {
                                          _loc57_ = prelisteners.head;
                                          while(_loc57_ != null)
                                          {
                                             _loc58_ = _loc57_.elt;
                                             if(_loc58_.itype == ZPP_Flags.id_InteractionType_ANY)
                                             {
                                                _loc53_.COLLISIONstamp = stamp;
                                                _loc53_.SENSORstamp = stamp;
                                                _loc53_.FLUIDstamp = stamp;
                                             }
                                             else
                                             {
                                                _loc53_.FLUIDstamp = stamp;
                                             }
                                             _loc57_ = _loc57_.next;
                                          }
                                       }
                                       _loc27_.mutable = true;
                                       if(_loc27_.wrap_position != null)
                                       {
                                          _loc27_.wrap_position.zpp_inner._immutable = false;
                                       }
                                       _loc61_ = _loc27_.active;
                                       _loc27_.active = true;
                                       _loc62_ = false;
                                       precb.zpp_inner.pre_arbiter = _loc27_;
                                       precb.zpp_inner.set = _loc53_;
                                       _loc57_ = prelisteners.head;
                                       while(_loc57_ != null)
                                       {
                                          _loc58_ = _loc57_.elt;
                                          precb.zpp_inner.listener = _loc58_;
                                          _loc63_ = precb.zpp_inner;
                                          _loc64_ = _loc53_.int1;
                                          _loc65_ = _loc53_.int2;
                                          _loc66_ = _loc58_.options1;
                                          _loc67_ = _loc64_.cbTypes;
                                          if(_loc66_.nonemptyintersection(_loc67_,_loc66_.includes) && !_loc66_.nonemptyintersection(_loc67_,_loc66_.excludes) && (_loc66_.nonemptyintersection(_loc67_,_loc66_.includes) && !_loc66_.nonemptyintersection(_loc67_,_loc66_.excludes)))
                                          {
                                             _loc63_.int1 = _loc64_;
                                             _loc63_.int2 = _loc65_;
                                          }
                                          else
                                          {
                                             _loc63_.int1 = _loc65_;
                                             _loc63_.int2 = _loc64_;
                                          }
                                          precb.zpp_inner.pre_swapped = _loc15_ != precb.zpp_inner.int1;
                                          _loc68_ = _loc58_.handlerp(precb);
                                          if(_loc68_ != null)
                                          {
                                             §§push(_loc27_);
                                             §§push(_loc68_);
                                             if(ZPP_Flags.PreFlag_ACCEPT == null)
                                             {
                                                ZPP_Flags.§internal§ = true;
                                                ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                                                ZPP_Flags.§internal§ = false;
                                             }
                                             if(§§pop() == ZPP_Flags.PreFlag_ACCEPT)
                                             {
                                                §§push(ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS);
                                             }
                                             else
                                             {
                                                §§push(_loc68_);
                                                if(ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                                                {
                                                   ZPP_Flags.§internal§ = true;
                                                   ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                                                   ZPP_Flags.§internal§ = false;
                                                }
                                                if(§§pop() == ZPP_Flags.PreFlag_ACCEPT_ONCE)
                                                {
                                                   §§push(ZPP_Flags.id_ImmState_ACCEPT);
                                                }
                                                else
                                                {
                                                   §§push(_loc68_);
                                                   if(ZPP_Flags.PreFlag_IGNORE == null)
                                                   {
                                                      ZPP_Flags.§internal§ = true;
                                                      ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                                                      ZPP_Flags.§internal§ = false;
                                                   }
                                                   §§push(§§pop() == ZPP_Flags.PreFlag_IGNORE ? ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS : ZPP_Flags.id_ImmState_IGNORE);
                                                }
                                             }
                                             §§pop().immState = §§pop();
                                          }
                                          _loc57_ = _loc57_.next;
                                       }
                                       _loc27_.mutable = false;
                                       if(_loc27_.wrap_position != null)
                                       {
                                          _loc27_.wrap_position.zpp_inner._immutable = true;
                                       }
                                       _loc27_.active = _loc61_;
                                       if(_loc53_ != null)
                                       {
                                          _loc57_ = prelisteners.head;
                                          while(_loc57_ != null)
                                          {
                                             _loc58_ = _loc57_.elt;
                                             if(_loc58_.itype == ZPP_Flags.id_InteractionType_ANY)
                                             {
                                                _loc53_.COLLISIONstate = _loc27_.immState;
                                                _loc53_.SENSORstate = _loc27_.immState;
                                                _loc53_.FLUIDstate = _loc27_.immState;
                                             }
                                             else
                                             {
                                                _loc53_.FLUIDstate = _loc27_.immState;
                                             }
                                             _loc57_ = _loc57_.next;
                                          }
                                       }
                                    }
                                    else if(_loc53_ == null)
                                    {
                                       if((_loc27_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                       {
                                          _loc27_.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                       }
                                    }
                                    else
                                    {
                                       _loc27_.immState = _loc53_.FLUIDstate;
                                    }
                                    _loc41_ = _loc41_.next;
                                 }
                              }
                           }
                           _loc40_ = _loc40_.next;
                        }
                        if(_loc31_ && (_loc27_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                        {
                           if(_loc27_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                           {
                              _loc24_ = _loc27_.b1;
                              if(!_loc24_.world)
                              {
                                 _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                                 if(_loc24_.component.sleeping)
                                 {
                                    really_wake(_loc24_,false);
                                 }
                              }
                           }
                           if(_loc27_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                           {
                              _loc24_ = _loc27_.b2;
                              if(!_loc24_.world)
                              {
                                 _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                                 if(_loc24_.component.sleeping)
                                 {
                                    really_wake(_loc24_,false);
                                 }
                              }
                           }
                        }
                     }
                     if((_loc27_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                     {
                        if(_loc27_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc27_.b1.component.sleeping)
                        {
                           _loc24_ = _loc27_.b1;
                           if(!_loc24_.world)
                           {
                              _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                              if(_loc24_.component.sleeping)
                              {
                                 really_wake(_loc24_,false);
                              }
                           }
                        }
                        if(_loc27_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc27_.b2.component.sleeping)
                        {
                           _loc24_ = _loc27_.b2;
                           if(!_loc24_.world)
                           {
                              _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                              if(_loc24_.component.sleeping)
                              {
                                 really_wake(_loc24_,false);
                              }
                           }
                        }
                     }
                     if(_loc27_.sleeping)
                     {
                        _loc27_.sleeping = false;
                        _loc36_ = f_arbiters;
                        if(ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                        {
                           _loc38_ = new ZNPNode_ZPP_FluidArbiter();
                        }
                        else
                        {
                           _loc38_ = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                           ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc38_.next;
                           _loc38_.next = null;
                        }
                        null;
                        _loc38_.elt = _loc27_;
                        _loc37_ = _loc38_;
                        _loc37_.next = _loc36_.head;
                        _loc36_.head = _loc37_;
                        _loc36_.modified = true;
                        ++_loc36_.length;
                        _loc27_;
                     }
                     §§push(_loc27_);
                  }
                  else
                  {
                     §§push(_loc17_ ? (_loc69_ = _loc27_, _loc69_.next = ZPP_FluidArbiter.zpp_pool, ZPP_FluidArbiter.zpp_pool = _loc69_, null) : _loc27_);
                  }
               }
               else
               {
                  §§push(_loc27_);
               }
               _loc7_ = §§pop();
            }
            else if(_loc10_ == 1)
            {
               _loc70_ = param3 ? c_arbiters_true : c_arbiters_false;
               if(param4 == null)
               {
                  _loc23_ = null;
                  _loc24_ = _loc8_.arbiters.length < _loc9_.arbiters.length ? _loc8_ : _loc9_;
                  _loc25_ = _loc24_.arbiters.head;
                  while(_loc25_ != null)
                  {
                     _loc26_ = _loc25_.elt;
                     if(_loc26_.id == _loc20_.id && _loc26_.di == _loc21_.id)
                     {
                        _loc23_ = _loc26_;
                        break;
                     }
                     _loc25_ = _loc25_.next;
                  }
                  §§push(_loc23_);
               }
               else
               {
                  §§push(param4);
               }
               _loc22_ = §§pop();
               _loc17_ = _loc22_ == null;
               _loc28_ = false;
               if(_loc17_)
               {
                  if(ZPP_ColArbiter.zpp_pool == null)
                  {
                     _loc71_ = new ZPP_ColArbiter();
                  }
                  else
                  {
                     _loc71_ = ZPP_ColArbiter.zpp_pool;
                     ZPP_ColArbiter.zpp_pool = _loc71_.next;
                     _loc71_.next = null;
                  }
                  null;
                  _loc71_.stat = param3;
               }
               else if(_loc22_.colarb == null)
               {
                  _loc22_.cleared = true;
                  _loc29_ = _loc22_.b1.arbiters;
                  _loc25_ = null;
                  _loc30_ = _loc29_.head;
                  _loc31_ = false;
                  while(_loc30_ != null)
                  {
                     if(_loc30_.elt == _loc22_)
                     {
                        if(_loc25_ == null)
                        {
                           _loc32_ = _loc29_.head;
                           _loc33_ = _loc32_.next;
                           _loc29_.head = _loc33_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc32_ = _loc25_.next;
                           _loc33_ = _loc32_.next;
                           _loc25_.next = _loc33_;
                           if(_loc33_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc34_ = _loc32_;
                        _loc34_.elt = null;
                        _loc34_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc34_;
                        _loc29_.modified = true;
                        --_loc29_.length;
                        _loc29_.pushmod = true;
                        _loc33_;
                        _loc31_ = true;
                        break;
                     }
                     _loc25_ = _loc30_;
                     _loc30_ = _loc30_.next;
                  }
                  _loc31_;
                  _loc29_ = _loc22_.b2.arbiters;
                  _loc25_ = null;
                  _loc30_ = _loc29_.head;
                  _loc31_ = false;
                  while(_loc30_ != null)
                  {
                     if(_loc30_.elt == _loc22_)
                     {
                        if(_loc25_ == null)
                        {
                           _loc32_ = _loc29_.head;
                           _loc33_ = _loc32_.next;
                           _loc29_.head = _loc33_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc32_ = _loc25_.next;
                           _loc33_ = _loc32_.next;
                           _loc25_.next = _loc33_;
                           if(_loc33_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc34_ = _loc32_;
                        _loc34_.elt = null;
                        _loc34_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc34_;
                        _loc29_.modified = true;
                        --_loc29_.length;
                        _loc29_.pushmod = true;
                        _loc33_;
                        _loc31_ = true;
                        break;
                     }
                     _loc25_ = _loc30_;
                     _loc30_ = _loc30_.next;
                  }
                  _loc31_;
                  if(_loc22_.pair != null)
                  {
                     _loc22_.pair.arb = null;
                     _loc22_.pair = null;
                  }
                  _loc22_.active = false;
                  f_arbiters.modified = true;
                  if(ZPP_ColArbiter.zpp_pool == null)
                  {
                     _loc71_ = new ZPP_ColArbiter();
                  }
                  else
                  {
                     _loc71_ = ZPP_ColArbiter.zpp_pool;
                     ZPP_ColArbiter.zpp_pool = _loc71_.next;
                     _loc71_.next = null;
                  }
                  null;
                  _loc71_.intchange = true;
                  _loc71_.stat = param3;
                  _loc17_ = true;
                  _loc28_ = true;
               }
               else
               {
                  _loc71_ = _loc22_.colarb;
                  _loc11_ = _loc20_ != _loc71_.s1;
                  if(_loc71_.stat != param3)
                  {
                     _loc71_.stat = param3;
                     if(!_loc71_.sleeping)
                     {
                        (param3 ? c_arbiters_false : c_arbiters_true).remove(_loc71_);
                        _loc70_.add(_loc71_);
                     }
                  }
               }
               _loc35_ = ZPP_Flags.id_InteractionType_COLLISION;
               if(_loc17_ || _loc71_.stamp != stamp || param5)
               {
                  _loc71_.stamp = stamp;
                  if(ZPP_Collide.contactCollide(_loc20_,_loc21_,_loc71_,_loc11_))
                  {
                     if(_loc17_)
                     {
                        _loc71_.b1 = param1.body;
                        _loc71_.ws1 = param1;
                        _loc71_.b2 = param2.body;
                        _loc71_.ws2 = param2;
                        _loc71_.id = _loc20_.id;
                        _loc71_.di = _loc21_.id;
                        _loc29_ = _loc71_.b1.arbiters;
                        if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                        {
                           _loc30_ = new ZNPNode_ZPP_Arbiter();
                        }
                        else
                        {
                           _loc30_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc30_.next;
                           _loc30_.next = null;
                        }
                        null;
                        _loc30_.elt = _loc71_;
                        _loc25_ = _loc30_;
                        _loc25_.next = _loc29_.head;
                        _loc29_.head = _loc25_;
                        _loc29_.modified = true;
                        ++_loc29_.length;
                        _loc71_;
                        _loc29_ = _loc71_.b2.arbiters;
                        if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                        {
                           _loc30_ = new ZNPNode_ZPP_Arbiter();
                        }
                        else
                        {
                           _loc30_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc30_.next;
                           _loc30_.next = null;
                        }
                        null;
                        _loc30_.elt = _loc71_;
                        _loc25_ = _loc30_;
                        _loc25_.next = _loc29_.head;
                        _loc29_.head = _loc25_;
                        _loc29_.modified = true;
                        ++_loc29_.length;
                        _loc71_;
                        _loc71_.active = true;
                        _loc71_.present = 0;
                        _loc71_.cleared = false;
                        _loc71_.sleeping = false;
                        _loc71_.fresh = false;
                        _loc71_.presentable = false;
                        _loc71_.s1 = param1;
                        _loc71_.s2 = param2;
                        if(!_loc71_.userdef_restitution)
                        {
                           if(_loc71_.s1.material.elasticity <= -1.79e+308 || _loc71_.s2.material.elasticity <= -1.79e+308)
                           {
                              _loc71_.restitution = 0;
                           }
                           else if(_loc71_.s1.material.elasticity >= 1.79e+308 || _loc71_.s2.material.elasticity >= 1.79e+308)
                           {
                              _loc71_.restitution = 1;
                           }
                           else
                           {
                              _loc71_.restitution = (_loc71_.s1.material.elasticity + _loc71_.s2.material.elasticity) / 2;
                           }
                           if(_loc71_.restitution < 0)
                           {
                              _loc71_.restitution = 0;
                           }
                           if(_loc71_.restitution > 1)
                           {
                              _loc71_.restitution = 1;
                           }
                        }
                        if(!_loc71_.userdef_dyn_fric)
                        {
                           _loc72_ = _loc71_.s1.material.dynamicFriction * _loc71_.s2.material.dynamicFriction;
                           _loc71_.dyn_fric = _loc72_ == 0 ? 0 : (sf32(_loc72_,0), si32(1597463007 - (li32(0) >> 1),0), _loc73_ = lf32(0), 1 / (_loc73_ * (1.5 - 0.5 * _loc72_ * _loc73_ * _loc73_)));
                        }
                        if(!_loc71_.userdef_stat_fric)
                        {
                           _loc72_ = _loc71_.s1.material.staticFriction * _loc71_.s2.material.staticFriction;
                           _loc71_.stat_fric = _loc72_ == 0 ? 0 : (sf32(_loc72_,0), si32(1597463007 - (li32(0) >> 1),0), _loc73_ = lf32(0), 1 / (_loc73_ * (1.5 - 0.5 * _loc72_ * _loc73_ * _loc73_)));
                        }
                        if(!_loc71_.userdef_rfric)
                        {
                           _loc72_ = _loc71_.s1.material.rollingFriction * _loc71_.s2.material.rollingFriction;
                           _loc71_.rfric = _loc72_ == 0 ? 0 : (sf32(_loc72_,0), si32(1597463007 - (li32(0) >> 1),0), _loc73_ = lf32(0), 1 / (_loc73_ * (1.5 - 0.5 * _loc72_ * _loc73_ * _loc73_)));
                        }
                        if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                        {
                           _loc75_ = new ZNPNode_ZPP_ColArbiter();
                        }
                        else
                        {
                           _loc75_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                           ZNPNode_ZPP_ColArbiter.zpp_pool = _loc75_.next;
                           _loc75_.next = null;
                        }
                        null;
                        _loc75_.elt = _loc71_;
                        _loc74_ = _loc75_;
                        _loc74_.next = _loc70_.head;
                        _loc70_.head = _loc74_;
                        _loc70_.modified = true;
                        ++_loc70_.length;
                        _loc71_;
                        _loc71_.fresh = !_loc28_;
                     }
                     else
                     {
                        _loc71_.fresh = _loc71_.up_stamp < stamp - 1 || _loc71_.endGenerated == stamp && param5;
                     }
                     _loc71_.up_stamp = _loc71_.stamp;
                     if(_loc71_.fresh || (_loc71_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                     {
                        _loc71_.immState = ZPP_Flags.id_ImmState_ACCEPT;
                        _loc31_ = false;
                        _loc39_ = mrca1;
                        while(_loc39_.head != null)
                        {
                           _loc40_ = _loc39_.head;
                           _loc39_.head = _loc40_.next;
                           _loc41_ = _loc40_;
                           _loc41_.elt = null;
                           _loc41_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc41_;
                           if(_loc39_.head == null)
                           {
                              _loc39_.pushmod = true;
                           }
                           _loc39_.modified = true;
                           --_loc39_.length;
                        }
                        _loc39_.pushmod = true;
                        _loc39_ = mrca2;
                        while(_loc39_.head != null)
                        {
                           _loc40_ = _loc39_.head;
                           _loc39_.head = _loc40_.next;
                           _loc41_ = _loc40_;
                           _loc41_.elt = null;
                           _loc41_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc41_;
                           if(_loc39_.head == null)
                           {
                              _loc39_.pushmod = true;
                           }
                           _loc39_.modified = true;
                           --_loc39_.length;
                        }
                        _loc39_.pushmod = true;
                        if(param1.cbSet != null)
                        {
                           _loc39_ = mrca1;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = param1;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           param1;
                        }
                        if(param1.body.cbSet != null)
                        {
                           _loc39_ = mrca1;
                           _loc15_ = param1.body;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = _loc15_;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc15_;
                        }
                        if(param2.cbSet != null)
                        {
                           _loc39_ = mrca2;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = param2;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           param2;
                        }
                        if(param2.body.cbSet != null)
                        {
                           _loc39_ = mrca2;
                           _loc15_ = param2.body;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = _loc15_;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc15_;
                        }
                        _loc42_ = param1.body.compound;
                        _loc43_ = param2.body.compound;
                        while(_loc42_ != _loc43_)
                        {
                           _loc44_ = _loc42_ == null ? 0 : _loc42_.depth;
                           _loc45_ = _loc43_ == null ? 0 : _loc43_.depth;
                           if(_loc44_ < _loc45_)
                           {
                              if(_loc43_.cbSet != null)
                              {
                                 _loc39_ = mrca2;
                                 if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                                 {
                                    _loc41_ = new ZNPNode_ZPP_Interactor();
                                 }
                                 else
                                 {
                                    _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                                    _loc41_.next = null;
                                 }
                                 null;
                                 _loc41_.elt = _loc43_;
                                 _loc40_ = _loc41_;
                                 _loc40_.next = _loc39_.head;
                                 _loc39_.head = _loc40_;
                                 _loc39_.modified = true;
                                 ++_loc39_.length;
                                 _loc43_;
                              }
                              _loc43_ = _loc43_.compound;
                           }
                           else
                           {
                              if(_loc42_.cbSet != null)
                              {
                                 _loc39_ = mrca1;
                                 if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                                 {
                                    _loc41_ = new ZNPNode_ZPP_Interactor();
                                 }
                                 else
                                 {
                                    _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                                    _loc41_.next = null;
                                 }
                                 null;
                                 _loc41_.elt = _loc42_;
                                 _loc40_ = _loc41_;
                                 _loc40_.next = _loc39_.head;
                                 _loc39_.head = _loc40_;
                                 _loc39_.modified = true;
                                 ++_loc39_.length;
                                 _loc42_;
                              }
                              _loc42_ = _loc42_.compound;
                           }
                        }
                        _loc40_ = mrca1.head;
                        while(_loc40_ != null)
                        {
                           _loc15_ = _loc40_.elt;
                           _loc41_ = mrca2.head;
                           while(_loc41_ != null)
                           {
                              _loc46_ = _loc41_.elt;
                              _loc47_ = _loc15_.cbSet;
                              _loc48_ = _loc46_.cbSet;
                              _loc49_ = null;
                              _loc50_ = _loc47_.cbpairs.length < _loc48_.cbpairs.length ? _loc47_.cbpairs : _loc48_.cbpairs;
                              _loc51_ = _loc50_.head;
                              while(_loc51_ != null)
                              {
                                 _loc52_ = _loc51_.elt;
                                 if(_loc52_.a == _loc47_ && _loc52_.b == _loc48_ || _loc52_.a == _loc48_ && _loc52_.b == _loc47_)
                                 {
                                    _loc49_ = _loc52_;
                                    break;
                                 }
                                 _loc51_ = _loc51_.next;
                              }
                              if(_loc49_ == null)
                              {
                                 if(ZPP_CbSetPair.zpp_pool == null)
                                 {
                                    _loc52_ = new ZPP_CbSetPair();
                                 }
                                 else
                                 {
                                    _loc52_ = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc52_.next;
                                    _loc52_.next = null;
                                 }
                                 _loc52_.zip_listeners = true;
                                 if(ZPP_CbSet.setlt(_loc47_,_loc48_))
                                 {
                                    _loc52_.a = _loc47_;
                                    _loc52_.b = _loc48_;
                                 }
                                 else
                                 {
                                    _loc52_.a = _loc48_;
                                    _loc52_.b = _loc47_;
                                 }
                                 _loc49_ = _loc52_;
                                 _loc47_.cbpairs.add(_loc49_);
                                 if(_loc48_ != _loc47_)
                                 {
                                    _loc48_.cbpairs.add(_loc49_);
                                 }
                              }
                              if(_loc49_.zip_listeners)
                              {
                                 _loc49_.zip_listeners = false;
                                 _loc49_.__validate();
                              }
                              if(_loc49_.listeners.head == null)
                              {
                                 _loc41_ = _loc41_.next;
                              }
                              else
                              {
                                 _loc53_ = null;
                                 _loc54_ = null;
                                 _loc55_ = prelisteners;
                                 while(_loc55_.head != null)
                                 {
                                    _loc56_ = _loc55_.head;
                                    _loc55_.head = _loc56_.next;
                                    _loc57_ = _loc56_;
                                    _loc57_.elt = null;
                                    _loc57_.next = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                    ZNPNode_ZPP_InteractionListener.zpp_pool = _loc57_;
                                    if(_loc55_.head == null)
                                    {
                                       _loc55_.pushmod = true;
                                    }
                                    _loc55_.modified = true;
                                    --_loc55_.length;
                                 }
                                 _loc55_.pushmod = true;
                                 _loc56_ = null;
                                 _loc44_ = ZPP_Flags.id_CbEvent_PRE;
                                 _loc49_ = null;
                                 _loc50_ = _loc47_.cbpairs.length < _loc48_.cbpairs.length ? _loc47_.cbpairs : _loc48_.cbpairs;
                                 _loc51_ = _loc50_.head;
                                 while(_loc51_ != null)
                                 {
                                    _loc52_ = _loc51_.elt;
                                    if(_loc52_.a == _loc47_ && _loc52_.b == _loc48_ || _loc52_.a == _loc48_ && _loc52_.b == _loc47_)
                                    {
                                       _loc49_ = _loc52_;
                                       break;
                                    }
                                    _loc51_ = _loc51_.next;
                                 }
                                 if(_loc49_ == null)
                                 {
                                    if(ZPP_CbSetPair.zpp_pool == null)
                                    {
                                       _loc52_ = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                       _loc52_ = ZPP_CbSetPair.zpp_pool;
                                       ZPP_CbSetPair.zpp_pool = _loc52_.next;
                                       _loc52_.next = null;
                                    }
                                    _loc52_.zip_listeners = true;
                                    if(ZPP_CbSet.setlt(_loc47_,_loc48_))
                                    {
                                       _loc52_.a = _loc47_;
                                       _loc52_.b = _loc48_;
                                    }
                                    else
                                    {
                                       _loc52_.a = _loc48_;
                                       _loc52_.b = _loc47_;
                                    }
                                    _loc49_ = _loc52_;
                                    _loc47_.cbpairs.add(_loc49_);
                                    if(_loc48_ != _loc47_)
                                    {
                                       _loc48_.cbpairs.add(_loc49_);
                                    }
                                 }
                                 if(_loc49_.zip_listeners)
                                 {
                                    _loc49_.zip_listeners = false;
                                    _loc49_.__validate();
                                 }
                                 _loc57_ = _loc49_.listeners.head;
                                 while(_loc57_ != null)
                                 {
                                    _loc58_ = _loc57_.elt;
                                    if(_loc58_.event == _loc44_)
                                    {
                                       if((_loc58_.itype & _loc35_) != 0)
                                       {
                                          _loc55_ = _loc6_.prelisteners;
                                          if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                                          {
                                             _loc60_ = new ZNPNode_ZPP_InteractionListener();
                                          }
                                          else
                                          {
                                             _loc60_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                             ZNPNode_ZPP_InteractionListener.zpp_pool = _loc60_.next;
                                             _loc60_.next = null;
                                          }
                                          null;
                                          _loc60_.elt = _loc58_;
                                          _loc59_ = _loc60_;
                                          if(_loc56_ == null)
                                          {
                                             _loc59_.next = _loc55_.head;
                                             _loc55_.head = _loc59_;
                                          }
                                          else
                                          {
                                             _loc59_.next = _loc56_.next;
                                             _loc56_.next = _loc59_;
                                          }
                                          _loc55_.pushmod = _loc55_.modified = true;
                                          ++_loc55_.length;
                                          _loc56_ = _loc59_;
                                          _loc31_ ||= !_loc58_.pure;
                                       }
                                    }
                                    _loc57_ = _loc57_.next;
                                 }
                                 if(prelisteners.head == null)
                                 {
                                    _loc41_ = _loc41_.next;
                                 }
                                 else
                                 {
                                    _loc53_ = ZPP_Interactor.get(_loc15_,_loc46_);
                                    if(_loc53_ == null)
                                    {
                                       _loc54_ = ZPP_CallbackSet.get(_loc15_,_loc46_);
                                       add_callbackset(_loc54_);
                                    }
                                    if(_loc53_ == null || (_loc53_.COLLISIONstamp != stamp || param5) && (_loc53_.COLLISIONstate & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                    {
                                       if(_loc54_ != null)
                                       {
                                          _loc53_ = _loc54_;
                                       }
                                       if(_loc53_ != null)
                                       {
                                          _loc57_ = prelisteners.head;
                                          while(_loc57_ != null)
                                          {
                                             _loc58_ = _loc57_.elt;
                                             if(_loc58_.itype == ZPP_Flags.id_InteractionType_ANY)
                                             {
                                                _loc53_.COLLISIONstamp = stamp;
                                                _loc53_.SENSORstamp = stamp;
                                                _loc53_.FLUIDstamp = stamp;
                                             }
                                             else
                                             {
                                                _loc53_.COLLISIONstamp = stamp;
                                             }
                                             _loc57_ = _loc57_.next;
                                          }
                                       }
                                       _loc71_.mutable = true;
                                       if(_loc71_.wrap_normal != null)
                                       {
                                          _loc71_.wrap_normal.zpp_inner._immutable = false;
                                       }
                                       if(_loc71_.wrap_contacts != null)
                                       {
                                          _loc71_.wrap_contacts.zpp_inner.immutable = false;
                                       }
                                       _loc61_ = _loc71_.active;
                                       _loc71_.active = true;
                                       _loc62_ = false;
                                       _loc76_ = true;
                                       _loc77_ = null;
                                       _loc78_ = null;
                                       _loc79_ = _loc71_.innards.next;
                                       _loc71_.hc2 = false;
                                       _loc80_ = _loc71_.contacts.next;
                                       while(_loc80_ != null)
                                       {
                                          _loc81_ = _loc80_;
                                          if(_loc81_.stamp + Config.arbiterExpirationDelay < _loc71_.stamp)
                                          {
                                             _loc82_ = _loc71_.contacts;
                                             if(_loc77_ == null)
                                             {
                                                _loc83_ = _loc82_.next;
                                                _loc84_ = _loc83_.next;
                                                _loc82_.next = _loc84_;
                                                if(_loc82_.next == null)
                                                {
                                                   _loc82_.pushmod = true;
                                                }
                                             }
                                             else
                                             {
                                                _loc83_ = _loc77_.next;
                                                _loc84_ = _loc83_.next;
                                                _loc77_.next = _loc84_;
                                                if(_loc84_ == null)
                                                {
                                                   _loc82_.pushmod = true;
                                                }
                                             }
                                             _loc83_._inuse = false;
                                             _loc82_.modified = true;
                                             --_loc82_.length;
                                             _loc82_.pushmod = true;
                                             _loc80_ = _loc84_;
                                             _loc85_ = _loc71_.innards;
                                             if(_loc78_ == null)
                                             {
                                                _loc86_ = _loc85_.next;
                                                _loc87_ = _loc86_.next;
                                                _loc85_.next = _loc87_;
                                                if(_loc85_.next == null)
                                                {
                                                   _loc85_.pushmod = true;
                                                }
                                             }
                                             else
                                             {
                                                _loc86_ = _loc78_.next;
                                                _loc87_ = _loc86_.next;
                                                _loc78_.next = _loc87_;
                                                if(_loc87_ == null)
                                                {
                                                   _loc85_.pushmod = true;
                                                }
                                             }
                                             _loc86_._inuse = false;
                                             _loc85_.modified = true;
                                             --_loc85_.length;
                                             _loc85_.pushmod = true;
                                             _loc79_ = _loc87_;
                                             _loc82_ = _loc81_;
                                             _loc82_.arbiter = null;
                                             _loc82_.next = ZPP_Contact.zpp_pool;
                                             ZPP_Contact.zpp_pool = _loc82_;
                                          }
                                          else
                                          {
                                             _loc85_ = _loc81_.inner;
                                             _loc88_ = _loc81_.active;
                                             _loc81_.active = _loc81_.stamp == _loc71_.stamp;
                                             if(_loc81_.active)
                                             {
                                                if(_loc76_)
                                                {
                                                   _loc76_ = false;
                                                   _loc71_.c1 = _loc85_;
                                                   _loc71_.oc1 = _loc81_;
                                                }
                                                else
                                                {
                                                   _loc71_.hc2 = true;
                                                   _loc71_.c2 = _loc85_;
                                                   _loc71_.oc2 = _loc81_;
                                                }
                                             }
                                             if(_loc88_ != _loc81_.active)
                                             {
                                                _loc71_.contacts.modified = true;
                                             }
                                             _loc77_ = _loc80_;
                                             _loc78_ = _loc79_;
                                             _loc79_ = _loc79_.next;
                                             _loc80_ = _loc80_.next;
                                          }
                                       }
                                       if(_loc71_.hc2)
                                       {
                                          _loc71_.hpc2 = true;
                                          if(_loc71_.oc1.posOnly)
                                          {
                                             _loc85_ = _loc71_.c1;
                                             _loc71_.c1 = _loc71_.c2;
                                             _loc71_.c2 = _loc85_;
                                             _loc80_ = _loc71_.oc1;
                                             _loc71_.oc1 = _loc71_.oc2;
                                             _loc71_.oc2 = _loc80_;
                                             _loc71_.hc2 = false;
                                          }
                                          else if(_loc71_.oc2.posOnly)
                                          {
                                             _loc71_.hc2 = false;
                                          }
                                          if(_loc71_.oc1.posOnly)
                                          {
                                             _loc76_ = true;
                                          }
                                       }
                                       else
                                       {
                                          _loc71_.hpc2 = false;
                                       }
                                       _loc76_;
                                       precb.zpp_inner.pre_arbiter = _loc71_;
                                       precb.zpp_inner.set = _loc53_;
                                       _loc57_ = prelisteners.head;
                                       while(_loc57_ != null)
                                       {
                                          _loc58_ = _loc57_.elt;
                                          precb.zpp_inner.listener = _loc58_;
                                          _loc63_ = precb.zpp_inner;
                                          _loc64_ = _loc53_.int1;
                                          _loc65_ = _loc53_.int2;
                                          _loc66_ = _loc58_.options1;
                                          _loc67_ = _loc64_.cbTypes;
                                          if(_loc66_.nonemptyintersection(_loc67_,_loc66_.includes) && !_loc66_.nonemptyintersection(_loc67_,_loc66_.excludes) && (_loc66_.nonemptyintersection(_loc67_,_loc66_.includes) && !_loc66_.nonemptyintersection(_loc67_,_loc66_.excludes)))
                                          {
                                             _loc63_.int1 = _loc64_;
                                             _loc63_.int2 = _loc65_;
                                          }
                                          else
                                          {
                                             _loc63_.int1 = _loc65_;
                                             _loc63_.int2 = _loc64_;
                                          }
                                          precb.zpp_inner.pre_swapped = _loc15_ != precb.zpp_inner.int1;
                                          _loc68_ = _loc58_.handlerp(precb);
                                          if(_loc68_ != null)
                                          {
                                             §§push(_loc71_);
                                             §§push(_loc68_);
                                             if(ZPP_Flags.PreFlag_ACCEPT == null)
                                             {
                                                ZPP_Flags.§internal§ = true;
                                                ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                                                ZPP_Flags.§internal§ = false;
                                             }
                                             if(§§pop() == ZPP_Flags.PreFlag_ACCEPT)
                                             {
                                                §§push(ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS);
                                             }
                                             else
                                             {
                                                §§push(_loc68_);
                                                if(ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                                                {
                                                   ZPP_Flags.§internal§ = true;
                                                   ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                                                   ZPP_Flags.§internal§ = false;
                                                }
                                                if(§§pop() == ZPP_Flags.PreFlag_ACCEPT_ONCE)
                                                {
                                                   §§push(ZPP_Flags.id_ImmState_ACCEPT);
                                                }
                                                else
                                                {
                                                   §§push(_loc68_);
                                                   if(ZPP_Flags.PreFlag_IGNORE == null)
                                                   {
                                                      ZPP_Flags.§internal§ = true;
                                                      ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                                                      ZPP_Flags.§internal§ = false;
                                                   }
                                                   §§push(§§pop() == ZPP_Flags.PreFlag_IGNORE ? ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS : ZPP_Flags.id_ImmState_IGNORE);
                                                }
                                             }
                                             §§pop().immState = §§pop();
                                          }
                                          _loc57_ = _loc57_.next;
                                       }
                                       _loc71_.mutable = false;
                                       if(_loc71_.wrap_normal != null)
                                       {
                                          _loc71_.wrap_normal.zpp_inner._immutable = true;
                                       }
                                       if(_loc71_.wrap_contacts != null)
                                       {
                                          _loc71_.wrap_contacts.zpp_inner.immutable = true;
                                       }
                                       _loc71_.active = _loc61_;
                                       if(_loc53_ != null)
                                       {
                                          _loc57_ = prelisteners.head;
                                          while(_loc57_ != null)
                                          {
                                             _loc58_ = _loc57_.elt;
                                             if(_loc58_.itype == ZPP_Flags.id_InteractionType_ANY)
                                             {
                                                _loc53_.COLLISIONstate = _loc71_.immState;
                                                _loc53_.SENSORstate = _loc71_.immState;
                                                _loc53_.FLUIDstate = _loc71_.immState;
                                             }
                                             else
                                             {
                                                _loc53_.COLLISIONstate = _loc71_.immState;
                                             }
                                             _loc57_ = _loc57_.next;
                                          }
                                       }
                                    }
                                    else if(_loc53_ == null)
                                    {
                                       if((_loc71_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                       {
                                          _loc71_.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                       }
                                    }
                                    else
                                    {
                                       _loc71_.immState = _loc53_.COLLISIONstate;
                                    }
                                    _loc41_ = _loc41_.next;
                                 }
                              }
                           }
                           _loc40_ = _loc40_.next;
                        }
                        if(_loc31_ && (_loc71_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                        {
                           if(_loc71_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                           {
                              _loc24_ = _loc71_.b1;
                              if(!_loc24_.world)
                              {
                                 _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                                 if(_loc24_.component.sleeping)
                                 {
                                    really_wake(_loc24_,false);
                                 }
                              }
                           }
                           if(_loc71_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                           {
                              _loc24_ = _loc71_.b2;
                              if(!_loc24_.world)
                              {
                                 _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                                 if(_loc24_.component.sleeping)
                                 {
                                    really_wake(_loc24_,false);
                                 }
                              }
                           }
                        }
                     }
                     if((_loc71_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                     {
                        if(_loc71_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc71_.b1.component.sleeping)
                        {
                           _loc24_ = _loc71_.b1;
                           if(!_loc24_.world)
                           {
                              _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                              if(_loc24_.component.sleeping)
                              {
                                 really_wake(_loc24_,false);
                              }
                           }
                        }
                        if(_loc71_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc71_.b2.component.sleeping)
                        {
                           _loc24_ = _loc71_.b2;
                           if(!_loc24_.world)
                           {
                              _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                              if(_loc24_.component.sleeping)
                              {
                                 really_wake(_loc24_,false);
                              }
                           }
                        }
                     }
                     if(_loc71_.sleeping)
                     {
                        _loc71_.sleeping = false;
                        if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                        {
                           _loc75_ = new ZNPNode_ZPP_ColArbiter();
                        }
                        else
                        {
                           _loc75_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                           ZNPNode_ZPP_ColArbiter.zpp_pool = _loc75_.next;
                           _loc75_.next = null;
                        }
                        null;
                        _loc75_.elt = _loc71_;
                        _loc74_ = _loc75_;
                        _loc74_.next = _loc70_.head;
                        _loc70_.head = _loc74_;
                        _loc70_.modified = true;
                        ++_loc70_.length;
                        _loc71_;
                     }
                     §§push(_loc71_);
                  }
                  else
                  {
                     §§push(_loc17_ ? (_loc89_ = _loc71_, _loc89_.userdef_dyn_fric = false, _loc89_.userdef_stat_fric = false, _loc89_.userdef_restitution = false, _loc89_.userdef_rfric = false, _loc89_.__ref_edge1 = _loc89_.__ref_edge2 = null, _loc89_.next = ZPP_ColArbiter.zpp_pool, ZPP_ColArbiter.zpp_pool = _loc89_, null) : _loc71_);
                  }
               }
               else
               {
                  §§push(_loc71_);
               }
               _loc7_ = §§pop();
            }
            else
            {
               if(param4 == null)
               {
                  _loc23_ = null;
                  _loc24_ = _loc8_.arbiters.length < _loc9_.arbiters.length ? _loc8_ : _loc9_;
                  _loc25_ = _loc24_.arbiters.head;
                  while(_loc25_ != null)
                  {
                     _loc26_ = _loc25_.elt;
                     if(_loc26_.id == _loc20_.id && _loc26_.di == _loc21_.id)
                     {
                        _loc23_ = _loc26_;
                        break;
                     }
                     _loc25_ = _loc25_.next;
                  }
                  §§push(_loc23_);
               }
               else
               {
                  §§push(param4);
               }
               _loc22_ = §§pop();
               _loc17_ = _loc22_ == null;
               _loc28_ = false;
               if(_loc17_)
               {
                  if(ZPP_SensorArbiter.zpp_pool == null)
                  {
                     _loc91_ = new ZPP_SensorArbiter();
                  }
                  else
                  {
                     _loc91_ = ZPP_SensorArbiter.zpp_pool;
                     ZPP_SensorArbiter.zpp_pool = _loc91_.next;
                     _loc91_.next = null;
                  }
                  null;
               }
               else if(_loc22_.sensorarb == null)
               {
                  _loc22_.cleared = true;
                  _loc29_ = _loc22_.b1.arbiters;
                  _loc25_ = null;
                  _loc30_ = _loc29_.head;
                  _loc31_ = false;
                  while(_loc30_ != null)
                  {
                     if(_loc30_.elt == _loc22_)
                     {
                        if(_loc25_ == null)
                        {
                           _loc32_ = _loc29_.head;
                           _loc33_ = _loc32_.next;
                           _loc29_.head = _loc33_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc32_ = _loc25_.next;
                           _loc33_ = _loc32_.next;
                           _loc25_.next = _loc33_;
                           if(_loc33_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc34_ = _loc32_;
                        _loc34_.elt = null;
                        _loc34_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc34_;
                        _loc29_.modified = true;
                        --_loc29_.length;
                        _loc29_.pushmod = true;
                        _loc33_;
                        _loc31_ = true;
                        break;
                     }
                     _loc25_ = _loc30_;
                     _loc30_ = _loc30_.next;
                  }
                  _loc31_;
                  _loc29_ = _loc22_.b2.arbiters;
                  _loc25_ = null;
                  _loc30_ = _loc29_.head;
                  _loc31_ = false;
                  while(_loc30_ != null)
                  {
                     if(_loc30_.elt == _loc22_)
                     {
                        if(_loc25_ == null)
                        {
                           _loc32_ = _loc29_.head;
                           _loc33_ = _loc32_.next;
                           _loc29_.head = _loc33_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc32_ = _loc25_.next;
                           _loc33_ = _loc32_.next;
                           _loc25_.next = _loc33_;
                           if(_loc33_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc34_ = _loc32_;
                        _loc34_.elt = null;
                        _loc34_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc34_;
                        _loc29_.modified = true;
                        --_loc29_.length;
                        _loc29_.pushmod = true;
                        _loc33_;
                        _loc31_ = true;
                        break;
                     }
                     _loc25_ = _loc30_;
                     _loc30_ = _loc30_.next;
                  }
                  _loc31_;
                  if(_loc22_.pair != null)
                  {
                     _loc22_.pair.arb = null;
                     _loc22_.pair = null;
                  }
                  _loc22_.active = false;
                  f_arbiters.modified = true;
                  if(ZPP_SensorArbiter.zpp_pool == null)
                  {
                     _loc91_ = new ZPP_SensorArbiter();
                  }
                  else
                  {
                     _loc91_ = ZPP_SensorArbiter.zpp_pool;
                     ZPP_SensorArbiter.zpp_pool = _loc91_.next;
                     _loc91_.next = null;
                  }
                  null;
                  _loc91_.intchange = true;
                  _loc17_ = true;
                  _loc28_ = true;
               }
               else
               {
                  _loc91_ = _loc22_.sensorarb;
               }
               _loc35_ = ZPP_Flags.id_InteractionType_SENSOR;
               if(_loc17_ || _loc91_.stamp != stamp || param5)
               {
                  _loc91_.stamp = stamp;
                  if(ZPP_Collide.testCollide(_loc20_,_loc21_))
                  {
                     if(_loc17_)
                     {
                        _loc91_.b1 = param1.body;
                        _loc91_.ws1 = param1;
                        _loc91_.b2 = param2.body;
                        _loc91_.ws2 = param2;
                        _loc91_.id = _loc20_.id;
                        _loc91_.di = _loc21_.id;
                        _loc29_ = _loc91_.b1.arbiters;
                        if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                        {
                           _loc30_ = new ZNPNode_ZPP_Arbiter();
                        }
                        else
                        {
                           _loc30_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc30_.next;
                           _loc30_.next = null;
                        }
                        null;
                        _loc30_.elt = _loc91_;
                        _loc25_ = _loc30_;
                        _loc25_.next = _loc29_.head;
                        _loc29_.head = _loc25_;
                        _loc29_.modified = true;
                        ++_loc29_.length;
                        _loc91_;
                        _loc29_ = _loc91_.b2.arbiters;
                        if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                        {
                           _loc30_ = new ZNPNode_ZPP_Arbiter();
                        }
                        else
                        {
                           _loc30_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc30_.next;
                           _loc30_.next = null;
                        }
                        null;
                        _loc30_.elt = _loc91_;
                        _loc25_ = _loc30_;
                        _loc25_.next = _loc29_.head;
                        _loc29_.head = _loc25_;
                        _loc29_.modified = true;
                        ++_loc29_.length;
                        _loc91_;
                        _loc91_.active = true;
                        _loc91_.present = 0;
                        _loc91_.cleared = false;
                        _loc91_.sleeping = false;
                        _loc91_.fresh = false;
                        _loc91_.presentable = false;
                        _loc92_ = s_arbiters;
                        if(ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                        {
                           _loc94_ = new ZNPNode_ZPP_SensorArbiter();
                        }
                        else
                        {
                           _loc94_ = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                           ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc94_.next;
                           _loc94_.next = null;
                        }
                        null;
                        _loc94_.elt = _loc91_;
                        _loc93_ = _loc94_;
                        _loc93_.next = _loc92_.head;
                        _loc92_.head = _loc93_;
                        _loc92_.modified = true;
                        ++_loc92_.length;
                        _loc91_;
                        _loc91_.fresh = !_loc28_;
                     }
                     else
                     {
                        _loc91_.fresh = _loc91_.up_stamp < stamp - 1 || _loc91_.endGenerated == stamp && param5;
                     }
                     _loc91_.up_stamp = _loc91_.stamp;
                     if(_loc91_.fresh || (_loc91_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                     {
                        _loc91_.immState = ZPP_Flags.id_ImmState_ACCEPT;
                        _loc31_ = false;
                        _loc39_ = mrca1;
                        while(_loc39_.head != null)
                        {
                           _loc40_ = _loc39_.head;
                           _loc39_.head = _loc40_.next;
                           _loc41_ = _loc40_;
                           _loc41_.elt = null;
                           _loc41_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc41_;
                           if(_loc39_.head == null)
                           {
                              _loc39_.pushmod = true;
                           }
                           _loc39_.modified = true;
                           --_loc39_.length;
                        }
                        _loc39_.pushmod = true;
                        _loc39_ = mrca2;
                        while(_loc39_.head != null)
                        {
                           _loc40_ = _loc39_.head;
                           _loc39_.head = _loc40_.next;
                           _loc41_ = _loc40_;
                           _loc41_.elt = null;
                           _loc41_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc41_;
                           if(_loc39_.head == null)
                           {
                              _loc39_.pushmod = true;
                           }
                           _loc39_.modified = true;
                           --_loc39_.length;
                        }
                        _loc39_.pushmod = true;
                        if(param1.cbSet != null)
                        {
                           _loc39_ = mrca1;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = param1;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           param1;
                        }
                        if(param1.body.cbSet != null)
                        {
                           _loc39_ = mrca1;
                           _loc15_ = param1.body;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = _loc15_;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc15_;
                        }
                        if(param2.cbSet != null)
                        {
                           _loc39_ = mrca2;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = param2;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           param2;
                        }
                        if(param2.body.cbSet != null)
                        {
                           _loc39_ = mrca2;
                           _loc15_ = param2.body;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc41_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                              _loc41_.next = null;
                           }
                           null;
                           _loc41_.elt = _loc15_;
                           _loc40_ = _loc41_;
                           _loc40_.next = _loc39_.head;
                           _loc39_.head = _loc40_;
                           _loc39_.modified = true;
                           ++_loc39_.length;
                           _loc15_;
                        }
                        _loc42_ = param1.body.compound;
                        _loc43_ = param2.body.compound;
                        while(_loc42_ != _loc43_)
                        {
                           _loc44_ = _loc42_ == null ? 0 : _loc42_.depth;
                           _loc45_ = _loc43_ == null ? 0 : _loc43_.depth;
                           if(_loc44_ < _loc45_)
                           {
                              if(_loc43_.cbSet != null)
                              {
                                 _loc39_ = mrca2;
                                 if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                                 {
                                    _loc41_ = new ZNPNode_ZPP_Interactor();
                                 }
                                 else
                                 {
                                    _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                                    _loc41_.next = null;
                                 }
                                 null;
                                 _loc41_.elt = _loc43_;
                                 _loc40_ = _loc41_;
                                 _loc40_.next = _loc39_.head;
                                 _loc39_.head = _loc40_;
                                 _loc39_.modified = true;
                                 ++_loc39_.length;
                                 _loc43_;
                              }
                              _loc43_ = _loc43_.compound;
                           }
                           else
                           {
                              if(_loc42_.cbSet != null)
                              {
                                 _loc39_ = mrca1;
                                 if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                                 {
                                    _loc41_ = new ZNPNode_ZPP_Interactor();
                                 }
                                 else
                                 {
                                    _loc41_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                    ZNPNode_ZPP_Interactor.zpp_pool = _loc41_.next;
                                    _loc41_.next = null;
                                 }
                                 null;
                                 _loc41_.elt = _loc42_;
                                 _loc40_ = _loc41_;
                                 _loc40_.next = _loc39_.head;
                                 _loc39_.head = _loc40_;
                                 _loc39_.modified = true;
                                 ++_loc39_.length;
                                 _loc42_;
                              }
                              _loc42_ = _loc42_.compound;
                           }
                        }
                        _loc40_ = mrca1.head;
                        while(_loc40_ != null)
                        {
                           _loc15_ = _loc40_.elt;
                           _loc41_ = mrca2.head;
                           while(_loc41_ != null)
                           {
                              _loc46_ = _loc41_.elt;
                              _loc47_ = _loc15_.cbSet;
                              _loc48_ = _loc46_.cbSet;
                              _loc49_ = null;
                              _loc50_ = _loc47_.cbpairs.length < _loc48_.cbpairs.length ? _loc47_.cbpairs : _loc48_.cbpairs;
                              _loc51_ = _loc50_.head;
                              while(_loc51_ != null)
                              {
                                 _loc52_ = _loc51_.elt;
                                 if(_loc52_.a == _loc47_ && _loc52_.b == _loc48_ || _loc52_.a == _loc48_ && _loc52_.b == _loc47_)
                                 {
                                    _loc49_ = _loc52_;
                                    break;
                                 }
                                 _loc51_ = _loc51_.next;
                              }
                              if(_loc49_ == null)
                              {
                                 if(ZPP_CbSetPair.zpp_pool == null)
                                 {
                                    _loc52_ = new ZPP_CbSetPair();
                                 }
                                 else
                                 {
                                    _loc52_ = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc52_.next;
                                    _loc52_.next = null;
                                 }
                                 _loc52_.zip_listeners = true;
                                 if(ZPP_CbSet.setlt(_loc47_,_loc48_))
                                 {
                                    _loc52_.a = _loc47_;
                                    _loc52_.b = _loc48_;
                                 }
                                 else
                                 {
                                    _loc52_.a = _loc48_;
                                    _loc52_.b = _loc47_;
                                 }
                                 _loc49_ = _loc52_;
                                 _loc47_.cbpairs.add(_loc49_);
                                 if(_loc48_ != _loc47_)
                                 {
                                    _loc48_.cbpairs.add(_loc49_);
                                 }
                              }
                              if(_loc49_.zip_listeners)
                              {
                                 _loc49_.zip_listeners = false;
                                 _loc49_.__validate();
                              }
                              if(_loc49_.listeners.head == null)
                              {
                                 _loc41_ = _loc41_.next;
                              }
                              else
                              {
                                 _loc53_ = null;
                                 _loc54_ = null;
                                 _loc55_ = prelisteners;
                                 while(_loc55_.head != null)
                                 {
                                    _loc56_ = _loc55_.head;
                                    _loc55_.head = _loc56_.next;
                                    _loc57_ = _loc56_;
                                    _loc57_.elt = null;
                                    _loc57_.next = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                    ZNPNode_ZPP_InteractionListener.zpp_pool = _loc57_;
                                    if(_loc55_.head == null)
                                    {
                                       _loc55_.pushmod = true;
                                    }
                                    _loc55_.modified = true;
                                    --_loc55_.length;
                                 }
                                 _loc55_.pushmod = true;
                                 _loc56_ = null;
                                 _loc44_ = ZPP_Flags.id_CbEvent_PRE;
                                 _loc49_ = null;
                                 _loc50_ = _loc47_.cbpairs.length < _loc48_.cbpairs.length ? _loc47_.cbpairs : _loc48_.cbpairs;
                                 _loc51_ = _loc50_.head;
                                 while(_loc51_ != null)
                                 {
                                    _loc52_ = _loc51_.elt;
                                    if(_loc52_.a == _loc47_ && _loc52_.b == _loc48_ || _loc52_.a == _loc48_ && _loc52_.b == _loc47_)
                                    {
                                       _loc49_ = _loc52_;
                                       break;
                                    }
                                    _loc51_ = _loc51_.next;
                                 }
                                 if(_loc49_ == null)
                                 {
                                    if(ZPP_CbSetPair.zpp_pool == null)
                                    {
                                       _loc52_ = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                       _loc52_ = ZPP_CbSetPair.zpp_pool;
                                       ZPP_CbSetPair.zpp_pool = _loc52_.next;
                                       _loc52_.next = null;
                                    }
                                    _loc52_.zip_listeners = true;
                                    if(ZPP_CbSet.setlt(_loc47_,_loc48_))
                                    {
                                       _loc52_.a = _loc47_;
                                       _loc52_.b = _loc48_;
                                    }
                                    else
                                    {
                                       _loc52_.a = _loc48_;
                                       _loc52_.b = _loc47_;
                                    }
                                    _loc49_ = _loc52_;
                                    _loc47_.cbpairs.add(_loc49_);
                                    if(_loc48_ != _loc47_)
                                    {
                                       _loc48_.cbpairs.add(_loc49_);
                                    }
                                 }
                                 if(_loc49_.zip_listeners)
                                 {
                                    _loc49_.zip_listeners = false;
                                    _loc49_.__validate();
                                 }
                                 _loc57_ = _loc49_.listeners.head;
                                 while(_loc57_ != null)
                                 {
                                    _loc58_ = _loc57_.elt;
                                    if(_loc58_.event == _loc44_)
                                    {
                                       if((_loc58_.itype & _loc35_) != 0)
                                       {
                                          _loc55_ = _loc6_.prelisteners;
                                          if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                                          {
                                             _loc60_ = new ZNPNode_ZPP_InteractionListener();
                                          }
                                          else
                                          {
                                             _loc60_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                             ZNPNode_ZPP_InteractionListener.zpp_pool = _loc60_.next;
                                             _loc60_.next = null;
                                          }
                                          null;
                                          _loc60_.elt = _loc58_;
                                          _loc59_ = _loc60_;
                                          if(_loc56_ == null)
                                          {
                                             _loc59_.next = _loc55_.head;
                                             _loc55_.head = _loc59_;
                                          }
                                          else
                                          {
                                             _loc59_.next = _loc56_.next;
                                             _loc56_.next = _loc59_;
                                          }
                                          _loc55_.pushmod = _loc55_.modified = true;
                                          ++_loc55_.length;
                                          _loc56_ = _loc59_;
                                          _loc31_ ||= !_loc58_.pure;
                                       }
                                    }
                                    _loc57_ = _loc57_.next;
                                 }
                                 if(prelisteners.head == null)
                                 {
                                    _loc41_ = _loc41_.next;
                                 }
                                 else
                                 {
                                    _loc53_ = ZPP_Interactor.get(_loc15_,_loc46_);
                                    if(_loc53_ == null)
                                    {
                                       _loc54_ = ZPP_CallbackSet.get(_loc15_,_loc46_);
                                       add_callbackset(_loc54_);
                                    }
                                    if(_loc53_ == null || (_loc53_.SENSORstamp != stamp || param5) && (_loc53_.SENSORstate & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                    {
                                       if(_loc54_ != null)
                                       {
                                          _loc53_ = _loc54_;
                                       }
                                       if(_loc53_ != null)
                                       {
                                          _loc57_ = prelisteners.head;
                                          while(_loc57_ != null)
                                          {
                                             _loc58_ = _loc57_.elt;
                                             if(_loc58_.itype == ZPP_Flags.id_InteractionType_ANY)
                                             {
                                                _loc53_.COLLISIONstamp = stamp;
                                                _loc53_.SENSORstamp = stamp;
                                                _loc53_.FLUIDstamp = stamp;
                                             }
                                             else
                                             {
                                                _loc53_.SENSORstamp = stamp;
                                             }
                                             _loc57_ = _loc57_.next;
                                          }
                                       }
                                       _loc61_ = _loc91_.active;
                                       _loc91_.active = true;
                                       _loc62_ = false;
                                       precb.zpp_inner.pre_arbiter = _loc91_;
                                       precb.zpp_inner.set = _loc53_;
                                       _loc57_ = prelisteners.head;
                                       while(_loc57_ != null)
                                       {
                                          _loc58_ = _loc57_.elt;
                                          precb.zpp_inner.listener = _loc58_;
                                          _loc63_ = precb.zpp_inner;
                                          _loc64_ = _loc53_.int1;
                                          _loc65_ = _loc53_.int2;
                                          _loc66_ = _loc58_.options1;
                                          _loc67_ = _loc64_.cbTypes;
                                          if(_loc66_.nonemptyintersection(_loc67_,_loc66_.includes) && !_loc66_.nonemptyintersection(_loc67_,_loc66_.excludes) && (_loc66_.nonemptyintersection(_loc67_,_loc66_.includes) && !_loc66_.nonemptyintersection(_loc67_,_loc66_.excludes)))
                                          {
                                             _loc63_.int1 = _loc64_;
                                             _loc63_.int2 = _loc65_;
                                          }
                                          else
                                          {
                                             _loc63_.int1 = _loc65_;
                                             _loc63_.int2 = _loc64_;
                                          }
                                          precb.zpp_inner.pre_swapped = _loc15_ != precb.zpp_inner.int1;
                                          _loc68_ = _loc58_.handlerp(precb);
                                          if(_loc68_ != null)
                                          {
                                             §§push(_loc91_);
                                             §§push(_loc68_);
                                             if(ZPP_Flags.PreFlag_ACCEPT == null)
                                             {
                                                ZPP_Flags.§internal§ = true;
                                                ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                                                ZPP_Flags.§internal§ = false;
                                             }
                                             if(§§pop() == ZPP_Flags.PreFlag_ACCEPT)
                                             {
                                                §§push(ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS);
                                             }
                                             else
                                             {
                                                §§push(_loc68_);
                                                if(ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                                                {
                                                   ZPP_Flags.§internal§ = true;
                                                   ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                                                   ZPP_Flags.§internal§ = false;
                                                }
                                                if(§§pop() == ZPP_Flags.PreFlag_ACCEPT_ONCE)
                                                {
                                                   §§push(ZPP_Flags.id_ImmState_ACCEPT);
                                                }
                                                else
                                                {
                                                   §§push(_loc68_);
                                                   if(ZPP_Flags.PreFlag_IGNORE == null)
                                                   {
                                                      ZPP_Flags.§internal§ = true;
                                                      ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                                                      ZPP_Flags.§internal§ = false;
                                                   }
                                                   §§push(§§pop() == ZPP_Flags.PreFlag_IGNORE ? ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS : ZPP_Flags.id_ImmState_IGNORE);
                                                }
                                             }
                                             §§pop().immState = §§pop();
                                          }
                                          _loc57_ = _loc57_.next;
                                       }
                                       _loc91_.active = _loc61_;
                                       if(_loc53_ != null)
                                       {
                                          _loc57_ = prelisteners.head;
                                          while(_loc57_ != null)
                                          {
                                             _loc58_ = _loc57_.elt;
                                             if(_loc58_.itype == ZPP_Flags.id_InteractionType_ANY)
                                             {
                                                _loc53_.COLLISIONstate = _loc91_.immState;
                                                _loc53_.SENSORstate = _loc91_.immState;
                                                _loc53_.FLUIDstate = _loc91_.immState;
                                             }
                                             else
                                             {
                                                _loc53_.SENSORstate = _loc91_.immState;
                                             }
                                             _loc57_ = _loc57_.next;
                                          }
                                       }
                                    }
                                    else if(_loc53_ == null)
                                    {
                                       if((_loc91_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                       {
                                          _loc91_.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                       }
                                    }
                                    else
                                    {
                                       _loc91_.immState = _loc53_.SENSORstate;
                                    }
                                    _loc41_ = _loc41_.next;
                                 }
                              }
                           }
                           _loc40_ = _loc40_.next;
                        }
                        if(_loc31_ && (_loc91_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                        {
                           if(_loc91_.b1.type != ZPP_Flags.id_BodyType_STATIC)
                           {
                              _loc24_ = _loc91_.b1;
                              if(!_loc24_.world)
                              {
                                 _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                                 if(_loc24_.component.sleeping)
                                 {
                                    really_wake(_loc24_,false);
                                 }
                              }
                           }
                           if(_loc91_.b2.type != ZPP_Flags.id_BodyType_STATIC)
                           {
                              _loc24_ = _loc91_.b2;
                              if(!_loc24_.world)
                              {
                                 _loc24_.component.waket = stamp + (midstep ? 0 : 1);
                                 if(_loc24_.component.sleeping)
                                 {
                                    really_wake(_loc24_,false);
                                 }
                              }
                           }
                        }
                     }
                     if(_loc91_.sleeping)
                     {
                        _loc91_.sleeping = false;
                        _loc92_ = s_arbiters;
                        if(ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                        {
                           _loc94_ = new ZNPNode_ZPP_SensorArbiter();
                        }
                        else
                        {
                           _loc94_ = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                           ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc94_.next;
                           _loc94_.next = null;
                        }
                        null;
                        _loc94_.elt = _loc91_;
                        _loc93_ = _loc94_;
                        _loc93_.next = _loc92_.head;
                        _loc92_.head = _loc93_;
                        _loc92_.modified = true;
                        ++_loc92_.length;
                        _loc91_;
                     }
                     §§push(_loc91_);
                  }
                  else
                  {
                     §§push(_loc17_ ? (_loc95_ = _loc91_, _loc95_.next = ZPP_SensorArbiter.zpp_pool, ZPP_SensorArbiter.zpp_pool = _loc95_, null) : _loc91_);
                  }
               }
               else
               {
                  §§push(_loc91_);
               }
               _loc7_ = §§pop();
            }
         }
         return _loc7_;
      }
      
      public function listeners_subber(param1:Listener) : void
      {
         remListener(param1.zpp_inner);
      }
      
      public function listeners_modifiable() : void
      {
         if(midstep)
         {
            Boot.lastError = new Error();
            throw "Error: Space::listeners cannot be set during space step()";
         }
      }
      
      public function listeners_adder(param1:Listener) : Boolean
      {
         if(param1.zpp_inner.space != this)
         {
            if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.outer.zpp_inner.wrap_listeners.remove(param1);
            }
            addListener(param1.zpp_inner);
            return true;
         }
         return false;
      }
      
      public function iterateVel(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc5_:* = null as ZPP_FluidArbiter;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZNPNode_ZPP_Constraint;
         var _loc12_:* = null as ZNPNode_ZPP_Constraint;
         var _loc13_:* = null as ZPP_Constraint;
         var _loc14_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc15_:Boolean = false;
         var _loc16_:* = null as ZPP_ColArbiter;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = _loc2_++;
            _loc4_ = f_arbiters.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               if(_loc5_.active && (_loc5_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
               {
                  if(!_loc5_.nodrag)
                  {
                     _loc6_ = _loc5_.b1.angvel + _loc5_.b1.kinangvel;
                     _loc7_ = _loc5_.b2.angvel + _loc5_.b2.kinangvel;
                     _loc8_ = _loc5_.b1.velx + _loc5_.b1.kinvelx - _loc5_.r1y * _loc6_ - (_loc5_.b2.velx + _loc5_.b2.kinvelx - _loc5_.r2y * _loc7_);
                     _loc9_ = _loc5_.b1.vely + _loc5_.b1.kinvely + _loc5_.r1x * _loc6_ - (_loc5_.b2.vely + _loc5_.b2.kinvely + _loc5_.r2x * _loc7_);
                     _loc10_ = _loc5_.vMassa * _loc8_ + _loc5_.vMassb * _loc9_;
                     _loc9_ = _loc5_.vMassb * _loc8_ + _loc5_.vMassc * _loc9_;
                     _loc8_ = _loc10_;
                     _loc10_ = _loc5_.lgamma;
                     _loc8_ -= _loc5_.dampx * _loc10_;
                     _loc9_ -= _loc5_.dampy * _loc10_;
                     _loc10_ = 1;
                     _loc5_.dampx += _loc8_ * _loc10_;
                     _loc5_.dampy += _loc9_ * _loc10_;
                     _loc10_ = _loc5_.b1.imass;
                     _loc5_.b1.velx -= _loc8_ * _loc10_;
                     _loc5_.b1.vely -= _loc9_ * _loc10_;
                     _loc10_ = _loc5_.b2.imass;
                     _loc5_.b2.velx += _loc8_ * _loc10_;
                     _loc5_.b2.vely += _loc9_ * _loc10_;
                     _loc5_.b1.angvel -= _loc5_.b1.iinertia * (_loc9_ * _loc5_.r1x - _loc8_ * _loc5_.r1y);
                     _loc5_.b2.angvel += _loc5_.b2.iinertia * (_loc9_ * _loc5_.r2x - _loc8_ * _loc5_.r2y);
                     _loc10_ = (_loc6_ - _loc7_) * _loc5_.wMass - _loc5_.adamp * _loc5_.agamma;
                     _loc5_.adamp += _loc10_;
                     _loc5_.b1.angvel -= _loc10_ * _loc5_.b1.iinertia;
                     _loc5_.b2.angvel += _loc10_ * _loc5_.b2.iinertia;
                  }
               }
               _loc4_ = _loc4_.next;
            }
            _loc11_ = null;
            _loc12_ = live_constraints.head;
            while(_loc12_ != null)
            {
               _loc13_ = _loc12_.elt;
               if(_loc13_.applyImpulseVel())
               {
                  _loc12_ = live_constraints.erase(_loc11_);
                  _loc13_.broken();
                  constraintCbBreak(_loc13_);
                  if(_loc13_.removeOnBreak)
                  {
                     _loc13_.component.sleeping = true;
                     midstep = false;
                     if(_loc13_.compound != null)
                     {
                        _loc13_.compound.wrap_constraints.remove(_loc13_.outer);
                     }
                     else
                     {
                        wrap_constraints.remove(_loc13_.outer);
                     }
                     midstep = true;
                  }
                  else
                  {
                     _loc13_.active = false;
                  }
                  _loc13_.clearcache();
               }
               else
               {
                  _loc11_ = _loc12_;
                  _loc12_ = _loc12_.next;
               }
            }
            _loc14_ = c_arbiters_false.head;
            _loc15_ = true;
            if(_loc14_ == null)
            {
               _loc14_ = c_arbiters_true.head;
               _loc15_ = false;
            }
            while(_loc14_ != null)
            {
               _loc16_ = _loc14_.elt;
               if(_loc16_.active && (_loc16_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
               {
                  _loc18_ = _loc16_.k1x + _loc16_.b2.velx - _loc16_.c1.r2y * _loc16_.b2.angvel - (_loc16_.b1.velx - _loc16_.c1.r1y * _loc16_.b1.angvel);
                  _loc19_ = _loc16_.k1y + _loc16_.b2.vely + _loc16_.c1.r2x * _loc16_.b2.angvel - (_loc16_.b1.vely + _loc16_.c1.r1x * _loc16_.b1.angvel);
                  _loc8_ = (_loc19_ * _loc16_.nx - _loc18_ * _loc16_.ny + _loc16_.surfacex) * _loc16_.c1.tMass;
                  _loc9_ = _loc16_.c1.friction * _loc16_.c1.jnAcc;
                  _loc10_ = _loc16_.c1.jtAcc;
                  _loc17_ = _loc10_ - _loc8_;
                  if(_loc17_ > _loc9_)
                  {
                     _loc17_ = _loc9_;
                  }
                  else if(_loc17_ < -_loc9_)
                  {
                     _loc17_ = -_loc9_;
                  }
                  _loc8_ = _loc17_ - _loc10_;
                  _loc16_.c1.jtAcc = _loc17_;
                  _loc6_ = -_loc16_.ny * _loc8_;
                  _loc7_ = _loc16_.nx * _loc8_;
                  _loc16_.b2.velx += _loc6_ * _loc16_.b2.imass;
                  _loc16_.b2.vely += _loc7_ * _loc16_.b2.imass;
                  _loc16_.b1.velx -= _loc6_ * _loc16_.b1.imass;
                  _loc16_.b1.vely -= _loc7_ * _loc16_.b1.imass;
                  _loc16_.b2.angvel += _loc16_.rt1b * _loc8_ * _loc16_.b2.iinertia;
                  _loc16_.b1.angvel -= _loc16_.rt1a * _loc8_ * _loc16_.b1.iinertia;
                  if(_loc16_.hc2)
                  {
                     _loc20_ = _loc16_.k2x + _loc16_.b2.velx - _loc16_.c2.r2y * _loc16_.b2.angvel - (_loc16_.b1.velx - _loc16_.c2.r1y * _loc16_.b1.angvel);
                     _loc21_ = _loc16_.k2y + _loc16_.b2.vely + _loc16_.c2.r2x * _loc16_.b2.angvel - (_loc16_.b1.vely + _loc16_.c2.r1x * _loc16_.b1.angvel);
                     _loc8_ = (_loc21_ * _loc16_.nx - _loc20_ * _loc16_.ny + _loc16_.surfacex) * _loc16_.c2.tMass;
                     _loc9_ = _loc16_.c2.friction * _loc16_.c2.jnAcc;
                     _loc10_ = _loc16_.c2.jtAcc;
                     _loc17_ = _loc10_ - _loc8_;
                     if(_loc17_ > _loc9_)
                     {
                        _loc17_ = _loc9_;
                     }
                     else if(_loc17_ < -_loc9_)
                     {
                        _loc17_ = -_loc9_;
                     }
                     _loc8_ = _loc17_ - _loc10_;
                     _loc16_.c2.jtAcc = _loc17_;
                     _loc6_ = -_loc16_.ny * _loc8_;
                     _loc7_ = _loc16_.nx * _loc8_;
                     _loc16_.b2.velx += _loc6_ * _loc16_.b2.imass;
                     _loc16_.b2.vely += _loc7_ * _loc16_.b2.imass;
                     _loc16_.b1.velx -= _loc6_ * _loc16_.b1.imass;
                     _loc16_.b1.vely -= _loc7_ * _loc16_.b1.imass;
                     _loc16_.b2.angvel += _loc16_.rt2b * _loc8_ * _loc16_.b2.iinertia;
                     _loc16_.b1.angvel -= _loc16_.rt2a * _loc8_ * _loc16_.b1.iinertia;
                     _loc18_ = _loc16_.k1x + _loc16_.b2.velx - _loc16_.c1.r2y * _loc16_.b2.angvel - (_loc16_.b1.velx - _loc16_.c1.r1y * _loc16_.b1.angvel);
                     _loc19_ = _loc16_.k1y + _loc16_.b2.vely + _loc16_.c1.r2x * _loc16_.b2.angvel - (_loc16_.b1.vely + _loc16_.c1.r1x * _loc16_.b1.angvel);
                     _loc20_ = _loc16_.k2x + _loc16_.b2.velx - _loc16_.c2.r2y * _loc16_.b2.angvel - (_loc16_.b1.velx - _loc16_.c2.r1y * _loc16_.b1.angvel);
                     _loc21_ = _loc16_.k2y + _loc16_.b2.vely + _loc16_.c2.r2x * _loc16_.b2.angvel - (_loc16_.b1.vely + _loc16_.c2.r1x * _loc16_.b1.angvel);
                     _loc22_ = _loc16_.c1.jnAcc;
                     _loc23_ = _loc16_.c2.jnAcc;
                     _loc24_ = _loc18_ * _loc16_.nx + _loc19_ * _loc16_.ny + _loc16_.surfacey + _loc16_.c1.bounce - (_loc16_.Ka * _loc22_ + _loc16_.Kb * _loc23_);
                     _loc25_ = _loc20_ * _loc16_.nx + _loc21_ * _loc16_.ny + _loc16_.surfacey + _loc16_.c2.bounce - (_loc16_.Kb * _loc22_ + _loc16_.Kc * _loc23_);
                     _loc26_ = -(_loc16_.kMassa * _loc24_ + _loc16_.kMassb * _loc25_);
                     _loc27_ = -(_loc16_.kMassb * _loc24_ + _loc16_.kMassc * _loc25_);
                     if(_loc26_ >= 0 && _loc27_ >= 0)
                     {
                        _loc24_ = _loc26_ - _loc22_;
                        _loc25_ = _loc27_ - _loc23_;
                        _loc16_.c1.jnAcc = _loc26_;
                        _loc16_.c2.jnAcc = _loc27_;
                     }
                     else
                     {
                        _loc26_ = -_loc16_.c1.nMass * _loc24_;
                        if(_loc26_ >= 0 && _loc16_.Kb * _loc26_ + _loc25_ >= 0)
                        {
                           _loc24_ = _loc26_ - _loc22_;
                           _loc25_ = -_loc23_;
                           _loc16_.c1.jnAcc = _loc26_;
                           _loc16_.c2.jnAcc = 0;
                        }
                        else
                        {
                           _loc27_ = -_loc16_.c2.nMass * _loc25_;
                           if(_loc27_ >= 0 && _loc16_.Kb * _loc27_ + _loc24_ >= 0)
                           {
                              _loc24_ = -_loc22_;
                              _loc25_ = _loc27_ - _loc23_;
                              _loc16_.c1.jnAcc = 0;
                              _loc16_.c2.jnAcc = _loc27_;
                           }
                           else if(_loc24_ >= 0 && _loc25_ >= 0)
                           {
                              _loc24_ = -_loc22_;
                              _loc25_ = -_loc23_;
                              _loc16_.c1.jnAcc = _loc16_.c2.jnAcc = 0;
                           }
                           else
                           {
                              _loc24_ = 0;
                              _loc25_ = 0;
                           }
                        }
                     }
                     _loc8_ = _loc24_ + _loc25_;
                     _loc6_ = _loc16_.nx * _loc8_;
                     _loc7_ = _loc16_.ny * _loc8_;
                     _loc16_.b2.velx += _loc6_ * _loc16_.b2.imass;
                     _loc16_.b2.vely += _loc7_ * _loc16_.b2.imass;
                     _loc16_.b1.velx -= _loc6_ * _loc16_.b1.imass;
                     _loc16_.b1.vely -= _loc7_ * _loc16_.b1.imass;
                     _loc16_.b2.angvel += (_loc16_.rn1b * _loc24_ + _loc16_.rn2b * _loc25_) * _loc16_.b2.iinertia;
                     _loc16_.b1.angvel -= (_loc16_.rn1a * _loc24_ + _loc16_.rn2a * _loc25_) * _loc16_.b1.iinertia;
                  }
                  else
                  {
                     if(_loc16_.radius != 0)
                     {
                        _loc20_ = _loc16_.b2.angvel - _loc16_.b1.angvel;
                        _loc8_ = _loc20_ * _loc16_.rMass;
                        _loc9_ = _loc16_.rfric * _loc16_.c1.jnAcc;
                        _loc10_ = _loc16_.jrAcc;
                        _loc16_.jrAcc -= _loc8_;
                        if(_loc16_.jrAcc > _loc9_)
                        {
                           _loc16_.jrAcc = _loc9_;
                        }
                        else if(_loc16_.jrAcc < -_loc9_)
                        {
                           _loc16_.jrAcc = -_loc9_;
                        }
                        _loc8_ = _loc16_.jrAcc - _loc10_;
                        _loc16_.b2.angvel += _loc8_ * _loc16_.b2.iinertia;
                        _loc16_.b1.angvel -= _loc8_ * _loc16_.b1.iinertia;
                     }
                     _loc18_ = _loc16_.k1x + _loc16_.b2.velx - _loc16_.c1.r2y * _loc16_.b2.angvel - (_loc16_.b1.velx - _loc16_.c1.r1y * _loc16_.b1.angvel);
                     _loc19_ = _loc16_.k1y + _loc16_.b2.vely + _loc16_.c1.r2x * _loc16_.b2.angvel - (_loc16_.b1.vely + _loc16_.c1.r1x * _loc16_.b1.angvel);
                     _loc8_ = (_loc16_.c1.bounce + (_loc16_.nx * _loc18_ + _loc16_.ny * _loc19_) + _loc16_.surfacey) * _loc16_.c1.nMass;
                     _loc10_ = _loc16_.c1.jnAcc;
                     _loc17_ = _loc10_ - _loc8_;
                     if(_loc17_ < 0)
                     {
                        _loc17_ = 0;
                     }
                     _loc8_ = _loc17_ - _loc10_;
                     _loc16_.c1.jnAcc = _loc17_;
                     _loc6_ = _loc16_.nx * _loc8_;
                     _loc7_ = _loc16_.ny * _loc8_;
                     _loc16_.b2.velx += _loc6_ * _loc16_.b2.imass;
                     _loc16_.b2.vely += _loc7_ * _loc16_.b2.imass;
                     _loc16_.b1.velx -= _loc6_ * _loc16_.b1.imass;
                     _loc16_.b1.vely -= _loc7_ * _loc16_.b1.imass;
                     _loc16_.b2.angvel += _loc16_.rn1b * _loc8_ * _loc16_.b2.iinertia;
                     _loc16_.b1.angvel -= _loc16_.rn1a * _loc8_ * _loc16_.b1.iinertia;
                  }
               }
               _loc14_ = _loc14_.next;
               if(_loc15_ && _loc14_ == null)
               {
                  _loc14_ = c_arbiters_true.head;
                  _loc15_ = false;
               }
            }
         }
      }
      
      public function iteratePos(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as ZNPNode_ZPP_Constraint;
         var _loc5_:* = null as ZNPNode_ZPP_Constraint;
         var _loc6_:* = null as ZPP_Constraint;
         var _loc7_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as ZPP_ColArbiter;
         var _loc10_:* = null as ZPP_IContact;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:* = null as ZPP_Body;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc45_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc47_:Number = NaN;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = _loc2_++;
            _loc4_ = null;
            _loc5_ = live_constraints.head;
            while(_loc5_ != null)
            {
               _loc6_ = _loc5_.elt;
               if(!_loc6_.__velocity && _loc6_.stiff)
               {
                  if(_loc6_.applyImpulsePos())
                  {
                     _loc5_ = live_constraints.erase(_loc4_);
                     _loc6_.broken();
                     constraintCbBreak(_loc6_);
                     if(_loc6_.removeOnBreak)
                     {
                        _loc6_.component.sleeping = true;
                        midstep = false;
                        if(_loc6_.compound != null)
                        {
                           _loc6_.compound.wrap_constraints.remove(_loc6_.outer);
                        }
                        else
                        {
                           wrap_constraints.remove(_loc6_.outer);
                        }
                        midstep = true;
                     }
                     else
                     {
                        _loc6_.active = false;
                     }
                     _loc6_.clearcache();
                     continue;
                  }
               }
               _loc4_ = _loc5_;
               _loc5_ = _loc5_.next;
            }
            _loc7_ = c_arbiters_false.head;
            _loc8_ = true;
            if(_loc7_ == null)
            {
               _loc7_ = c_arbiters_true.head;
               _loc8_ = false;
            }
            while(_loc7_ != null)
            {
               _loc9_ = _loc7_.elt;
               if(_loc9_.active && (_loc9_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
               {
                  if(_loc9_.ptype == 2)
                  {
                     _loc10_ = _loc9_.c1;
                     _loc11_ = 0;
                     _loc12_ = 0;
                     _loc13_ = 0;
                     _loc14_ = 0;
                     _loc13_ = _loc9_.b2.axisy * _loc10_.lr2x - _loc9_.b2.axisx * _loc10_.lr2y;
                     _loc14_ = _loc10_.lr2x * _loc9_.b2.axisx + _loc10_.lr2y * _loc9_.b2.axisy;
                     _loc15_ = 1;
                     _loc13_ += _loc9_.b2.posx * _loc15_;
                     _loc14_ += _loc9_.b2.posy * _loc15_;
                     _loc15_ = 0;
                     _loc16_ = 0;
                     _loc15_ = _loc9_.b1.axisy * _loc10_.lr1x - _loc9_.b1.axisx * _loc10_.lr1y;
                     _loc16_ = _loc10_.lr1x * _loc9_.b1.axisx + _loc10_.lr1y * _loc9_.b1.axisy;
                     _loc17_ = 1;
                     _loc15_ += _loc9_.b1.posx * _loc17_;
                     _loc16_ += _loc9_.b1.posy * _loc17_;
                     _loc17_ = 0;
                     _loc18_ = 0;
                     _loc17_ = _loc13_ - _loc15_;
                     _loc18_ = _loc14_ - _loc16_;
                     _loc20_ = _loc17_ * _loc17_ + _loc18_ * _loc18_;
                     _loc19_ = _loc20_ == 0 ? 0 : (sf32(_loc20_,0), si32(1597463007 - (li32(0) >> 1),0), _loc21_ = lf32(0), 1 / (_loc21_ * (1.5 - 0.5 * _loc20_ * _loc21_ * _loc21_)));
                     _loc20_ = _loc9_.radius - Config.collisionSlop;
                     _loc21_ = _loc19_ - _loc20_;
                     if(_loc17_ * _loc9_.nx + _loc18_ * _loc9_.ny < 0)
                     {
                        _loc17_ = -_loc17_;
                        _loc18_ = -_loc18_;
                        _loc21_ -= _loc9_.radius;
                     }
                     if(_loc21_ < 0)
                     {
                        if(_loc19_ < Config.epsilon)
                        {
                           if(_loc9_.b1.smass != 0)
                           {
                              _loc9_.b1.posx += Config.epsilon * 10;
                           }
                           else
                           {
                              _loc9_.b2.posx += Config.epsilon * 10;
                           }
                        }
                        else
                        {
                           _loc22_ = 1 / _loc19_;
                           _loc17_ *= _loc22_;
                           _loc18_ *= _loc22_;
                           _loc22_ = 0.5 * (_loc15_ + _loc13_);
                           _loc23_ = 0.5 * (_loc16_ + _loc14_);
                           _loc24_ = _loc19_ - _loc20_;
                           _loc15_ = _loc22_ - _loc9_.b1.posx;
                           _loc16_ = _loc23_ - _loc9_.b1.posy;
                           _loc13_ = _loc22_ - _loc9_.b2.posx;
                           _loc14_ = _loc23_ - _loc9_.b2.posy;
                           _loc25_ = _loc18_ * _loc15_ - _loc17_ * _loc16_;
                           _loc26_ = _loc18_ * _loc13_ - _loc17_ * _loc14_;
                           _loc27_ = _loc9_.b2.smass + _loc26_ * _loc26_ * _loc9_.b2.sinertia + _loc9_.b1.smass + _loc25_ * _loc25_ * _loc9_.b1.sinertia;
                           if(_loc27_ != 0)
                           {
                              _loc28_ = -_loc9_.biasCoef * _loc24_ / _loc27_;
                              _loc29_ = 0;
                              _loc30_ = 0;
                              _loc31_ = _loc28_;
                              _loc29_ = _loc17_ * _loc31_;
                              _loc30_ = _loc18_ * _loc31_;
                              _loc31_ = _loc9_.b1.imass;
                              _loc9_.b1.posx -= _loc29_ * _loc31_;
                              _loc9_.b1.posy -= _loc30_ * _loc31_;
                              _loc32_ = _loc9_.b1;
                              _loc31_ = -_loc25_ * _loc9_.b1.iinertia * _loc28_;
                              _loc32_.rot += _loc31_;
                              if(_loc31_ * _loc31_ > 0.0001)
                              {
                                 _loc32_.axisx = Math.sin(_loc32_.rot);
                                 _loc32_.axisy = Math.cos(_loc32_.rot);
                                 null;
                              }
                              else
                              {
                                 _loc33_ = _loc31_ * _loc31_;
                                 _loc34_ = 1 - 0.5 * _loc33_;
                                 _loc35_ = 1 - _loc33_ * _loc33_ / 8;
                                 _loc36_ = (_loc34_ * _loc32_.axisx + _loc31_ * _loc32_.axisy) * _loc35_;
                                 _loc32_.axisy = (_loc34_ * _loc32_.axisy - _loc31_ * _loc32_.axisx) * _loc35_;
                                 _loc32_.axisx = _loc36_;
                              }
                              _loc31_ = _loc9_.b2.imass;
                              _loc9_.b2.posx += _loc29_ * _loc31_;
                              _loc9_.b2.posy += _loc30_ * _loc31_;
                              _loc32_ = _loc9_.b2;
                              _loc31_ = _loc26_ * _loc9_.b2.iinertia * _loc28_;
                              _loc32_.rot += _loc31_;
                              if(_loc31_ * _loc31_ > 0.0001)
                              {
                                 _loc32_.axisx = Math.sin(_loc32_.rot);
                                 _loc32_.axisy = Math.cos(_loc32_.rot);
                                 null;
                              }
                              else
                              {
                                 _loc33_ = _loc31_ * _loc31_;
                                 _loc34_ = 1 - 0.5 * _loc33_;
                                 _loc35_ = 1 - _loc33_ * _loc33_ / 8;
                                 _loc36_ = (_loc34_ * _loc32_.axisx + _loc31_ * _loc32_.axisy) * _loc35_;
                                 _loc32_.axisy = (_loc34_ * _loc32_.axisy - _loc31_ * _loc32_.axisx) * _loc35_;
                                 _loc32_.axisx = _loc36_;
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     _loc11_ = 0;
                     _loc12_ = 0;
                     _loc14_ = 0;
                     _loc15_ = 0;
                     _loc16_ = 0;
                     _loc17_ = 0;
                     if(_loc9_.ptype == 0)
                     {
                        _loc11_ = _loc9_.b1.axisy * _loc9_.lnormx - _loc9_.b1.axisx * _loc9_.lnormy;
                        _loc12_ = _loc9_.lnormx * _loc9_.b1.axisx + _loc9_.lnormy * _loc9_.b1.axisy;
                        _loc13_ = _loc9_.lproj + (_loc11_ * _loc9_.b1.posx + _loc12_ * _loc9_.b1.posy);
                        _loc14_ = _loc9_.b2.axisy * _loc9_.c1.lr1x - _loc9_.b2.axisx * _loc9_.c1.lr1y;
                        _loc15_ = _loc9_.c1.lr1x * _loc9_.b2.axisx + _loc9_.c1.lr1y * _loc9_.b2.axisy;
                        _loc18_ = 1;
                        _loc14_ += _loc9_.b2.posx * _loc18_;
                        _loc15_ += _loc9_.b2.posy * _loc18_;
                        if(_loc9_.hpc2)
                        {
                           _loc16_ = _loc9_.b2.axisy * _loc9_.c2.lr1x - _loc9_.b2.axisx * _loc9_.c2.lr1y;
                           _loc17_ = _loc9_.c2.lr1x * _loc9_.b2.axisx + _loc9_.c2.lr1y * _loc9_.b2.axisy;
                           _loc18_ = 1;
                           _loc16_ += _loc9_.b2.posx * _loc18_;
                           _loc17_ += _loc9_.b2.posy * _loc18_;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc9_.b2.axisy * _loc9_.lnormx - _loc9_.b2.axisx * _loc9_.lnormy;
                        _loc12_ = _loc9_.lnormx * _loc9_.b2.axisx + _loc9_.lnormy * _loc9_.b2.axisy;
                        _loc13_ = _loc9_.lproj + (_loc11_ * _loc9_.b2.posx + _loc12_ * _loc9_.b2.posy);
                        _loc14_ = _loc9_.b1.axisy * _loc9_.c1.lr1x - _loc9_.b1.axisx * _loc9_.c1.lr1y;
                        _loc15_ = _loc9_.c1.lr1x * _loc9_.b1.axisx + _loc9_.c1.lr1y * _loc9_.b1.axisy;
                        _loc18_ = 1;
                        _loc14_ += _loc9_.b1.posx * _loc18_;
                        _loc15_ += _loc9_.b1.posy * _loc18_;
                        if(_loc9_.hpc2)
                        {
                           _loc16_ = _loc9_.b1.axisy * _loc9_.c2.lr1x - _loc9_.b1.axisx * _loc9_.c2.lr1y;
                           _loc17_ = _loc9_.c2.lr1x * _loc9_.b1.axisx + _loc9_.c2.lr1y * _loc9_.b1.axisy;
                           _loc18_ = 1;
                           _loc16_ += _loc9_.b1.posx * _loc18_;
                           _loc17_ += _loc9_.b1.posy * _loc18_;
                        }
                     }
                     _loc18_ = _loc14_ * _loc11_ + _loc15_ * _loc12_ - _loc13_ - _loc9_.radius;
                     _loc18_ += Config.collisionSlop;
                     _loc19_ = 0;
                     if(_loc9_.hpc2)
                     {
                        _loc19_ = _loc16_ * _loc11_ + _loc17_ * _loc12_ - _loc13_ - _loc9_.radius;
                        _loc19_ += Config.collisionSlop;
                     }
                     if(_loc18_ < 0 || _loc19_ < 0)
                     {
                        if(_loc9_.rev)
                        {
                           _loc11_ = -_loc11_;
                           _loc12_ = -_loc12_;
                        }
                        _loc20_ = 0;
                        _loc21_ = 0;
                        _loc20_ = _loc14_ - _loc9_.b1.posx;
                        _loc21_ = _loc15_ - _loc9_.b1.posy;
                        _loc22_ = 0;
                        _loc23_ = 0;
                        _loc22_ = _loc14_ - _loc9_.b2.posx;
                        _loc23_ = _loc15_ - _loc9_.b2.posy;
                        _loc24_ = 0;
                        _loc25_ = 0;
                        _loc26_ = 0;
                        _loc27_ = 0;
                        if(_loc9_.hpc2)
                        {
                           _loc24_ = _loc16_ - _loc9_.b1.posx;
                           _loc25_ = _loc17_ - _loc9_.b1.posy;
                           _loc26_ = _loc16_ - _loc9_.b2.posx;
                           _loc27_ = _loc17_ - _loc9_.b2.posy;
                           _loc28_ = _loc12_ * _loc20_ - _loc11_ * _loc21_;
                           _loc29_ = _loc12_ * _loc22_ - _loc11_ * _loc23_;
                           _loc30_ = _loc12_ * _loc24_ - _loc11_ * _loc25_;
                           _loc31_ = _loc12_ * _loc26_ - _loc11_ * _loc27_;
                           _loc33_ = _loc9_.b1.smass + _loc9_.b2.smass;
                           _loc9_.kMassa = _loc33_ + _loc9_.b1.sinertia * _loc28_ * _loc28_ + _loc9_.b2.sinertia * _loc29_ * _loc29_;
                           _loc9_.kMassb = _loc33_ + _loc9_.b1.sinertia * _loc28_ * _loc30_ + _loc9_.b2.sinertia * _loc29_ * _loc31_;
                           _loc9_.kMassc = _loc33_ + _loc9_.b1.sinertia * _loc30_ * _loc30_ + _loc9_.b2.sinertia * _loc31_ * _loc31_;
                           _loc34_ = 0;
                           _loc35_ = 0;
                           _loc36_ = 0;
                           _loc34_ = _loc9_.kMassa;
                           _loc35_ = _loc9_.kMassb;
                           _loc36_ = _loc9_.kMassc;
                           _loc37_ = _loc18_ * _loc9_.biasCoef;
                           _loc38_ = _loc19_ * _loc9_.biasCoef;
                           do
                           {
                              _loc39_ = 0;
                              _loc40_ = 0;
                              _loc39_ = _loc37_;
                              _loc40_ = _loc38_;
                              _loc39_ = -_loc39_;
                              _loc40_ = -_loc40_;
                              _loc41_ = _loc9_.kMassa * _loc9_.kMassc - _loc9_.kMassb * _loc9_.kMassb;
                              if(_loc41_ != _loc41_)
                              {
                                 _loc39_ = _loc40_ = 0;
                              }
                              else if(_loc41_ == 0)
                              {
                                 if(_loc9_.kMassa != 0)
                                 {
                                    _loc39_ /= _loc9_.kMassa;
                                 }
                                 else
                                 {
                                    _loc39_ = 0;
                                 }
                                 if(_loc9_.kMassc != 0)
                                 {
                                    _loc40_ /= _loc9_.kMassc;
                                 }
                                 else
                                 {
                                    _loc40_ = 0;
                                 }
                              }
                              else
                              {
                                 _loc41_ = 1 / _loc41_;
                                 _loc42_ = _loc41_ * (_loc9_.kMassc * _loc39_ - _loc9_.kMassb * _loc40_);
                                 _loc40_ = _loc41_ * (_loc9_.kMassa * _loc40_ - _loc9_.kMassb * _loc39_);
                                 _loc39_ = _loc42_;
                              }
                              if(_loc39_ >= 0 && _loc40_ >= 0)
                              {
                                 _loc41_ = (_loc39_ + _loc40_) * _loc9_.b1.imass;
                                 _loc9_.b1.posx -= _loc11_ * _loc41_;
                                 _loc9_.b1.posy -= _loc12_ * _loc41_;
                                 _loc32_ = _loc9_.b1;
                                 _loc41_ = -_loc9_.b1.iinertia * (_loc28_ * _loc39_ + _loc30_ * _loc40_);
                                 _loc32_.rot += _loc41_;
                                 if(_loc41_ * _loc41_ > 0.0001)
                                 {
                                    _loc32_.axisx = Math.sin(_loc32_.rot);
                                    _loc32_.axisy = Math.cos(_loc32_.rot);
                                    null;
                                 }
                                 else
                                 {
                                    _loc42_ = _loc41_ * _loc41_;
                                    _loc43_ = 1 - 0.5 * _loc42_;
                                    _loc44_ = 1 - _loc42_ * _loc42_ / 8;
                                    _loc45_ = (_loc43_ * _loc32_.axisx + _loc41_ * _loc32_.axisy) * _loc44_;
                                    _loc32_.axisy = (_loc43_ * _loc32_.axisy - _loc41_ * _loc32_.axisx) * _loc44_;
                                    _loc32_.axisx = _loc45_;
                                 }
                                 _loc41_ = (_loc39_ + _loc40_) * _loc9_.b2.imass;
                                 _loc9_.b2.posx += _loc11_ * _loc41_;
                                 _loc9_.b2.posy += _loc12_ * _loc41_;
                                 _loc32_ = _loc9_.b2;
                                 _loc41_ = _loc9_.b2.iinertia * (_loc29_ * _loc39_ + _loc31_ * _loc40_);
                                 _loc32_.rot += _loc41_;
                                 if(_loc41_ * _loc41_ > 0.0001)
                                 {
                                    _loc32_.axisx = Math.sin(_loc32_.rot);
                                    _loc32_.axisy = Math.cos(_loc32_.rot);
                                    null;
                                 }
                                 else
                                 {
                                    _loc42_ = _loc41_ * _loc41_;
                                    _loc43_ = 1 - 0.5 * _loc42_;
                                    _loc44_ = 1 - _loc42_ * _loc42_ / 8;
                                    _loc45_ = (_loc43_ * _loc32_.axisx + _loc41_ * _loc32_.axisy) * _loc44_;
                                    _loc32_.axisy = (_loc43_ * _loc32_.axisy - _loc41_ * _loc32_.axisx) * _loc44_;
                                    _loc32_.axisx = _loc45_;
                                 }
                                 break;
                              }
                              _loc39_ = -_loc37_ / _loc34_;
                              _loc40_ = 0;
                              _loc41_ = _loc35_ * _loc39_ + _loc38_;
                              if(_loc39_ >= 0 && _loc41_ >= 0)
                              {
                                 _loc42_ = (_loc39_ + _loc40_) * _loc9_.b1.imass;
                                 _loc9_.b1.posx -= _loc11_ * _loc42_;
                                 _loc9_.b1.posy -= _loc12_ * _loc42_;
                                 _loc32_ = _loc9_.b1;
                                 _loc42_ = -_loc9_.b1.iinertia * (_loc28_ * _loc39_ + _loc30_ * _loc40_);
                                 _loc32_.rot += _loc42_;
                                 if(_loc42_ * _loc42_ > 0.0001)
                                 {
                                    _loc32_.axisx = Math.sin(_loc32_.rot);
                                    _loc32_.axisy = Math.cos(_loc32_.rot);
                                    null;
                                 }
                                 else
                                 {
                                    _loc43_ = _loc42_ * _loc42_;
                                    _loc44_ = 1 - 0.5 * _loc43_;
                                    _loc45_ = 1 - _loc43_ * _loc43_ / 8;
                                    _loc46_ = (_loc44_ * _loc32_.axisx + _loc42_ * _loc32_.axisy) * _loc45_;
                                    _loc32_.axisy = (_loc44_ * _loc32_.axisy - _loc42_ * _loc32_.axisx) * _loc45_;
                                    _loc32_.axisx = _loc46_;
                                 }
                                 _loc42_ = (_loc39_ + _loc40_) * _loc9_.b2.imass;
                                 _loc9_.b2.posx += _loc11_ * _loc42_;
                                 _loc9_.b2.posy += _loc12_ * _loc42_;
                                 _loc32_ = _loc9_.b2;
                                 _loc42_ = _loc9_.b2.iinertia * (_loc29_ * _loc39_ + _loc31_ * _loc40_);
                                 _loc32_.rot += _loc42_;
                                 if(_loc42_ * _loc42_ > 0.0001)
                                 {
                                    _loc32_.axisx = Math.sin(_loc32_.rot);
                                    _loc32_.axisy = Math.cos(_loc32_.rot);
                                    null;
                                 }
                                 else
                                 {
                                    _loc43_ = _loc42_ * _loc42_;
                                    _loc44_ = 1 - 0.5 * _loc43_;
                                    _loc45_ = 1 - _loc43_ * _loc43_ / 8;
                                    _loc46_ = (_loc44_ * _loc32_.axisx + _loc42_ * _loc32_.axisy) * _loc45_;
                                    _loc32_.axisy = (_loc44_ * _loc32_.axisy - _loc42_ * _loc32_.axisx) * _loc45_;
                                    _loc32_.axisx = _loc46_;
                                 }
                                 break;
                              }
                              _loc39_ = 0;
                              _loc40_ = -_loc38_ / _loc36_;
                              _loc42_ = _loc35_ * _loc40_ + _loc37_;
                              if(_loc40_ >= 0 && _loc42_ >= 0)
                              {
                                 _loc43_ = (_loc39_ + _loc40_) * _loc9_.b1.imass;
                                 _loc9_.b1.posx -= _loc11_ * _loc43_;
                                 _loc9_.b1.posy -= _loc12_ * _loc43_;
                                 _loc32_ = _loc9_.b1;
                                 _loc43_ = -_loc9_.b1.iinertia * (_loc28_ * _loc39_ + _loc30_ * _loc40_);
                                 _loc32_.rot += _loc43_;
                                 if(_loc43_ * _loc43_ > 0.0001)
                                 {
                                    _loc32_.axisx = Math.sin(_loc32_.rot);
                                    _loc32_.axisy = Math.cos(_loc32_.rot);
                                    null;
                                 }
                                 else
                                 {
                                    _loc44_ = _loc43_ * _loc43_;
                                    _loc45_ = 1 - 0.5 * _loc44_;
                                    _loc46_ = 1 - _loc44_ * _loc44_ / 8;
                                    _loc47_ = (_loc45_ * _loc32_.axisx + _loc43_ * _loc32_.axisy) * _loc46_;
                                    _loc32_.axisy = (_loc45_ * _loc32_.axisy - _loc43_ * _loc32_.axisx) * _loc46_;
                                    _loc32_.axisx = _loc47_;
                                 }
                                 _loc43_ = (_loc39_ + _loc40_) * _loc9_.b2.imass;
                                 _loc9_.b2.posx += _loc11_ * _loc43_;
                                 _loc9_.b2.posy += _loc12_ * _loc43_;
                                 _loc32_ = _loc9_.b2;
                                 _loc43_ = _loc9_.b2.iinertia * (_loc29_ * _loc39_ + _loc31_ * _loc40_);
                                 _loc32_.rot += _loc43_;
                                 if(_loc43_ * _loc43_ > 0.0001)
                                 {
                                    _loc32_.axisx = Math.sin(_loc32_.rot);
                                    _loc32_.axisy = Math.cos(_loc32_.rot);
                                    null;
                                 }
                                 else
                                 {
                                    _loc44_ = _loc43_ * _loc43_;
                                    _loc45_ = 1 - 0.5 * _loc44_;
                                    _loc46_ = 1 - _loc44_ * _loc44_ / 8;
                                    _loc47_ = (_loc45_ * _loc32_.axisx + _loc43_ * _loc32_.axisy) * _loc46_;
                                    _loc32_.axisy = (_loc45_ * _loc32_.axisy - _loc43_ * _loc32_.axisx) * _loc46_;
                                    _loc32_.axisx = _loc47_;
                                 }
                                 break;
                              }
                           }
                           while(false);
                           
                        }
                        else
                        {
                           _loc28_ = _loc12_ * _loc20_ - _loc11_ * _loc21_;
                           _loc29_ = _loc12_ * _loc22_ - _loc11_ * _loc23_;
                           _loc30_ = _loc9_.b2.smass + _loc29_ * _loc29_ * _loc9_.b2.sinertia + _loc9_.b1.smass + _loc28_ * _loc28_ * _loc9_.b1.sinertia;
                           if(_loc30_ != 0)
                           {
                              _loc31_ = -_loc9_.biasCoef * _loc18_ / _loc30_;
                              _loc33_ = 0;
                              _loc34_ = 0;
                              _loc35_ = _loc31_;
                              _loc33_ = _loc11_ * _loc35_;
                              _loc34_ = _loc12_ * _loc35_;
                              _loc35_ = _loc9_.b1.imass;
                              _loc9_.b1.posx -= _loc33_ * _loc35_;
                              _loc9_.b1.posy -= _loc34_ * _loc35_;
                              _loc32_ = _loc9_.b1;
                              _loc35_ = -_loc28_ * _loc9_.b1.iinertia * _loc31_;
                              _loc32_.rot += _loc35_;
                              if(_loc35_ * _loc35_ > 0.0001)
                              {
                                 _loc32_.axisx = Math.sin(_loc32_.rot);
                                 _loc32_.axisy = Math.cos(_loc32_.rot);
                                 null;
                              }
                              else
                              {
                                 _loc36_ = _loc35_ * _loc35_;
                                 _loc37_ = 1 - 0.5 * _loc36_;
                                 _loc38_ = 1 - _loc36_ * _loc36_ / 8;
                                 _loc39_ = (_loc37_ * _loc32_.axisx + _loc35_ * _loc32_.axisy) * _loc38_;
                                 _loc32_.axisy = (_loc37_ * _loc32_.axisy - _loc35_ * _loc32_.axisx) * _loc38_;
                                 _loc32_.axisx = _loc39_;
                              }
                              _loc35_ = _loc9_.b2.imass;
                              _loc9_.b2.posx += _loc33_ * _loc35_;
                              _loc9_.b2.posy += _loc34_ * _loc35_;
                              _loc32_ = _loc9_.b2;
                              _loc35_ = _loc29_ * _loc9_.b2.iinertia * _loc31_;
                              _loc32_.rot += _loc35_;
                              if(_loc35_ * _loc35_ > 0.0001)
                              {
                                 _loc32_.axisx = Math.sin(_loc32_.rot);
                                 _loc32_.axisy = Math.cos(_loc32_.rot);
                                 null;
                              }
                              else
                              {
                                 _loc36_ = _loc35_ * _loc35_;
                                 _loc37_ = 1 - 0.5 * _loc36_;
                                 _loc38_ = 1 - _loc36_ * _loc36_ / 8;
                                 _loc39_ = (_loc37_ * _loc32_.axisx + _loc35_ * _loc32_.axisy) * _loc38_;
                                 _loc32_.axisy = (_loc37_ * _loc32_.axisy - _loc35_ * _loc32_.axisx) * _loc38_;
                                 _loc32_.axisx = _loc39_;
                              }
                           }
                        }
                     }
                  }
               }
               _loc7_ = _loc7_.next;
               if(_loc8_ && _loc7_ == null)
               {
                  _loc7_ = c_arbiters_true.head;
                  _loc8_ = false;
               }
            }
         }
      }
      
      public function inlined_MRCA_chains(param1:ZPP_Shape, param2:ZPP_Shape) : void
      {
         var _loc3_:* = null as ZNPList_ZPP_Interactor;
         var _loc4_:* = null as ZNPNode_ZPP_Interactor;
         var _loc5_:* = null as ZNPNode_ZPP_Interactor;
         var _loc6_:* = null as ZPP_Interactor;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc3_ = mrca1;
         while(_loc3_.head != null)
         {
            _loc4_ = _loc3_.head;
            _loc3_.head = _loc4_.next;
            _loc5_ = _loc4_;
            _loc5_.elt = null;
            _loc5_.next = ZNPNode_ZPP_Interactor.zpp_pool;
            ZNPNode_ZPP_Interactor.zpp_pool = _loc5_;
            if(_loc3_.head == null)
            {
               _loc3_.pushmod = true;
            }
            _loc3_.modified = true;
            --_loc3_.length;
         }
         _loc3_.pushmod = true;
         _loc3_ = mrca2;
         while(_loc3_.head != null)
         {
            _loc4_ = _loc3_.head;
            _loc3_.head = _loc4_.next;
            _loc5_ = _loc4_;
            _loc5_.elt = null;
            _loc5_.next = ZNPNode_ZPP_Interactor.zpp_pool;
            ZNPNode_ZPP_Interactor.zpp_pool = _loc5_;
            if(_loc3_.head == null)
            {
               _loc3_.pushmod = true;
            }
            _loc3_.modified = true;
            --_loc3_.length;
         }
         _loc3_.pushmod = true;
         if(param1.cbSet != null)
         {
            _loc3_ = mrca1;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = param1;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            ++_loc3_.length;
            param1;
         }
         if(param1.body.cbSet != null)
         {
            _loc3_ = mrca1;
            _loc6_ = param1.body;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = _loc6_;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            ++_loc3_.length;
            _loc6_;
         }
         if(param2.cbSet != null)
         {
            _loc3_ = mrca2;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = param2;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            ++_loc3_.length;
            param2;
         }
         if(param2.body.cbSet != null)
         {
            _loc3_ = mrca2;
            _loc6_ = param2.body;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = _loc6_;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            ++_loc3_.length;
            _loc6_;
         }
         var _loc7_:ZPP_Compound = param1.body.compound;
         var _loc8_:ZPP_Compound = param2.body.compound;
         while(_loc7_ != _loc8_)
         {
            _loc9_ = _loc7_ == null ? 0 : _loc7_.depth;
            _loc10_ = _loc8_ == null ? 0 : _loc8_.depth;
            if(_loc9_ < _loc10_)
            {
               if(_loc8_.cbSet != null)
               {
                  _loc3_ = mrca2;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc5_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
                     _loc5_.next = null;
                  }
                  null;
                  _loc5_.elt = _loc8_;
                  _loc4_ = _loc5_;
                  _loc4_.next = _loc3_.head;
                  _loc3_.head = _loc4_;
                  _loc3_.modified = true;
                  ++_loc3_.length;
                  _loc8_;
               }
               _loc8_ = _loc8_.compound;
            }
            else
            {
               if(_loc7_.cbSet != null)
               {
                  _loc3_ = mrca1;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc5_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
                     _loc5_.next = null;
                  }
                  null;
                  _loc5_.elt = _loc7_;
                  _loc4_ = _loc5_;
                  _loc4_.next = _loc3_.head;
                  _loc3_.head = _loc4_;
                  _loc3_.modified = true;
                  ++_loc3_.length;
                  _loc7_;
               }
               _loc7_ = _loc7_.compound;
            }
         }
      }
      
      public function gravity_validate() : void
      {
         wrap_gravity.zpp_inner.x = gravityx;
         wrap_gravity.zpp_inner.y = gravityy;
      }
      
      public function gravity_invalidate(param1:ZPP_Vec2) : void
      {
         var _loc3_:* = null as ZNPNode_ZPP_Body;
         var _loc4_:* = null as ZPP_Body;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Compound;
         var _loc7_:* = null as ZPP_Compound;
         var _loc8_:* = null as ZPP_Compound;
         if(midstep)
         {
            Boot.lastError = new Error();
            throw "Error: Space::gravity cannot be set during space step";
         }
         gravityx = param1.x;
         gravityy = param1.y;
         var _loc2_:ZNPList_ZPP_Compound = new ZNPList_ZPP_Compound();
         _loc3_ = bodies.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            _loc5_ = _loc4_;
            if(!_loc5_.world)
            {
               _loc5_.component.waket = stamp + (midstep ? 0 : 1);
               if(_loc5_.component.sleeping)
               {
                  really_wake(_loc5_,false);
               }
            }
            _loc3_ = _loc3_.next;
         }
         _loc6_ = compounds.head;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.elt;
            _loc2_.add(_loc7_);
            _loc6_ = _loc6_.next;
         }
         while(_loc2_.head != null)
         {
            _loc7_ = _loc2_.pop_unsafe();
            _loc3_ = _loc7_.bodies.head;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_.elt;
               _loc5_ = _loc4_;
               if(!_loc5_.world)
               {
                  _loc5_.component.waket = stamp + (midstep ? 0 : 1);
                  if(_loc5_.component.sleeping)
                  {
                     really_wake(_loc5_,false);
                  }
               }
               _loc3_ = _loc3_.next;
            }
            _loc6_ = _loc7_.compounds.head;
            while(_loc6_ != null)
            {
               _loc8_ = _loc6_.elt;
               _loc2_.add(_loc8_);
               _loc6_ = _loc6_.next;
            }
         }
      }
      
      public function getgravity() : void
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc1_:Number = gravityx;
         var _loc2_:Number = gravityy;
         var _loc3_:Boolean = false;
         §§push(§§findproperty(wrap_gravity));
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
         §§pop().wrap_gravity = _loc4_;
         wrap_gravity.zpp_inner._inuse = true;
         wrap_gravity.zpp_inner._invalidate = gravity_invalidate;
         wrap_gravity.zpp_inner._validate = gravity_validate;
      }
      
      public function freshListenerType(param1:ZPP_CbSet, param2:ZPP_CbSet) : void
      {
         var _loc4_:* = null as ZNPNode_ZPP_Interactor;
         var _loc5_:* = null as ZPP_Interactor;
         var _loc6_:* = null as ZPP_Compound;
         var _loc7_:* = null as ZNPNode_ZPP_Body;
         var _loc8_:* = null as ZPP_Body;
         var _loc9_:* = null as ZNPNode_ZPP_Compound;
         var _loc10_:* = null as ZPP_Compound;
         var _loc11_:* = null as ZPP_Shape;
         var _loc12_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc13_:* = null as ZPP_Arbiter;
         var _loc14_:* = null as ZPP_Interactor;
         var _loc15_:* = null as ZNPNode_ZPP_Interactor;
         var _loc16_:* = null as ZPP_Interactor;
         var _loc17_:* = null as ZPP_CallbackSet;
         var _loc18_:Boolean = false;
         var _loc19_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc20_:* = null as ZPP_Arbiter;
         var _loc21_:* = null as ZNPList_ZPP_Arbiter;
         var _loc22_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc3_:ZNPList_ZPP_Interactor = new ZNPList_ZPP_Interactor();
         _loc4_ = param1.interactors.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc3_.add(_loc5_);
            _loc4_ = _loc4_.next;
         }
         if(param1 != param2)
         {
            _loc4_ = param2.interactors.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               _loc3_.add(_loc5_);
               _loc4_ = _loc4_.next;
            }
         }
         while(_loc3_.head != null)
         {
            _loc5_ = _loc3_.pop_unsafe();
            if(_loc5_.icompound != null)
            {
               _loc6_ = _loc5_.icompound;
               _loc7_ = _loc6_.bodies.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc3_.add(_loc8_);
                  _loc7_ = _loc7_.next;
               }
               _loc9_ = _loc6_.compounds.head;
               while(_loc9_ != null)
               {
                  _loc10_ = _loc9_.elt;
                  _loc3_.add(_loc10_);
                  _loc9_ = _loc9_.next;
               }
            }
            else
            {
               _loc8_ = _loc5_.ibody != null ? _loc5_.ibody : _loc5_.ishape.body;
               _loc11_ = _loc5_.ishape != null ? _loc5_.ishape : null;
               _loc12_ = _loc8_.arbiters.head;
               while(_loc12_ != null)
               {
                  _loc13_ = _loc12_.elt;
                  if(!_loc13_.presentable)
                  {
                     _loc12_ = _loc12_.next;
                  }
                  else if(_loc11_ != null && !(_loc13_.ws1 == _loc11_ || _loc13_.ws2 == _loc11_))
                  {
                     _loc12_ = _loc12_.next;
                  }
                  else
                  {
                     MRCA_chains(_loc13_.ws1,_loc13_.ws2);
                     _loc4_ = mrca1.head;
                     while(_loc4_ != null)
                     {
                        _loc14_ = _loc4_.elt;
                        if(_loc14_.cbSet != param1 && _loc14_.cbSet != param2)
                        {
                           _loc4_ = _loc4_.next;
                        }
                        else
                        {
                           _loc15_ = mrca2.head;
                           while(_loc15_ != null)
                           {
                              _loc16_ = _loc15_.elt;
                              if(_loc14_.cbSet == param1 && _loc16_.cbSet != param2 || _loc14_.cbSet == param2 && _loc16_.cbSet != param1)
                              {
                                 _loc15_ = _loc15_.next;
                              }
                              else
                              {
                                 _loc17_ = ZPP_Interactor.get(_loc14_,_loc16_);
                                 if(_loc17_ == null)
                                 {
                                    _loc17_ = ZPP_CallbackSet.get(_loc14_,_loc16_);
                                    add_callbackset(_loc17_);
                                 }
                                 _loc18_ = false;
                                 _loc19_ = _loc17_.arbiters.head;
                                 while(_loc19_ != null)
                                 {
                                    _loc20_ = _loc19_.elt;
                                    if(_loc20_ == _loc13_)
                                    {
                                       _loc18_ = true;
                                       break;
                                    }
                                    _loc19_ = _loc19_.next;
                                 }
                                 if(!_loc18_)
                                 {
                                    _loc21_ = _loc17_.arbiters;
                                    if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                    {
                                       _loc22_ = new ZNPNode_ZPP_Arbiter();
                                    }
                                    else
                                    {
                                       _loc22_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                                       ZNPNode_ZPP_Arbiter.zpp_pool = _loc22_.next;
                                       _loc22_.next = null;
                                    }
                                    null;
                                    _loc22_.elt = _loc13_;
                                    _loc19_ = _loc22_;
                                    _loc19_.next = _loc21_.head;
                                    _loc21_.head = _loc19_;
                                    _loc21_.modified = true;
                                    ++_loc21_.length;
                                    _loc13_;
                                    §§push(true);
                                 }
                                 else
                                 {
                                    §§push(false);
                                 }
                                 if(§§pop())
                                 {
                                    ++_loc13_.present;
                                 }
                                 _loc15_ = _loc15_.next;
                              }
                           }
                           _loc4_ = _loc4_.next;
                        }
                     }
                     _loc12_ = _loc12_.next;
                  }
               }
            }
         }
      }
      
      public function freshInteractorType(param1:ZPP_Interactor, param2:ZPP_Interactor = undefined) : void
      {
         var _loc3_:* = null as ZPP_Compound;
         var _loc4_:* = null as ZNPNode_ZPP_Body;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Compound;
         var _loc7_:* = null as ZPP_Compound;
         var _loc8_:* = null as ZPP_Shape;
         var _loc9_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as ZNPNode_ZPP_Interactor;
         var _loc12_:* = null as ZPP_Interactor;
         var _loc13_:* = null as ZNPNode_ZPP_Interactor;
         var _loc14_:* = null as ZPP_Interactor;
         var _loc15_:* = null as ZPP_CbSet;
         var _loc16_:* = null as ZPP_CbSet;
         var _loc17_:* = null as ZPP_CbSetPair;
         var _loc18_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc19_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc20_:* = null as ZPP_CbSetPair;
         var _loc21_:* = null as ZPP_CallbackSet;
         var _loc22_:Boolean = false;
         var _loc23_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc24_:* = null as ZPP_Arbiter;
         var _loc25_:* = null as ZNPList_ZPP_Arbiter;
         var _loc26_:* = null as ZNPNode_ZPP_Arbiter;
         if(param2 == null)
         {
            param2 = param1;
         }
         if(param1.icompound != null)
         {
            _loc3_ = param1.icompound;
            _loc4_ = _loc3_.bodies.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               freshInteractorType(_loc5_,param2);
               _loc4_ = _loc4_.next;
            }
            _loc6_ = _loc3_.compounds.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               freshInteractorType(_loc7_,param2);
               _loc6_ = _loc6_.next;
            }
         }
         else
         {
            _loc5_ = param1.ibody != null ? param1.ibody : param1.ishape.body;
            _loc8_ = param1.ishape != null ? param1.ishape : null;
            _loc9_ = _loc5_.arbiters.head;
            while(_loc9_ != null)
            {
               _loc10_ = _loc9_.elt;
               if(!_loc10_.presentable)
               {
                  _loc9_ = _loc9_.next;
               }
               else if(_loc8_ != null && !(_loc10_.ws1 == _loc8_ || _loc10_.ws2 == _loc8_))
               {
                  _loc9_ = _loc9_.next;
               }
               else
               {
                  MRCA_chains(_loc10_.ws1,_loc10_.ws2);
                  _loc11_ = mrca1.head;
                  while(_loc11_ != null)
                  {
                     _loc12_ = _loc11_.elt;
                     _loc13_ = mrca2.head;
                     while(_loc13_ != null)
                     {
                        _loc14_ = _loc13_.elt;
                        if(_loc12_ != param2 && _loc14_ != param2)
                        {
                           _loc13_ = _loc13_.next;
                        }
                        else
                        {
                           _loc15_ = _loc12_.cbSet;
                           _loc16_ = _loc14_.cbSet;
                           _loc15_.validate();
                           _loc16_.validate();
                           _loc17_ = null;
                           _loc18_ = _loc15_.cbpairs.length < _loc16_.cbpairs.length ? _loc15_.cbpairs : _loc16_.cbpairs;
                           _loc19_ = _loc18_.head;
                           while(_loc19_ != null)
                           {
                              _loc20_ = _loc19_.elt;
                              if(_loc20_.a == _loc15_ && _loc20_.b == _loc16_ || _loc20_.a == _loc16_ && _loc20_.b == _loc15_)
                              {
                                 _loc17_ = _loc20_;
                                 break;
                              }
                              _loc19_ = _loc19_.next;
                           }
                           if(_loc17_ == null)
                           {
                              if(ZPP_CbSetPair.zpp_pool == null)
                              {
                                 _loc20_ = new ZPP_CbSetPair();
                              }
                              else
                              {
                                 _loc20_ = ZPP_CbSetPair.zpp_pool;
                                 ZPP_CbSetPair.zpp_pool = _loc20_.next;
                                 _loc20_.next = null;
                              }
                              _loc20_.zip_listeners = true;
                              if(ZPP_CbSet.setlt(_loc15_,_loc16_))
                              {
                                 _loc20_.a = _loc15_;
                                 _loc20_.b = _loc16_;
                              }
                              else
                              {
                                 _loc20_.a = _loc16_;
                                 _loc20_.b = _loc15_;
                              }
                              _loc17_ = _loc20_;
                              _loc15_.cbpairs.add(_loc17_);
                              if(_loc16_ != _loc15_)
                              {
                                 _loc16_.cbpairs.add(_loc17_);
                              }
                           }
                           if(_loc17_.zip_listeners)
                           {
                              _loc17_.zip_listeners = false;
                              _loc17_.__validate();
                           }
                           if(_loc17_.listeners.head != null)
                           {
                              _loc21_ = ZPP_Interactor.get(_loc12_,_loc14_);
                              if(_loc21_ == null)
                              {
                                 _loc21_ = ZPP_CallbackSet.get(_loc12_,_loc14_);
                                 add_callbackset(_loc21_);
                              }
                              _loc22_ = false;
                              _loc23_ = _loc21_.arbiters.head;
                              while(_loc23_ != null)
                              {
                                 _loc24_ = _loc23_.elt;
                                 if(_loc24_ == _loc10_)
                                 {
                                    _loc22_ = true;
                                    break;
                                 }
                                 _loc23_ = _loc23_.next;
                              }
                              if(!_loc22_)
                              {
                                 _loc25_ = _loc21_.arbiters;
                                 if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                 {
                                    _loc26_ = new ZNPNode_ZPP_Arbiter();
                                 }
                                 else
                                 {
                                    _loc26_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc26_.next;
                                    _loc26_.next = null;
                                 }
                                 null;
                                 _loc26_.elt = _loc10_;
                                 _loc23_ = _loc26_;
                                 _loc23_.next = _loc25_.head;
                                 _loc25_.head = _loc23_;
                                 _loc25_.modified = true;
                                 ++_loc25_.length;
                                 _loc10_;
                                 §§push(true);
                              }
                              else
                              {
                                 §§push(false);
                              }
                              if(§§pop())
                              {
                                 ++_loc10_.present;
                              }
                           }
                           _loc13_ = _loc13_.next;
                        }
                     }
                     _loc11_ = _loc11_.next;
                  }
                  _loc9_ = _loc9_.next;
               }
            }
         }
      }
      
      public function doForests(param1:Number) : void
      {
         var _loc3_:* = null as ZPP_ColArbiter;
         var _loc4_:* = null as ZPP_Component;
         var _loc5_:* = null as ZPP_Component;
         var _loc6_:* = null as ZPP_Component;
         var _loc7_:* = null as ZPP_Component;
         var _loc8_:* = null as ZPP_Component;
         var _loc10_:* = null as ZPP_FluidArbiter;
         var _loc11_:* = null as ZNPNode_ZPP_Constraint;
         var _loc12_:* = null as ZPP_Constraint;
         var _loc13_:* = null as ZPP_Body;
         var _loc14_:* = null as ZNPList_ZPP_Body;
         var _loc15_:* = null as ZPP_Body;
         var _loc16_:* = null as ZPP_Island;
         var _loc17_:* = null as ZPP_Island;
         var _loc18_:* = null as ZPP_Island;
         var _loc19_:* = null as ZNPList_ZPP_Component;
         var _loc20_:* = null as ZNPNode_ZPP_Component;
         var _loc21_:* = null as ZNPNode_ZPP_Component;
         var _loc22_:Boolean = false;
         var _loc23_:* = null as ZNPList_ZPP_Constraint;
         var _loc24_:* = null as ZPP_Constraint;
         var _loc25_:* = null as ZNPNode_ZPP_Shape;
         var _loc26_:* = null as ZPP_Shape;
         var _loc27_:* = null as ZNPNode_ZPP_Body;
         var _loc28_:* = null as ZNPNode_ZPP_Body;
         var _loc29_:* = null as ZNPNode_ZPP_Constraint;
         var _loc2_:ZNPNode_ZPP_ColArbiter = c_arbiters_false.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            if(!_loc3_.cleared && _loc3_.up_stamp == stamp && (_loc3_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
            {
               if(_loc3_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc3_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  if(_loc3_.b1.component == _loc3_.b1.component.parent)
                  {
                     §§push(_loc3_.b1.component);
                  }
                  else
                  {
                     _loc5_ = _loc3_.b1.component;
                     _loc6_ = null;
                     while(_loc5_ != _loc5_.parent)
                     {
                        _loc7_ = _loc5_.parent;
                        _loc5_.parent = _loc6_;
                        _loc6_ = _loc5_;
                        _loc5_ = _loc7_;
                     }
                     while(_loc6_ != null)
                     {
                        _loc7_ = _loc6_.parent;
                        _loc6_.parent = _loc5_;
                        _loc6_ = _loc7_;
                     }
                     §§push(_loc5_);
                  }
                  _loc4_ = §§pop();
                  if(_loc3_.b2.component == _loc3_.b2.component.parent)
                  {
                     §§push(_loc3_.b2.component);
                  }
                  else
                  {
                     _loc6_ = _loc3_.b2.component;
                     _loc7_ = null;
                     while(_loc6_ != _loc6_.parent)
                     {
                        _loc8_ = _loc6_.parent;
                        _loc6_.parent = _loc7_;
                        _loc7_ = _loc6_;
                        _loc6_ = _loc8_;
                     }
                     while(_loc7_ != null)
                     {
                        _loc8_ = _loc7_.parent;
                        _loc7_.parent = _loc6_;
                        _loc7_ = _loc8_;
                     }
                     §§push(_loc6_);
                  }
                  _loc5_ = §§pop();
                  if(_loc4_ != _loc5_)
                  {
                     if(_loc4_.rank < _loc5_.rank)
                     {
                        _loc4_.parent = _loc5_;
                     }
                     else if(_loc4_.rank > _loc5_.rank)
                     {
                        _loc5_.parent = _loc4_;
                     }
                     else
                     {
                        _loc5_.parent = _loc4_;
                        ++_loc4_.rank;
                     }
                  }
               }
            }
            _loc2_ = _loc2_.next;
         }
         var _loc9_:ZNPNode_ZPP_FluidArbiter = f_arbiters.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            if(!_loc10_.cleared && _loc10_.up_stamp == stamp && (_loc10_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
            {
               if(_loc10_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc10_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  if(_loc10_.b1.component == _loc10_.b1.component.parent)
                  {
                     §§push(_loc10_.b1.component);
                  }
                  else
                  {
                     _loc5_ = _loc10_.b1.component;
                     _loc6_ = null;
                     while(_loc5_ != _loc5_.parent)
                     {
                        _loc7_ = _loc5_.parent;
                        _loc5_.parent = _loc6_;
                        _loc6_ = _loc5_;
                        _loc5_ = _loc7_;
                     }
                     while(_loc6_ != null)
                     {
                        _loc7_ = _loc6_.parent;
                        _loc6_.parent = _loc5_;
                        _loc6_ = _loc7_;
                     }
                     §§push(_loc5_);
                  }
                  _loc4_ = §§pop();
                  if(_loc10_.b2.component == _loc10_.b2.component.parent)
                  {
                     §§push(_loc10_.b2.component);
                  }
                  else
                  {
                     _loc6_ = _loc10_.b2.component;
                     _loc7_ = null;
                     while(_loc6_ != _loc6_.parent)
                     {
                        _loc8_ = _loc6_.parent;
                        _loc6_.parent = _loc7_;
                        _loc7_ = _loc6_;
                        _loc6_ = _loc8_;
                     }
                     while(_loc7_ != null)
                     {
                        _loc8_ = _loc7_.parent;
                        _loc7_.parent = _loc6_;
                        _loc7_ = _loc8_;
                     }
                     §§push(_loc6_);
                  }
                  _loc5_ = §§pop();
                  if(_loc4_ != _loc5_)
                  {
                     if(_loc4_.rank < _loc5_.rank)
                     {
                        _loc4_.parent = _loc5_;
                     }
                     else if(_loc4_.rank > _loc5_.rank)
                     {
                        _loc5_.parent = _loc4_;
                     }
                     else
                     {
                        _loc5_.parent = _loc4_;
                        ++_loc4_.rank;
                     }
                  }
               }
            }
            _loc9_ = _loc9_.next;
         }
         _loc11_ = live_constraints.head;
         while(_loc11_ != null)
         {
            _loc12_ = _loc11_.elt;
            _loc12_.forest();
            _loc11_ = _loc11_.next;
         }
         while(live.head != null)
         {
            _loc14_ = live;
            _loc15_ = _loc14_.head.elt;
            _loc14_.pop();
            _loc13_ = _loc15_;
            _loc4_ = _loc13_.component;
            if(_loc4_ == _loc4_.parent)
            {
               §§push(_loc4_);
            }
            else
            {
               _loc6_ = _loc4_;
               _loc7_ = null;
               while(_loc6_ != _loc6_.parent)
               {
                  _loc8_ = _loc6_.parent;
                  _loc6_.parent = _loc7_;
                  _loc7_ = _loc6_;
                  _loc6_ = _loc8_;
               }
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.parent;
                  _loc7_.parent = _loc6_;
                  _loc7_ = _loc8_;
               }
               §§push(_loc6_);
            }
            _loc5_ = §§pop();
            if(_loc5_.island == null)
            {
               if(ZPP_Island.zpp_pool == null)
               {
                  _loc5_.island = new ZPP_Island();
               }
               else
               {
                  _loc5_.island = ZPP_Island.zpp_pool;
                  ZPP_Island.zpp_pool = _loc5_.island.next;
                  _loc5_.island.next = null;
               }
               _loc5_.island.waket = 0;
               _loc16_ = islands;
               _loc17_ = _loc5_.island;
               _loc17_._inuse = true;
               _loc18_ = _loc17_;
               _loc18_.next = _loc16_.next;
               _loc16_.next = _loc18_;
               _loc16_.modified = true;
               ++_loc16_.length;
               _loc17_;
               _loc5_.island.sleep = true;
            }
            _loc4_.island = _loc5_.island;
            _loc19_ = _loc4_.island.comps;
            if(ZNPNode_ZPP_Component.zpp_pool == null)
            {
               _loc21_ = new ZNPNode_ZPP_Component();
            }
            else
            {
               _loc21_ = ZNPNode_ZPP_Component.zpp_pool;
               ZNPNode_ZPP_Component.zpp_pool = _loc21_.next;
               _loc21_.next = null;
            }
            null;
            _loc21_.elt = _loc4_;
            _loc20_ = _loc21_;
            _loc20_.next = _loc19_.head;
            _loc19_.head = _loc20_;
            _loc19_.modified = true;
            ++_loc19_.length;
            _loc4_;
            _loc22_ = _loc13_.atRest(param1);
            _loc4_.island.sleep &&= _loc22_;
            if(_loc4_.waket > _loc4_.island.waket)
            {
               _loc4_.island.waket = _loc4_.waket;
            }
         }
         while(live_constraints.head != null)
         {
            _loc23_ = live_constraints;
            _loc24_ = _loc23_.head.elt;
            _loc23_.pop();
            _loc12_ = _loc24_;
            _loc4_ = _loc12_.component;
            if(_loc4_ == _loc4_.parent)
            {
               §§push(_loc4_);
            }
            else
            {
               _loc6_ = _loc4_;
               _loc7_ = null;
               while(_loc6_ != _loc6_.parent)
               {
                  _loc8_ = _loc6_.parent;
                  _loc6_.parent = _loc7_;
                  _loc7_ = _loc6_;
                  _loc6_ = _loc8_;
               }
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.parent;
                  _loc7_.parent = _loc6_;
                  _loc7_ = _loc8_;
               }
               §§push(_loc6_);
            }
            _loc5_ = §§pop();
            _loc4_.island = _loc5_.island;
            _loc19_ = _loc4_.island.comps;
            if(ZNPNode_ZPP_Component.zpp_pool == null)
            {
               _loc21_ = new ZNPNode_ZPP_Component();
            }
            else
            {
               _loc21_ = ZNPNode_ZPP_Component.zpp_pool;
               ZNPNode_ZPP_Component.zpp_pool = _loc21_.next;
               _loc21_.next = null;
            }
            null;
            _loc21_.elt = _loc4_;
            _loc20_ = _loc21_;
            _loc20_.next = _loc19_.head;
            _loc19_.head = _loc20_;
            _loc19_.modified = true;
            ++_loc19_.length;
            _loc4_;
            if(_loc4_.waket > _loc4_.island.waket)
            {
               _loc4_.island.waket = _loc4_.waket;
            }
         }
         while(islands.next != null)
         {
            _loc17_ = islands;
            _loc18_ = _loc17_.next;
            _loc17_.pop();
            _loc16_ = _loc18_;
            if(_loc16_.sleep)
            {
               _loc20_ = _loc16_.comps.head;
               while(_loc20_ != null)
               {
                  _loc4_ = _loc20_.elt;
                  if(_loc4_.isBody)
                  {
                     _loc13_ = _loc4_.body;
                     _loc13_.velx = 0;
                     _loc13_.vely = 0;
                     _loc13_.angvel = 0;
                     _loc4_.sleeping = true;
                     _loc25_ = _loc13_.shapes.head;
                     while(_loc25_ != null)
                     {
                        _loc26_ = _loc25_.elt;
                        bphase.sync(_loc26_);
                        _loc25_ = _loc25_.next;
                     }
                     bodyCbSleep(_loc13_);
                  }
                  else
                  {
                     _loc12_ = _loc4_.constraint;
                     constraintCbSleep(_loc12_);
                     _loc4_.sleeping = true;
                  }
                  _loc20_ = _loc20_.next;
               }
            }
            else
            {
               while(_loc16_.comps.head != null)
               {
                  _loc19_ = _loc16_.comps;
                  _loc5_ = _loc19_.head.elt;
                  _loc19_.pop();
                  _loc4_ = _loc5_;
                  _loc4_.waket = _loc16_.waket;
                  if(_loc4_.isBody)
                  {
                     _loc14_ = live;
                     _loc13_ = _loc4_.body;
                     if(ZNPNode_ZPP_Body.zpp_pool == null)
                     {
                        _loc28_ = new ZNPNode_ZPP_Body();
                     }
                     else
                     {
                        _loc28_ = ZNPNode_ZPP_Body.zpp_pool;
                        ZNPNode_ZPP_Body.zpp_pool = _loc28_.next;
                        _loc28_.next = null;
                     }
                     null;
                     _loc28_.elt = _loc13_;
                     _loc27_ = _loc28_;
                     _loc27_.next = _loc14_.head;
                     _loc14_.head = _loc27_;
                     _loc14_.modified = true;
                     ++_loc14_.length;
                     _loc13_;
                  }
                  else
                  {
                     _loc23_ = live_constraints;
                     _loc12_ = _loc4_.constraint;
                     if(ZNPNode_ZPP_Constraint.zpp_pool == null)
                     {
                        _loc29_ = new ZNPNode_ZPP_Constraint();
                     }
                     else
                     {
                        _loc29_ = ZNPNode_ZPP_Constraint.zpp_pool;
                        ZNPNode_ZPP_Constraint.zpp_pool = _loc29_.next;
                        _loc29_.next = null;
                     }
                     null;
                     _loc29_.elt = _loc12_;
                     _loc11_ = _loc29_;
                     _loc11_.next = _loc23_.head;
                     _loc23_.head = _loc11_;
                     _loc23_.modified = true;
                     ++_loc23_.length;
                     _loc12_;
                  }
                  _loc4_.sleeping = false;
                  _loc4_.island = null;
                  _loc4_.parent = _loc4_;
                  _loc4_.rank = 0;
               }
               _loc17_ = _loc16_;
               _loc17_.next = ZPP_Island.zpp_pool;
               ZPP_Island.zpp_pool = _loc17_;
            }
         }
      }
      
      public function convexMultiCast(param1:ZPP_Shape, param2:Number, param3:InteractionFilter, param4:Boolean, param5:ConvexResultList) : ConvexResultList
      {
         var _loc6_:* = null as ZPP_ToiEvent;
         var _loc7_:* = null as ZPP_Shape;
         var _loc8_:* = null as ZPP_Circle;
         var _loc9_:* = null as ZPP_Polygon;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Vec2;
         var _loc14_:* = null as ZPP_Vec2;
         var _loc15_:Number = NaN;
         var _loc16_:* = null as ZPP_Vec2;
         var _loc17_:* = null as ZPP_Body;
         var _loc18_:* = null as ZNPNode_ZPP_Edge;
         var _loc19_:* = null as ZPP_Edge;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:* = null as ZPP_AABB;
         var _loc28_:* = null as ShapeList;
         var _loc30_:* = null as Vec2;
         var _loc33_:* = null as Shape;
         var _loc34_:int = 0;
         var _loc35_:* = null as ZPP_Body;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:* = null as ConvexResult;
         var _loc40_:Boolean = false;
         var _loc41_:Boolean = false;
         var _loc42_:* = null as ZNPNode_ConvexResult;
         var _loc43_:* = null as ZNPNode_ConvexResult;
         var _loc44_:* = null as ConvexResult;
         var _loc45_:* = null as ZNPList_ConvexResult;
         var _loc46_:* = null as ZNPNode_ConvexResult;
         if(ZPP_ToiEvent.zpp_pool == null)
         {
            _loc6_ = new ZPP_ToiEvent();
         }
         else
         {
            _loc6_ = ZPP_ToiEvent.zpp_pool;
            ZPP_ToiEvent.zpp_pool = _loc6_.next;
            _loc6_.next = null;
         }
         _loc6_.failed = false;
         _loc6_.s1 = _loc6_.s2 = null;
         _loc6_.arbiter = null;
         if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            _loc8_ = param1.circle;
            if(_loc8_.zip_worldCOM)
            {
               if(_loc8_.body != null)
               {
                  _loc8_.zip_worldCOM = false;
                  if(_loc8_.zip_localCOM)
                  {
                     _loc8_.zip_localCOM = false;
                     if(_loc8_.type == ZPP_Flags.id_ShapeType_POLYGON)
                     {
                        _loc9_ = _loc8_.polygon;
                        if(_loc9_.lverts.next == null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: An empty polygon has no meaningful localCOM";
                        }
                        if(_loc9_.lverts.next.next == null)
                        {
                           _loc9_.localCOMx = _loc9_.lverts.next.x;
                           _loc9_.localCOMy = _loc9_.lverts.next.y;
                           null;
                        }
                        else if(_loc9_.lverts.next.next.next == null)
                        {
                           _loc9_.localCOMx = _loc9_.lverts.next.x;
                           _loc9_.localCOMy = _loc9_.lverts.next.y;
                           _loc10_ = 1;
                           _loc9_.localCOMx += _loc9_.lverts.next.next.x * _loc10_;
                           _loc9_.localCOMy += _loc9_.lverts.next.next.y * _loc10_;
                           _loc10_ = 0.5;
                           _loc9_.localCOMx *= _loc10_;
                           _loc9_.localCOMy *= _loc10_;
                        }
                        else
                        {
                           _loc9_.localCOMx = 0;
                           _loc9_.localCOMy = 0;
                           _loc10_ = 0;
                           _loc11_ = _loc9_.lverts.next;
                           _loc12_ = _loc11_;
                           _loc11_ = _loc11_.next;
                           _loc13_ = _loc11_;
                           _loc11_ = _loc11_.next;
                           while(_loc11_ != null)
                           {
                              _loc14_ = _loc11_;
                              _loc10_ += _loc13_.x * (_loc14_.y - _loc12_.y);
                              _loc15_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                              _loc9_.localCOMx += (_loc13_.x + _loc14_.x) * _loc15_;
                              _loc9_.localCOMy += (_loc13_.y + _loc14_.y) * _loc15_;
                              _loc12_ = _loc13_;
                              _loc13_ = _loc14_;
                              _loc11_ = _loc11_.next;
                           }
                           _loc11_ = _loc9_.lverts.next;
                           _loc14_ = _loc11_;
                           _loc10_ += _loc13_.x * (_loc14_.y - _loc12_.y);
                           _loc15_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                           _loc9_.localCOMx += (_loc13_.x + _loc14_.x) * _loc15_;
                           _loc9_.localCOMy += (_loc13_.y + _loc14_.y) * _loc15_;
                           _loc12_ = _loc13_;
                           _loc13_ = _loc14_;
                           _loc11_ = _loc11_.next;
                           _loc16_ = _loc11_;
                           _loc10_ += _loc13_.x * (_loc16_.y - _loc12_.y);
                           _loc15_ = _loc16_.y * _loc13_.x - _loc16_.x * _loc13_.y;
                           _loc9_.localCOMx += (_loc13_.x + _loc16_.x) * _loc15_;
                           _loc9_.localCOMy += (_loc13_.y + _loc16_.y) * _loc15_;
                           _loc10_ = 1 / (3 * _loc10_);
                           _loc15_ = _loc10_;
                           _loc9_.localCOMx *= _loc15_;
                           _loc9_.localCOMy *= _loc15_;
                        }
                     }
                  }
                  _loc17_ = _loc8_.body;
                  if(_loc17_.zip_axis)
                  {
                     _loc17_.zip_axis = false;
                     _loc17_.axisx = Math.sin(_loc17_.rot);
                     _loc17_.axisy = Math.cos(_loc17_.rot);
                     null;
                  }
                  _loc8_.worldCOMx = _loc8_.body.posx + (_loc8_.body.axisy * _loc8_.localCOMx - _loc8_.body.axisx * _loc8_.localCOMy);
                  _loc8_.worldCOMy = _loc8_.body.posy + (_loc8_.localCOMx * _loc8_.body.axisx + _loc8_.localCOMy * _loc8_.body.axisy);
               }
            }
         }
         else
         {
            _loc9_ = param1.polygon;
            if(_loc9_.zip_gaxi)
            {
               if(_loc9_.body != null)
               {
                  _loc9_.zip_gaxi = false;
                  _loc9_.validate_laxi();
                  _loc17_ = _loc9_.body;
                  if(_loc17_.zip_axis)
                  {
                     _loc17_.zip_axis = false;
                     _loc17_.axisx = Math.sin(_loc17_.rot);
                     _loc17_.axisy = Math.cos(_loc17_.rot);
                     null;
                  }
                  if(_loc9_.zip_gverts)
                  {
                     if(_loc9_.body != null)
                     {
                        _loc9_.zip_gverts = false;
                        _loc9_.validate_lverts();
                        _loc17_ = _loc9_.body;
                        if(_loc17_.zip_axis)
                        {
                           _loc17_.zip_axis = false;
                           _loc17_.axisx = Math.sin(_loc17_.rot);
                           _loc17_.axisy = Math.cos(_loc17_.rot);
                           null;
                        }
                        _loc11_ = _loc9_.lverts.next;
                        _loc12_ = _loc9_.gverts.next;
                        while(_loc12_ != null)
                        {
                           _loc13_ = _loc12_;
                           _loc14_ = _loc11_;
                           _loc11_ = _loc11_.next;
                           _loc13_.x = _loc9_.body.posx + (_loc9_.body.axisy * _loc14_.x - _loc9_.body.axisx * _loc14_.y);
                           _loc13_.y = _loc9_.body.posy + (_loc14_.x * _loc9_.body.axisx + _loc14_.y * _loc9_.body.axisy);
                           _loc12_ = _loc12_.next;
                        }
                     }
                  }
                  _loc18_ = _loc9_.edges.head;
                  _loc11_ = _loc9_.gverts.next;
                  _loc12_ = _loc11_;
                  _loc11_ = _loc11_.next;
                  while(_loc11_ != null)
                  {
                     _loc13_ = _loc11_;
                     _loc19_ = _loc18_.elt;
                     _loc18_ = _loc18_.next;
                     _loc19_.gp0 = _loc12_;
                     _loc19_.gp1 = _loc13_;
                     _loc19_.gnormx = _loc9_.body.axisy * _loc19_.lnormx - _loc9_.body.axisx * _loc19_.lnormy;
                     _loc19_.gnormy = _loc19_.lnormx * _loc9_.body.axisx + _loc19_.lnormy * _loc9_.body.axisy;
                     _loc19_.gprojection = _loc9_.body.posx * _loc19_.gnormx + _loc9_.body.posy * _loc19_.gnormy + _loc19_.lprojection;
                     if(_loc19_.wrap_gnorm != null)
                     {
                        _loc19_.wrap_gnorm.zpp_inner.x = _loc19_.gnormx;
                        _loc19_.wrap_gnorm.zpp_inner.y = _loc19_.gnormy;
                     }
                     _loc19_.tp0 = _loc19_.gp0.y * _loc19_.gnormx - _loc19_.gp0.x * _loc19_.gnormy;
                     _loc19_.tp1 = _loc19_.gp1.y * _loc19_.gnormx - _loc19_.gp1.x * _loc19_.gnormy;
                     _loc12_ = _loc13_;
                     _loc11_ = _loc11_.next;
                  }
                  _loc13_ = _loc9_.gverts.next;
                  _loc19_ = _loc18_.elt;
                  _loc18_ = _loc18_.next;
                  _loc19_.gp0 = _loc12_;
                  _loc19_.gp1 = _loc13_;
                  _loc19_.gnormx = _loc9_.body.axisy * _loc19_.lnormx - _loc9_.body.axisx * _loc19_.lnormy;
                  _loc19_.gnormy = _loc19_.lnormx * _loc9_.body.axisx + _loc19_.lnormy * _loc9_.body.axisy;
                  _loc19_.gprojection = _loc9_.body.posx * _loc19_.gnormx + _loc9_.body.posy * _loc19_.gnormy + _loc19_.lprojection;
                  if(_loc19_.wrap_gnorm != null)
                  {
                     _loc19_.wrap_gnorm.zpp_inner.x = _loc19_.gnormx;
                     _loc19_.wrap_gnorm.zpp_inner.y = _loc19_.gnormy;
                  }
                  _loc19_.tp0 = _loc19_.gp0.y * _loc19_.gnormx - _loc19_.gp0.x * _loc19_.gnormy;
                  _loc19_.tp1 = _loc19_.gp1.y * _loc19_.gnormx - _loc19_.gp1.x * _loc19_.gnormy;
               }
            }
         }
         _loc17_ = param1.body;
         _loc10_ = _loc17_.posx;
         _loc15_ = _loc17_.posy;
         _loc17_.sweepTime = 0;
         _loc17_.sweep_angvel = _loc17_.angvel;
         var _loc20_:Number = param2 - _loc17_.sweepTime;
         if(_loc20_ != 0)
         {
            _loc17_.sweepTime = param2;
            _loc21_ = _loc20_;
            _loc17_.posx += _loc17_.velx * _loc21_;
            _loc17_.posy += _loc17_.vely * _loc21_;
            if(_loc17_.angvel != 0)
            {
               _loc21_ = _loc17_.sweep_angvel * _loc20_;
               _loc17_.rot += _loc21_;
               if(_loc21_ * _loc21_ > 0.0001)
               {
                  _loc17_.axisx = Math.sin(_loc17_.rot);
                  _loc17_.axisy = Math.cos(_loc17_.rot);
                  null;
               }
               else
               {
                  _loc22_ = _loc21_ * _loc21_;
                  _loc23_ = 1 - 0.5 * _loc22_;
                  _loc24_ = 1 - _loc22_ * _loc22_ / 8;
                  _loc25_ = (_loc23_ * _loc17_.axisx + _loc21_ * _loc17_.axisy) * _loc24_;
                  _loc17_.axisy = (_loc23_ * _loc17_.axisy - _loc21_ * _loc17_.axisx) * _loc24_;
                  _loc17_.axisx = _loc25_;
               }
            }
         }
         _loc20_ = _loc17_.posx;
         _loc21_ = _loc17_.posy;
         param1.validate_sweepRadius();
         _loc22_ = param1.sweepRadius;
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc26_ = new ZPP_AABB();
         }
         else
         {
            _loc26_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc26_.next;
            _loc26_.next = null;
         }
         null;
         _loc23_ = _loc10_;
         _loc24_ = _loc20_;
         _loc26_.minx = (_loc23_ < _loc24_ ? _loc23_ : _loc24_) - _loc22_;
         _loc23_ = _loc10_;
         _loc24_ = _loc20_;
         _loc26_.maxx = (_loc23_ > _loc24_ ? _loc23_ : _loc24_) + _loc22_;
         _loc23_ = _loc15_;
         _loc24_ = _loc21_;
         _loc26_.miny = (_loc23_ < _loc24_ ? _loc23_ : _loc24_) - _loc22_;
         _loc23_ = _loc15_;
         _loc24_ = _loc21_;
         _loc26_.maxy = (_loc23_ > _loc24_ ? _loc23_ : _loc24_) + _loc22_;
         var _loc27_:ShapeList = convexShapeList = bphase.shapesInAABB(_loc26_,false,false,param3 == null ? null : param3.zpp_inner,convexShapeList);
         var _loc29_:ZPP_AABB = _loc26_;
         if(_loc29_.outer != null)
         {
            _loc29_.outer.zpp_inner = null;
            _loc29_.outer = null;
         }
         _loc29_.wrap_min = _loc29_.wrap_max = null;
         _loc29_._invalidate = null;
         _loc29_._validate = null;
         _loc29_.next = ZPP_AABB.zpp_pool;
         ZPP_AABB.zpp_pool = _loc29_;
         var _loc31_:ConvexResultList = param5 == null ? new ConvexResultList() : param5;
         _loc27_.zpp_inner.valmod();
         var _loc32_:ShapeIterator = ShapeIterator.get(_loc27_);
         while(true)
         {
            _loc32_.zpp_inner.zpp_inner.valmod();
            _loc28_ = _loc32_.zpp_inner;
            _loc28_.zpp_inner.valmod();
            if(_loc28_.zpp_inner.zip_length)
            {
               _loc28_.zpp_inner.zip_length = false;
               _loc28_.zpp_inner.user_length = _loc28_.zpp_inner.inner.length;
            }
            _loc34_ = _loc28_.zpp_inner.user_length;
            _loc32_.zpp_critical = true;
            if(!(_loc32_.zpp_i < _loc34_ ? true : (_loc32_.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc32_, _loc32_.zpp_inner = null, false)))
            {
               break;
            }
            _loc32_.zpp_critical = false;
            _loc32_.zpp_i = (_loc34_ = _loc32_.zpp_i) + 1;
            _loc33_ = _loc32_.zpp_inner.at(_loc34_);
            if(_loc33_ != param1.outer && (_loc33_.zpp_inner.body != null ? _loc33_.zpp_inner.body.outer : null) != _loc17_.outer)
            {
               _loc6_.s1 = param1;
               _loc6_.s2 = _loc33_.zpp_inner;
               if(param4)
               {
                  _loc33_.zpp_inner.validate_sweepRadius();
                  (_loc33_.zpp_inner.body != null ? _loc33_.zpp_inner.body.outer : null).zpp_inner.sweep_angvel = (_loc33_.zpp_inner.body != null ? _loc33_.zpp_inner.body.outer : null).zpp_inner.angvel;
                  (_loc33_.zpp_inner.body != null ? _loc33_.zpp_inner.body.outer : null).zpp_inner.sweepTime = 0;
                  ZPP_SweepDistance.dynamicSweep(_loc6_,param2,0,0,true);
                  _loc35_ = (_loc33_.zpp_inner.body != null ? _loc33_.zpp_inner.body.outer : null).zpp_inner;
                  _loc23_ = 0 - _loc35_.sweepTime;
                  if(_loc23_ != 0)
                  {
                     _loc35_.sweepTime = 0;
                     _loc24_ = _loc23_;
                     _loc35_.posx += _loc35_.velx * _loc24_;
                     _loc35_.posy += _loc35_.vely * _loc24_;
                     if(_loc35_.angvel != 0)
                     {
                        _loc24_ = _loc35_.sweep_angvel * _loc23_;
                        _loc35_.rot += _loc24_;
                        if(_loc24_ * _loc24_ > 0.0001)
                        {
                           _loc35_.axisx = Math.sin(_loc35_.rot);
                           _loc35_.axisy = Math.cos(_loc35_.rot);
                           null;
                        }
                        else
                        {
                           _loc25_ = _loc24_ * _loc24_;
                           _loc36_ = 1 - 0.5 * _loc25_;
                           _loc37_ = 1 - _loc25_ * _loc25_ / 8;
                           _loc38_ = (_loc36_ * _loc35_.axisx + _loc24_ * _loc35_.axisy) * _loc37_;
                           _loc35_.axisy = (_loc36_ * _loc35_.axisy - _loc24_ * _loc35_.axisx) * _loc37_;
                           _loc35_.axisx = _loc38_;
                        }
                     }
                  }
                  _loc35_ = (_loc33_.zpp_inner.body != null ? _loc33_.zpp_inner.body.outer : null).zpp_inner;
                  _loc7_ = _loc33_.zpp_inner;
                  if(_loc7_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc7_.worldCOMx = _loc35_.posx + (_loc35_.axisy * _loc7_.localCOMx - _loc35_.axisx * _loc7_.localCOMy);
                     _loc7_.worldCOMy = _loc35_.posy + (_loc7_.localCOMx * _loc35_.axisx + _loc7_.localCOMy * _loc35_.axisy);
                  }
                  else
                  {
                     _loc9_ = _loc7_.polygon;
                     _loc11_ = _loc9_.lverts.next;
                     _loc12_ = _loc9_.gverts.next;
                     while(_loc12_ != null)
                     {
                        _loc13_ = _loc12_;
                        _loc14_ = _loc11_;
                        _loc11_ = _loc11_.next;
                        _loc13_.x = _loc35_.posx + (_loc35_.axisy * _loc14_.x - _loc35_.axisx * _loc14_.y);
                        _loc13_.y = _loc35_.posy + (_loc14_.x * _loc35_.axisx + _loc14_.y * _loc35_.axisy);
                        _loc12_ = _loc12_.next;
                     }
                     _loc18_ = _loc9_.edges.head;
                     _loc12_ = _loc9_.gverts.next;
                     _loc13_ = _loc12_;
                     _loc12_ = _loc12_.next;
                     while(_loc12_ != null)
                     {
                        _loc14_ = _loc12_;
                        _loc19_ = _loc18_.elt;
                        _loc18_ = _loc18_.next;
                        _loc19_.gnormx = _loc35_.axisy * _loc19_.lnormx - _loc35_.axisx * _loc19_.lnormy;
                        _loc19_.gnormy = _loc19_.lnormx * _loc35_.axisx + _loc19_.lnormy * _loc35_.axisy;
                        _loc19_.gprojection = _loc35_.posx * _loc19_.gnormx + _loc35_.posy * _loc19_.gnormy + _loc19_.lprojection;
                        _loc19_.tp0 = _loc13_.y * _loc19_.gnormx - _loc13_.x * _loc19_.gnormy;
                        _loc19_.tp1 = _loc14_.y * _loc19_.gnormx - _loc14_.x * _loc19_.gnormy;
                        _loc13_ = _loc14_;
                        _loc12_ = _loc12_.next;
                     }
                     _loc14_ = _loc9_.gverts.next;
                     _loc19_ = _loc18_.elt;
                     _loc18_ = _loc18_.next;
                     _loc19_.gnormx = _loc35_.axisy * _loc19_.lnormx - _loc35_.axisx * _loc19_.lnormy;
                     _loc19_.gnormy = _loc19_.lnormx * _loc35_.axisx + _loc19_.lnormy * _loc35_.axisy;
                     _loc19_.gprojection = _loc35_.posx * _loc19_.gnormx + _loc35_.posy * _loc19_.gnormy + _loc19_.lprojection;
                     _loc19_.tp0 = _loc13_.y * _loc19_.gnormx - _loc13_.x * _loc19_.gnormy;
                     _loc19_.tp1 = _loc14_.y * _loc19_.gnormx - _loc14_.x * _loc19_.gnormy;
                  }
               }
               else
               {
                  ZPP_SweepDistance.staticSweep(_loc6_,param2,0,0);
               }
               _loc6_.toi *= param2;
               if(_loc6_.toi > 0)
               {
                  _loc23_ = -_loc6_.axis.x;
                  _loc24_ = -_loc6_.axis.y;
                  _loc40_ = false;
                  §§push(ZPP_ConvexRayResult);
                  if(_loc23_ != _loc23_ || _loc24_ != _loc24_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 components cannot be NaN";
                  }
                  if(ZPP_PubPool.poolVec2 == null)
                  {
                     _loc30_ = new Vec2();
                  }
                  else
                  {
                     _loc30_ = ZPP_PubPool.poolVec2;
                     ZPP_PubPool.poolVec2 = _loc30_.zpp_pool;
                     _loc30_.zpp_pool = null;
                     _loc30_.zpp_disp = false;
                     if(_loc30_ == ZPP_PubPool.nextVec2)
                     {
                        ZPP_PubPool.nextVec2 = null;
                     }
                  }
                  if(_loc30_.zpp_inner == null)
                  {
                     _loc41_ = false;
                     §§push(_loc30_);
                     if(ZPP_Vec2.zpp_pool == null)
                     {
                        _loc11_ = new ZPP_Vec2();
                     }
                     else
                     {
                        _loc11_ = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc11_.next;
                        _loc11_.next = null;
                     }
                     _loc11_.weak = false;
                     _loc11_._immutable = _loc41_;
                     _loc11_.x = _loc23_;
                     _loc11_.y = _loc24_;
                     §§pop().zpp_inner = _loc11_;
                     _loc30_.zpp_inner.outer = _loc30_;
                  }
                  else
                  {
                     if(_loc30_ != null && _loc30_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc30_.zpp_inner;
                     if(_loc11_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc11_._isimmutable != null)
                     {
                        _loc11_._isimmutable();
                     }
                     if(_loc23_ != _loc23_ || _loc24_ != _loc24_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     §§push(false);
                     if(_loc30_ != null && _loc30_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc30_.zpp_inner;
                     if(_loc11_._validate != null)
                     {
                        _loc11_._validate();
                     }
                     if(_loc30_.zpp_inner.x == _loc23_)
                     {
                        §§pop();
                        if(_loc30_ != null && _loc30_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc30_.zpp_inner;
                        if(_loc11_._validate != null)
                        {
                           _loc11_._validate();
                        }
                        §§push(_loc30_.zpp_inner.y == _loc24_);
                     }
                     if(!§§pop())
                     {
                        _loc30_.zpp_inner.x = _loc23_;
                        _loc30_.zpp_inner.y = _loc24_;
                        _loc11_ = _loc30_.zpp_inner;
                        if(_loc11_._invalidate != null)
                        {
                           _loc11_._invalidate(_loc11_);
                        }
                     }
                     _loc30_;
                  }
                  _loc30_.zpp_inner.weak = _loc40_;
                  _loc23_ = _loc6_.c2.x;
                  _loc24_ = _loc6_.c2.y;
                  _loc40_ = false;
                  §§push(_loc30_);
                  if(_loc23_ != _loc23_ || _loc24_ != _loc24_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 components cannot be NaN";
                  }
                  if(ZPP_PubPool.poolVec2 == null)
                  {
                     _loc30_ = new Vec2();
                  }
                  else
                  {
                     _loc30_ = ZPP_PubPool.poolVec2;
                     ZPP_PubPool.poolVec2 = _loc30_.zpp_pool;
                     _loc30_.zpp_pool = null;
                     _loc30_.zpp_disp = false;
                     if(_loc30_ == ZPP_PubPool.nextVec2)
                     {
                        ZPP_PubPool.nextVec2 = null;
                     }
                  }
                  if(_loc30_.zpp_inner == null)
                  {
                     _loc41_ = false;
                     §§push(_loc30_);
                     if(ZPP_Vec2.zpp_pool == null)
                     {
                        _loc11_ = new ZPP_Vec2();
                     }
                     else
                     {
                        _loc11_ = ZPP_Vec2.zpp_pool;
                        ZPP_Vec2.zpp_pool = _loc11_.next;
                        _loc11_.next = null;
                     }
                     _loc11_.weak = false;
                     _loc11_._immutable = _loc41_;
                     _loc11_.x = _loc23_;
                     _loc11_.y = _loc24_;
                     §§pop().zpp_inner = _loc11_;
                     _loc30_.zpp_inner.outer = _loc30_;
                  }
                  else
                  {
                     if(_loc30_ != null && _loc30_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc30_.zpp_inner;
                     if(_loc11_._immutable)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 is immutable";
                     }
                     if(_loc11_._isimmutable != null)
                     {
                        _loc11_._isimmutable();
                     }
                     if(_loc23_ != _loc23_ || _loc24_ != _loc24_)
                     {
                        Boot.lastError = new Error();
                        throw "Error: Vec2 components cannot be NaN";
                     }
                     §§push(false);
                     if(_loc30_ != null && _loc30_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc11_ = _loc30_.zpp_inner;
                     if(_loc11_._validate != null)
                     {
                        _loc11_._validate();
                     }
                     if(_loc30_.zpp_inner.x == _loc23_)
                     {
                        §§pop();
                        if(_loc30_ != null && _loc30_.zpp_disp)
                        {
                           Boot.lastError = new Error();
                           throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                        }
                        _loc11_ = _loc30_.zpp_inner;
                        if(_loc11_._validate != null)
                        {
                           _loc11_._validate();
                        }
                        §§push(_loc30_.zpp_inner.y == _loc24_);
                     }
                     if(!§§pop())
                     {
                        _loc30_.zpp_inner.x = _loc23_;
                        _loc30_.zpp_inner.y = _loc24_;
                        _loc11_ = _loc30_.zpp_inner;
                        if(_loc11_._invalidate != null)
                        {
                           _loc11_._invalidate(_loc11_);
                        }
                     }
                     _loc30_;
                  }
                  _loc30_.zpp_inner.weak = _loc40_;
                  _loc39_ = §§pop().getConvex(§§pop(),_loc30_,_loc6_.toi,_loc33_);
                  _loc42_ = null;
                  _loc43_ = _loc31_.zpp_inner.inner.head;
                  while(_loc43_ != null)
                  {
                     _loc44_ = _loc43_.elt;
                     if(_loc39_.zpp_inner.next != null)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This object has been disposed of and cannot be used";
                     }
                     §§push(_loc39_.zpp_inner.toiDistance);
                     if(_loc44_.zpp_inner.next != null)
                     {
                        Boot.lastError = new Error();
                        throw "Error: This object has been disposed of and cannot be used";
                     }
                     if(§§pop() < _loc44_.zpp_inner.toiDistance)
                     {
                        break;
                     }
                     _loc42_ = _loc43_;
                     _loc43_ = _loc43_.next;
                  }
                  _loc45_ = _loc31_.zpp_inner.inner;
                  if(ZNPNode_ConvexResult.zpp_pool == null)
                  {
                     _loc46_ = new ZNPNode_ConvexResult();
                  }
                  else
                  {
                     _loc46_ = ZNPNode_ConvexResult.zpp_pool;
                     ZNPNode_ConvexResult.zpp_pool = _loc46_.next;
                     _loc46_.next = null;
                  }
                  null;
                  _loc46_.elt = _loc39_;
                  _loc43_ = _loc46_;
                  if(_loc42_ == null)
                  {
                     _loc43_.next = _loc45_.head;
                     _loc45_.head = _loc43_;
                  }
                  else
                  {
                     _loc43_.next = _loc42_.next;
                     _loc42_.next = _loc43_;
                  }
                  _loc45_.pushmod = _loc45_.modified = true;
                  ++_loc45_.length;
                  _loc43_;
               }
            }
         }
         _loc27_.clear();
         var _loc47_:ZPP_ToiEvent = _loc6_;
         _loc47_.next = ZPP_ToiEvent.zpp_pool;
         ZPP_ToiEvent.zpp_pool = _loc47_;
         _loc23_ = 0 - _loc17_.sweepTime;
         if(_loc23_ != 0)
         {
            _loc17_.sweepTime = 0;
            _loc24_ = _loc23_;
            _loc17_.posx += _loc17_.velx * _loc24_;
            _loc17_.posy += _loc17_.vely * _loc24_;
            if(_loc17_.angvel != 0)
            {
               _loc24_ = _loc17_.sweep_angvel * _loc23_;
               _loc17_.rot += _loc24_;
               if(_loc24_ * _loc24_ > 0.0001)
               {
                  _loc17_.axisx = Math.sin(_loc17_.rot);
                  _loc17_.axisy = Math.cos(_loc17_.rot);
                  null;
               }
               else
               {
                  _loc25_ = _loc24_ * _loc24_;
                  _loc36_ = 1 - 0.5 * _loc25_;
                  _loc37_ = 1 - _loc25_ * _loc25_ / 8;
                  _loc38_ = (_loc36_ * _loc17_.axisx + _loc24_ * _loc17_.axisy) * _loc37_;
                  _loc17_.axisy = (_loc36_ * _loc17_.axisy - _loc24_ * _loc17_.axisx) * _loc37_;
                  _loc17_.axisx = _loc38_;
               }
            }
         }
         if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            param1.worldCOMx = _loc17_.posx + (_loc17_.axisy * param1.localCOMx - _loc17_.axisx * param1.localCOMy);
            param1.worldCOMy = _loc17_.posy + (param1.localCOMx * _loc17_.axisx + param1.localCOMy * _loc17_.axisy);
         }
         else
         {
            _loc9_ = param1.polygon;
            _loc11_ = _loc9_.lverts.next;
            _loc12_ = _loc9_.gverts.next;
            while(_loc12_ != null)
            {
               _loc13_ = _loc12_;
               _loc14_ = _loc11_;
               _loc11_ = _loc11_.next;
               _loc13_.x = _loc17_.posx + (_loc17_.axisy * _loc14_.x - _loc17_.axisx * _loc14_.y);
               _loc13_.y = _loc17_.posy + (_loc14_.x * _loc17_.axisx + _loc14_.y * _loc17_.axisy);
               _loc12_ = _loc12_.next;
            }
            _loc18_ = _loc9_.edges.head;
            _loc12_ = _loc9_.gverts.next;
            _loc13_ = _loc12_;
            _loc12_ = _loc12_.next;
            while(_loc12_ != null)
            {
               _loc14_ = _loc12_;
               _loc19_ = _loc18_.elt;
               _loc18_ = _loc18_.next;
               _loc19_.gnormx = _loc17_.axisy * _loc19_.lnormx - _loc17_.axisx * _loc19_.lnormy;
               _loc19_.gnormy = _loc19_.lnormx * _loc17_.axisx + _loc19_.lnormy * _loc17_.axisy;
               _loc19_.gprojection = _loc17_.posx * _loc19_.gnormx + _loc17_.posy * _loc19_.gnormy + _loc19_.lprojection;
               _loc19_.tp0 = _loc13_.y * _loc19_.gnormx - _loc13_.x * _loc19_.gnormy;
               _loc19_.tp1 = _loc14_.y * _loc19_.gnormx - _loc14_.x * _loc19_.gnormy;
               _loc13_ = _loc14_;
               _loc12_ = _loc12_.next;
            }
            _loc14_ = _loc9_.gverts.next;
            _loc19_ = _loc18_.elt;
            _loc18_ = _loc18_.next;
            _loc19_.gnormx = _loc17_.axisy * _loc19_.lnormx - _loc17_.axisx * _loc19_.lnormy;
            _loc19_.gnormy = _loc19_.lnormx * _loc17_.axisx + _loc19_.lnormy * _loc17_.axisy;
            _loc19_.gprojection = _loc17_.posx * _loc19_.gnormx + _loc17_.posy * _loc19_.gnormy + _loc19_.lprojection;
            _loc19_.tp0 = _loc13_.y * _loc19_.gnormx - _loc13_.x * _loc19_.gnormy;
            _loc19_.tp1 = _loc14_.y * _loc19_.gnormx - _loc14_.x * _loc19_.gnormy;
         }
         return _loc31_;
      }
      
      public function convexCast(param1:ZPP_Shape, param2:Number, param3:InteractionFilter, param4:Boolean) : ConvexResult
      {
         var _loc5_:* = null as ZPP_ToiEvent;
         var _loc6_:* = null as ZPP_Shape;
         var _loc7_:* = null as ZPP_Circle;
         var _loc8_:* = null as ZPP_Polygon;
         var _loc9_:Number = NaN;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Vec2;
         var _loc14_:Number = NaN;
         var _loc15_:* = null as ZPP_Vec2;
         var _loc16_:* = null as ZPP_Body;
         var _loc17_:* = null as ZNPNode_ZPP_Edge;
         var _loc18_:* = null as ZPP_Edge;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:* = null as ZPP_AABB;
         var _loc27_:* = null as ShapeList;
         var _loc29_:* = null as Vec2;
         var _loc34_:* = null as Shape;
         var _loc35_:int = 0;
         var _loc36_:* = null as ZPP_Body;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc44_:Boolean = false;
         var _loc45_:Boolean = false;
         if(ZPP_ToiEvent.zpp_pool == null)
         {
            _loc5_ = new ZPP_ToiEvent();
         }
         else
         {
            _loc5_ = ZPP_ToiEvent.zpp_pool;
            ZPP_ToiEvent.zpp_pool = _loc5_.next;
            _loc5_.next = null;
         }
         _loc5_.failed = false;
         _loc5_.s1 = _loc5_.s2 = null;
         _loc5_.arbiter = null;
         if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            _loc7_ = param1.circle;
            if(_loc7_.zip_worldCOM)
            {
               if(_loc7_.body != null)
               {
                  _loc7_.zip_worldCOM = false;
                  if(_loc7_.zip_localCOM)
                  {
                     _loc7_.zip_localCOM = false;
                     if(_loc7_.type == ZPP_Flags.id_ShapeType_POLYGON)
                     {
                        _loc8_ = _loc7_.polygon;
                        if(_loc8_.lverts.next == null)
                        {
                           Boot.lastError = new Error();
                           throw "Error: An empty polygon has no meaningful localCOM";
                        }
                        if(_loc8_.lverts.next.next == null)
                        {
                           _loc8_.localCOMx = _loc8_.lverts.next.x;
                           _loc8_.localCOMy = _loc8_.lverts.next.y;
                           null;
                        }
                        else if(_loc8_.lverts.next.next.next == null)
                        {
                           _loc8_.localCOMx = _loc8_.lverts.next.x;
                           _loc8_.localCOMy = _loc8_.lverts.next.y;
                           _loc9_ = 1;
                           _loc8_.localCOMx += _loc8_.lverts.next.next.x * _loc9_;
                           _loc8_.localCOMy += _loc8_.lverts.next.next.y * _loc9_;
                           _loc9_ = 0.5;
                           _loc8_.localCOMx *= _loc9_;
                           _loc8_.localCOMy *= _loc9_;
                        }
                        else
                        {
                           _loc8_.localCOMx = 0;
                           _loc8_.localCOMy = 0;
                           _loc9_ = 0;
                           _loc10_ = _loc8_.lverts.next;
                           _loc11_ = _loc10_;
                           _loc10_ = _loc10_.next;
                           _loc12_ = _loc10_;
                           _loc10_ = _loc10_.next;
                           while(_loc10_ != null)
                           {
                              _loc13_ = _loc10_;
                              _loc9_ += _loc12_.x * (_loc13_.y - _loc11_.y);
                              _loc14_ = _loc13_.y * _loc12_.x - _loc13_.x * _loc12_.y;
                              _loc8_.localCOMx += (_loc12_.x + _loc13_.x) * _loc14_;
                              _loc8_.localCOMy += (_loc12_.y + _loc13_.y) * _loc14_;
                              _loc11_ = _loc12_;
                              _loc12_ = _loc13_;
                              _loc10_ = _loc10_.next;
                           }
                           _loc10_ = _loc8_.lverts.next;
                           _loc13_ = _loc10_;
                           _loc9_ += _loc12_.x * (_loc13_.y - _loc11_.y);
                           _loc14_ = _loc13_.y * _loc12_.x - _loc13_.x * _loc12_.y;
                           _loc8_.localCOMx += (_loc12_.x + _loc13_.x) * _loc14_;
                           _loc8_.localCOMy += (_loc12_.y + _loc13_.y) * _loc14_;
                           _loc11_ = _loc12_;
                           _loc12_ = _loc13_;
                           _loc10_ = _loc10_.next;
                           _loc15_ = _loc10_;
                           _loc9_ += _loc12_.x * (_loc15_.y - _loc11_.y);
                           _loc14_ = _loc15_.y * _loc12_.x - _loc15_.x * _loc12_.y;
                           _loc8_.localCOMx += (_loc12_.x + _loc15_.x) * _loc14_;
                           _loc8_.localCOMy += (_loc12_.y + _loc15_.y) * _loc14_;
                           _loc9_ = 1 / (3 * _loc9_);
                           _loc14_ = _loc9_;
                           _loc8_.localCOMx *= _loc14_;
                           _loc8_.localCOMy *= _loc14_;
                        }
                     }
                  }
                  _loc16_ = _loc7_.body;
                  if(_loc16_.zip_axis)
                  {
                     _loc16_.zip_axis = false;
                     _loc16_.axisx = Math.sin(_loc16_.rot);
                     _loc16_.axisy = Math.cos(_loc16_.rot);
                     null;
                  }
                  _loc7_.worldCOMx = _loc7_.body.posx + (_loc7_.body.axisy * _loc7_.localCOMx - _loc7_.body.axisx * _loc7_.localCOMy);
                  _loc7_.worldCOMy = _loc7_.body.posy + (_loc7_.localCOMx * _loc7_.body.axisx + _loc7_.localCOMy * _loc7_.body.axisy);
               }
            }
         }
         else
         {
            _loc8_ = param1.polygon;
            if(_loc8_.zip_gaxi)
            {
               if(_loc8_.body != null)
               {
                  _loc8_.zip_gaxi = false;
                  _loc8_.validate_laxi();
                  _loc16_ = _loc8_.body;
                  if(_loc16_.zip_axis)
                  {
                     _loc16_.zip_axis = false;
                     _loc16_.axisx = Math.sin(_loc16_.rot);
                     _loc16_.axisy = Math.cos(_loc16_.rot);
                     null;
                  }
                  if(_loc8_.zip_gverts)
                  {
                     if(_loc8_.body != null)
                     {
                        _loc8_.zip_gverts = false;
                        _loc8_.validate_lverts();
                        _loc16_ = _loc8_.body;
                        if(_loc16_.zip_axis)
                        {
                           _loc16_.zip_axis = false;
                           _loc16_.axisx = Math.sin(_loc16_.rot);
                           _loc16_.axisy = Math.cos(_loc16_.rot);
                           null;
                        }
                        _loc10_ = _loc8_.lverts.next;
                        _loc11_ = _loc8_.gverts.next;
                        while(_loc11_ != null)
                        {
                           _loc12_ = _loc11_;
                           _loc13_ = _loc10_;
                           _loc10_ = _loc10_.next;
                           _loc12_.x = _loc8_.body.posx + (_loc8_.body.axisy * _loc13_.x - _loc8_.body.axisx * _loc13_.y);
                           _loc12_.y = _loc8_.body.posy + (_loc13_.x * _loc8_.body.axisx + _loc13_.y * _loc8_.body.axisy);
                           _loc11_ = _loc11_.next;
                        }
                     }
                  }
                  _loc17_ = _loc8_.edges.head;
                  _loc10_ = _loc8_.gverts.next;
                  _loc11_ = _loc10_;
                  _loc10_ = _loc10_.next;
                  while(_loc10_ != null)
                  {
                     _loc12_ = _loc10_;
                     _loc18_ = _loc17_.elt;
                     _loc17_ = _loc17_.next;
                     _loc18_.gp0 = _loc11_;
                     _loc18_.gp1 = _loc12_;
                     _loc18_.gnormx = _loc8_.body.axisy * _loc18_.lnormx - _loc8_.body.axisx * _loc18_.lnormy;
                     _loc18_.gnormy = _loc18_.lnormx * _loc8_.body.axisx + _loc18_.lnormy * _loc8_.body.axisy;
                     _loc18_.gprojection = _loc8_.body.posx * _loc18_.gnormx + _loc8_.body.posy * _loc18_.gnormy + _loc18_.lprojection;
                     if(_loc18_.wrap_gnorm != null)
                     {
                        _loc18_.wrap_gnorm.zpp_inner.x = _loc18_.gnormx;
                        _loc18_.wrap_gnorm.zpp_inner.y = _loc18_.gnormy;
                     }
                     _loc18_.tp0 = _loc18_.gp0.y * _loc18_.gnormx - _loc18_.gp0.x * _loc18_.gnormy;
                     _loc18_.tp1 = _loc18_.gp1.y * _loc18_.gnormx - _loc18_.gp1.x * _loc18_.gnormy;
                     _loc11_ = _loc12_;
                     _loc10_ = _loc10_.next;
                  }
                  _loc12_ = _loc8_.gverts.next;
                  _loc18_ = _loc17_.elt;
                  _loc17_ = _loc17_.next;
                  _loc18_.gp0 = _loc11_;
                  _loc18_.gp1 = _loc12_;
                  _loc18_.gnormx = _loc8_.body.axisy * _loc18_.lnormx - _loc8_.body.axisx * _loc18_.lnormy;
                  _loc18_.gnormy = _loc18_.lnormx * _loc8_.body.axisx + _loc18_.lnormy * _loc8_.body.axisy;
                  _loc18_.gprojection = _loc8_.body.posx * _loc18_.gnormx + _loc8_.body.posy * _loc18_.gnormy + _loc18_.lprojection;
                  if(_loc18_.wrap_gnorm != null)
                  {
                     _loc18_.wrap_gnorm.zpp_inner.x = _loc18_.gnormx;
                     _loc18_.wrap_gnorm.zpp_inner.y = _loc18_.gnormy;
                  }
                  _loc18_.tp0 = _loc18_.gp0.y * _loc18_.gnormx - _loc18_.gp0.x * _loc18_.gnormy;
                  _loc18_.tp1 = _loc18_.gp1.y * _loc18_.gnormx - _loc18_.gp1.x * _loc18_.gnormy;
               }
            }
         }
         _loc16_ = param1.body;
         _loc9_ = _loc16_.posx;
         _loc14_ = _loc16_.posy;
         _loc16_.sweepTime = 0;
         _loc16_.sweep_angvel = _loc16_.angvel;
         var _loc19_:Number = param2 - _loc16_.sweepTime;
         if(_loc19_ != 0)
         {
            _loc16_.sweepTime = param2;
            _loc20_ = _loc19_;
            _loc16_.posx += _loc16_.velx * _loc20_;
            _loc16_.posy += _loc16_.vely * _loc20_;
            if(_loc16_.angvel != 0)
            {
               _loc20_ = _loc16_.sweep_angvel * _loc19_;
               _loc16_.rot += _loc20_;
               if(_loc20_ * _loc20_ > 0.0001)
               {
                  _loc16_.axisx = Math.sin(_loc16_.rot);
                  _loc16_.axisy = Math.cos(_loc16_.rot);
                  null;
               }
               else
               {
                  _loc21_ = _loc20_ * _loc20_;
                  _loc22_ = 1 - 0.5 * _loc21_;
                  _loc23_ = 1 - _loc21_ * _loc21_ / 8;
                  _loc24_ = (_loc22_ * _loc16_.axisx + _loc20_ * _loc16_.axisy) * _loc23_;
                  _loc16_.axisy = (_loc22_ * _loc16_.axisy - _loc20_ * _loc16_.axisx) * _loc23_;
                  _loc16_.axisx = _loc24_;
               }
            }
         }
         _loc19_ = _loc16_.posx;
         _loc20_ = _loc16_.posy;
         param1.validate_sweepRadius();
         _loc21_ = param1.sweepRadius;
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc25_ = new ZPP_AABB();
         }
         else
         {
            _loc25_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc25_.next;
            _loc25_.next = null;
         }
         null;
         _loc22_ = _loc9_;
         _loc23_ = _loc19_;
         _loc25_.minx = (_loc22_ < _loc23_ ? _loc22_ : _loc23_) - _loc21_;
         _loc22_ = _loc9_;
         _loc23_ = _loc19_;
         _loc25_.maxx = (_loc22_ > _loc23_ ? _loc22_ : _loc23_) + _loc21_;
         _loc22_ = _loc14_;
         _loc23_ = _loc20_;
         _loc25_.miny = (_loc22_ < _loc23_ ? _loc22_ : _loc23_) - _loc21_;
         _loc22_ = _loc14_;
         _loc23_ = _loc20_;
         _loc25_.maxy = (_loc22_ > _loc23_ ? _loc22_ : _loc23_) + _loc21_;
         var _loc26_:ShapeList = convexShapeList = bphase.shapesInAABB(_loc25_,false,false,param3 == null ? null : param3.zpp_inner,convexShapeList);
         var _loc28_:ZPP_AABB = _loc25_;
         if(_loc28_.outer != null)
         {
            _loc28_.outer.zpp_inner = null;
            _loc28_.outer = null;
         }
         _loc28_.wrap_min = _loc28_.wrap_max = null;
         _loc28_._invalidate = null;
         _loc28_._validate = null;
         _loc28_.next = ZPP_AABB.zpp_pool;
         ZPP_AABB.zpp_pool = _loc28_;
         _loc22_ = 0;
         _loc23_ = 0;
         _loc22_ = 0;
         _loc23_ = 0;
         _loc24_ = 0;
         var _loc30_:Number = 0;
         _loc24_ = 0;
         _loc30_ = 0;
         var _loc31_:Shape = null;
         var _loc32_:Number = param2 + 1;
         _loc26_.zpp_inner.valmod();
         var _loc33_:ShapeIterator = ShapeIterator.get(_loc26_);
         while(true)
         {
            _loc33_.zpp_inner.zpp_inner.valmod();
            _loc27_ = _loc33_.zpp_inner;
            _loc27_.zpp_inner.valmod();
            if(_loc27_.zpp_inner.zip_length)
            {
               _loc27_.zpp_inner.zip_length = false;
               _loc27_.zpp_inner.user_length = _loc27_.zpp_inner.inner.length;
            }
            _loc35_ = _loc27_.zpp_inner.user_length;
            _loc33_.zpp_critical = true;
            if(!(_loc33_.zpp_i < _loc35_ ? true : (_loc33_.zpp_next = ShapeIterator.zpp_pool, ShapeIterator.zpp_pool = _loc33_, _loc33_.zpp_inner = null, false)))
            {
               break;
            }
            _loc33_.zpp_critical = false;
            _loc33_.zpp_i = (_loc35_ = _loc33_.zpp_i) + 1;
            _loc34_ = _loc33_.zpp_inner.at(_loc35_);
            if(_loc34_ != param1.outer && (_loc34_.zpp_inner.body != null ? _loc34_.zpp_inner.body.outer : null) != _loc16_.outer)
            {
               _loc5_.s1 = param1;
               _loc5_.s2 = _loc34_.zpp_inner;
               if(param4)
               {
                  _loc34_.zpp_inner.validate_sweepRadius();
                  (_loc34_.zpp_inner.body != null ? _loc34_.zpp_inner.body.outer : null).zpp_inner.sweep_angvel = (_loc34_.zpp_inner.body != null ? _loc34_.zpp_inner.body.outer : null).zpp_inner.angvel;
                  (_loc34_.zpp_inner.body != null ? _loc34_.zpp_inner.body.outer : null).zpp_inner.sweepTime = 0;
                  ZPP_SweepDistance.dynamicSweep(_loc5_,param2,0,0,true);
                  _loc36_ = (_loc34_.zpp_inner.body != null ? _loc34_.zpp_inner.body.outer : null).zpp_inner;
                  _loc37_ = 0 - _loc36_.sweepTime;
                  if(_loc37_ != 0)
                  {
                     _loc36_.sweepTime = 0;
                     _loc38_ = _loc37_;
                     _loc36_.posx += _loc36_.velx * _loc38_;
                     _loc36_.posy += _loc36_.vely * _loc38_;
                     if(_loc36_.angvel != 0)
                     {
                        _loc38_ = _loc36_.sweep_angvel * _loc37_;
                        _loc36_.rot += _loc38_;
                        if(_loc38_ * _loc38_ > 0.0001)
                        {
                           _loc36_.axisx = Math.sin(_loc36_.rot);
                           _loc36_.axisy = Math.cos(_loc36_.rot);
                           null;
                        }
                        else
                        {
                           _loc39_ = _loc38_ * _loc38_;
                           _loc40_ = 1 - 0.5 * _loc39_;
                           _loc41_ = 1 - _loc39_ * _loc39_ / 8;
                           _loc42_ = (_loc40_ * _loc36_.axisx + _loc38_ * _loc36_.axisy) * _loc41_;
                           _loc36_.axisy = (_loc40_ * _loc36_.axisy - _loc38_ * _loc36_.axisx) * _loc41_;
                           _loc36_.axisx = _loc42_;
                        }
                     }
                  }
                  _loc36_ = (_loc34_.zpp_inner.body != null ? _loc34_.zpp_inner.body.outer : null).zpp_inner;
                  _loc6_ = _loc34_.zpp_inner;
                  if(_loc6_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc6_.worldCOMx = _loc36_.posx + (_loc36_.axisy * _loc6_.localCOMx - _loc36_.axisx * _loc6_.localCOMy);
                     _loc6_.worldCOMy = _loc36_.posy + (_loc6_.localCOMx * _loc36_.axisx + _loc6_.localCOMy * _loc36_.axisy);
                  }
                  else
                  {
                     _loc8_ = _loc6_.polygon;
                     _loc10_ = _loc8_.lverts.next;
                     _loc11_ = _loc8_.gverts.next;
                     while(_loc11_ != null)
                     {
                        _loc12_ = _loc11_;
                        _loc13_ = _loc10_;
                        _loc10_ = _loc10_.next;
                        _loc12_.x = _loc36_.posx + (_loc36_.axisy * _loc13_.x - _loc36_.axisx * _loc13_.y);
                        _loc12_.y = _loc36_.posy + (_loc13_.x * _loc36_.axisx + _loc13_.y * _loc36_.axisy);
                        _loc11_ = _loc11_.next;
                     }
                     _loc17_ = _loc8_.edges.head;
                     _loc11_ = _loc8_.gverts.next;
                     _loc12_ = _loc11_;
                     _loc11_ = _loc11_.next;
                     while(_loc11_ != null)
                     {
                        _loc13_ = _loc11_;
                        _loc18_ = _loc17_.elt;
                        _loc17_ = _loc17_.next;
                        _loc18_.gnormx = _loc36_.axisy * _loc18_.lnormx - _loc36_.axisx * _loc18_.lnormy;
                        _loc18_.gnormy = _loc18_.lnormx * _loc36_.axisx + _loc18_.lnormy * _loc36_.axisy;
                        _loc18_.gprojection = _loc36_.posx * _loc18_.gnormx + _loc36_.posy * _loc18_.gnormy + _loc18_.lprojection;
                        _loc18_.tp0 = _loc12_.y * _loc18_.gnormx - _loc12_.x * _loc18_.gnormy;
                        _loc18_.tp1 = _loc13_.y * _loc18_.gnormx - _loc13_.x * _loc18_.gnormy;
                        _loc12_ = _loc13_;
                        _loc11_ = _loc11_.next;
                     }
                     _loc13_ = _loc8_.gverts.next;
                     _loc18_ = _loc17_.elt;
                     _loc17_ = _loc17_.next;
                     _loc18_.gnormx = _loc36_.axisy * _loc18_.lnormx - _loc36_.axisx * _loc18_.lnormy;
                     _loc18_.gnormy = _loc18_.lnormx * _loc36_.axisx + _loc18_.lnormy * _loc36_.axisy;
                     _loc18_.gprojection = _loc36_.posx * _loc18_.gnormx + _loc36_.posy * _loc18_.gnormy + _loc18_.lprojection;
                     _loc18_.tp0 = _loc12_.y * _loc18_.gnormx - _loc12_.x * _loc18_.gnormy;
                     _loc18_.tp1 = _loc13_.y * _loc18_.gnormx - _loc13_.x * _loc18_.gnormy;
                  }
               }
               else
               {
                  ZPP_SweepDistance.staticSweep(_loc5_,param2,0,0);
               }
               _loc5_.toi *= param2;
               if(_loc5_.toi > 0 && _loc5_.toi < _loc32_)
               {
                  _loc32_ = _loc5_.toi;
                  _loc22_ = _loc5_.axis.x;
                  _loc23_ = _loc5_.axis.y;
                  _loc24_ = _loc5_.c2.x;
                  _loc30_ = _loc5_.c2.y;
                  _loc31_ = _loc34_;
               }
            }
         }
         _loc26_.clear();
         var _loc43_:ZPP_ToiEvent = _loc5_;
         _loc43_.next = ZPP_ToiEvent.zpp_pool;
         ZPP_ToiEvent.zpp_pool = _loc43_;
         _loc37_ = 0 - _loc16_.sweepTime;
         if(_loc37_ != 0)
         {
            _loc16_.sweepTime = 0;
            _loc38_ = _loc37_;
            _loc16_.posx += _loc16_.velx * _loc38_;
            _loc16_.posy += _loc16_.vely * _loc38_;
            if(_loc16_.angvel != 0)
            {
               _loc38_ = _loc16_.sweep_angvel * _loc37_;
               _loc16_.rot += _loc38_;
               if(_loc38_ * _loc38_ > 0.0001)
               {
                  _loc16_.axisx = Math.sin(_loc16_.rot);
                  _loc16_.axisy = Math.cos(_loc16_.rot);
                  null;
               }
               else
               {
                  _loc39_ = _loc38_ * _loc38_;
                  _loc40_ = 1 - 0.5 * _loc39_;
                  _loc41_ = 1 - _loc39_ * _loc39_ / 8;
                  _loc42_ = (_loc40_ * _loc16_.axisx + _loc38_ * _loc16_.axisy) * _loc41_;
                  _loc16_.axisy = (_loc40_ * _loc16_.axisy - _loc38_ * _loc16_.axisx) * _loc41_;
                  _loc16_.axisx = _loc42_;
               }
            }
         }
         if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
         {
            param1.worldCOMx = _loc16_.posx + (_loc16_.axisy * param1.localCOMx - _loc16_.axisx * param1.localCOMy);
            param1.worldCOMy = _loc16_.posy + (param1.localCOMx * _loc16_.axisx + param1.localCOMy * _loc16_.axisy);
         }
         else
         {
            _loc8_ = param1.polygon;
            _loc10_ = _loc8_.lverts.next;
            _loc11_ = _loc8_.gverts.next;
            while(_loc11_ != null)
            {
               _loc12_ = _loc11_;
               _loc13_ = _loc10_;
               _loc10_ = _loc10_.next;
               _loc12_.x = _loc16_.posx + (_loc16_.axisy * _loc13_.x - _loc16_.axisx * _loc13_.y);
               _loc12_.y = _loc16_.posy + (_loc13_.x * _loc16_.axisx + _loc13_.y * _loc16_.axisy);
               _loc11_ = _loc11_.next;
            }
            _loc17_ = _loc8_.edges.head;
            _loc11_ = _loc8_.gverts.next;
            _loc12_ = _loc11_;
            _loc11_ = _loc11_.next;
            while(_loc11_ != null)
            {
               _loc13_ = _loc11_;
               _loc18_ = _loc17_.elt;
               _loc17_ = _loc17_.next;
               _loc18_.gnormx = _loc16_.axisy * _loc18_.lnormx - _loc16_.axisx * _loc18_.lnormy;
               _loc18_.gnormy = _loc18_.lnormx * _loc16_.axisx + _loc18_.lnormy * _loc16_.axisy;
               _loc18_.gprojection = _loc16_.posx * _loc18_.gnormx + _loc16_.posy * _loc18_.gnormy + _loc18_.lprojection;
               _loc18_.tp0 = _loc12_.y * _loc18_.gnormx - _loc12_.x * _loc18_.gnormy;
               _loc18_.tp1 = _loc13_.y * _loc18_.gnormx - _loc13_.x * _loc18_.gnormy;
               _loc12_ = _loc13_;
               _loc11_ = _loc11_.next;
            }
            _loc13_ = _loc8_.gverts.next;
            _loc18_ = _loc17_.elt;
            _loc17_ = _loc17_.next;
            _loc18_.gnormx = _loc16_.axisy * _loc18_.lnormx - _loc16_.axisx * _loc18_.lnormy;
            _loc18_.gnormy = _loc18_.lnormx * _loc16_.axisx + _loc18_.lnormy * _loc16_.axisy;
            _loc18_.gprojection = _loc16_.posx * _loc18_.gnormx + _loc16_.posy * _loc18_.gnormy + _loc18_.lprojection;
            _loc18_.tp0 = _loc12_.y * _loc18_.gnormx - _loc12_.x * _loc18_.gnormy;
            _loc18_.tp1 = _loc13_.y * _loc18_.gnormx - _loc13_.x * _loc18_.gnormy;
         }
         if(_loc32_ <= param2)
         {
            _loc37_ = -_loc22_;
            _loc38_ = -_loc23_;
            _loc44_ = false;
            §§push(ZPP_ConvexRayResult);
            if(_loc37_ != _loc37_ || _loc38_ != _loc38_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc29_ = new Vec2();
            }
            else
            {
               _loc29_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc29_.zpp_pool;
               _loc29_.zpp_pool = null;
               _loc29_.zpp_disp = false;
               if(_loc29_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc29_.zpp_inner == null)
            {
               _loc45_ = false;
               §§push(_loc29_);
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
               _loc10_._immutable = _loc45_;
               _loc10_.x = _loc37_;
               _loc10_.y = _loc38_;
               §§pop().zpp_inner = _loc10_;
               _loc29_.zpp_inner.outer = _loc29_;
            }
            else
            {
               if(_loc29_ != null && _loc29_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc29_.zpp_inner;
               if(_loc10_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc10_._isimmutable != null)
               {
                  _loc10_._isimmutable();
               }
               if(_loc37_ != _loc37_ || _loc38_ != _loc38_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc29_ != null && _loc29_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc29_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               if(_loc29_.zpp_inner.x == _loc37_)
               {
                  §§pop();
                  if(_loc29_ != null && _loc29_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc10_ = _loc29_.zpp_inner;
                  if(_loc10_._validate != null)
                  {
                     _loc10_._validate();
                  }
                  §§push(_loc29_.zpp_inner.y == _loc38_);
               }
               if(!§§pop())
               {
                  _loc29_.zpp_inner.x = _loc37_;
                  _loc29_.zpp_inner.y = _loc38_;
                  _loc10_ = _loc29_.zpp_inner;
                  if(_loc10_._invalidate != null)
                  {
                     _loc10_._invalidate(_loc10_);
                  }
               }
               _loc29_;
            }
            _loc29_.zpp_inner.weak = _loc44_;
            _loc44_ = false;
            §§push(_loc29_);
            if(_loc24_ != _loc24_ || _loc30_ != _loc30_)
            {
               Boot.lastError = new Error();
               throw "Error: Vec2 components cannot be NaN";
            }
            if(ZPP_PubPool.poolVec2 == null)
            {
               _loc29_ = new Vec2();
            }
            else
            {
               _loc29_ = ZPP_PubPool.poolVec2;
               ZPP_PubPool.poolVec2 = _loc29_.zpp_pool;
               _loc29_.zpp_pool = null;
               _loc29_.zpp_disp = false;
               if(_loc29_ == ZPP_PubPool.nextVec2)
               {
                  ZPP_PubPool.nextVec2 = null;
               }
            }
            if(_loc29_.zpp_inner == null)
            {
               _loc45_ = false;
               §§push(_loc29_);
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
               _loc10_._immutable = _loc45_;
               _loc10_.x = _loc24_;
               _loc10_.y = _loc30_;
               §§pop().zpp_inner = _loc10_;
               _loc29_.zpp_inner.outer = _loc29_;
            }
            else
            {
               if(_loc29_ != null && _loc29_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc29_.zpp_inner;
               if(_loc10_._immutable)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 is immutable";
               }
               if(_loc10_._isimmutable != null)
               {
                  _loc10_._isimmutable();
               }
               if(_loc24_ != _loc24_ || _loc30_ != _loc30_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               §§push(false);
               if(_loc29_ != null && _loc29_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc10_ = _loc29_.zpp_inner;
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               if(_loc29_.zpp_inner.x == _loc24_)
               {
                  §§pop();
                  if(_loc29_ != null && _loc29_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc10_ = _loc29_.zpp_inner;
                  if(_loc10_._validate != null)
                  {
                     _loc10_._validate();
                  }
                  §§push(_loc29_.zpp_inner.y == _loc30_);
               }
               if(!§§pop())
               {
                  _loc29_.zpp_inner.x = _loc24_;
                  _loc29_.zpp_inner.y = _loc30_;
                  _loc10_ = _loc29_.zpp_inner;
                  if(_loc10_._invalidate != null)
                  {
                     _loc10_._invalidate(_loc10_);
                  }
               }
               _loc29_;
            }
            _loc29_.zpp_inner.weak = _loc44_;
            return §§pop().getConvex(§§pop(),_loc29_,_loc32_,_loc31_);
         }
         return null;
      }
      
      public function continuousEvent(param1:ZPP_Shape, param2:ZPP_Shape, param3:Boolean, param4:ZPP_Arbiter, param5:Boolean) : ZPP_Arbiter
      {
         var _loc6_:* = null as ZPP_Body;
         var _loc7_:* = null as ZPP_Body;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as ZNPNode_ZPP_Constraint;
         var _loc10_:* = null as ZPP_Constraint;
         var _loc11_:* = null as ZPP_InteractionGroup;
         var _loc12_:* = null as ZPP_Interactor;
         var _loc13_:* = null as ZPP_InteractionGroup;
         var _loc14_:Boolean = false;
         var _loc15_:* = null as ZPP_InteractionFilter;
         var _loc16_:* = null as ZPP_InteractionFilter;
         var _loc17_:* = null as ZPP_ToiEvent;
         var _loc18_:* = null as ZPP_Shape;
         var _loc19_:* = null as ZPP_ToiEvent;
         if(param1.body.sweepFrozen && param2.body.sweepFrozen)
         {
            return param4;
         }
         if(param1.body.disableCCD || param2.body.disableCCD)
         {
            return param4;
         }
         if(param4 != null && param4.colarb == null || (!_loc8_ && !§§pop() ? ((param1.sensorEnabled || param2.sensorEnabled) && ((_loc15_.sensorMask & _loc16_.sensorGroup) != 0 && (_loc16_.sensorMask & _loc15_.sensorGroup) != 0) ? 2 : ((param1.fluidEnabled || param2.fluidEnabled) && ((_loc15_.fluidMask & _loc16_.fluidGroup) != 0 && (_loc16_.fluidMask & _loc15_.fluidGroup) != 0) && !(_loc6_.imass == 0 && _loc7_.imass == 0 && _loc6_.iinertia == 0 && _loc7_.iinertia == 0) ? 0 : (_loc15_ = param1.filter, _loc16_ = param2.filter, (_loc15_.collisionMask & _loc16_.collisionGroup) != 0 && (_loc16_.collisionMask & _loc15_.collisionGroup) != 0 && !(_loc6_.imass == 0 && _loc7_.imass == 0 && _loc6_.iinertia == 0 && _loc7_.iinertia == 0) ? 1 : -1))) : -1) == 0)
         {
            return param4;
         }
         _loc6_ = param1.body;
         _loc7_ = param2.body;
         if(param3 || _loc6_.bullet || _loc7_.bullet)
         {
            if(ZPP_ToiEvent.zpp_pool == null)
            {
               _loc17_ = new ZPP_ToiEvent();
            }
            else
            {
               _loc17_ = ZPP_ToiEvent.zpp_pool;
               ZPP_ToiEvent.zpp_pool = _loc17_.next;
               _loc17_.next = null;
            }
            _loc17_.failed = false;
            _loc17_.s1 = _loc17_.s2 = null;
            _loc17_.arbiter = null;
            _loc8_ = _loc6_.type == ZPP_Flags.id_BodyType_KINEMATIC || _loc7_.type == ZPP_Flags.id_BodyType_KINEMATIC;
            if(param3 && !_loc8_)
            {
               if(param1.body.type != ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  _loc17_.s2 = param1;
                  _loc17_.s1 = param2;
               }
               else
               {
                  _loc17_.s1 = param1;
                  _loc17_.s2 = param2;
               }
               _loc17_.kinematic = false;
               ZPP_SweepDistance.staticSweep(_loc17_,pre_dt,0,Config.collisionSlopCCD);
            }
            else
            {
               _loc17_.s1 = param1;
               _loc17_.s2 = param2;
               _loc17_.kinematic = _loc8_;
               if(_loc17_.s1.body.sweepFrozen || _loc17_.s2.body.sweepFrozen)
               {
                  if(_loc17_.s1.body.sweepFrozen)
                  {
                     _loc18_ = _loc17_.s1;
                     _loc17_.s1 = _loc17_.s2;
                     _loc17_.s2 = _loc18_;
                     _loc17_.frozen1 = false;
                     _loc17_.frozen2 = true;
                  }
                  ZPP_SweepDistance.staticSweep(_loc17_,pre_dt,0,Config.collisionSlopCCD);
               }
               else
               {
                  ZPP_SweepDistance.dynamicSweep(_loc17_,pre_dt,0,Config.collisionSlopCCD);
               }
            }
            if(param3 && _loc17_.toi < 0 || _loc17_.failed)
            {
               _loc19_ = _loc17_;
               _loc19_.next = ZPP_ToiEvent.zpp_pool;
               ZPP_ToiEvent.zpp_pool = _loc19_;
            }
            else
            {
               toiEvents.add(_loc17_);
               _loc17_.frozen1 = _loc17_.s1.body.sweepFrozen;
               _loc17_.frozen2 = _loc17_.s2.body.sweepFrozen;
               _loc17_.arbiter = param4 != null ? param4.colarb : null;
            }
         }
         return param4;
      }
      
      public function continuousCollisions(param1:Number) : void
      {
         var _loc4_:* = null as ZPP_ToiEvent;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZNPNode_ZPP_ToiEvent;
         var _loc8_:* = null as ZNPNode_ZPP_ToiEvent;
         var _loc9_:* = null as ZNPNode_ZPP_ToiEvent;
         var _loc10_:* = null as ZPP_ToiEvent;
         var _loc11_:* = null as ZPP_Body;
         var _loc12_:* = null as ZPP_Body;
         var _loc13_:* = null as ZPP_ToiEvent;
         var _loc14_:* = null as ZPP_Shape;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:* = null as ZPP_Polygon;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as ZPP_Vec2;
         var _loc25_:* = null as ZPP_Vec2;
         var _loc26_:* = null as ZPP_Vec2;
         var _loc27_:* = null as ZNPNode_ZPP_Edge;
         var _loc28_:* = null as ZPP_Edge;
         var _loc29_:Boolean = false;
         var _loc30_:* = null as ZPP_Arbiter;
         var _loc31_:* = null as ZPP_ColArbiter;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc2_:Number = 2 * Math.PI / param1;
         bphase.broadphase(this,false);
         var _loc3_:Number = 0;
         while(_loc3_ < 1 && toiEvents.head != null)
         {
            _loc4_ = null;
            _loc5_ = 2;
            _loc6_ = false;
            _loc7_ = null;
            _loc8_ = null;
            _loc9_ = toiEvents.head;
            while(_loc9_ != null)
            {
               _loc10_ = _loc9_.elt;
               _loc11_ = _loc10_.s1.body;
               _loc12_ = _loc10_.s2.body;
               if(_loc11_.sweepFrozen && _loc12_.sweepFrozen)
               {
                  if(!(_loc10_.toi != 0 && ZPP_Collide.testCollide_safe(_loc10_.s1,_loc10_.s2)))
                  {
                     _loc9_ = toiEvents.erase(_loc8_);
                     _loc13_ = _loc10_;
                     _loc13_.next = ZPP_ToiEvent.zpp_pool;
                     ZPP_ToiEvent.zpp_pool = _loc13_;
                     continue;
                  }
                  _loc10_.toi = 0;
               }
               if(_loc10_.frozen1 != _loc11_.sweepFrozen || _loc10_.frozen2 != _loc12_.sweepFrozen)
               {
                  if(_loc10_.kinematic)
                  {
                     _loc9_ = toiEvents.erase(_loc8_);
                     _loc13_ = _loc10_;
                     _loc13_.next = ZPP_ToiEvent.zpp_pool;
                     ZPP_ToiEvent.zpp_pool = _loc13_;
                     continue;
                  }
                  _loc10_.frozen1 = _loc11_.sweepFrozen;
                  _loc10_.frozen2 = _loc12_.sweepFrozen;
                  if(_loc10_.frozen1)
                  {
                     _loc14_ = _loc10_.s1;
                     _loc10_.s1 = _loc10_.s2;
                     _loc10_.s2 = _loc14_;
                     _loc10_.frozen1 = false;
                     _loc10_.frozen2 = true;
                  }
                  ZPP_SweepDistance.staticSweep(_loc10_,param1,0,Config.collisionSlopCCD);
                  if(_loc10_.toi < 0)
                  {
                     _loc9_ = toiEvents.erase(_loc8_);
                     _loc13_ = _loc10_;
                     _loc13_.next = ZPP_ToiEvent.zpp_pool;
                     ZPP_ToiEvent.zpp_pool = _loc13_;
                     continue;
                  }
               }
               if(_loc10_.toi >= 0 && (_loc10_.toi < _loc5_ || !_loc6_ && _loc10_.kinematic))
               {
                  _loc4_ = _loc10_;
                  _loc5_ = _loc10_.toi;
                  _loc6_ = _loc10_.kinematic;
                  _loc7_ = _loc8_;
               }
               _loc8_ = _loc9_;
               _loc9_ = _loc9_.next;
            }
            if(_loc4_ == null)
            {
               break;
            }
            toiEvents.erase(_loc7_);
            _loc3_ = _loc4_.toi;
            _loc11_ = _loc4_.s1.body;
            _loc12_ = _loc4_.s2.body;
            if(!_loc11_.sweepFrozen)
            {
               _loc15_ = _loc3_ * param1;
               _loc16_ = _loc15_ - _loc11_.sweepTime;
               if(_loc16_ != 0)
               {
                  _loc11_.sweepTime = _loc15_;
                  _loc17_ = _loc16_;
                  _loc11_.posx += _loc11_.velx * _loc17_;
                  _loc11_.posy += _loc11_.vely * _loc17_;
                  if(_loc11_.angvel != 0)
                  {
                     _loc17_ = _loc11_.sweep_angvel * _loc16_;
                     _loc11_.rot += _loc17_;
                     if(_loc17_ * _loc17_ > 0.0001)
                     {
                        _loc11_.axisx = Math.sin(_loc11_.rot);
                        _loc11_.axisy = Math.cos(_loc11_.rot);
                        null;
                     }
                     else
                     {
                        _loc18_ = _loc17_ * _loc17_;
                        _loc19_ = 1 - 0.5 * _loc18_;
                        _loc20_ = 1 - _loc18_ * _loc18_ / 8;
                        _loc21_ = (_loc19_ * _loc11_.axisx + _loc17_ * _loc11_.axisy) * _loc20_;
                        _loc11_.axisy = (_loc19_ * _loc11_.axisy - _loc17_ * _loc11_.axisx) * _loc20_;
                        _loc11_.axisx = _loc21_;
                     }
                  }
               }
               _loc14_ = _loc4_.s1;
               if(_loc14_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc14_.worldCOMx = _loc11_.posx + (_loc11_.axisy * _loc14_.localCOMx - _loc11_.axisx * _loc14_.localCOMy);
                  _loc14_.worldCOMy = _loc11_.posy + (_loc14_.localCOMx * _loc11_.axisx + _loc14_.localCOMy * _loc11_.axisy);
               }
               else
               {
                  _loc22_ = _loc14_.polygon;
                  _loc23_ = _loc22_.lverts.next;
                  _loc24_ = _loc22_.gverts.next;
                  while(_loc24_ != null)
                  {
                     _loc25_ = _loc24_;
                     _loc26_ = _loc23_;
                     _loc23_ = _loc23_.next;
                     _loc25_.x = _loc11_.posx + (_loc11_.axisy * _loc26_.x - _loc11_.axisx * _loc26_.y);
                     _loc25_.y = _loc11_.posy + (_loc26_.x * _loc11_.axisx + _loc26_.y * _loc11_.axisy);
                     _loc24_ = _loc24_.next;
                  }
                  _loc27_ = _loc22_.edges.head;
                  _loc24_ = _loc22_.gverts.next;
                  _loc25_ = _loc24_;
                  _loc24_ = _loc24_.next;
                  while(_loc24_ != null)
                  {
                     _loc26_ = _loc24_;
                     _loc28_ = _loc27_.elt;
                     _loc27_ = _loc27_.next;
                     _loc28_.gnormx = _loc11_.axisy * _loc28_.lnormx - _loc11_.axisx * _loc28_.lnormy;
                     _loc28_.gnormy = _loc28_.lnormx * _loc11_.axisx + _loc28_.lnormy * _loc11_.axisy;
                     _loc28_.gprojection = _loc11_.posx * _loc28_.gnormx + _loc11_.posy * _loc28_.gnormy + _loc28_.lprojection;
                     _loc28_.tp0 = _loc25_.y * _loc28_.gnormx - _loc25_.x * _loc28_.gnormy;
                     _loc28_.tp1 = _loc26_.y * _loc28_.gnormx - _loc26_.x * _loc28_.gnormy;
                     _loc25_ = _loc26_;
                     _loc24_ = _loc24_.next;
                  }
                  _loc26_ = _loc22_.gverts.next;
                  _loc28_ = _loc27_.elt;
                  _loc27_ = _loc27_.next;
                  _loc28_.gnormx = _loc11_.axisy * _loc28_.lnormx - _loc11_.axisx * _loc28_.lnormy;
                  _loc28_.gnormy = _loc28_.lnormx * _loc11_.axisx + _loc28_.lnormy * _loc11_.axisy;
                  _loc28_.gprojection = _loc11_.posx * _loc28_.gnormx + _loc11_.posy * _loc28_.gnormy + _loc28_.lprojection;
                  _loc28_.tp0 = _loc25_.y * _loc28_.gnormx - _loc25_.x * _loc28_.gnormy;
                  _loc28_.tp1 = _loc26_.y * _loc28_.gnormx - _loc26_.x * _loc28_.gnormy;
               }
            }
            if(!_loc12_.sweepFrozen)
            {
               _loc15_ = _loc3_ * param1;
               _loc16_ = _loc15_ - _loc12_.sweepTime;
               if(_loc16_ != 0)
               {
                  _loc12_.sweepTime = _loc15_;
                  _loc17_ = _loc16_;
                  _loc12_.posx += _loc12_.velx * _loc17_;
                  _loc12_.posy += _loc12_.vely * _loc17_;
                  if(_loc12_.angvel != 0)
                  {
                     _loc17_ = _loc12_.sweep_angvel * _loc16_;
                     _loc12_.rot += _loc17_;
                     if(_loc17_ * _loc17_ > 0.0001)
                     {
                        _loc12_.axisx = Math.sin(_loc12_.rot);
                        _loc12_.axisy = Math.cos(_loc12_.rot);
                        null;
                     }
                     else
                     {
                        _loc18_ = _loc17_ * _loc17_;
                        _loc19_ = 1 - 0.5 * _loc18_;
                        _loc20_ = 1 - _loc18_ * _loc18_ / 8;
                        _loc21_ = (_loc19_ * _loc12_.axisx + _loc17_ * _loc12_.axisy) * _loc20_;
                        _loc12_.axisy = (_loc19_ * _loc12_.axisy - _loc17_ * _loc12_.axisx) * _loc20_;
                        _loc12_.axisx = _loc21_;
                     }
                  }
               }
               _loc14_ = _loc4_.s2;
               if(_loc14_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc14_.worldCOMx = _loc12_.posx + (_loc12_.axisy * _loc14_.localCOMx - _loc12_.axisx * _loc14_.localCOMy);
                  _loc14_.worldCOMy = _loc12_.posy + (_loc14_.localCOMx * _loc12_.axisx + _loc14_.localCOMy * _loc12_.axisy);
               }
               else
               {
                  _loc22_ = _loc14_.polygon;
                  _loc23_ = _loc22_.lverts.next;
                  _loc24_ = _loc22_.gverts.next;
                  while(_loc24_ != null)
                  {
                     _loc25_ = _loc24_;
                     _loc26_ = _loc23_;
                     _loc23_ = _loc23_.next;
                     _loc25_.x = _loc12_.posx + (_loc12_.axisy * _loc26_.x - _loc12_.axisx * _loc26_.y);
                     _loc25_.y = _loc12_.posy + (_loc26_.x * _loc12_.axisx + _loc26_.y * _loc12_.axisy);
                     _loc24_ = _loc24_.next;
                  }
                  _loc27_ = _loc22_.edges.head;
                  _loc24_ = _loc22_.gverts.next;
                  _loc25_ = _loc24_;
                  _loc24_ = _loc24_.next;
                  while(_loc24_ != null)
                  {
                     _loc26_ = _loc24_;
                     _loc28_ = _loc27_.elt;
                     _loc27_ = _loc27_.next;
                     _loc28_.gnormx = _loc12_.axisy * _loc28_.lnormx - _loc12_.axisx * _loc28_.lnormy;
                     _loc28_.gnormy = _loc28_.lnormx * _loc12_.axisx + _loc28_.lnormy * _loc12_.axisy;
                     _loc28_.gprojection = _loc12_.posx * _loc28_.gnormx + _loc12_.posy * _loc28_.gnormy + _loc28_.lprojection;
                     _loc28_.tp0 = _loc25_.y * _loc28_.gnormx - _loc25_.x * _loc28_.gnormy;
                     _loc28_.tp1 = _loc26_.y * _loc28_.gnormx - _loc26_.x * _loc28_.gnormy;
                     _loc25_ = _loc26_;
                     _loc24_ = _loc24_.next;
                  }
                  _loc26_ = _loc22_.gverts.next;
                  _loc28_ = _loc27_.elt;
                  _loc27_ = _loc27_.next;
                  _loc28_.gnormx = _loc12_.axisy * _loc28_.lnormx - _loc12_.axisx * _loc28_.lnormy;
                  _loc28_.gnormy = _loc28_.lnormx * _loc12_.axisx + _loc28_.lnormy * _loc12_.axisy;
                  _loc28_.gprojection = _loc12_.posx * _loc28_.gnormx + _loc12_.posy * _loc28_.gnormy + _loc28_.lprojection;
                  _loc28_.tp0 = _loc25_.y * _loc28_.gnormx - _loc25_.x * _loc28_.gnormy;
                  _loc28_.tp1 = _loc26_.y * _loc28_.gnormx - _loc26_.x * _loc28_.gnormy;
               }
            }
            _loc29_ = _loc4_.arbiter == null;
            _loc30_ = narrowPhase(_loc4_.s1,_loc4_.s2,true,_loc4_.arbiter,true);
            if(_loc30_ == null)
            {
               if(_loc4_.arbiter != null && _loc4_.arbiter.pair != null)
               {
                  _loc4_.arbiter.pair.arb = null;
                  _loc4_.arbiter.pair = null;
               }
            }
            else if(!presteparb(_loc30_,param1,true))
            {
               if(_loc30_.type == ZPP_Arbiter.COL && (_loc30_.active && (_loc30_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0))
               {
                  _loc31_ = _loc30_.colarb;
                  _loc15_ = _loc31_.nx * _loc31_.c1.jnAcc - _loc31_.ny * _loc31_.c1.jtAcc;
                  _loc16_ = _loc31_.ny * _loc31_.c1.jnAcc + _loc31_.nx * _loc31_.c1.jtAcc;
                  _loc17_ = _loc31_.b1.imass;
                  _loc31_.b1.velx -= _loc15_ * _loc17_;
                  _loc31_.b1.vely -= _loc16_ * _loc17_;
                  _loc31_.b1.angvel -= _loc31_.b1.iinertia * (_loc16_ * _loc31_.c1.r1x - _loc15_ * _loc31_.c1.r1y);
                  _loc17_ = _loc31_.b2.imass;
                  _loc31_.b2.velx += _loc15_ * _loc17_;
                  _loc31_.b2.vely += _loc16_ * _loc17_;
                  _loc31_.b2.angvel += _loc31_.b2.iinertia * (_loc16_ * _loc31_.c1.r2x - _loc15_ * _loc31_.c1.r2y);
                  if(_loc31_.hc2)
                  {
                     _loc15_ = _loc31_.nx * _loc31_.c2.jnAcc - _loc31_.ny * _loc31_.c2.jtAcc;
                     _loc16_ = _loc31_.ny * _loc31_.c2.jnAcc + _loc31_.nx * _loc31_.c2.jtAcc;
                     _loc17_ = _loc31_.b1.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc17_;
                     _loc31_.b1.vely -= _loc16_ * _loc17_;
                     _loc31_.b1.angvel -= _loc31_.b1.iinertia * (_loc16_ * _loc31_.c2.r1x - _loc15_ * _loc31_.c2.r1y);
                     _loc17_ = _loc31_.b2.imass;
                     _loc31_.b2.velx += _loc15_ * _loc17_;
                     _loc31_.b2.vely += _loc16_ * _loc17_;
                     _loc31_.b2.angvel += _loc31_.b2.iinertia * (_loc16_ * _loc31_.c2.r2x - _loc15_ * _loc31_.c2.r2y);
                  }
                  _loc31_.b2.angvel += _loc31_.jrAcc * _loc31_.b2.iinertia;
                  _loc31_.b1.angvel -= _loc31_.jrAcc * _loc31_.b1.iinertia;
                  _loc31_ = _loc30_.colarb;
                  _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                  _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                  _loc17_ = (_loc32_ * _loc31_.nx - _loc21_ * _loc31_.ny + _loc31_.surfacex) * _loc31_.c1.tMass;
                  _loc18_ = _loc31_.c1.friction * _loc31_.c1.jnAcc;
                  _loc19_ = _loc31_.c1.jtAcc;
                  _loc20_ = _loc19_ - _loc17_;
                  if(_loc20_ > _loc18_)
                  {
                     _loc20_ = _loc18_;
                  }
                  else if(_loc20_ < -_loc18_)
                  {
                     _loc20_ = -_loc18_;
                  }
                  _loc17_ = _loc20_ - _loc19_;
                  _loc31_.c1.jtAcc = _loc20_;
                  _loc15_ = -_loc31_.ny * _loc17_;
                  _loc16_ = _loc31_.nx * _loc17_;
                  _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                  _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                  _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                  _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                  _loc31_.b2.angvel += _loc31_.rt1b * _loc17_ * _loc31_.b2.iinertia;
                  _loc31_.b1.angvel -= _loc31_.rt1a * _loc17_ * _loc31_.b1.iinertia;
                  if(_loc31_.hc2)
                  {
                     _loc33_ = _loc31_.k2x + _loc31_.b2.velx - _loc31_.c2.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c2.r1y * _loc31_.b1.angvel);
                     _loc34_ = _loc31_.k2y + _loc31_.b2.vely + _loc31_.c2.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c2.r1x * _loc31_.b1.angvel);
                     _loc17_ = (_loc34_ * _loc31_.nx - _loc33_ * _loc31_.ny + _loc31_.surfacex) * _loc31_.c2.tMass;
                     _loc18_ = _loc31_.c2.friction * _loc31_.c2.jnAcc;
                     _loc19_ = _loc31_.c2.jtAcc;
                     _loc20_ = _loc19_ - _loc17_;
                     if(_loc20_ > _loc18_)
                     {
                        _loc20_ = _loc18_;
                     }
                     else if(_loc20_ < -_loc18_)
                     {
                        _loc20_ = -_loc18_;
                     }
                     _loc17_ = _loc20_ - _loc19_;
                     _loc31_.c2.jtAcc = _loc20_;
                     _loc15_ = -_loc31_.ny * _loc17_;
                     _loc16_ = _loc31_.nx * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += _loc31_.rt2b * _loc17_ * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= _loc31_.rt2a * _loc17_ * _loc31_.b1.iinertia;
                     _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                     _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                     _loc33_ = _loc31_.k2x + _loc31_.b2.velx - _loc31_.c2.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c2.r1y * _loc31_.b1.angvel);
                     _loc34_ = _loc31_.k2y + _loc31_.b2.vely + _loc31_.c2.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c2.r1x * _loc31_.b1.angvel);
                     _loc35_ = _loc31_.c1.jnAcc;
                     _loc36_ = _loc31_.c2.jnAcc;
                     _loc37_ = _loc21_ * _loc31_.nx + _loc32_ * _loc31_.ny + _loc31_.surfacey + _loc31_.c1.bounce - (_loc31_.Ka * _loc35_ + _loc31_.Kb * _loc36_);
                     _loc38_ = _loc33_ * _loc31_.nx + _loc34_ * _loc31_.ny + _loc31_.surfacey + _loc31_.c2.bounce - (_loc31_.Kb * _loc35_ + _loc31_.Kc * _loc36_);
                     _loc39_ = -(_loc31_.kMassa * _loc37_ + _loc31_.kMassb * _loc38_);
                     _loc40_ = -(_loc31_.kMassb * _loc37_ + _loc31_.kMassc * _loc38_);
                     if(_loc39_ >= 0 && _loc40_ >= 0)
                     {
                        _loc37_ = _loc39_ - _loc35_;
                        _loc38_ = _loc40_ - _loc36_;
                        _loc31_.c1.jnAcc = _loc39_;
                        _loc31_.c2.jnAcc = _loc40_;
                     }
                     else
                     {
                        _loc39_ = -_loc31_.c1.nMass * _loc37_;
                        if(_loc39_ >= 0 && _loc31_.Kb * _loc39_ + _loc38_ >= 0)
                        {
                           _loc37_ = _loc39_ - _loc35_;
                           _loc38_ = -_loc36_;
                           _loc31_.c1.jnAcc = _loc39_;
                           _loc31_.c2.jnAcc = 0;
                        }
                        else
                        {
                           _loc40_ = -_loc31_.c2.nMass * _loc38_;
                           if(_loc40_ >= 0 && _loc31_.Kb * _loc40_ + _loc37_ >= 0)
                           {
                              _loc37_ = -_loc35_;
                              _loc38_ = _loc40_ - _loc36_;
                              _loc31_.c1.jnAcc = 0;
                              _loc31_.c2.jnAcc = _loc40_;
                           }
                           else if(_loc37_ >= 0 && _loc38_ >= 0)
                           {
                              _loc37_ = -_loc35_;
                              _loc38_ = -_loc36_;
                              _loc31_.c1.jnAcc = _loc31_.c2.jnAcc = 0;
                           }
                           else
                           {
                              _loc37_ = 0;
                              _loc38_ = 0;
                           }
                        }
                     }
                     _loc17_ = _loc37_ + _loc38_;
                     _loc15_ = _loc31_.nx * _loc17_;
                     _loc16_ = _loc31_.ny * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += (_loc31_.rn1b * _loc37_ + _loc31_.rn2b * _loc38_) * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= (_loc31_.rn1a * _loc37_ + _loc31_.rn2a * _loc38_) * _loc31_.b1.iinertia;
                  }
                  else
                  {
                     if(_loc31_.radius != 0)
                     {
                        _loc33_ = _loc31_.b2.angvel - _loc31_.b1.angvel;
                        _loc17_ = _loc33_ * _loc31_.rMass;
                        _loc18_ = _loc31_.rfric * _loc31_.c1.jnAcc;
                        _loc19_ = _loc31_.jrAcc;
                        _loc31_.jrAcc -= _loc17_;
                        if(_loc31_.jrAcc > _loc18_)
                        {
                           _loc31_.jrAcc = _loc18_;
                        }
                        else if(_loc31_.jrAcc < -_loc18_)
                        {
                           _loc31_.jrAcc = -_loc18_;
                        }
                        _loc17_ = _loc31_.jrAcc - _loc19_;
                        _loc31_.b2.angvel += _loc17_ * _loc31_.b2.iinertia;
                        _loc31_.b1.angvel -= _loc17_ * _loc31_.b1.iinertia;
                     }
                     _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                     _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                     _loc17_ = (_loc31_.c1.bounce + (_loc31_.nx * _loc21_ + _loc31_.ny * _loc32_) + _loc31_.surfacey) * _loc31_.c1.nMass;
                     _loc19_ = _loc31_.c1.jnAcc;
                     _loc20_ = _loc19_ - _loc17_;
                     if(_loc20_ < 0)
                     {
                        _loc20_ = 0;
                     }
                     _loc17_ = _loc20_ - _loc19_;
                     _loc31_.c1.jnAcc = _loc20_;
                     _loc15_ = _loc31_.nx * _loc17_;
                     _loc16_ = _loc31_.ny * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += _loc31_.rn1b * _loc17_ * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= _loc31_.rn1a * _loc17_ * _loc31_.b1.iinertia;
                  }
                  _loc31_ = _loc30_.colarb;
                  _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                  _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                  _loc17_ = (_loc32_ * _loc31_.nx - _loc21_ * _loc31_.ny + _loc31_.surfacex) * _loc31_.c1.tMass;
                  _loc18_ = _loc31_.c1.friction * _loc31_.c1.jnAcc;
                  _loc19_ = _loc31_.c1.jtAcc;
                  _loc20_ = _loc19_ - _loc17_;
                  if(_loc20_ > _loc18_)
                  {
                     _loc20_ = _loc18_;
                  }
                  else if(_loc20_ < -_loc18_)
                  {
                     _loc20_ = -_loc18_;
                  }
                  _loc17_ = _loc20_ - _loc19_;
                  _loc31_.c1.jtAcc = _loc20_;
                  _loc15_ = -_loc31_.ny * _loc17_;
                  _loc16_ = _loc31_.nx * _loc17_;
                  _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                  _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                  _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                  _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                  _loc31_.b2.angvel += _loc31_.rt1b * _loc17_ * _loc31_.b2.iinertia;
                  _loc31_.b1.angvel -= _loc31_.rt1a * _loc17_ * _loc31_.b1.iinertia;
                  if(_loc31_.hc2)
                  {
                     _loc33_ = _loc31_.k2x + _loc31_.b2.velx - _loc31_.c2.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c2.r1y * _loc31_.b1.angvel);
                     _loc34_ = _loc31_.k2y + _loc31_.b2.vely + _loc31_.c2.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c2.r1x * _loc31_.b1.angvel);
                     _loc17_ = (_loc34_ * _loc31_.nx - _loc33_ * _loc31_.ny + _loc31_.surfacex) * _loc31_.c2.tMass;
                     _loc18_ = _loc31_.c2.friction * _loc31_.c2.jnAcc;
                     _loc19_ = _loc31_.c2.jtAcc;
                     _loc20_ = _loc19_ - _loc17_;
                     if(_loc20_ > _loc18_)
                     {
                        _loc20_ = _loc18_;
                     }
                     else if(_loc20_ < -_loc18_)
                     {
                        _loc20_ = -_loc18_;
                     }
                     _loc17_ = _loc20_ - _loc19_;
                     _loc31_.c2.jtAcc = _loc20_;
                     _loc15_ = -_loc31_.ny * _loc17_;
                     _loc16_ = _loc31_.nx * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += _loc31_.rt2b * _loc17_ * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= _loc31_.rt2a * _loc17_ * _loc31_.b1.iinertia;
                     _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                     _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                     _loc33_ = _loc31_.k2x + _loc31_.b2.velx - _loc31_.c2.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c2.r1y * _loc31_.b1.angvel);
                     _loc34_ = _loc31_.k2y + _loc31_.b2.vely + _loc31_.c2.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c2.r1x * _loc31_.b1.angvel);
                     _loc35_ = _loc31_.c1.jnAcc;
                     _loc36_ = _loc31_.c2.jnAcc;
                     _loc37_ = _loc21_ * _loc31_.nx + _loc32_ * _loc31_.ny + _loc31_.surfacey + _loc31_.c1.bounce - (_loc31_.Ka * _loc35_ + _loc31_.Kb * _loc36_);
                     _loc38_ = _loc33_ * _loc31_.nx + _loc34_ * _loc31_.ny + _loc31_.surfacey + _loc31_.c2.bounce - (_loc31_.Kb * _loc35_ + _loc31_.Kc * _loc36_);
                     _loc39_ = -(_loc31_.kMassa * _loc37_ + _loc31_.kMassb * _loc38_);
                     _loc40_ = -(_loc31_.kMassb * _loc37_ + _loc31_.kMassc * _loc38_);
                     if(_loc39_ >= 0 && _loc40_ >= 0)
                     {
                        _loc37_ = _loc39_ - _loc35_;
                        _loc38_ = _loc40_ - _loc36_;
                        _loc31_.c1.jnAcc = _loc39_;
                        _loc31_.c2.jnAcc = _loc40_;
                     }
                     else
                     {
                        _loc39_ = -_loc31_.c1.nMass * _loc37_;
                        if(_loc39_ >= 0 && _loc31_.Kb * _loc39_ + _loc38_ >= 0)
                        {
                           _loc37_ = _loc39_ - _loc35_;
                           _loc38_ = -_loc36_;
                           _loc31_.c1.jnAcc = _loc39_;
                           _loc31_.c2.jnAcc = 0;
                        }
                        else
                        {
                           _loc40_ = -_loc31_.c2.nMass * _loc38_;
                           if(_loc40_ >= 0 && _loc31_.Kb * _loc40_ + _loc37_ >= 0)
                           {
                              _loc37_ = -_loc35_;
                              _loc38_ = _loc40_ - _loc36_;
                              _loc31_.c1.jnAcc = 0;
                              _loc31_.c2.jnAcc = _loc40_;
                           }
                           else if(_loc37_ >= 0 && _loc38_ >= 0)
                           {
                              _loc37_ = -_loc35_;
                              _loc38_ = -_loc36_;
                              _loc31_.c1.jnAcc = _loc31_.c2.jnAcc = 0;
                           }
                           else
                           {
                              _loc37_ = 0;
                              _loc38_ = 0;
                           }
                        }
                     }
                     _loc17_ = _loc37_ + _loc38_;
                     _loc15_ = _loc31_.nx * _loc17_;
                     _loc16_ = _loc31_.ny * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += (_loc31_.rn1b * _loc37_ + _loc31_.rn2b * _loc38_) * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= (_loc31_.rn1a * _loc37_ + _loc31_.rn2a * _loc38_) * _loc31_.b1.iinertia;
                  }
                  else
                  {
                     if(_loc31_.radius != 0)
                     {
                        _loc33_ = _loc31_.b2.angvel - _loc31_.b1.angvel;
                        _loc17_ = _loc33_ * _loc31_.rMass;
                        _loc18_ = _loc31_.rfric * _loc31_.c1.jnAcc;
                        _loc19_ = _loc31_.jrAcc;
                        _loc31_.jrAcc -= _loc17_;
                        if(_loc31_.jrAcc > _loc18_)
                        {
                           _loc31_.jrAcc = _loc18_;
                        }
                        else if(_loc31_.jrAcc < -_loc18_)
                        {
                           _loc31_.jrAcc = -_loc18_;
                        }
                        _loc17_ = _loc31_.jrAcc - _loc19_;
                        _loc31_.b2.angvel += _loc17_ * _loc31_.b2.iinertia;
                        _loc31_.b1.angvel -= _loc17_ * _loc31_.b1.iinertia;
                     }
                     _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                     _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                     _loc17_ = (_loc31_.c1.bounce + (_loc31_.nx * _loc21_ + _loc31_.ny * _loc32_) + _loc31_.surfacey) * _loc31_.c1.nMass;
                     _loc19_ = _loc31_.c1.jnAcc;
                     _loc20_ = _loc19_ - _loc17_;
                     if(_loc20_ < 0)
                     {
                        _loc20_ = 0;
                     }
                     _loc17_ = _loc20_ - _loc19_;
                     _loc31_.c1.jnAcc = _loc20_;
                     _loc15_ = _loc31_.nx * _loc17_;
                     _loc16_ = _loc31_.ny * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += _loc31_.rn1b * _loc17_ * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= _loc31_.rn1a * _loc17_ * _loc31_.b1.iinertia;
                  }
                  _loc31_ = _loc30_.colarb;
                  _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                  _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                  _loc17_ = (_loc32_ * _loc31_.nx - _loc21_ * _loc31_.ny + _loc31_.surfacex) * _loc31_.c1.tMass;
                  _loc18_ = _loc31_.c1.friction * _loc31_.c1.jnAcc;
                  _loc19_ = _loc31_.c1.jtAcc;
                  _loc20_ = _loc19_ - _loc17_;
                  if(_loc20_ > _loc18_)
                  {
                     _loc20_ = _loc18_;
                  }
                  else if(_loc20_ < -_loc18_)
                  {
                     _loc20_ = -_loc18_;
                  }
                  _loc17_ = _loc20_ - _loc19_;
                  _loc31_.c1.jtAcc = _loc20_;
                  _loc15_ = -_loc31_.ny * _loc17_;
                  _loc16_ = _loc31_.nx * _loc17_;
                  _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                  _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                  _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                  _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                  _loc31_.b2.angvel += _loc31_.rt1b * _loc17_ * _loc31_.b2.iinertia;
                  _loc31_.b1.angvel -= _loc31_.rt1a * _loc17_ * _loc31_.b1.iinertia;
                  if(_loc31_.hc2)
                  {
                     _loc33_ = _loc31_.k2x + _loc31_.b2.velx - _loc31_.c2.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c2.r1y * _loc31_.b1.angvel);
                     _loc34_ = _loc31_.k2y + _loc31_.b2.vely + _loc31_.c2.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c2.r1x * _loc31_.b1.angvel);
                     _loc17_ = (_loc34_ * _loc31_.nx - _loc33_ * _loc31_.ny + _loc31_.surfacex) * _loc31_.c2.tMass;
                     _loc18_ = _loc31_.c2.friction * _loc31_.c2.jnAcc;
                     _loc19_ = _loc31_.c2.jtAcc;
                     _loc20_ = _loc19_ - _loc17_;
                     if(_loc20_ > _loc18_)
                     {
                        _loc20_ = _loc18_;
                     }
                     else if(_loc20_ < -_loc18_)
                     {
                        _loc20_ = -_loc18_;
                     }
                     _loc17_ = _loc20_ - _loc19_;
                     _loc31_.c2.jtAcc = _loc20_;
                     _loc15_ = -_loc31_.ny * _loc17_;
                     _loc16_ = _loc31_.nx * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += _loc31_.rt2b * _loc17_ * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= _loc31_.rt2a * _loc17_ * _loc31_.b1.iinertia;
                     _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                     _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                     _loc33_ = _loc31_.k2x + _loc31_.b2.velx - _loc31_.c2.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c2.r1y * _loc31_.b1.angvel);
                     _loc34_ = _loc31_.k2y + _loc31_.b2.vely + _loc31_.c2.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c2.r1x * _loc31_.b1.angvel);
                     _loc35_ = _loc31_.c1.jnAcc;
                     _loc36_ = _loc31_.c2.jnAcc;
                     _loc37_ = _loc21_ * _loc31_.nx + _loc32_ * _loc31_.ny + _loc31_.surfacey + _loc31_.c1.bounce - (_loc31_.Ka * _loc35_ + _loc31_.Kb * _loc36_);
                     _loc38_ = _loc33_ * _loc31_.nx + _loc34_ * _loc31_.ny + _loc31_.surfacey + _loc31_.c2.bounce - (_loc31_.Kb * _loc35_ + _loc31_.Kc * _loc36_);
                     _loc39_ = -(_loc31_.kMassa * _loc37_ + _loc31_.kMassb * _loc38_);
                     _loc40_ = -(_loc31_.kMassb * _loc37_ + _loc31_.kMassc * _loc38_);
                     if(_loc39_ >= 0 && _loc40_ >= 0)
                     {
                        _loc37_ = _loc39_ - _loc35_;
                        _loc38_ = _loc40_ - _loc36_;
                        _loc31_.c1.jnAcc = _loc39_;
                        _loc31_.c2.jnAcc = _loc40_;
                     }
                     else
                     {
                        _loc39_ = -_loc31_.c1.nMass * _loc37_;
                        if(_loc39_ >= 0 && _loc31_.Kb * _loc39_ + _loc38_ >= 0)
                        {
                           _loc37_ = _loc39_ - _loc35_;
                           _loc38_ = -_loc36_;
                           _loc31_.c1.jnAcc = _loc39_;
                           _loc31_.c2.jnAcc = 0;
                        }
                        else
                        {
                           _loc40_ = -_loc31_.c2.nMass * _loc38_;
                           if(_loc40_ >= 0 && _loc31_.Kb * _loc40_ + _loc37_ >= 0)
                           {
                              _loc37_ = -_loc35_;
                              _loc38_ = _loc40_ - _loc36_;
                              _loc31_.c1.jnAcc = 0;
                              _loc31_.c2.jnAcc = _loc40_;
                           }
                           else if(_loc37_ >= 0 && _loc38_ >= 0)
                           {
                              _loc37_ = -_loc35_;
                              _loc38_ = -_loc36_;
                              _loc31_.c1.jnAcc = _loc31_.c2.jnAcc = 0;
                           }
                           else
                           {
                              _loc37_ = 0;
                              _loc38_ = 0;
                           }
                        }
                     }
                     _loc17_ = _loc37_ + _loc38_;
                     _loc15_ = _loc31_.nx * _loc17_;
                     _loc16_ = _loc31_.ny * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += (_loc31_.rn1b * _loc37_ + _loc31_.rn2b * _loc38_) * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= (_loc31_.rn1a * _loc37_ + _loc31_.rn2a * _loc38_) * _loc31_.b1.iinertia;
                  }
                  else
                  {
                     if(_loc31_.radius != 0)
                     {
                        _loc33_ = _loc31_.b2.angvel - _loc31_.b1.angvel;
                        _loc17_ = _loc33_ * _loc31_.rMass;
                        _loc18_ = _loc31_.rfric * _loc31_.c1.jnAcc;
                        _loc19_ = _loc31_.jrAcc;
                        _loc31_.jrAcc -= _loc17_;
                        if(_loc31_.jrAcc > _loc18_)
                        {
                           _loc31_.jrAcc = _loc18_;
                        }
                        else if(_loc31_.jrAcc < -_loc18_)
                        {
                           _loc31_.jrAcc = -_loc18_;
                        }
                        _loc17_ = _loc31_.jrAcc - _loc19_;
                        _loc31_.b2.angvel += _loc17_ * _loc31_.b2.iinertia;
                        _loc31_.b1.angvel -= _loc17_ * _loc31_.b1.iinertia;
                     }
                     _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                     _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                     _loc17_ = (_loc31_.c1.bounce + (_loc31_.nx * _loc21_ + _loc31_.ny * _loc32_) + _loc31_.surfacey) * _loc31_.c1.nMass;
                     _loc19_ = _loc31_.c1.jnAcc;
                     _loc20_ = _loc19_ - _loc17_;
                     if(_loc20_ < 0)
                     {
                        _loc20_ = 0;
                     }
                     _loc17_ = _loc20_ - _loc19_;
                     _loc31_.c1.jnAcc = _loc20_;
                     _loc15_ = _loc31_.nx * _loc17_;
                     _loc16_ = _loc31_.ny * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += _loc31_.rn1b * _loc17_ * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= _loc31_.rn1a * _loc17_ * _loc31_.b1.iinertia;
                  }
                  _loc31_ = _loc30_.colarb;
                  _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                  _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                  _loc17_ = (_loc32_ * _loc31_.nx - _loc21_ * _loc31_.ny + _loc31_.surfacex) * _loc31_.c1.tMass;
                  _loc18_ = _loc31_.c1.friction * _loc31_.c1.jnAcc;
                  _loc19_ = _loc31_.c1.jtAcc;
                  _loc20_ = _loc19_ - _loc17_;
                  if(_loc20_ > _loc18_)
                  {
                     _loc20_ = _loc18_;
                  }
                  else if(_loc20_ < -_loc18_)
                  {
                     _loc20_ = -_loc18_;
                  }
                  _loc17_ = _loc20_ - _loc19_;
                  _loc31_.c1.jtAcc = _loc20_;
                  _loc15_ = -_loc31_.ny * _loc17_;
                  _loc16_ = _loc31_.nx * _loc17_;
                  _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                  _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                  _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                  _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                  _loc31_.b2.angvel += _loc31_.rt1b * _loc17_ * _loc31_.b2.iinertia;
                  _loc31_.b1.angvel -= _loc31_.rt1a * _loc17_ * _loc31_.b1.iinertia;
                  if(_loc31_.hc2)
                  {
                     _loc33_ = _loc31_.k2x + _loc31_.b2.velx - _loc31_.c2.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c2.r1y * _loc31_.b1.angvel);
                     _loc34_ = _loc31_.k2y + _loc31_.b2.vely + _loc31_.c2.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c2.r1x * _loc31_.b1.angvel);
                     _loc17_ = (_loc34_ * _loc31_.nx - _loc33_ * _loc31_.ny + _loc31_.surfacex) * _loc31_.c2.tMass;
                     _loc18_ = _loc31_.c2.friction * _loc31_.c2.jnAcc;
                     _loc19_ = _loc31_.c2.jtAcc;
                     _loc20_ = _loc19_ - _loc17_;
                     if(_loc20_ > _loc18_)
                     {
                        _loc20_ = _loc18_;
                     }
                     else if(_loc20_ < -_loc18_)
                     {
                        _loc20_ = -_loc18_;
                     }
                     _loc17_ = _loc20_ - _loc19_;
                     _loc31_.c2.jtAcc = _loc20_;
                     _loc15_ = -_loc31_.ny * _loc17_;
                     _loc16_ = _loc31_.nx * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += _loc31_.rt2b * _loc17_ * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= _loc31_.rt2a * _loc17_ * _loc31_.b1.iinertia;
                     _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                     _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                     _loc33_ = _loc31_.k2x + _loc31_.b2.velx - _loc31_.c2.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c2.r1y * _loc31_.b1.angvel);
                     _loc34_ = _loc31_.k2y + _loc31_.b2.vely + _loc31_.c2.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c2.r1x * _loc31_.b1.angvel);
                     _loc35_ = _loc31_.c1.jnAcc;
                     _loc36_ = _loc31_.c2.jnAcc;
                     _loc37_ = _loc21_ * _loc31_.nx + _loc32_ * _loc31_.ny + _loc31_.surfacey + _loc31_.c1.bounce - (_loc31_.Ka * _loc35_ + _loc31_.Kb * _loc36_);
                     _loc38_ = _loc33_ * _loc31_.nx + _loc34_ * _loc31_.ny + _loc31_.surfacey + _loc31_.c2.bounce - (_loc31_.Kb * _loc35_ + _loc31_.Kc * _loc36_);
                     _loc39_ = -(_loc31_.kMassa * _loc37_ + _loc31_.kMassb * _loc38_);
                     _loc40_ = -(_loc31_.kMassb * _loc37_ + _loc31_.kMassc * _loc38_);
                     if(_loc39_ >= 0 && _loc40_ >= 0)
                     {
                        _loc37_ = _loc39_ - _loc35_;
                        _loc38_ = _loc40_ - _loc36_;
                        _loc31_.c1.jnAcc = _loc39_;
                        _loc31_.c2.jnAcc = _loc40_;
                     }
                     else
                     {
                        _loc39_ = -_loc31_.c1.nMass * _loc37_;
                        if(_loc39_ >= 0 && _loc31_.Kb * _loc39_ + _loc38_ >= 0)
                        {
                           _loc37_ = _loc39_ - _loc35_;
                           _loc38_ = -_loc36_;
                           _loc31_.c1.jnAcc = _loc39_;
                           _loc31_.c2.jnAcc = 0;
                        }
                        else
                        {
                           _loc40_ = -_loc31_.c2.nMass * _loc38_;
                           if(_loc40_ >= 0 && _loc31_.Kb * _loc40_ + _loc37_ >= 0)
                           {
                              _loc37_ = -_loc35_;
                              _loc38_ = _loc40_ - _loc36_;
                              _loc31_.c1.jnAcc = 0;
                              _loc31_.c2.jnAcc = _loc40_;
                           }
                           else if(_loc37_ >= 0 && _loc38_ >= 0)
                           {
                              _loc37_ = -_loc35_;
                              _loc38_ = -_loc36_;
                              _loc31_.c1.jnAcc = _loc31_.c2.jnAcc = 0;
                           }
                           else
                           {
                              _loc37_ = 0;
                              _loc38_ = 0;
                           }
                        }
                     }
                     _loc17_ = _loc37_ + _loc38_;
                     _loc15_ = _loc31_.nx * _loc17_;
                     _loc16_ = _loc31_.ny * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += (_loc31_.rn1b * _loc37_ + _loc31_.rn2b * _loc38_) * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= (_loc31_.rn1a * _loc37_ + _loc31_.rn2a * _loc38_) * _loc31_.b1.iinertia;
                  }
                  else
                  {
                     if(_loc31_.radius != 0)
                     {
                        _loc33_ = _loc31_.b2.angvel - _loc31_.b1.angvel;
                        _loc17_ = _loc33_ * _loc31_.rMass;
                        _loc18_ = _loc31_.rfric * _loc31_.c1.jnAcc;
                        _loc19_ = _loc31_.jrAcc;
                        _loc31_.jrAcc -= _loc17_;
                        if(_loc31_.jrAcc > _loc18_)
                        {
                           _loc31_.jrAcc = _loc18_;
                        }
                        else if(_loc31_.jrAcc < -_loc18_)
                        {
                           _loc31_.jrAcc = -_loc18_;
                        }
                        _loc17_ = _loc31_.jrAcc - _loc19_;
                        _loc31_.b2.angvel += _loc17_ * _loc31_.b2.iinertia;
                        _loc31_.b1.angvel -= _loc17_ * _loc31_.b1.iinertia;
                     }
                     _loc21_ = _loc31_.k1x + _loc31_.b2.velx - _loc31_.c1.r2y * _loc31_.b2.angvel - (_loc31_.b1.velx - _loc31_.c1.r1y * _loc31_.b1.angvel);
                     _loc32_ = _loc31_.k1y + _loc31_.b2.vely + _loc31_.c1.r2x * _loc31_.b2.angvel - (_loc31_.b1.vely + _loc31_.c1.r1x * _loc31_.b1.angvel);
                     _loc17_ = (_loc31_.c1.bounce + (_loc31_.nx * _loc21_ + _loc31_.ny * _loc32_) + _loc31_.surfacey) * _loc31_.c1.nMass;
                     _loc19_ = _loc31_.c1.jnAcc;
                     _loc20_ = _loc19_ - _loc17_;
                     if(_loc20_ < 0)
                     {
                        _loc20_ = 0;
                     }
                     _loc17_ = _loc20_ - _loc19_;
                     _loc31_.c1.jnAcc = _loc20_;
                     _loc15_ = _loc31_.nx * _loc17_;
                     _loc16_ = _loc31_.ny * _loc17_;
                     _loc31_.b2.velx += _loc15_ * _loc31_.b2.imass;
                     _loc31_.b2.vely += _loc16_ * _loc31_.b2.imass;
                     _loc31_.b1.velx -= _loc15_ * _loc31_.b1.imass;
                     _loc31_.b1.vely -= _loc16_ * _loc31_.b1.imass;
                     _loc31_.b2.angvel += _loc31_.rn1b * _loc17_ * _loc31_.b2.iinertia;
                     _loc31_.b1.angvel -= _loc31_.rn1a * _loc17_ * _loc31_.b1.iinertia;
                  }
                  _loc11_.sweep_angvel = _loc11_.angvel % _loc2_;
                  _loc12_.sweep_angvel = _loc12_.angvel % _loc2_;
               }
            }
            if(_loc30_ != null && (_loc30_.active && (_loc30_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0) && _loc30_.type == ZPP_Arbiter.COL)
            {
               if(!_loc11_.sweepFrozen && _loc11_.type != ZPP_Flags.id_BodyType_KINEMATIC)
               {
                  _loc11_.sweepFrozen = true;
                  if(_loc4_.failed)
                  {
                     _loc11_.angvel = _loc11_.sweep_angvel = 0;
                  }
                  else if(_loc4_.slipped)
                  {
                     _loc11_.angvel = _loc11_.sweep_angvel = _loc11_.sweep_angvel * Config.angularCCDSlipScale;
                  }
                  else
                  {
                     _loc11_.angvel = _loc11_.sweep_angvel;
                  }
               }
               if(!_loc12_.sweepFrozen && _loc12_.type != ZPP_Flags.id_BodyType_KINEMATIC)
               {
                  _loc12_.sweepFrozen = true;
                  if(_loc4_.failed)
                  {
                     _loc12_.angvel = _loc12_.sweep_angvel = 0;
                  }
                  else if(_loc4_.slipped)
                  {
                     _loc12_.angvel = _loc12_.sweep_angvel = _loc12_.sweep_angvel * Config.angularCCDSlipScale;
                  }
                  else
                  {
                     _loc12_.angvel = _loc12_.sweep_angvel;
                  }
               }
            }
         }
         while(toiEvents.head != null)
         {
            _loc4_ = toiEvents.pop_unsafe();
            _loc10_ = _loc4_;
            _loc10_.next = ZPP_ToiEvent.zpp_pool;
            ZPP_ToiEvent.zpp_pool = _loc10_;
         }
         var _loc42_:ZNPNode_ZPP_Body = kinematics.head;
         while(_loc42_ != null)
         {
            _loc11_ = _loc42_.elt;
            _loc5_ = param1 - _loc11_.sweepTime;
            if(_loc5_ != 0)
            {
               _loc11_.sweepTime = param1;
               _loc15_ = _loc5_;
               _loc11_.posx += _loc11_.velx * _loc15_;
               _loc11_.posy += _loc11_.vely * _loc15_;
               if(_loc11_.angvel != 0)
               {
                  _loc15_ = _loc11_.sweep_angvel * _loc5_;
                  _loc11_.rot += _loc15_;
                  if(_loc15_ * _loc15_ > 0.0001)
                  {
                     _loc11_.axisx = Math.sin(_loc11_.rot);
                     _loc11_.axisy = Math.cos(_loc11_.rot);
                     null;
                  }
                  else
                  {
                     _loc16_ = _loc15_ * _loc15_;
                     _loc17_ = 1 - 0.5 * _loc16_;
                     _loc18_ = 1 - _loc16_ * _loc16_ / 8;
                     _loc19_ = (_loc17_ * _loc11_.axisx + _loc15_ * _loc11_.axisy) * _loc18_;
                     _loc11_.axisy = (_loc17_ * _loc11_.axisy - _loc15_ * _loc11_.axisx) * _loc18_;
                     _loc11_.axisx = _loc19_;
                  }
               }
            }
            _loc11_.sweepTime = 0;
            _loc42_ = _loc42_.next;
         }
         _loc42_ = live.head;
         while(_loc42_ != null)
         {
            _loc11_ = _loc42_.elt;
            if(!_loc11_.sweepFrozen)
            {
               _loc5_ = param1 - _loc11_.sweepTime;
               if(_loc5_ != 0)
               {
                  _loc11_.sweepTime = param1;
                  _loc15_ = _loc5_;
                  _loc11_.posx += _loc11_.velx * _loc15_;
                  _loc11_.posy += _loc11_.vely * _loc15_;
                  if(_loc11_.angvel != 0)
                  {
                     _loc15_ = _loc11_.sweep_angvel * _loc5_;
                     _loc11_.rot += _loc15_;
                     if(_loc15_ * _loc15_ > 0.0001)
                     {
                        _loc11_.axisx = Math.sin(_loc11_.rot);
                        _loc11_.axisy = Math.cos(_loc11_.rot);
                        null;
                     }
                     else
                     {
                        _loc16_ = _loc15_ * _loc15_;
                        _loc17_ = 1 - 0.5 * _loc16_;
                        _loc18_ = 1 - _loc16_ * _loc16_ / 8;
                        _loc19_ = (_loc17_ * _loc11_.axisx + _loc15_ * _loc11_.axisy) * _loc18_;
                        _loc11_.axisy = (_loc17_ * _loc11_.axisy - _loc15_ * _loc11_.axisx) * _loc18_;
                        _loc11_.axisx = _loc19_;
                     }
                  }
               }
            }
            _loc11_.sweepTime = 0;
            _loc42_ = _loc42_.next;
         }
      }
      
      public function constraints_subber(param1:Constraint) : void
      {
         remConstraint(param1.zpp_inner);
      }
      
      public function constraints_modifiable() : void
      {
         if(midstep)
         {
            Boot.lastError = new Error();
            throw "Error: Space::constraints cannot be set during space step()";
         }
      }
      
      public function constraints_adder(param1:Constraint) : Boolean
      {
         if(param1.zpp_inner.compound != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set the space of a Constraint belonging to a Compound, only the root Compound space can be set";
         }
         if(param1.zpp_inner.space != this)
         {
            if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.outer.zpp_inner.wrap_constraints.remove(param1);
            }
            addConstraint(param1.zpp_inner);
            return true;
         }
         return false;
      }
      
      public function constraintCbWake(param1:ZPP_Constraint) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc3_:* = null as ZPP_ConstraintListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.cbSet != null)
         {
            if(midstep)
            {
               _loc2_ = param1.cbSet.conlisteners.head;
               while(_loc2_ != null)
               {
                  _loc3_ = _loc2_.elt;
                  if(_loc3_.event != ZPP_Flags.id_CbEvent_WAKE)
                  {
                     _loc2_ = _loc2_.next;
                  }
                  else
                  {
                     _loc4_ = push_callback(_loc3_);
                     _loc4_.event = ZPP_Flags.id_CbEvent_WAKE;
                     _loc4_.constraint = param1;
                     _loc2_ = _loc2_.next;
                  }
               }
            }
            else
            {
               param1.component.woken = true;
            }
         }
      }
      
      public function constraintCbSleep(param1:ZPP_Constraint) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc3_:* = null as ZPP_ConstraintListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.cbSet != null)
         {
            _loc2_ = param1.cbSet.conlisteners.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.event != ZPP_Flags.id_CbEvent_SLEEP)
               {
                  _loc2_ = _loc2_.next;
               }
               else
               {
                  _loc4_ = push_callback(_loc3_);
                  _loc4_.event = ZPP_Flags.id_CbEvent_SLEEP;
                  _loc4_.constraint = param1;
                  _loc2_ = _loc2_.next;
               }
            }
         }
      }
      
      public function constraintCbBreak(param1:ZPP_Constraint) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc3_:* = null as ZPP_ConstraintListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.cbSet != null)
         {
            _loc2_ = param1.cbSet.conlisteners.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.event != ZPP_Flags.id_CbEvent_BREAK)
               {
                  _loc2_ = _loc2_.next;
               }
               else
               {
                  _loc4_ = push_callback(_loc3_);
                  _loc4_.event = ZPP_Flags.id_CbEvent_BREAK;
                  _loc4_.constraint = param1;
                  _loc2_ = _loc2_.next;
               }
            }
         }
      }
      
      public function compounds_subber(param1:Compound) : void
      {
         remCompound(param1.zpp_inner);
      }
      
      public function compounds_modifiable() : void
      {
         if(midstep)
         {
            Boot.lastError = new Error();
            throw "Error: Space::compounds cannot be set during space step()";
         }
      }
      
      public function compounds_adder(param1:Compound) : Boolean
      {
         if(param1.zpp_inner.compound != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set the space of an inner Compound, only the root Compound space can be set";
         }
         if(param1.zpp_inner.space != this)
         {
            if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.wrap_compounds.remove(param1);
            }
            addCompound(param1.zpp_inner);
            return true;
         }
         return false;
      }
      
      public function clear() : void
      {
         var _loc1_:* = null as ZPP_Listener;
         var _loc2_:* = null as ZPP_CallbackSet;
         var _loc3_:* = null as ZPP_CallbackSet;
         var _loc4_:* = null as ZPP_Interactor;
         var _loc5_:int = 0;
         var _loc6_:* = null as ZPP_ColArbiter;
         var _loc7_:* = null as ZNPList_ZPP_Arbiter;
         var _loc8_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc9_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc10_:Boolean = false;
         var _loc11_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc12_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc13_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc14_:* = null as ZPP_Body;
         var _loc15_:* = null as ZPP_Contact;
         var _loc16_:* = null as ZPP_Contact;
         var _loc17_:* = null as ZPP_Contact;
         var _loc18_:* = null as ZPP_IContact;
         var _loc19_:* = null as ZPP_IContact;
         var _loc20_:* = null as ZPP_ColArbiter;
         var _loc21_:* = null as ZPP_Edge;
         var _loc22_:* = null as ZPP_SensorArbiter;
         var _loc23_:* = null as ZPP_SensorArbiter;
         var _loc24_:* = null as ZPP_FluidArbiter;
         var _loc25_:* = null as ZPP_FluidArbiter;
         var _loc26_:* = null as ZPP_Island;
         var _loc27_:* = null as ZPP_Component;
         var _loc28_:* = null as ZPP_Island;
         var _loc29_:* = null as ZPP_Constraint;
         var _loc31_:* = null as ZPP_Compound;
         var _loc32_:* = null as ZNPNode_ZPP_Body;
         var _loc33_:* = null as ZNPNode_ZPP_Constraint;
         var _loc34_:* = null as ZNPNode_ZPP_Compound;
         var _loc35_:* = null as ZPP_Compound;
         while(listeners.head != null)
         {
            _loc1_ = listeners.pop_unsafe();
            remListener(_loc1_);
         }
         while(callbackset_list.next != null)
         {
            _loc2_ = callbackset_list.pop_unsafe();
            _loc2_.arbiters.clear();
            _loc3_ = _loc2_;
            _loc3_.int1 = _loc3_.int2 = null;
            _loc3_.id = _loc3_.di = -1;
            _loc3_.freed = true;
            null;
            _loc3_.next = ZPP_CallbackSet.zpp_pool;
            ZPP_CallbackSet.zpp_pool = _loc3_;
         }
         while(c_arbiters_true.head != null)
         {
            _loc6_ = c_arbiters_true.pop_unsafe();
            if(!_loc6_.cleared)
            {
               _loc7_ = _loc6_.b1.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc6_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     --_loc7_.length;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               _loc7_ = _loc6_.b2.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc6_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     --_loc7_.length;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               if(_loc6_.pair != null)
               {
                  _loc6_.pair.arb = null;
                  _loc6_.pair = null;
               }
            }
            _loc6_.b1 = _loc6_.b2 = null;
            _loc6_.active = false;
            _loc6_.intchange = false;
            while(_loc6_.contacts.next != null)
            {
               _loc16_ = _loc6_.contacts;
               _loc17_ = _loc16_.next;
               _loc16_.pop();
               _loc15_ = _loc17_;
               _loc15_.arbiter = null;
               _loc15_.next = ZPP_Contact.zpp_pool;
               ZPP_Contact.zpp_pool = _loc15_;
               _loc18_ = _loc6_.innards;
               _loc19_ = _loc18_.next;
               _loc18_.next = _loc19_.next;
               _loc19_._inuse = false;
               if(_loc18_.next == null)
               {
                  _loc18_.pushmod = true;
               }
               _loc18_.modified = true;
               --_loc18_.length;
            }
            _loc20_ = _loc6_;
            _loc20_.userdef_dyn_fric = false;
            _loc20_.userdef_stat_fric = false;
            _loc20_.userdef_restitution = false;
            _loc20_.userdef_rfric = false;
            _loc20_.__ref_edge1 = _loc20_.__ref_edge2 = null;
            _loc20_.next = ZPP_ColArbiter.zpp_pool;
            ZPP_ColArbiter.zpp_pool = _loc20_;
            _loc6_.pre_dt = -1;
         }
         while(c_arbiters_false.head != null)
         {
            _loc6_ = c_arbiters_false.pop_unsafe();
            if(!_loc6_.cleared)
            {
               _loc7_ = _loc6_.b1.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc6_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     --_loc7_.length;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               _loc7_ = _loc6_.b2.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc6_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     --_loc7_.length;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               if(_loc6_.pair != null)
               {
                  _loc6_.pair.arb = null;
                  _loc6_.pair = null;
               }
            }
            _loc6_.b1 = _loc6_.b2 = null;
            _loc6_.active = false;
            _loc6_.intchange = false;
            while(_loc6_.contacts.next != null)
            {
               _loc16_ = _loc6_.contacts;
               _loc17_ = _loc16_.next;
               _loc16_.pop();
               _loc15_ = _loc17_;
               _loc15_.arbiter = null;
               _loc15_.next = ZPP_Contact.zpp_pool;
               ZPP_Contact.zpp_pool = _loc15_;
               _loc18_ = _loc6_.innards;
               _loc19_ = _loc18_.next;
               _loc18_.next = _loc19_.next;
               _loc19_._inuse = false;
               if(_loc18_.next == null)
               {
                  _loc18_.pushmod = true;
               }
               _loc18_.modified = true;
               --_loc18_.length;
            }
            _loc20_ = _loc6_;
            _loc20_.userdef_dyn_fric = false;
            _loc20_.userdef_stat_fric = false;
            _loc20_.userdef_restitution = false;
            _loc20_.userdef_rfric = false;
            _loc20_.__ref_edge1 = _loc20_.__ref_edge2 = null;
            _loc20_.next = ZPP_ColArbiter.zpp_pool;
            ZPP_ColArbiter.zpp_pool = _loc20_;
            _loc6_.pre_dt = -1;
         }
         while(s_arbiters.head != null)
         {
            _loc22_ = s_arbiters.pop_unsafe();
            if(!_loc22_.cleared)
            {
               _loc7_ = _loc22_.b1.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc22_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     --_loc7_.length;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               _loc7_ = _loc22_.b2.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc22_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     --_loc7_.length;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               if(_loc22_.pair != null)
               {
                  _loc22_.pair.arb = null;
                  _loc22_.pair = null;
               }
            }
            _loc22_.b1 = _loc22_.b2 = null;
            _loc22_.active = false;
            _loc22_.intchange = false;
            _loc23_ = _loc22_;
            _loc23_.next = ZPP_SensorArbiter.zpp_pool;
            ZPP_SensorArbiter.zpp_pool = _loc23_;
         }
         while(f_arbiters.head != null)
         {
            _loc24_ = f_arbiters.pop_unsafe();
            if(!_loc24_.cleared)
            {
               _loc7_ = _loc24_.b1.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc24_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     --_loc7_.length;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               _loc7_ = _loc24_.b2.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc24_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     --_loc7_.length;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               if(_loc24_.pair != null)
               {
                  _loc24_.pair.arb = null;
                  _loc24_.pair = null;
               }
            }
            _loc24_.b1 = _loc24_.b2 = null;
            _loc24_.active = false;
            _loc24_.intchange = false;
            _loc25_ = _loc24_;
            _loc25_.next = ZPP_FluidArbiter.zpp_pool;
            ZPP_FluidArbiter.zpp_pool = _loc25_;
            _loc24_.pre_dt = -1;
         }
         bphase.clear();
         while(bodies.head != null)
         {
            _loc14_ = bodies.pop_unsafe();
            if(_loc14_.component != null)
            {
               _loc26_ = _loc14_.component.island;
               if(_loc26_ != null)
               {
                  while(_loc26_.comps.head != null)
                  {
                     _loc27_ = _loc26_.comps.pop_unsafe();
                     _loc27_.sleeping = false;
                     _loc27_.island = null;
                     _loc27_.parent = _loc27_;
                     _loc27_.rank = 0;
                  }
                  _loc28_ = _loc26_;
                  _loc28_.next = ZPP_Island.zpp_pool;
                  ZPP_Island.zpp_pool = _loc28_;
               }
            }
            _loc14_.removedFromSpace();
            _loc14_.space = null;
         }
         while(constraints.head != null)
         {
            _loc29_ = constraints.pop_unsafe();
            if(_loc29_.component != null)
            {
               _loc26_ = _loc29_.component.island;
               if(_loc26_ != null)
               {
                  while(_loc26_.comps.head != null)
                  {
                     _loc27_ = _loc26_.comps.pop_unsafe();
                     _loc27_.sleeping = false;
                     _loc27_.island = null;
                     _loc27_.parent = _loc27_;
                     _loc27_.rank = 0;
                  }
                  _loc28_ = _loc26_;
                  _loc28_.next = ZPP_Island.zpp_pool;
                  ZPP_Island.zpp_pool = _loc28_;
               }
            }
            _loc29_.removedFromSpace();
            _loc29_.space = null;
         }
         kinematics.clear();
         var _loc30_:ZNPList_ZPP_Compound = new ZNPList_ZPP_Compound();
         while(compounds.head != null)
         {
            _loc31_ = compounds.pop_unsafe();
            _loc30_.add(_loc31_);
         }
         while(_loc30_.head != null)
         {
            _loc31_ = _loc30_.pop_unsafe();
            _loc31_.removedFromSpace();
            _loc31_.space = null;
            _loc32_ = _loc31_.bodies.head;
            while(_loc32_ != null)
            {
               _loc14_ = _loc32_.elt;
               if(_loc14_.component != null)
               {
                  _loc26_ = _loc14_.component.island;
                  if(_loc26_ != null)
                  {
                     while(_loc26_.comps.head != null)
                     {
                        _loc27_ = _loc26_.comps.pop_unsafe();
                        _loc27_.sleeping = false;
                        _loc27_.island = null;
                        _loc27_.parent = _loc27_;
                        _loc27_.rank = 0;
                     }
                     _loc28_ = _loc26_;
                     _loc28_.next = ZPP_Island.zpp_pool;
                     ZPP_Island.zpp_pool = _loc28_;
                  }
               }
               _loc14_.removedFromSpace();
               _loc14_.space = null;
               _loc32_ = _loc32_.next;
            }
            _loc33_ = _loc31_.constraints.head;
            while(_loc33_ != null)
            {
               _loc29_ = _loc33_.elt;
               if(_loc29_.component != null)
               {
                  _loc26_ = _loc29_.component.island;
                  if(_loc26_ != null)
                  {
                     while(_loc26_.comps.head != null)
                     {
                        _loc27_ = _loc26_.comps.pop_unsafe();
                        _loc27_.sleeping = false;
                        _loc27_.island = null;
                        _loc27_.parent = _loc27_;
                        _loc27_.rank = 0;
                     }
                     _loc28_ = _loc26_;
                     _loc28_.next = ZPP_Island.zpp_pool;
                     ZPP_Island.zpp_pool = _loc28_;
                  }
               }
               _loc29_.removedFromSpace();
               _loc29_.space = null;
               _loc33_ = _loc33_.next;
            }
            _loc34_ = _loc31_.compounds.head;
            while(_loc34_ != null)
            {
               _loc35_ = _loc34_.elt;
               _loc30_.add(_loc35_);
               _loc34_ = _loc34_.next;
            }
         }
         staticsleep.clear();
         live.clear();
         live_constraints.clear();
         stamp = 0;
         time = 0;
         mrca1.clear();
         mrca2.clear();
         prelisteners.clear();
         cbsets.clear();
      }
      
      public function bodyCbWake(param1:ZPP_Body) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_BodyListener;
         var _loc3_:* = null as ZPP_BodyListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.type == ZPP_Flags.id_BodyType_DYNAMIC && param1.cbSet != null)
         {
            if(midstep)
            {
               _loc2_ = param1.cbSet.bodylisteners.head;
               while(_loc2_ != null)
               {
                  _loc3_ = _loc2_.elt;
                  if(_loc3_.event != ZPP_Flags.id_CbEvent_WAKE)
                  {
                     _loc2_ = _loc2_.next;
                  }
                  else
                  {
                     _loc4_ = push_callback(_loc3_);
                     _loc4_.event = ZPP_Flags.id_CbEvent_WAKE;
                     _loc4_.body = param1;
                     _loc2_ = _loc2_.next;
                  }
               }
            }
            else
            {
               param1.component.woken = true;
            }
         }
      }
      
      public function bodyCbSleep(param1:ZPP_Body) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_BodyListener;
         var _loc3_:* = null as ZPP_BodyListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.type == ZPP_Flags.id_BodyType_DYNAMIC && param1.cbSet != null)
         {
            _loc2_ = param1.cbSet.bodylisteners.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.event != ZPP_Flags.id_CbEvent_SLEEP)
               {
                  _loc2_ = _loc2_.next;
               }
               else
               {
                  _loc4_ = push_callback(_loc3_);
                  _loc4_.event = ZPP_Flags.id_CbEvent_SLEEP;
                  _loc4_.body = param1;
                  _loc2_ = _loc2_.next;
               }
            }
         }
      }
      
      public function bodies_subber(param1:Body) : void
      {
         remBody(param1.zpp_inner);
      }
      
      public function bodies_modifiable() : void
      {
         if(midstep)
         {
            Boot.lastError = new Error();
            throw "Error: Space::bodies cannot be set during space step()";
         }
      }
      
      public function bodies_adder(param1:Body) : Boolean
      {
         if(param1.zpp_inner.compound != null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot set the space of a Body belonging to a Compound, only the root Compound space can be set";
         }
         if(param1.zpp_inner.space != this)
         {
            if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.outer.zpp_inner.wrap_bodies.remove(param1);
            }
            addBody(param1.zpp_inner);
            return true;
         }
         return false;
      }
      
      public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
      {
         return bphase.bodiesUnderPoint(param1,param2,param3,param4);
      }
      
      public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter, param4:BodyList) : BodyList
      {
         return bphase.bodiesInShape(param1,param2,param3,param4);
      }
      
      public function bodiesInCircle(param1:Vec2, param2:Number, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
      {
         §§push(bphase);
         if(param1 != null && param1.zpp_disp)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
         }
         var _loc6_:ZPP_Vec2 = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§push(param1.zpp_inner.x);
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
         return §§pop().bodiesInCircle(§§pop(),param1.zpp_inner.y,param2,param3,param4,param5);
      }
      
      public function bodiesInAABB(param1:AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter, param5:BodyList) : BodyList
      {
         return bphase.bodiesInAABB(param1.zpp_inner,param2,param3,param4,param5);
      }
      
      public function added_shape(param1:ZPP_Shape, param2:Boolean = false) : void
      {
         var _loc3_:* = null as ZPP_Body;
         if(!param2)
         {
            _loc3_ = param1.body;
            if(!_loc3_.world)
            {
               _loc3_.component.waket = stamp + (midstep ? 0 : 1);
               if(_loc3_.component.sleeping)
               {
                  really_wake(_loc3_,false);
               }
            }
         }
         bphase.insert(param1);
         param1.addedToSpace();
      }
      
      public function add_callbackset(param1:ZPP_CallbackSet) : void
      {
         var _loc4_:* = null as ZNPNode_ZPP_CallbackSet;
         var _loc2_:ZNPList_ZPP_CallbackSet = param1.int1.cbsets;
         if(ZNPNode_ZPP_CallbackSet.zpp_pool == null)
         {
            _loc4_ = new ZNPNode_ZPP_CallbackSet();
         }
         else
         {
            _loc4_ = ZNPNode_ZPP_CallbackSet.zpp_pool;
            ZNPNode_ZPP_CallbackSet.zpp_pool = _loc4_.next;
            _loc4_.next = null;
         }
         null;
         _loc4_.elt = param1;
         var _loc3_:ZNPNode_ZPP_CallbackSet = _loc4_;
         _loc3_.next = _loc2_.head;
         _loc2_.head = _loc3_;
         _loc2_.modified = true;
         ++_loc2_.length;
         param1;
         _loc2_ = param1.int2.cbsets;
         if(ZNPNode_ZPP_CallbackSet.zpp_pool == null)
         {
            _loc4_ = new ZNPNode_ZPP_CallbackSet();
         }
         else
         {
            _loc4_ = ZNPNode_ZPP_CallbackSet.zpp_pool;
            ZNPNode_ZPP_CallbackSet.zpp_pool = _loc4_.next;
            _loc4_.next = null;
         }
         null;
         _loc4_.elt = param1;
         _loc3_ = _loc4_;
         _loc3_.next = _loc2_.head;
         _loc2_.head = _loc3_;
         _loc2_.modified = true;
         ++_loc2_.length;
         param1;
         var _loc5_:ZPP_CallbackSet = callbackset_list;
         param1._inuse = true;
         var _loc6_:ZPP_CallbackSet = param1;
         _loc6_.next = _loc5_.next;
         _loc5_.next = _loc6_;
         _loc5_.modified = true;
         ++_loc5_.length;
         param1;
      }
      
      public function addListener(param1:ZPP_Listener) : void
      {
         param1.space = this;
         param1.addedToSpace();
         if(param1.interaction != null)
         {
            null;
         }
      }
      
      public function addConstraint(param1:ZPP_Constraint) : void
      {
         param1.space = this;
         param1.addedToSpace();
         if(param1.active)
         {
            param1.component.sleeping = true;
            wake_constraint(param1,true);
         }
      }
      
      public function addCompound(param1:ZPP_Compound) : void
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc5_:* = null as ZPP_Constraint;
         var _loc7_:* = null as ZPP_Compound;
         param1.space = this;
         param1.addedToSpace();
         var _loc2_:ZNPNode_ZPP_Body = param1.bodies.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            addBody(_loc3_);
            _loc2_ = _loc2_.next;
         }
         var _loc4_:ZNPNode_ZPP_Constraint = param1.constraints.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            addConstraint(_loc5_);
            _loc4_ = _loc4_.next;
         }
         var _loc6_:ZNPNode_ZPP_Compound = param1.compounds.head;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.elt;
            addCompound(_loc7_);
            _loc6_ = _loc6_.next;
         }
      }
      
      public function addBody(param1:ZPP_Body, param2:int = -1) : void
      {
         var _loc5_:* = null as ZPP_Shape;
         param1.space = this;
         param1.addedToSpace();
         param1.component.sleeping = true;
         var _loc3_:ZPP_Body = param1;
         if(!_loc3_.world)
         {
            _loc3_.component.waket = stamp + (midstep ? 0 : 1);
            if(_loc3_.component.sleeping)
            {
               really_wake(_loc3_,true);
            }
         }
         var _loc4_:ZNPNode_ZPP_Shape = param1.shapes.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            bphase.insert(_loc5_);
            _loc5_.addedToSpace();
            _loc4_ = _loc4_.next;
         }
         if(param1.type == ZPP_Flags.id_BodyType_STATIC)
         {
            static_validation(param1);
         }
         else if(param1.type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            if(param2 != ZPP_Flags.id_BodyType_KINEMATIC)
            {
               kinematics.add(param1);
            }
         }
      }
      
      public function MRCA_chains(param1:ZPP_Shape, param2:ZPP_Shape) : void
      {
         var _loc3_:* = null as ZNPList_ZPP_Interactor;
         var _loc4_:* = null as ZNPNode_ZPP_Interactor;
         var _loc5_:* = null as ZNPNode_ZPP_Interactor;
         var _loc6_:* = null as ZPP_Interactor;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc3_ = mrca1;
         while(_loc3_.head != null)
         {
            _loc4_ = _loc3_.head;
            _loc3_.head = _loc4_.next;
            _loc5_ = _loc4_;
            _loc5_.elt = null;
            _loc5_.next = ZNPNode_ZPP_Interactor.zpp_pool;
            ZNPNode_ZPP_Interactor.zpp_pool = _loc5_;
            if(_loc3_.head == null)
            {
               _loc3_.pushmod = true;
            }
            _loc3_.modified = true;
            --_loc3_.length;
         }
         _loc3_.pushmod = true;
         _loc3_ = mrca2;
         while(_loc3_.head != null)
         {
            _loc4_ = _loc3_.head;
            _loc3_.head = _loc4_.next;
            _loc5_ = _loc4_;
            _loc5_.elt = null;
            _loc5_.next = ZNPNode_ZPP_Interactor.zpp_pool;
            ZNPNode_ZPP_Interactor.zpp_pool = _loc5_;
            if(_loc3_.head == null)
            {
               _loc3_.pushmod = true;
            }
            _loc3_.modified = true;
            --_loc3_.length;
         }
         _loc3_.pushmod = true;
         if(param1.cbSet != null)
         {
            _loc3_ = mrca1;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = param1;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            ++_loc3_.length;
            param1;
         }
         if(param1.body.cbSet != null)
         {
            _loc3_ = mrca1;
            _loc6_ = param1.body;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = _loc6_;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            ++_loc3_.length;
            _loc6_;
         }
         if(param2.cbSet != null)
         {
            _loc3_ = mrca2;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = param2;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            ++_loc3_.length;
            param2;
         }
         if(param2.body.cbSet != null)
         {
            _loc3_ = mrca2;
            _loc6_ = param2.body;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = _loc6_;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            ++_loc3_.length;
            _loc6_;
         }
         var _loc7_:ZPP_Compound = param1.body.compound;
         var _loc8_:ZPP_Compound = param2.body.compound;
         while(_loc7_ != _loc8_)
         {
            _loc9_ = _loc7_ == null ? 0 : _loc7_.depth;
            _loc10_ = _loc8_ == null ? 0 : _loc8_.depth;
            if(_loc9_ < _loc10_)
            {
               if(_loc8_.cbSet != null)
               {
                  _loc3_ = mrca2;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc5_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
                     _loc5_.next = null;
                  }
                  null;
                  _loc5_.elt = _loc8_;
                  _loc4_ = _loc5_;
                  _loc4_.next = _loc3_.head;
                  _loc3_.head = _loc4_;
                  _loc3_.modified = true;
                  ++_loc3_.length;
                  _loc8_;
               }
               _loc8_ = _loc8_.compound;
            }
            else
            {
               if(_loc7_.cbSet != null)
               {
                  _loc3_ = mrca1;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc5_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
                     _loc5_.next = null;
                  }
                  null;
                  _loc5_.elt = _loc7_;
                  _loc4_ = _loc5_;
                  _loc4_.next = _loc3_.head;
                  _loc3_.head = _loc4_;
                  _loc3_.modified = true;
                  ++_loc3_.length;
                  _loc7_;
               }
               _loc7_ = _loc7_.compound;
            }
         }
      }
   }
}

