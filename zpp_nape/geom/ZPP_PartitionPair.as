package zpp_nape.geom
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Set_ZPP_PartitionPair;
   
   public class ZPP_PartitionPair
   {
      
      public static var zpp_pool:ZPP_PartitionPair = null;
       
      
      public var pushmod:Boolean;
      
      public var node:ZPP_Set_ZPP_PartitionPair;
      
      public var next:ZPP_PartitionPair;
      
      public var modified:Boolean;
      
      public var length:int;
      
      public var id:int;
      
      public var di:int;
      
      public var b:ZPP_PartitionVertex;
      
      public var a:ZPP_PartitionVertex;
      
      public var _inuse:Boolean;
      
      public function ZPP_PartitionPair()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         node = null;
         di = 0;
         id = 0;
         b = null;
         a = null;
         length = 0;
         pushmod = false;
         modified = false;
         _inuse = false;
         next = null;
      }
      
      public static function get(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : ZPP_PartitionPair
      {
         var _loc3_:* = null as ZPP_PartitionPair;
         if(ZPP_PartitionPair.zpp_pool == null)
         {
            _loc3_ = new ZPP_PartitionPair();
         }
         else
         {
            _loc3_ = ZPP_PartitionPair.zpp_pool;
            ZPP_PartitionPair.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.a = param1;
         _loc3_.b = param2;
         if(param1.id < param2.id)
         {
            _loc3_.id = param1.id;
            _loc3_.di = param2.id;
         }
         else
         {
            _loc3_.id = param2.id;
            _loc3_.di = param1.id;
         }
         return _loc3_;
      }
      
      public static function edge_swap(param1:ZPP_PartitionPair, param2:ZPP_PartitionPair) : void
      {
         var _loc3_:ZPP_Set_ZPP_PartitionPair = param1.node;
         param1.node = param2.node;
         param2.node = _loc3_;
      }
      
      public static function edge_lt(param1:ZPP_PartitionPair, param2:ZPP_PartitionPair) : Boolean
      {
         return param1.id < param2.id || param1.id == param2.id && param1.di < param2.di;
      }
      
      public function try_remove(param1:ZPP_PartitionPair) : Boolean
      {
         var _loc2_:ZPP_PartitionPair = null;
         var _loc3_:ZPP_PartitionPair = next;
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
      
      public function splice(param1:ZPP_PartitionPair, param2:int) : ZPP_PartitionPair
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
         var _loc3_:* = null as ZPP_PartitionPair;
         var _loc1_:ZPP_PartitionPair = next;
         var _loc2_:ZPP_PartitionPair = null;
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
      
      public function remove(param1:ZPP_PartitionPair) : void
      {
         var _loc5_:* = null as ZPP_PartitionPair;
         var _loc6_:* = null as ZPP_PartitionPair;
         var _loc2_:ZPP_PartitionPair = null;
         var _loc3_:ZPP_PartitionPair = next;
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
      
      public function pop_unsafe() : ZPP_PartitionPair
      {
         var _loc1_:ZPP_PartitionPair = next;
         pop();
         return _loc1_;
      }
      
      public function pop() : void
      {
         var _loc1_:ZPP_PartitionPair = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function iterator_at(param1:int) : ZPP_PartitionPair
      {
         var _loc2_:ZPP_PartitionPair = next;
         while(param1-- > 0 && _loc2_ != null)
         {
            _loc2_ = _loc2_.next;
         }
         return _loc2_;
      }
      
      public function insert(param1:ZPP_PartitionPair, param2:ZPP_PartitionPair) : ZPP_PartitionPair
      {
         param2._inuse = true;
         var _loc3_:ZPP_PartitionPair = param2;
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
      
      public function inlined_pop_unsafe() : ZPP_PartitionPair
      {
         var _loc1_:ZPP_PartitionPair = next;
         pop();
         return _loc1_;
      }
      
      public function inlined_pop() : void
      {
         var _loc1_:ZPP_PartitionPair = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function inlined_insert(param1:ZPP_PartitionPair, param2:ZPP_PartitionPair) : ZPP_PartitionPair
      {
         param2._inuse = true;
         var _loc3_:ZPP_PartitionPair = param2;
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
      
      public function inlined_has(param1:ZPP_PartitionPair) : Boolean
      {
         var _loc4_:* = null as ZPP_PartitionPair;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_PartitionPair = next;
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
      
      public function inlined_erase(param1:ZPP_PartitionPair) : ZPP_PartitionPair
      {
         var _loc2_:* = null as ZPP_PartitionPair;
         var _loc3_:* = null as ZPP_PartitionPair;
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
      
      public function inlined_add(param1:ZPP_PartitionPair) : ZPP_PartitionPair
      {
         param1._inuse = true;
         var _loc2_:ZPP_PartitionPair = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
      
      public function has(param1:ZPP_PartitionPair) : Boolean
      {
         var _loc4_:* = null as ZPP_PartitionPair;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_PartitionPair = next;
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
      
      public function erase(param1:ZPP_PartitionPair) : ZPP_PartitionPair
      {
         var _loc2_:* = null as ZPP_PartitionPair;
         var _loc3_:* = null as ZPP_PartitionPair;
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
      
      public function clear() : void
      {
      }
      
      public function begin() : ZPP_PartitionPair
      {
         return next;
      }
      
      public function back() : ZPP_PartitionPair
      {
         var _loc1_:ZPP_PartitionPair = next;
         var _loc2_:ZPP_PartitionPair = _loc1_;
         while(_loc2_ != null)
         {
            _loc1_ = _loc2_;
            _loc2_ = _loc2_.next;
         }
         return _loc1_;
      }
      
      public function at(param1:int) : ZPP_PartitionPair
      {
         var _loc2_:ZPP_PartitionPair = iterator_at(param1);
         return _loc2_ != null ? _loc2_ : null;
      }
      
      public function addAll(param1:ZPP_PartitionPair) : void
      {
         var _loc3_:* = null as ZPP_PartitionPair;
         var _loc2_:ZPP_PartitionPair = param1.next;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            add(_loc3_);
            _loc2_ = _loc2_.next;
         }
      }
      
      public function add(param1:ZPP_PartitionPair) : ZPP_PartitionPair
      {
         param1._inuse = true;
         var _loc2_:ZPP_PartitionPair = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
   }
}
