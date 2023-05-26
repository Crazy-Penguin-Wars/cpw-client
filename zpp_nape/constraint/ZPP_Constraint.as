package zpp_nape.constraint
{
   import flash.Boot;
   import nape.callbacks.CbType;
   import nape.callbacks.CbTypeIterator;
   import nape.callbacks.CbTypeList;
   import nape.constraint.Constraint;
   import nape.util.Debug;
   import zpp_nape.ZPP_ID;
   import zpp_nape.callbacks.ZPP_CbSet;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPNode_ZPP_CbType;
   import zpp_nape.util.ZPP_CbTypeList;
   
   public class ZPP_Constraint
   {
       
      
      public var wrap_cbTypes:CbTypeList;
      
      public var userData;
      
      public var stiff:Boolean;
      
      public var space:ZPP_Space;
      
      public var removeOnBreak:Boolean;
      
      public var pre_dt:Number;
      
      public var outer:Constraint;
      
      public var maxForce:Number;
      
      public var maxError:Number;
      
      public var ignore:Boolean;
      
      public var id:int;
      
      public var frequency:Number;
      
      public var damping:Number;
      
      public var compound:ZPP_Compound;
      
      public var component:ZPP_Component;
      
      public var cbTypes:ZNPList_ZPP_CbType;
      
      public var cbSet:ZPP_CbSet;
      
      public var breakUnderForce:Boolean;
      
      public var breakUnderError:Boolean;
      
      public var active:Boolean;
      
      public var __velocity:Boolean;
      
      public function ZPP_Constraint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         pre_dt = 0;
         wrap_cbTypes = null;
         cbSet = null;
         cbTypes = null;
         __velocity = false;
         ignore = false;
         component = null;
         removeOnBreak = false;
         breakUnderError = false;
         breakUnderForce = false;
         maxError = 0;
         maxForce = 0;
         damping = 0;
         frequency = 0;
         stiff = false;
         active = false;
         space = null;
         compound = null;
         userData = null;
         id = 0;
         outer = null;
         __velocity = false;
         id = ZPP_ID.Constraint();
         stiff = true;
         active = true;
         ignore = false;
         frequency = 10;
         damping = 1;
         maxForce = 1.79e+308;
         maxError = 1.79e+308;
         breakUnderForce = false;
         removeOnBreak = true;
         pre_dt = -1;
         cbTypes = new ZNPList_ZPP_CbType();
      }
      
      public function wrap_cbTypes_subber(param1:CbType) : void
      {
         var _loc2_:ZPP_CbType = param1.zpp_inner;
         if(cbTypes.has(_loc2_))
         {
            if(space != null)
            {
               dealloc_cbSet();
               _loc2_.constraints.remove(this);
            }
            cbTypes.remove(_loc2_);
            if(space != null)
            {
               alloc_cbSet();
               wake();
            }
         }
      }
      
      public function wrap_cbTypes_adder(param1:CbType) : Boolean
      {
         insert_cbtype(param1.zpp_inner);
         return false;
      }
      
      public function warmStart() : void
      {
      }
      
      public function wake_connected() : void
      {
      }
      
      public function wake() : void
      {
         if(space != null)
         {
            space.wake_constraint(this);
         }
      }
      
      public function validate() : void
      {
      }
      
      public function setupcbTypes() : void
      {
         wrap_cbTypes = ZPP_CbTypeList.get(cbTypes);
         wrap_cbTypes.zpp_inner.adder = wrap_cbTypes_adder;
         wrap_cbTypes.zpp_inner.subber = wrap_cbTypes_subber;
         wrap_cbTypes.zpp_inner.dontremove = true;
         wrap_cbTypes.zpp_inner._modifiable = immutable_cbTypes;
      }
      
      public function removedFromSpace() : void
      {
         var _loc2_:* = null as ZPP_CbType;
         if(active)
         {
            inactiveOrOutSpace();
         }
         inactiveBodies();
         var _loc1_:ZNPNode_ZPP_CbType = cbTypes.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.constraints.remove(this);
            _loc1_ = _loc1_.next;
         }
      }
      
      public function preStep(param1:Number) : Boolean
      {
         return false;
      }
      
      public function pair_exists(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function insert_cbtype(param1:ZPP_CbType) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_CbType;
         var _loc3_:* = null as ZNPNode_ZPP_CbType;
         var _loc4_:* = null as ZPP_CbType;
         var _loc5_:* = null as ZNPList_ZPP_CbType;
         var _loc6_:* = null as ZNPNode_ZPP_CbType;
         var _loc7_:Boolean = false;
         if(!cbTypes.has(param1))
         {
            if(space != null)
            {
               dealloc_cbSet();
               param1.constraints.add(this);
            }
            _loc2_ = null;
            _loc3_ = cbTypes.head;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_.elt;
               if(param1.id < _loc4_.id)
               {
                  break;
               }
               _loc2_ = _loc3_;
               _loc3_ = _loc3_.next;
            }
            _loc5_ = cbTypes;
            if(ZNPNode_ZPP_CbType.zpp_pool == null)
            {
               _loc6_ = new ZNPNode_ZPP_CbType();
            }
            else
            {
               _loc6_ = ZNPNode_ZPP_CbType.zpp_pool;
               ZNPNode_ZPP_CbType.zpp_pool = _loc6_.next;
               _loc6_.next = null;
            }
            _loc6_.elt = param1;
            _loc3_ = _loc6_;
            if(_loc2_ == null)
            {
               _loc3_.next = _loc5_.head;
               _loc5_.head = _loc3_;
            }
            else
            {
               _loc3_.next = _loc2_.next;
               _loc2_.next = _loc3_;
            }
            _loc5_.pushmod = _loc5_.modified = true;
            _loc5_.length = _loc5_.length + 1;
            _loc3_;
            if(space != null)
            {
               alloc_cbSet();
               wake();
            }
         }
      }
      
      public function inactiveOrOutSpace() : void
      {
         dealloc_cbSet();
         var _loc1_:ZPP_Component = component;
         _loc1_.body = null;
         _loc1_.constraint = null;
         _loc1_.next = ZPP_Component.zpp_pool;
         ZPP_Component.zpp_pool = _loc1_;
         component = null;
      }
      
      public function inactiveBodies() : void
      {
      }
      
      public function immutable_midstep(param1:String) : void
      {
         if(space != null && space.midstep)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::" + param1 + " cannot be set during space step()";
         }
      }
      
      public function immutable_cbTypes() : void
      {
         immutable_midstep("Constraint::cbTypes");
      }
      
      public function forest() : void
      {
      }
      
      public function draw(param1:Debug) : void
      {
      }
      
      public function dealloc_cbSet() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null as ZPP_CbSet;
         var _loc3_:* = null as ZPP_CbType;
         if(cbSet != null)
         {
            cbSet.constraints.remove(this);
            if((cbSet.count = cbSet.count - 1) == 0)
            {
               space.cbsets.remove(cbSet);
               _loc2_ = cbSet;
               _loc2_.listeners.clear();
               _loc2_.zip_listeners = true;
               _loc2_.bodylisteners.clear();
               _loc2_.zip_bodylisteners = true;
               _loc2_.conlisteners.clear();
               _loc2_.zip_conlisteners = true;
               while(_loc2_.cbTypes.head != null)
               {
                  _loc3_ = _loc2_.cbTypes.pop_unsafe();
                  _loc3_.cbsets.remove(_loc2_);
               }
               _loc2_.next = ZPP_CbSet.zpp_pool;
               ZPP_CbSet.zpp_pool = _loc2_;
            }
            cbSet = null;
         }
      }
      
      public function deactivate() : void
      {
         if(space != null)
         {
            inactiveOrOutSpace();
         }
      }
      
      public function copyto(param1:Constraint) : void
      {
         var _loc4_:* = null as CbTypeList;
         var _loc5_:* = null as CbType;
         var _loc6_:int = 0;
         var _loc2_:Constraint = outer;
         if(_loc2_.zpp_inner.wrap_cbTypes == null)
         {
            _loc2_.zpp_inner.setupcbTypes();
         }
         _loc4_ = _loc2_.zpp_inner.wrap_cbTypes;
         _loc4_.zpp_inner.valmod();
         var _loc3_:CbTypeIterator = CbTypeIterator.get(_loc4_);
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc4_ = _loc3_.zpp_inner;
            _loc4_.zpp_inner.valmod();
            if(_loc4_.zpp_inner.zip_length)
            {
               _loc4_.zpp_inner.zip_length = false;
               _loc4_.zpp_inner.user_length = _loc4_.zpp_inner.inner.length;
            }
            _loc6_ = _loc4_.zpp_inner.user_length;
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc6_ ? true : (_loc3_.zpp_next = CbTypeIterator.zpp_pool, CbTypeIterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
            {
               break;
            }
            _loc3_.zpp_critical = false;
            _loc3_.zpp_i = (_loc6_ = _loc3_.zpp_i) + 1;
            _loc5_ = _loc3_.zpp_inner.at(_loc6_);
            if(param1.zpp_inner.wrap_cbTypes == null)
            {
               param1.zpp_inner.setupcbTypes();
            }
            _loc4_ = param1.zpp_inner.wrap_cbTypes;
            if(_loc4_.zpp_inner.reverse_flag)
            {
               _loc4_.push(_loc5_);
            }
            else
            {
               _loc4_.unshift(_loc5_);
            }
         }
         param1.zpp_inner.removeOnBreak = _loc2_.zpp_inner.removeOnBreak;
         param1.zpp_inner.removeOnBreak;
         var _loc7_:Boolean = _loc2_.zpp_inner.breakUnderError;
         if(param1.zpp_inner.breakUnderError != _loc7_)
         {
            param1.zpp_inner.breakUnderError = _loc7_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.breakUnderError;
         _loc7_ = _loc2_.zpp_inner.breakUnderForce;
         if(param1.zpp_inner.breakUnderForce != _loc7_)
         {
            param1.zpp_inner.breakUnderForce = _loc7_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.breakUnderForce;
         var _loc8_:Number = _loc2_.zpp_inner.maxError;
         if(_loc8_ != _loc8_)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::maxError cannot be NaN";
         }
         if(_loc8_ < 0)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::maxError must be >=0";
         }
         if(param1.zpp_inner.maxError != _loc8_)
         {
            param1.zpp_inner.maxError = _loc8_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.maxError;
         _loc8_ = _loc2_.zpp_inner.maxForce;
         if(_loc8_ != _loc8_)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::maxForce cannot be NaN";
         }
         if(_loc8_ < 0)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::maxForce must be >=0";
         }
         if(param1.zpp_inner.maxForce != _loc8_)
         {
            param1.zpp_inner.maxForce = _loc8_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.maxForce;
         _loc8_ = _loc2_.zpp_inner.damping;
         if(_loc8_ != _loc8_)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::Damping cannot be Nan";
         }
         if(_loc8_ < 0)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::Damping must be >=0";
         }
         if(param1.zpp_inner.damping != _loc8_)
         {
            param1.zpp_inner.damping = _loc8_;
            if(!param1.zpp_inner.stiff)
            {
               param1.zpp_inner.wake();
            }
         }
         param1.zpp_inner.damping;
         _loc8_ = _loc2_.zpp_inner.frequency;
         if(_loc8_ != _loc8_)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::Frequency cannot be NaN";
         }
         if(_loc8_ <= 0)
         {
            Boot.lastError = new Error();
            throw "Error: Constraint::Frequency must be >0";
         }
         if(param1.zpp_inner.frequency != _loc8_)
         {
            param1.zpp_inner.frequency = _loc8_;
            if(!param1.zpp_inner.stiff)
            {
               param1.zpp_inner.wake();
            }
         }
         param1.zpp_inner.frequency;
         _loc7_ = _loc2_.zpp_inner.stiff;
         if(param1.zpp_inner.stiff != _loc7_)
         {
            param1.zpp_inner.stiff = _loc7_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.stiff;
         _loc7_ = _loc2_.zpp_inner.ignore;
         if(param1.zpp_inner.ignore != _loc7_)
         {
            param1.zpp_inner.ignore = _loc7_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.ignore;
         _loc7_ = _loc2_.zpp_inner.active;
         if(param1.zpp_inner.active != _loc7_)
         {
            if(param1.zpp_inner.component != null)
            {
               param1.zpp_inner.component.woken = false;
            }
            param1.zpp_inner.clearcache();
            if(_loc7_)
            {
               param1.zpp_inner.active = _loc7_;
               param1.zpp_inner.activate();
               if(param1.zpp_inner.space != null)
               {
                  if(param1.zpp_inner.component != null)
                  {
                     param1.zpp_inner.component.sleeping = true;
                  }
                  param1.zpp_inner.space.wake_constraint(param1.zpp_inner,true);
               }
            }
            else
            {
               if(param1.zpp_inner.space != null)
               {
                  param1.zpp_inner.wake();
                  param1.zpp_inner.space.live_constraints.remove(param1.zpp_inner);
               }
               param1.zpp_inner.active = _loc7_;
               param1.zpp_inner.deactivate();
            }
         }
         param1.zpp_inner.active;
      }
      
      public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
      {
         return null;
      }
      
      public function clearcache() : void
      {
      }
      
      public function clear() : void
      {
      }
      
      public function broken() : void
      {
      }
      
      public function applyImpulseVel() : Boolean
      {
         return false;
      }
      
      public function applyImpulsePos() : Boolean
      {
         return false;
      }
      
      public function alloc_cbSet() : void
      {
         if((cbSet = space.cbsets.get(cbTypes)) != null)
         {
            cbSet.count = cbSet.count + 1;
            cbSet.constraints.add(this);
         }
      }
      
      public function addedToSpace() : void
      {
         var _loc2_:* = null as ZPP_CbType;
         if(active)
         {
            activeInSpace();
         }
         activeBodies();
         var _loc1_:ZNPNode_ZPP_CbType = cbTypes.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.constraints.add(this);
            _loc1_ = _loc1_.next;
         }
      }
      
      public function activeInSpace() : void
      {
         alloc_cbSet();
         if(ZPP_Component.zpp_pool == null)
         {
            component = new ZPP_Component();
         }
         else
         {
            component = ZPP_Component.zpp_pool;
            ZPP_Component.zpp_pool = component.next;
            component.next = null;
         }
         component.isBody = false;
         component.constraint = this;
      }
      
      public function activeBodies() : void
      {
      }
      
      public function activate() : void
      {
         if(space != null)
         {
            activeInSpace();
         }
      }
   }
}
