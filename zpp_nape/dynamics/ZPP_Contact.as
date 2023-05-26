package zpp_nape.dynamics
{
   import flash.Boot;
   import nape.dynamics.Contact;
   import nape.geom.Vec2;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public class ZPP_Contact
   {
      
      public static var §internal§:Boolean = false;
      
      public static var zpp_pool:ZPP_Contact = null;
       
      
      public var wrap_position:Vec2;
      
      public var stamp:int;
      
      public var py:Number;
      
      public var px:Number;
      
      public var pushmod:Boolean;
      
      public var posOnly:Boolean;
      
      public var outer:Contact;
      
      public var next:ZPP_Contact;
      
      public var modified:Boolean;
      
      public var length:int;
      
      public var inner:ZPP_IContact;
      
      public var hash:int;
      
      public var fresh:Boolean;
      
      public var elasticity:Number;
      
      public var dist:Number;
      
      public var arbiter:ZPP_Arbiter;
      
      public var active:Boolean;
      
      public var _inuse:Boolean;
      
      public function ZPP_Contact()
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
         elasticity = 0;
         dist = 0;
         fresh = false;
         hash = 0;
         stamp = 0;
         posOnly = false;
         active = false;
         inner = null;
         arbiter = null;
         wrap_position = null;
         py = 0;
         px = 0;
         outer = null;
         inner = new ZPP_IContact();
      }
      
      public function wrapper() : Contact
      {
         if(outer == null)
         {
            ZPP_Contact.§internal§ = true;
            outer = new Contact();
            ZPP_Contact.§internal§ = false;
            outer.zpp_inner = this;
         }
         return outer;
      }
      
      public function try_remove(param1:ZPP_Contact) : Boolean
      {
         var _loc2_:ZPP_Contact = null;
         var _loc3_:ZPP_Contact = next;
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
      
      public function splice(param1:ZPP_Contact, param2:int) : ZPP_Contact
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
         var _loc3_:* = null as ZPP_Contact;
         var _loc1_:ZPP_Contact = next;
         var _loc2_:ZPP_Contact = null;
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
      
      public function remove(param1:ZPP_Contact) : void
      {
         var _loc5_:* = null as ZPP_Contact;
         var _loc6_:* = null as ZPP_Contact;
         var _loc2_:ZPP_Contact = null;
         var _loc3_:ZPP_Contact = next;
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
      
      public function position_validate() : void
      {
         if(inactiveme())
         {
            Boot.lastError = new Error();
            throw "Error: Contact not currently in use";
         }
         wrap_position.zpp_inner.x = px;
         wrap_position.zpp_inner.y = py;
      }
      
      public function pop_unsafe() : ZPP_Contact
      {
         var _loc1_:ZPP_Contact = next;
         pop();
         return _loc1_;
      }
      
      public function pop() : void
      {
         var _loc1_:ZPP_Contact = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function iterator_at(param1:int) : ZPP_Contact
      {
         var _loc2_:ZPP_Contact = next;
         while(param1-- > 0 && _loc2_ != null)
         {
            _loc2_ = _loc2_.next;
         }
         return _loc2_;
      }
      
      public function insert(param1:ZPP_Contact, param2:ZPP_Contact) : ZPP_Contact
      {
         param2._inuse = true;
         var _loc3_:ZPP_Contact = param2;
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
      
      public function inlined_pop_unsafe() : ZPP_Contact
      {
         var _loc1_:ZPP_Contact = next;
         pop();
         return _loc1_;
      }
      
      public function inlined_pop() : void
      {
         var _loc1_:ZPP_Contact = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function inlined_insert(param1:ZPP_Contact, param2:ZPP_Contact) : ZPP_Contact
      {
         param2._inuse = true;
         var _loc3_:ZPP_Contact = param2;
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
      
      public function inlined_has(param1:ZPP_Contact) : Boolean
      {
         var _loc4_:* = null as ZPP_Contact;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_Contact = next;
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
      
      public function inlined_erase(param1:ZPP_Contact) : ZPP_Contact
      {
         var _loc2_:* = null as ZPP_Contact;
         var _loc3_:* = null as ZPP_Contact;
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
      
      public function inlined_add(param1:ZPP_Contact) : ZPP_Contact
      {
         param1._inuse = true;
         var _loc2_:ZPP_Contact = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
      
      public function inactiveme() : Boolean
      {
         return !(active && arbiter != null && arbiter.active);
      }
      
      public function has(param1:ZPP_Contact) : Boolean
      {
         var _loc4_:* = null as ZPP_Contact;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_Contact = next;
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
      
      public function getposition() : void
      {
         var _loc5_:* = null as Vec2;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZPP_Vec2;
         §§push(§§findproperty(wrap_position));
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc5_ = new Vec2();
         }
         else
         {
            _loc5_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc5_.zpp_pool;
            _loc5_.zpp_pool = null;
            _loc5_.zpp_disp = false;
            if(_loc5_ == ZPP_PubPool.nextVec2)
            {
               ZPP_PubPool.nextVec2 = null;
            }
         }
         if(_loc5_.zpp_inner == null)
         {
            _loc6_ = false;
            §§push(_loc5_);
            if(ZPP_Vec2.zpp_pool == null)
            {
               _loc7_ = new ZPP_Vec2();
            }
            else
            {
               _loc7_ = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc7_.next;
               _loc7_.next = null;
            }
            _loc7_.weak = false;
            _loc7_._immutable = _loc6_;
            _loc7_.x = 0;
            _loc7_.y = 0;
            §§pop().zpp_inner = _loc7_;
            _loc5_.zpp_inner.outer = _loc5_;
         }
         else
         {
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
            §§push(false);
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
            if(_loc5_.zpp_inner.x == 0)
            {
               §§pop();
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
               §§push(_loc5_.zpp_inner.y == 0);
            }
            if(!§§pop())
            {
               _loc5_.zpp_inner.x = 0;
               _loc5_.zpp_inner.y = 0;
               _loc7_ = _loc5_.zpp_inner;
               if(_loc7_._invalidate != null)
               {
                  _loc7_._invalidate(_loc7_);
               }
            }
            _loc5_;
         }
         _loc5_.zpp_inner.weak = false;
         §§pop().wrap_position = _loc5_;
         wrap_position.zpp_inner._inuse = true;
         wrap_position.zpp_inner._immutable = true;
         wrap_position.zpp_inner._validate = position_validate;
      }
      
      public function erase(param1:ZPP_Contact) : ZPP_Contact
      {
         var _loc2_:* = null as ZPP_Contact;
         var _loc3_:* = null as ZPP_Contact;
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
      
      public function begin() : ZPP_Contact
      {
         return next;
      }
      
      public function back() : ZPP_Contact
      {
         var _loc1_:ZPP_Contact = next;
         var _loc2_:ZPP_Contact = _loc1_;
         while(_loc2_ != null)
         {
            _loc1_ = _loc2_;
            _loc2_ = _loc2_.next;
         }
         return _loc1_;
      }
      
      public function at(param1:int) : ZPP_Contact
      {
         var _loc2_:ZPP_Contact = iterator_at(param1);
         return _loc2_ != null ? _loc2_ : null;
      }
      
      public function addAll(param1:ZPP_Contact) : void
      {
         var _loc3_:* = null as ZPP_Contact;
         var _loc2_:ZPP_Contact = param1.next;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            add(_loc3_);
            _loc2_ = _loc2_.next;
         }
      }
      
      public function add(param1:ZPP_Contact) : ZPP_Contact
      {
         param1._inuse = true;
         var _loc2_:ZPP_Contact = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
   }
}
