package zpp_nape.space
{
   import flash.Boot;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.util.ZNPList_ZPP_Arbiter;
   import zpp_nape.util.ZNPNode_ZPP_Arbiter;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_CallbackSet
   {
      
      public static var zpp_pool:ZPP_CallbackSet = null;
       
      
      public var pushmod:Boolean;
      
      public var next:ZPP_CallbackSet;
      
      public var modified:Boolean;
      
      public var length:int;
      
      public var lazydel:Boolean;
      
      public var int2:ZPP_Interactor;
      
      public var int1:ZPP_Interactor;
      
      public var id:int;
      
      public var freed:Boolean;
      
      public var di:int;
      
      public var arbiters:ZNPList_ZPP_Arbiter;
      
      public var _inuse:Boolean;
      
      public var SENSORstate:int;
      
      public var SENSORstamp:int;
      
      public var FLUIDstate:int;
      
      public var FLUIDstamp:int;
      
      public var COLLISIONstate:int;
      
      public var COLLISIONstamp:int;
      
      public function ZPP_CallbackSet()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         lazydel = false;
         freed = false;
         length = 0;
         pushmod = false;
         modified = false;
         _inuse = false;
         next = null;
         int2 = null;
         int1 = null;
         di = 0;
         id = 0;
         arbiters = new ZNPList_ZPP_Arbiter();
      }
      
      public static function get(param1:ZPP_Interactor, param2:ZPP_Interactor) : ZPP_CallbackSet
      {
         var _loc3_:* = null as ZPP_CallbackSet;
         if(ZPP_CallbackSet.zpp_pool == null)
         {
            _loc3_ = new ZPP_CallbackSet();
         }
         else
         {
            _loc3_ = ZPP_CallbackSet.zpp_pool;
            ZPP_CallbackSet.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.freed = false;
         _loc3_.lazydel = false;
         _loc3_.COLLISIONstate = ZPP_Flags.id_PreFlag_ACCEPT;
         _loc3_.COLLISIONstamp = 0;
         _loc3_.SENSORstate = ZPP_Flags.id_PreFlag_ACCEPT;
         _loc3_.SENSORstamp = 0;
         _loc3_.FLUIDstate = ZPP_Flags.id_PreFlag_ACCEPT;
         _loc3_.FLUIDstamp = 0;
         if(param1.id < param2.id)
         {
            _loc3_.int1 = param1;
            _loc3_.int2 = param2;
         }
         else
         {
            _loc3_.int1 = param2;
            _loc3_.int2 = param1;
         }
         _loc3_.id = _loc3_.int1.id;
         _loc3_.di = _loc3_.int2.id;
         return _loc3_;
      }
      
      public function try_remove_arb(param1:ZPP_Arbiter) : Boolean
      {
         var _loc6_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc7_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc8_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc2_:ZNPList_ZPP_Arbiter = arbiters;
         var _loc3_:ZNPNode_ZPP_Arbiter = null;
         var _loc4_:ZNPNode_ZPP_Arbiter = _loc2_.head;
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
               _loc8_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
               ZNPNode_ZPP_Arbiter.zpp_pool = _loc8_;
               _loc2_.modified = true;
               _loc2_.length = _loc2_.length - 1;
               _loc2_.pushmod = true;
               _loc7_;
               _loc5_ = true;
               break;
            }
            _loc3_ = _loc4_;
            _loc4_ = _loc4_.next;
         }
         return _loc5_;
      }
      
      public function try_remove(param1:ZPP_CallbackSet) : Boolean
      {
         var _loc2_:ZPP_CallbackSet = null;
         var _loc3_:ZPP_CallbackSet = next;
         var _loc4_:Boolean = false;
         while(_loc3_ != null)
         {
            if(_loc3_ == param1)
            {
               erase(_loc2_);
               _loc4_ = true;
               break;
            }
            _loc2_ = _loc3_;
            _loc3_ = _loc3_.next;
         }
         return _loc4_;
      }
      
      public function splice(param1:ZPP_CallbackSet, param2:int) : ZPP_CallbackSet
      {
         while(param2-- > 0 && param1.next != null)
         {
            erase(param1);
         }
         return param1.next;
      }
      
      public function size() : int
      {
         return length;
      }
      
      public function reverse() : void
      {
         var _loc3_:* = null as ZPP_CallbackSet;
         var _loc1_:ZPP_CallbackSet = next;
         var _loc2_:ZPP_CallbackSet = null;
         while(_loc1_ != null)
         {
            _loc3_ = _loc1_.next;
            _loc1_.next = _loc2_;
            next = _loc1_;
            _loc2_ = _loc1_;
            _loc1_ = _loc3_;
         }
         modified = true;
         pushmod = true;
      }
      
      public function remove_arb(param1:ZPP_Arbiter) : void
      {
         var _loc6_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc7_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc8_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc2_:ZNPList_ZPP_Arbiter = arbiters;
         var _loc3_:ZNPNode_ZPP_Arbiter = null;
         var _loc4_:ZNPNode_ZPP_Arbiter = _loc2_.head;
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
               _loc8_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
               ZNPNode_ZPP_Arbiter.zpp_pool = _loc8_;
               _loc2_.modified = true;
               _loc2_.length = _loc2_.length - 1;
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
      
      public function remove(param1:ZPP_CallbackSet) : void
      {
         var _loc5_:* = null as ZPP_CallbackSet;
         var _loc6_:* = null as ZPP_CallbackSet;
         var _loc2_:ZPP_CallbackSet = null;
         var _loc3_:ZPP_CallbackSet = next;
         var _loc4_:Boolean = false;
         while(_loc3_ != null)
         {
            if(_loc3_ == param1)
            {
               if(_loc2_ == null)
               {
                  _loc5_ = next;
                  _loc6_ = _loc5_.next;
                  next = _loc6_;
                  if(next == null)
                  {
                     pushmod = true;
                  }
               }
               else
               {
                  _loc5_ = _loc2_.next;
                  _loc6_ = _loc5_.next;
                  _loc2_.next = _loc6_;
                  if(_loc6_ == null)
                  {
                     pushmod = true;
                  }
               }
               _loc5_._inuse = false;
               modified = true;
               length = length - 1;
               pushmod = true;
               _loc6_;
               _loc4_ = true;
               break;
            }
            _loc2_ = _loc3_;
            _loc3_ = _loc3_.next;
         }
         _loc4_;
      }
      
      public function pop_unsafe() : ZPP_CallbackSet
      {
         var _loc1_:ZPP_CallbackSet = next;
         pop();
         return _loc1_;
      }
      
      public function pop() : void
      {
         var _loc1_:ZPP_CallbackSet = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function iterator_at(param1:int) : ZPP_CallbackSet
      {
         var _loc2_:ZPP_CallbackSet = next;
         while(param1-- > 0 && _loc2_ != null)
         {
            _loc2_ = _loc2_.next;
         }
         return _loc2_;
      }
      
      public function insert(param1:ZPP_CallbackSet, param2:ZPP_CallbackSet) : ZPP_CallbackSet
      {
         param2._inuse = true;
         var _loc3_:ZPP_CallbackSet = param2;
         if(param1 == null)
         {
            _loc3_.next = next;
            next = _loc3_;
         }
         else
         {
            _loc3_.next = param1.next;
            param1.next = _loc3_;
         }
         modified = true;
         pushmod = true;
         length = length + 1;
         return _loc3_;
      }
      
      public function inlined_pop_unsafe() : ZPP_CallbackSet
      {
         var _loc1_:ZPP_CallbackSet = next;
         pop();
         return _loc1_;
      }
      
      public function inlined_pop() : void
      {
         var _loc1_:ZPP_CallbackSet = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function inlined_insert(param1:ZPP_CallbackSet, param2:ZPP_CallbackSet) : ZPP_CallbackSet
      {
         param2._inuse = true;
         var _loc3_:ZPP_CallbackSet = param2;
         if(param1 == null)
         {
            _loc3_.next = next;
            next = _loc3_;
         }
         else
         {
            _loc3_.next = param1.next;
            param1.next = _loc3_;
         }
         modified = true;
         pushmod = true;
         length = length + 1;
         return _loc3_;
      }
      
      public function inlined_has(param1:ZPP_CallbackSet) : Boolean
      {
         var _loc4_:* = null as ZPP_CallbackSet;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_CallbackSet = next;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            if(_loc4_ == param1)
            {
               _loc2_ = true;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         return _loc2_;
      }
      
      public function inlined_erase(param1:ZPP_CallbackSet) : ZPP_CallbackSet
      {
         var _loc2_:* = null as ZPP_CallbackSet;
         var _loc3_:* = null as ZPP_CallbackSet;
         if(param1 == null)
         {
            _loc2_ = next;
            _loc3_ = _loc2_.next;
            next = _loc3_;
            if(next == null)
            {
               pushmod = true;
            }
         }
         else
         {
            _loc2_ = param1.next;
            _loc3_ = _loc2_.next;
            param1.next = _loc3_;
            if(_loc3_ == null)
            {
               pushmod = true;
            }
         }
         _loc2_._inuse = false;
         modified = true;
         length = length - 1;
         pushmod = true;
         return _loc3_;
      }
      
      public function inlined_clear() : void
      {
      }
      
      public function inlined_add(param1:ZPP_CallbackSet) : ZPP_CallbackSet
      {
         param1._inuse = true;
         var _loc2_:ZPP_CallbackSet = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
      
      public function has(param1:ZPP_CallbackSet) : Boolean
      {
         var _loc4_:* = null as ZPP_CallbackSet;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_CallbackSet = next;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            if(_loc4_ == param1)
            {
               _loc2_ = true;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         return _loc2_;
      }
      
      public function erase(param1:ZPP_CallbackSet) : ZPP_CallbackSet
      {
         var _loc2_:* = null as ZPP_CallbackSet;
         var _loc3_:* = null as ZPP_CallbackSet;
         if(param1 == null)
         {
            _loc2_ = next;
            _loc3_ = _loc2_.next;
            next = _loc3_;
            if(next == null)
            {
               pushmod = true;
            }
         }
         else
         {
            _loc2_ = param1.next;
            _loc3_ = _loc2_.next;
            param1.next = _loc3_;
            if(_loc3_ == null)
            {
               pushmod = true;
            }
         }
         _loc2_._inuse = false;
         modified = true;
         length = length - 1;
         pushmod = true;
         return _loc3_;
      }
      
      public function empty_arb(param1:int) : Boolean
      {
         var _loc4_:* = null as ZPP_Arbiter;
         var _loc2_:Boolean = true;
         var _loc3_:ZNPNode_ZPP_Arbiter = arbiters.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            if((_loc4_.type & param1) != 0)
            {
               _loc2_ = false;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
      }
      
      public function begin() : ZPP_CallbackSet
      {
         return next;
      }
      
      public function back() : ZPP_CallbackSet
      {
         var _loc1_:ZPP_CallbackSet = next;
         var _loc2_:ZPP_CallbackSet = _loc1_;
         while(_loc2_ != null)
         {
            _loc1_ = _loc2_;
            _loc2_ = _loc2_.next;
         }
         return _loc1_;
      }
      
      public function at(param1:int) : ZPP_CallbackSet
      {
         var _loc2_:ZPP_CallbackSet = iterator_at(param1);
         return _loc2_ != null ? _loc2_ : null;
      }
      
      public function add_arb(param1:ZPP_Arbiter) : Boolean
      {
         var _loc3_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc4_:* = null as ZPP_Arbiter;
         var _loc5_:* = null as ZNPList_ZPP_Arbiter;
         var _loc6_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc2_:Boolean = false;
         _loc3_ = arbiters.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            if(_loc4_ == param1)
            {
               _loc2_ = true;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         if(!_loc2_)
         {
            _loc5_ = arbiters;
            if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
            {
               _loc6_ = new ZNPNode_ZPP_Arbiter();
            }
            else
            {
               _loc6_ = ZNPNode_ZPP_Arbiter.zpp_pool;
               ZNPNode_ZPP_Arbiter.zpp_pool = _loc6_.next;
               _loc6_.next = null;
            }
            _loc6_.elt = param1;
            _loc3_ = _loc6_;
            _loc3_.next = _loc5_.head;
            _loc5_.head = _loc3_;
            _loc5_.modified = true;
            _loc5_.length = _loc5_.length + 1;
            param1;
            return true;
         }
         return false;
      }
      
      public function addAll(param1:ZPP_CallbackSet) : void
      {
         var _loc3_:* = null as ZPP_CallbackSet;
         var _loc2_:ZPP_CallbackSet = param1.next;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            add(_loc3_);
            _loc2_ = _loc2_.next;
         }
      }
      
      public function add(param1:ZPP_CallbackSet) : ZPP_CallbackSet
      {
         param1._inuse = true;
         var _loc2_:ZPP_CallbackSet = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
   }
}
