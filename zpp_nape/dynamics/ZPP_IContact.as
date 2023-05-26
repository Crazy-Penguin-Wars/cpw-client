package zpp_nape.dynamics
{
   import flash.Boot;
   
   public class ZPP_IContact
   {
       
      
      public var tMass:Number;
      
      public var r2y:Number;
      
      public var r2x:Number;
      
      public var r1y:Number;
      
      public var r1x:Number;
      
      public var pushmod:Boolean;
      
      public var next:ZPP_IContact;
      
      public var nMass:Number;
      
      public var modified:Boolean;
      
      public var lr2y:Number;
      
      public var lr2x:Number;
      
      public var lr1y:Number;
      
      public var lr1x:Number;
      
      public var length:int;
      
      public var jtAcc:Number;
      
      public var jnAcc:Number;
      
      public var friction:Number;
      
      public var bounce:Number;
      
      public var _inuse:Boolean;
      
      public function ZPP_IContact()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         length = 0;
         pushmod = false;
         modified = false;
         _inuse = false;
         next = null;
         lr2y = 0;
         lr2x = 0;
         lr1y = 0;
         lr1x = 0;
         jtAcc = 0;
         jnAcc = 0;
         friction = 0;
         bounce = 0;
         tMass = 0;
         nMass = 0;
         r2y = 0;
         r2x = 0;
         r1y = 0;
         r1x = 0;
      }
      
      public function try_remove(param1:ZPP_IContact) : Boolean
      {
         var _loc2_:ZPP_IContact = null;
         var _loc3_:ZPP_IContact = next;
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
      
      public function splice(param1:ZPP_IContact, param2:int) : ZPP_IContact
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
         var _loc3_:* = null as ZPP_IContact;
         var _loc1_:ZPP_IContact = next;
         var _loc2_:ZPP_IContact = null;
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
      
      public function remove(param1:ZPP_IContact) : void
      {
         var _loc5_:* = null as ZPP_IContact;
         var _loc6_:* = null as ZPP_IContact;
         var _loc2_:ZPP_IContact = null;
         var _loc3_:ZPP_IContact = next;
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
      
      public function pop_unsafe() : ZPP_IContact
      {
         var _loc1_:ZPP_IContact = next;
         pop();
         return _loc1_;
      }
      
      public function pop() : void
      {
         var _loc1_:ZPP_IContact = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function iterator_at(param1:int) : ZPP_IContact
      {
         var _loc2_:ZPP_IContact = next;
         while(param1-- > 0 && _loc2_ != null)
         {
            _loc2_ = _loc2_.next;
         }
         return _loc2_;
      }
      
      public function insert(param1:ZPP_IContact, param2:ZPP_IContact) : ZPP_IContact
      {
         param2._inuse = true;
         var _loc3_:ZPP_IContact = param2;
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
      
      public function inlined_pop_unsafe() : ZPP_IContact
      {
         var _loc1_:ZPP_IContact = next;
         pop();
         return _loc1_;
      }
      
      public function inlined_pop() : void
      {
         var _loc1_:ZPP_IContact = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function inlined_insert(param1:ZPP_IContact, param2:ZPP_IContact) : ZPP_IContact
      {
         param2._inuse = true;
         var _loc3_:ZPP_IContact = param2;
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
      
      public function inlined_has(param1:ZPP_IContact) : Boolean
      {
         var _loc4_:* = null as ZPP_IContact;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_IContact = next;
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
      
      public function inlined_erase(param1:ZPP_IContact) : ZPP_IContact
      {
         var _loc2_:* = null as ZPP_IContact;
         var _loc3_:* = null as ZPP_IContact;
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
      
      public function inlined_add(param1:ZPP_IContact) : ZPP_IContact
      {
         param1._inuse = true;
         var _loc2_:ZPP_IContact = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
      
      public function has(param1:ZPP_IContact) : Boolean
      {
         var _loc4_:* = null as ZPP_IContact;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_IContact = next;
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
      
      public function erase(param1:ZPP_IContact) : ZPP_IContact
      {
         var _loc2_:* = null as ZPP_IContact;
         var _loc3_:* = null as ZPP_IContact;
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
      
      public function begin() : ZPP_IContact
      {
         return next;
      }
      
      public function back() : ZPP_IContact
      {
         var _loc1_:ZPP_IContact = next;
         var _loc2_:ZPP_IContact = _loc1_;
         while(_loc2_ != null)
         {
            _loc1_ = _loc2_;
            _loc2_ = _loc2_.next;
         }
         return _loc1_;
      }
      
      public function at(param1:int) : ZPP_IContact
      {
         var _loc2_:ZPP_IContact = iterator_at(param1);
         return _loc2_ != null ? _loc2_ : null;
      }
      
      public function addAll(param1:ZPP_IContact) : void
      {
         var _loc3_:* = null as ZPP_IContact;
         var _loc2_:ZPP_IContact = param1.next;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            add(_loc3_);
            _loc2_ = _loc2_.next;
         }
      }
      
      public function add(param1:ZPP_IContact) : ZPP_IContact
      {
         param1._inuse = true;
         var _loc2_:ZPP_IContact = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
   }
}
