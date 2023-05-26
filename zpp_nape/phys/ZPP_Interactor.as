package zpp_nape.phys
{
   import flash.Boot;
   import nape.callbacks.CbType;
   import nape.callbacks.CbTypeIterator;
   import nape.callbacks.CbTypeList;
   import nape.phys.Interactor;
   import zpp_nape.ZPP_ID;
   import zpp_nape.callbacks.ZPP_Callback;
   import zpp_nape.callbacks.ZPP_CbSet;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.callbacks.ZPP_InteractionListener;
   import zpp_nape.callbacks.ZPP_OptionType;
   import zpp_nape.dynamics.ZPP_InteractionGroup;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_CallbackSet;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_CallbackSet;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPNode_ZPP_CallbackSet;
   import zpp_nape.util.ZNPNode_ZPP_CbType;
   import zpp_nape.util.ZPP_CbTypeList;
   
   public class ZPP_Interactor
   {
       
      
      public var wrap_cbTypes:CbTypeList;
      
      public var userData;
      
      public var outer_i:Interactor;
      
      public var ishape:ZPP_Shape;
      
      public var id:int;
      
      public var icompound:ZPP_Compound;
      
      public var ibody:ZPP_Body;
      
      public var group:ZPP_InteractionGroup;
      
      public var cbsets:ZNPList_ZPP_CallbackSet;
      
      public var cbTypes:ZNPList_ZPP_CbType;
      
      public var cbSet:ZPP_CbSet;
      
      public function ZPP_Interactor()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         wrap_cbTypes = null;
         cbSet = null;
         cbTypes = null;
         group = null;
         cbsets = null;
         icompound = null;
         ibody = null;
         ishape = null;
         userData = null;
         id = 0;
         outer_i = null;
         id = ZPP_ID.Interactor();
         cbsets = new ZNPList_ZPP_CallbackSet();
         cbTypes = new ZNPList_ZPP_CbType();
      }
      
      public static function get(param1:ZPP_Interactor, param2:ZPP_Interactor) : ZPP_CallbackSet
      {
         var _loc8_:* = null as ZPP_CallbackSet;
         var _loc3_:int = param1.id < param2.id ? param1.id : param2.id;
         var _loc4_:int = param1.id < param2.id ? param2.id : param1.id;
         var _loc5_:ZNPList_ZPP_CallbackSet = param1.cbsets.length < param2.cbsets.length ? param1.cbsets : param2.cbsets;
         var _loc6_:ZPP_CallbackSet = null;
         var _loc7_:ZNPNode_ZPP_CallbackSet = _loc5_.head;
         while(_loc7_ != null)
         {
            _loc8_ = _loc7_.elt;
            if(_loc8_.id == _loc3_ && _loc8_.di == _loc4_)
            {
               _loc6_ = _loc8_;
               break;
            }
            _loc7_ = _loc7_.next;
         }
         return _loc6_;
      }
      
      public static function int_callback(param1:ZPP_CallbackSet, param2:ZPP_InteractionListener, param3:ZPP_Callback) : void
      {
         var _loc6_:* = null as ZPP_OptionType;
         var _loc7_:* = null as ZNPList_ZPP_CbType;
         var _loc4_:ZPP_Interactor = param1.int1;
         var _loc5_:ZPP_Interactor = param1.int2;
         _loc6_ = param2.options1;
         _loc7_ = _loc4_.cbTypes;
         if(_loc6_.nonemptyintersection(_loc7_,_loc6_.includes) && !_loc6_.nonemptyintersection(_loc7_,_loc6_.excludes) && (_loc6_.nonemptyintersection(_loc7_,_loc6_.includes) && !_loc6_.nonemptyintersection(_loc7_,_loc6_.excludes)))
         {
            param3.int1 = _loc4_;
            param3.int2 = _loc5_;
         }
         else
         {
            param3.int1 = _loc5_;
            param3.int2 = _loc4_;
         }
      }
      
      public function wrap_cbTypes_subber(param1:CbType) : void
      {
         var _loc3_:* = null as ZPP_Space;
         var _loc2_:ZPP_CbType = param1.zpp_inner;
         if(cbTypes.has(_loc2_))
         {
            _loc3_ = ishape != null ? (ishape.body == null ? null : ishape.body.space) : (ibody != null ? ibody.space : icompound.space);
            if(_loc3_ != null)
            {
               dealloc_cbSet();
               _loc2_.interactors.remove(this);
            }
            cbTypes.remove(_loc2_);
            if(_loc3_ != null)
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
      
      public function wake() : void
      {
         var _loc1_:* = null as ZPP_Body;
         if(ishape != null)
         {
            _loc1_ = ishape.body;
            if(_loc1_ != null && _loc1_.space != null)
            {
               _loc1_.space.non_inlined_wake(_loc1_);
            }
         }
         else if(ibody != null)
         {
            if(ibody.space != null)
            {
               ibody.space.non_inlined_wake(ibody);
            }
         }
         else if(icompound.space != null)
         {
            icompound.space.wakeCompound(icompound);
         }
      }
      
      public function setupcbTypes() : void
      {
         wrap_cbTypes = ZPP_CbTypeList.get(cbTypes);
         wrap_cbTypes.zpp_inner.adder = wrap_cbTypes_adder;
         wrap_cbTypes.zpp_inner.subber = wrap_cbTypes_subber;
         wrap_cbTypes.zpp_inner.dontremove = true;
         wrap_cbTypes.zpp_inner._modifiable = immutable_cbTypes;
      }
      
      public function setGroup(param1:ZPP_InteractionGroup) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(group != param1)
         {
            _loc2_ = (ishape != null ? (ishape.body == null ? null : ishape.body.space) : (ibody != null ? ibody.space : icompound.space)) != null;
            if(_loc2_ && group != null)
            {
               _loc3_ = -1;
               group.interactors.remove(this);
            }
            group = param1;
            if(_loc2_ && param1 != null)
            {
               param1.interactors.add(this);
            }
            if(_loc2_)
            {
               if(ishape != null)
               {
                  ishape.body.wake();
               }
               else if(ibody != null)
               {
                  ibody.wake();
               }
               else
               {
                  icompound.wake();
               }
            }
         }
      }
      
      public function isCompound() : Boolean
      {
         return icompound != null;
      }
      
      public function isBody() : Boolean
      {
         return ibody != null;
      }
      
      public function insert_cbtype(param1:ZPP_CbType) : void
      {
         var _loc2_:* = null as ZPP_Space;
         var _loc3_:* = null as ZNPNode_ZPP_CbType;
         var _loc4_:* = null as ZNPNode_ZPP_CbType;
         var _loc5_:* = null as ZPP_CbType;
         var _loc6_:* = null as ZNPList_ZPP_CbType;
         var _loc7_:* = null as ZNPNode_ZPP_CbType;
         var _loc8_:Boolean = false;
         if(!cbTypes.has(param1))
         {
            _loc2_ = ishape != null ? (ishape.body == null ? null : ishape.body.space) : (ibody != null ? ibody.space : icompound.space);
            if(_loc2_ != null)
            {
               dealloc_cbSet();
               param1.interactors.add(this);
            }
            _loc3_ = null;
            _loc4_ = cbTypes.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               if(param1.id < _loc5_.id)
               {
                  break;
               }
               _loc3_ = _loc4_;
               _loc4_ = _loc4_.next;
            }
            _loc6_ = cbTypes;
            if(ZNPNode_ZPP_CbType.zpp_pool == null)
            {
               _loc7_ = new ZNPNode_ZPP_CbType();
            }
            else
            {
               _loc7_ = ZNPNode_ZPP_CbType.zpp_pool;
               ZNPNode_ZPP_CbType.zpp_pool = _loc7_.next;
               _loc7_.next = null;
            }
            _loc7_.elt = param1;
            _loc4_ = _loc7_;
            if(_loc3_ == null)
            {
               _loc4_.next = _loc6_.head;
               _loc6_.head = _loc4_;
            }
            else
            {
               _loc4_.next = _loc3_.next;
               _loc3_.next = _loc4_;
            }
            _loc6_.pushmod = _loc6_.modified = true;
            _loc6_.length = _loc6_.length + 1;
            _loc4_;
            if(_loc2_ != null)
            {
               alloc_cbSet();
               wake();
            }
         }
      }
      
      public function immutable_midstep(param1:String) : void
      {
         var _loc2_:* = null as ZPP_Body;
         if(ibody != null)
         {
            _loc2_ = ibody;
            if(_loc2_.space != null && _loc2_.space.midstep)
            {
               Boot.lastError = new Error();
               throw "Error: " + param1 + " cannot be set during a space step()";
            }
         }
         else if(ishape != null)
         {
            ishape.__immutable_midstep(param1);
         }
         else
         {
            icompound.__imutable_midstep(param1);
         }
      }
      
      public function immutable_cbTypes() : void
      {
         immutable_midstep("Interactor::cbTypes");
      }
      
      public function dealloc_cbSet() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null as ZPP_CbSet;
         var _loc4_:* = null as ZPP_CbType;
         var _loc1_:ZPP_Space = ishape != null ? (ishape.body == null ? null : ishape.body.space) : (ibody != null ? ibody.space : icompound.space);
         if(cbSet != null)
         {
            cbSet.interactors.remove(this);
            _loc1_.nullInteractorType(this);
            if((cbSet.count = cbSet.count - 1) == 0)
            {
               _loc1_.cbsets.remove(cbSet);
               _loc3_ = cbSet;
               _loc3_.listeners.clear();
               _loc3_.zip_listeners = true;
               _loc3_.bodylisteners.clear();
               _loc3_.zip_bodylisteners = true;
               _loc3_.conlisteners.clear();
               _loc3_.zip_conlisteners = true;
               while(_loc3_.cbTypes.head != null)
               {
                  _loc4_ = _loc3_.cbTypes.pop_unsafe();
                  _loc4_.cbsets.remove(_loc3_);
               }
               _loc3_.next = ZPP_CbSet.zpp_pool;
               ZPP_CbSet.zpp_pool = _loc3_;
            }
            cbSet = null;
         }
      }
      
      public function copyto(param1:Interactor) : void
      {
         var _loc3_:* = null as CbTypeList;
         var _loc5_:* = null as CbType;
         var _loc6_:int = 0;
         param1.zpp_inner_i.group = group;
         var _loc4_:Interactor = outer_i;
         if(_loc4_.zpp_inner_i.wrap_cbTypes == null)
         {
            _loc4_.zpp_inner_i.setupcbTypes();
         }
         _loc3_ = _loc4_.zpp_inner_i.wrap_cbTypes;
         _loc3_.zpp_inner.valmod();
         var _loc2_:CbTypeIterator = CbTypeIterator.get(_loc3_);
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
            _loc6_ = _loc3_.zpp_inner.user_length;
            _loc2_.zpp_critical = true;
            if(!(_loc2_.zpp_i < _loc6_ ? true : (_loc2_.zpp_next = CbTypeIterator.zpp_pool, CbTypeIterator.zpp_pool = _loc2_, _loc2_.zpp_inner = null, false)))
            {
               break;
            }
            _loc2_.zpp_critical = false;
            _loc2_.zpp_i = (_loc6_ = _loc2_.zpp_i) + 1;
            _loc5_ = _loc2_.zpp_inner.at(_loc6_);
            if(param1.zpp_inner_i.wrap_cbTypes == null)
            {
               param1.zpp_inner_i.setupcbTypes();
            }
            _loc3_ = param1.zpp_inner_i.wrap_cbTypes;
            if(_loc3_.zpp_inner.reverse_flag)
            {
               _loc3_.push(_loc5_);
            }
            else
            {
               _loc3_.unshift(_loc5_);
            }
         }
         if(userData != null)
         {
            param1.zpp_inner_i.userData = Reflect.copy(userData);
         }
      }
      
      public function alloc_cbSet() : void
      {
         var _loc1_:ZPP_Space = ishape != null ? (ishape.body == null ? null : ishape.body.space) : (ibody != null ? ibody.space : icompound.space);
         if((cbSet = _loc1_.cbsets.get(cbTypes)) != null)
         {
            cbSet.count = cbSet.count + 1;
            cbSet.interactors.add(this);
            cbSet.validate();
            _loc1_.freshInteractorType(this);
         }
      }
      
      public function __iremovedFromSpace() : void
      {
         var _loc1_:int = 0;
         var _loc3_:* = null as ZPP_CbType;
         if(group != null)
         {
            _loc1_ = -1;
            group.interactors.remove(this);
         }
         var _loc2_:ZNPNode_ZPP_CbType = cbTypes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc3_.interactors.remove(this);
            _loc2_ = _loc2_.next;
         }
         dealloc_cbSet();
      }
      
      public function __iaddedToSpace() : void
      {
         var _loc2_:* = null as ZPP_CbType;
         if(group != null)
         {
            group.interactors.add(this);
         }
         var _loc1_:ZNPNode_ZPP_CbType = cbTypes.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.interactors.add(this);
            _loc1_ = _loc1_.next;
         }
         alloc_cbSet();
      }
   }
}
