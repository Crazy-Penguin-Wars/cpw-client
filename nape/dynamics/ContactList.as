package nape.dynamics
{
   import flash.Boot;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.util.ZPP_ContactList;
   
   public final class ContactList
   {
       
      
      public var zpp_inner:ZPP_ContactList;
      
      public function ContactList()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         zpp_inner = new ZPP_ContactList();
         zpp_inner.outer = this;
      }
      
      public static function fromArray(param1:Array) : ContactList
      {
         var _loc4_:* = null as Contact;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot convert null Array to Nape list";
         }
         var _loc2_:ContactList = new ContactList();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            if(!(_loc4_ is Contact))
            {
               Boot.lastError = new Error();
               throw "Error: Array contains non " + "Contact" + " types.";
            }
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function fromVector(param1:Vector.<Contact>) : ContactList
      {
         var _loc4_:* = null as Contact;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot convert null Vector to Nape list";
         }
         var _loc2_:ContactList = new ContactList();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public function unshift(param1:Contact) : Boolean
      {
         var _loc3_:* = null as ZPP_Contact;
         var _loc4_:* = null as ZPP_Contact;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Contact" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc2_:Boolean = zpp_inner.adder != null ? zpp_inner.adder(param1) : true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               if(zpp_inner.push_ite == null)
               {
                  zpp_inner.valmod();
                  §§push(zpp_inner);
                  if(zpp_inner.zip_length)
                  {
                     zpp_inner.zip_length = false;
                     zpp_inner.user_length = 0;
                     _loc3_ = zpp_inner.inner.next;
                     while(_loc3_ != null)
                     {
                        _loc4_ = _loc3_;
                        if(_loc4_.active && _loc4_.arbiter.active)
                        {
                           zpp_inner.user_length = zpp_inner.user_length + 1;
                        }
                        _loc3_ = _loc3_.next;
                     }
                  }
                  if(zpp_inner.user_length == 0)
                  {
                     §§push(null);
                  }
                  else
                  {
                     zpp_inner.valmod();
                     §§push(zpp_inner.inner);
                     if(zpp_inner.zip_length)
                     {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = 0;
                        _loc3_ = zpp_inner.inner.next;
                        while(_loc3_ != null)
                        {
                           _loc4_ = _loc3_;
                           if(_loc4_.active && _loc4_.arbiter.active)
                           {
                              zpp_inner.user_length = zpp_inner.user_length + 1;
                           }
                           _loc3_ = _loc3_.next;
                        }
                     }
                     §§push(§§pop().iterator_at(zpp_inner.user_length - 1));
                  }
                  §§pop().push_ite = §§pop();
               }
               zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite,param1.zpp_inner);
            }
            else
            {
               zpp_inner.inner.add(param1.zpp_inner);
            }
            zpp_inner.invalidate();
            if(zpp_inner.post_adder != null)
            {
               zpp_inner.post_adder(param1);
            }
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         var _loc4_:* = null as Contact;
         var _loc5_:int = 0;
         var _loc6_:* = null as ContactList;
         var _loc7_:* = null as ZPP_Contact;
         var _loc8_:* = null as ZPP_Contact;
         var _loc1_:String = "[";
         var _loc2_:Boolean = true;
         zpp_inner.valmod();
         var _loc3_:ContactIterator = ContactIterator.get(this);
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc6_ = _loc3_.zpp_inner;
            _loc6_.zpp_inner.valmod();
            if(_loc6_.zpp_inner.zip_length)
            {
               _loc6_.zpp_inner.zip_length = false;
               _loc6_.zpp_inner.user_length = 0;
               _loc7_ = _loc6_.zpp_inner.inner.next;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_;
                  if(_loc8_.active && _loc8_.arbiter.active)
                  {
                     _loc6_.zpp_inner.user_length = _loc6_.zpp_inner.user_length + 1;
                  }
                  _loc7_ = _loc7_.next;
               }
            }
            _loc5_ = _loc6_.zpp_inner.user_length;
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc5_ ? true : (_loc3_.zpp_next = ContactIterator.zpp_pool, ContactIterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
            {
               break;
            }
            _loc3_.zpp_critical = false;
            _loc3_.zpp_i = (_loc5_ = _loc3_.zpp_i) + 1;
            _loc4_ = _loc3_.zpp_inner.at(_loc5_);
            if(!_loc2_)
            {
               _loc1_ += ",";
            }
            _loc1_ += _loc4_ == null ? "NULL" : _loc4_.toString();
            _loc2_ = false;
         }
         return _loc1_ + "]";
      }
      
      public function shift() : Contact
      {
         var _loc1_:* = null as ZPP_Contact;
         var _loc2_:* = null as ZPP_Contact;
         var _loc3_:* = null as ZPP_Contact;
         var _loc4_:* = null as ZPP_Contact;
         var _loc5_:* = null as Contact;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Contact" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = 0;
            _loc1_ = zpp_inner.inner.next;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_;
               if(_loc2_.active && _loc2_.arbiter.active)
               {
                  zpp_inner.user_length = zpp_inner.user_length + 1;
               }
               _loc1_ = _loc1_.next;
            }
         }
         if(zpp_inner.user_length == 0)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot remove from empty list";
         }
         zpp_inner.valmod();
         _loc1_ = null;
         if(zpp_inner.reverse_flag)
         {
            if(zpp_inner.at_ite != null && zpp_inner.at_ite.next == null)
            {
               zpp_inner.at_ite = null;
            }
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = 0;
               _loc3_ = zpp_inner.inner.next;
               while(_loc3_ != null)
               {
                  _loc4_ = _loc3_;
                  if(_loc4_.active && _loc4_.arbiter.active)
                  {
                     zpp_inner.user_length = zpp_inner.user_length + 1;
                  }
                  _loc3_ = _loc3_.next;
               }
            }
            if(zpp_inner.user_length == 1)
            {
               §§push(null);
            }
            else
            {
               zpp_inner.valmod();
               §§push(zpp_inner.inner);
               if(zpp_inner.zip_length)
               {
                  zpp_inner.zip_length = false;
                  zpp_inner.user_length = 0;
                  _loc3_ = zpp_inner.inner.next;
                  while(_loc3_ != null)
                  {
                     _loc4_ = _loc3_;
                     if(_loc4_.active && _loc4_.arbiter.active)
                     {
                        zpp_inner.user_length = zpp_inner.user_length + 1;
                     }
                     _loc3_ = _loc3_.next;
                  }
               }
               §§push(§§pop().iterator_at(zpp_inner.user_length - 2));
            }
            _loc2_ = §§pop();
            _loc1_ = _loc2_ == null ? zpp_inner.inner.next : _loc2_.next;
            _loc5_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc5_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.erase(_loc2_);
            }
         }
         else
         {
            _loc1_ = zpp_inner.inner.next;
            _loc5_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc5_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.pop();
            }
         }
         zpp_inner.invalidate();
         return _loc1_.wrapper();
      }
      
      public function remove(param1:Contact) : Boolean
      {
         var _loc4_:* = null as ZPP_Contact;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Contact" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_Contact = zpp_inner.inner.next;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            if(_loc4_ == param1.zpp_inner)
            {
               _loc2_ = true;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         if(_loc2_)
         {
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(param1);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.remove(param1.zpp_inner);
            }
            zpp_inner.invalidate();
         }
         return _loc2_;
      }
      
      public function push(param1:Contact) : Boolean
      {
         var _loc3_:* = null as ZPP_Contact;
         var _loc4_:* = null as ZPP_Contact;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Contact" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc2_:Boolean = zpp_inner.adder != null ? zpp_inner.adder(param1) : true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               zpp_inner.inner.add(param1.zpp_inner);
            }
            else
            {
               if(zpp_inner.push_ite == null)
               {
                  zpp_inner.valmod();
                  §§push(zpp_inner);
                  if(zpp_inner.zip_length)
                  {
                     zpp_inner.zip_length = false;
                     zpp_inner.user_length = 0;
                     _loc3_ = zpp_inner.inner.next;
                     while(_loc3_ != null)
                     {
                        _loc4_ = _loc3_;
                        if(_loc4_.active && _loc4_.arbiter.active)
                        {
                           zpp_inner.user_length = zpp_inner.user_length + 1;
                        }
                        _loc3_ = _loc3_.next;
                     }
                  }
                  if(zpp_inner.user_length == 0)
                  {
                     §§push(null);
                  }
                  else
                  {
                     zpp_inner.valmod();
                     §§push(zpp_inner.inner);
                     if(zpp_inner.zip_length)
                     {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = 0;
                        _loc3_ = zpp_inner.inner.next;
                        while(_loc3_ != null)
                        {
                           _loc4_ = _loc3_;
                           if(_loc4_.active && _loc4_.arbiter.active)
                           {
                              zpp_inner.user_length = zpp_inner.user_length + 1;
                           }
                           _loc3_ = _loc3_.next;
                        }
                     }
                     §§push(§§pop().iterator_at(zpp_inner.user_length - 1));
                  }
                  §§pop().push_ite = §§pop();
               }
               zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite,param1.zpp_inner);
            }
            zpp_inner.invalidate();
            if(zpp_inner.post_adder != null)
            {
               zpp_inner.post_adder(param1);
            }
         }
         return _loc2_;
      }
      
      public function pop() : Contact
      {
         var _loc1_:* = null as ZPP_Contact;
         var _loc2_:* = null as ZPP_Contact;
         var _loc3_:* = null as Contact;
         var _loc4_:* = null as ZPP_Contact;
         var _loc5_:* = null as ZPP_Contact;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Contact" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = 0;
            _loc1_ = zpp_inner.inner.next;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_;
               if(_loc2_.active && _loc2_.arbiter.active)
               {
                  zpp_inner.user_length = zpp_inner.user_length + 1;
               }
               _loc1_ = _loc1_.next;
            }
         }
         if(zpp_inner.user_length == 0)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot remove from empty list";
         }
         zpp_inner.valmod();
         _loc1_ = null;
         if(zpp_inner.reverse_flag)
         {
            _loc1_ = zpp_inner.inner.next;
            _loc3_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc3_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.pop();
            }
         }
         else
         {
            if(zpp_inner.at_ite != null && zpp_inner.at_ite.next == null)
            {
               zpp_inner.at_ite = null;
            }
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = 0;
               _loc4_ = zpp_inner.inner.next;
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_;
                  if(_loc5_.active && _loc5_.arbiter.active)
                  {
                     zpp_inner.user_length = zpp_inner.user_length + 1;
                  }
                  _loc4_ = _loc4_.next;
               }
            }
            if(zpp_inner.user_length == 1)
            {
               §§push(null);
            }
            else
            {
               zpp_inner.valmod();
               §§push(zpp_inner.inner);
               if(zpp_inner.zip_length)
               {
                  zpp_inner.zip_length = false;
                  zpp_inner.user_length = 0;
                  _loc4_ = zpp_inner.inner.next;
                  while(_loc4_ != null)
                  {
                     _loc5_ = _loc4_;
                     if(_loc5_.active && _loc5_.arbiter.active)
                     {
                        zpp_inner.user_length = zpp_inner.user_length + 1;
                     }
                     _loc4_ = _loc4_.next;
                  }
               }
               §§push(§§pop().iterator_at(zpp_inner.user_length - 2));
            }
            _loc2_ = §§pop();
            _loc1_ = _loc2_ == null ? zpp_inner.inner.next : _loc2_.next;
            _loc3_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc3_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.erase(_loc2_);
            }
         }
         zpp_inner.invalidate();
         return _loc1_.wrapper();
      }
      
      public function merge(param1:ContactList) : void
      {
         var _loc3_:* = null as Contact;
         var _loc4_:int = 0;
         var _loc5_:* = null as ContactList;
         var _loc6_:* = null as ZPP_Contact;
         var _loc7_:* = null as ZPP_Contact;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot merge with null list";
         }
         param1.zpp_inner.valmod();
         var _loc2_:ContactIterator = ContactIterator.get(param1);
         while(true)
         {
            _loc2_.zpp_inner.zpp_inner.valmod();
            _loc5_ = _loc2_.zpp_inner;
            _loc5_.zpp_inner.valmod();
            if(_loc5_.zpp_inner.zip_length)
            {
               _loc5_.zpp_inner.zip_length = false;
               _loc5_.zpp_inner.user_length = 0;
               _loc6_ = _loc5_.zpp_inner.inner.next;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_;
                  if(_loc7_.active && _loc7_.arbiter.active)
                  {
                     _loc5_.zpp_inner.user_length = _loc5_.zpp_inner.user_length + 1;
                  }
                  _loc6_ = _loc6_.next;
               }
            }
            _loc4_ = _loc5_.zpp_inner.user_length;
            _loc2_.zpp_critical = true;
            if(!(_loc2_.zpp_i < _loc4_ ? true : (_loc2_.zpp_next = ContactIterator.zpp_pool, ContactIterator.zpp_pool = _loc2_, _loc2_.zpp_inner = null, false)))
            {
               break;
            }
            _loc2_.zpp_critical = false;
            _loc2_.zpp_i = (_loc4_ = _loc2_.zpp_i) + 1;
            _loc3_ = _loc2_.zpp_inner.at(_loc4_);
            if(!has(_loc3_))
            {
               if(zpp_inner.reverse_flag)
               {
                  push(_loc3_);
               }
               else
               {
                  unshift(_loc3_);
               }
            }
         }
      }
      
      public function iterator() : ContactIterator
      {
         zpp_inner.valmod();
         return ContactIterator.get(this);
      }
      
      public function has(param1:Contact) : Boolean
      {
         zpp_inner.valmod();
         return zpp_inner.inner.has(param1.zpp_inner);
      }
      
      public function get length() : int
      {
         var _loc1_:* = null as ZPP_Contact;
         var _loc2_:* = null as ZPP_Contact;
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = 0;
            _loc1_ = zpp_inner.inner.next;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_;
               if(_loc2_.active && _loc2_.arbiter.active)
               {
                  zpp_inner.user_length = zpp_inner.user_length + 1;
               }
               _loc1_ = _loc1_.next;
            }
         }
         return zpp_inner.user_length;
      }
      
      public function foreach(param1:Function) : ContactList
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null as ContactList;
         var _loc7_:* = null as ZPP_Contact;
         var _loc8_:* = null as ZPP_Contact;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot execute null on list elements";
         }
         zpp_inner.valmod();
         var _loc3_:ContactIterator = ContactIterator.get(this);
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc6_ = _loc3_.zpp_inner;
            _loc6_.zpp_inner.valmod();
            if(_loc6_.zpp_inner.zip_length)
            {
               _loc6_.zpp_inner.zip_length = false;
               _loc6_.zpp_inner.user_length = 0;
               _loc7_ = _loc6_.zpp_inner.inner.next;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_;
                  if(_loc8_.active && _loc8_.arbiter.active)
                  {
                     _loc6_.zpp_inner.user_length = _loc6_.zpp_inner.user_length + 1;
                  }
                  _loc7_ = _loc7_.next;
               }
            }
            _loc4_ = _loc6_.zpp_inner.user_length;
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc4_ ? true : (_loc3_.zpp_next = ContactIterator.zpp_pool, ContactIterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
            {
               break;
            }
            try
            {
               _loc3_.zpp_critical = false;
               _loc3_.zpp_i = (_loc4_ = _loc3_.zpp_i) + 1;
               param1(_loc3_.zpp_inner.at(_loc4_));
            }
            catch(_loc_e_:*)
            {
               break;
            }
         }
         return this;
      }
      
      public function filter(param1:Function) : ContactList
      {
         var _loc4_:* = null as Contact;
         var _loc5_:* = null;
         var _loc6_:* = null as ZPP_Contact;
         var _loc7_:* = null as ZPP_Contact;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot select elements of list with null";
         }
         var _loc3_:int = 0;
         while(true)
         {
            zpp_inner.valmod();
            §§push(_loc3_);
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = 0;
               _loc6_ = zpp_inner.inner.next;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_;
                  if(_loc7_.active && _loc7_.arbiter.active)
                  {
                     zpp_inner.user_length = zpp_inner.user_length + 1;
                  }
                  _loc6_ = _loc6_.next;
               }
            }
            if(§§pop() < zpp_inner.user_length)
            {
               _loc4_ = at(_loc3_);
               try
               {
                  if(param1(_loc4_))
                  {
                     _loc3_++;
                  }
                  else
                  {
                     remove(_loc4_);
                  }
               }
               catch(_loc_e_:*)
               {
                  break;
               }
            }
            break;
         }
         return this;
      }
      
      public function empty() : Boolean
      {
         var _loc1_:* = null as ZPP_Contact;
         var _loc2_:* = null as ZPP_Contact;
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = 0;
            _loc1_ = zpp_inner.inner.next;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_;
               if(_loc2_.active && _loc2_.arbiter.active)
               {
                  zpp_inner.user_length = zpp_inner.user_length + 1;
               }
               _loc1_ = _loc1_.next;
            }
         }
         return zpp_inner.user_length == 0;
      }
      
      public function copy(param1:Boolean = false) : ContactList
      {
         var _loc4_:* = null as Contact;
         var _loc5_:int = 0;
         var _loc6_:* = null as ContactList;
         var _loc7_:* = null as ZPP_Contact;
         var _loc8_:* = null as ZPP_Contact;
         var _loc2_:ContactList = new ContactList();
         zpp_inner.valmod();
         var _loc3_:ContactIterator = ContactIterator.get(this);
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc6_ = _loc3_.zpp_inner;
            _loc6_.zpp_inner.valmod();
            if(_loc6_.zpp_inner.zip_length)
            {
               _loc6_.zpp_inner.zip_length = false;
               _loc6_.zpp_inner.user_length = 0;
               _loc7_ = _loc6_.zpp_inner.inner.next;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_;
                  if(_loc8_.active && _loc8_.arbiter.active)
                  {
                     _loc6_.zpp_inner.user_length = _loc6_.zpp_inner.user_length + 1;
                  }
                  _loc7_ = _loc7_.next;
               }
            }
            _loc5_ = _loc6_.zpp_inner.user_length;
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc5_ ? true : (_loc3_.zpp_next = ContactIterator.zpp_pool, ContactIterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
            {
               break;
            }
            _loc3_.zpp_critical = false;
            _loc3_.zpp_i = (_loc5_ = _loc3_.zpp_i) + 1;
            _loc4_ = _loc3_.zpp_inner.at(_loc5_);
            §§push(_loc2_);
            if(param1)
            {
               Boot.lastError = new Error();
               throw "Error: " + "Contact" + " is not a copyable type";
            }
            §§pop().push(_loc4_);
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         var _loc1_:* = null as ZPP_Contact;
         var _loc2_:* = null as ZPP_Contact;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Contact" + "List is immutable";
         }
         if(zpp_inner.reverse_flag)
         {
            while(true)
            {
               zpp_inner.valmod();
               if(zpp_inner.zip_length)
               {
                  zpp_inner.zip_length = false;
                  zpp_inner.user_length = 0;
                  _loc1_ = zpp_inner.inner.next;
                  while(_loc1_ != null)
                  {
                     _loc2_ = _loc1_;
                     if(_loc2_.active && _loc2_.arbiter.active)
                     {
                        zpp_inner.user_length = zpp_inner.user_length + 1;
                     }
                     _loc1_ = _loc1_.next;
                  }
               }
               if(zpp_inner.user_length == 0)
               {
                  break;
               }
               pop();
            }
         }
         else
         {
            while(true)
            {
               zpp_inner.valmod();
               if(zpp_inner.zip_length)
               {
                  zpp_inner.zip_length = false;
                  zpp_inner.user_length = 0;
                  _loc1_ = zpp_inner.inner.next;
                  while(_loc1_ != null)
                  {
                     _loc2_ = _loc1_;
                     if(_loc2_.active && _loc2_.arbiter.active)
                     {
                        zpp_inner.user_length = zpp_inner.user_length + 1;
                     }
                     _loc1_ = _loc1_.next;
                  }
               }
               if(zpp_inner.user_length == 0)
               {
                  break;
               }
               shift();
            }
         }
      }
      
      public function at(param1:int) : Contact
      {
         var _loc2_:* = null as ZPP_Contact;
         var _loc3_:* = null as ZPP_Contact;
         zpp_inner.valmod();
         if(param1 < 0 || §§pop() >= zpp_inner.user_length)
         {
            Boot.lastError = new Error();
            throw "Error: Index out of bounds";
         }
         if(zpp_inner.reverse_flag)
         {
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = 0;
               _loc2_ = zpp_inner.inner.next;
               while(_loc2_ != null)
               {
                  _loc3_ = _loc2_;
                  if(_loc3_.active && _loc3_.arbiter.active)
                  {
                     zpp_inner.user_length = zpp_inner.user_length + 1;
                  }
                  _loc2_ = _loc2_.next;
               }
            }
            param1 = zpp_inner.user_length - 1 - param1;
         }
         if(param1 < zpp_inner.at_index || zpp_inner.at_ite == null)
         {
            zpp_inner.at_index = 0;
            zpp_inner.at_ite = zpp_inner.inner.next;
            while(true)
            {
               _loc2_ = zpp_inner.at_ite;
               if(_loc2_.active && _loc2_.arbiter.active)
               {
                  break;
               }
               zpp_inner.at_ite = zpp_inner.at_ite.next;
            }
         }
         while(zpp_inner.at_index != param1)
         {
            zpp_inner.at_index = zpp_inner.at_index + 1;
            zpp_inner.at_ite = zpp_inner.at_ite.next;
            while(true)
            {
               _loc2_ = zpp_inner.at_ite;
               if(_loc2_.active && _loc2_.arbiter.active)
               {
                  break;
               }
               zpp_inner.at_ite = zpp_inner.at_ite.next;
            }
         }
         return zpp_inner.at_ite.wrapper();
      }
      
      public function add(param1:Contact) : Boolean
      {
         return zpp_inner.reverse_flag ? push(param1) : unshift(param1);
      }
   }
}
