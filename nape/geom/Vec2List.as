package nape.geom
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   import zpp_nape.util.ZPP_Vec2List;
   
   public class Vec2List
   {
       
      
      public var zpp_inner:ZPP_Vec2List;
      
      public function Vec2List()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         zpp_inner = new ZPP_Vec2List();
         zpp_inner.outer = this;
      }
      
      public static function fromArray(param1:Array) : Vec2List
      {
         var _loc4_:* = null as Vec2;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot convert null Array to Nape list";
         }
         var _loc2_:Vec2List = new Vec2List();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            if(!(_loc4_ is Vec2))
            {
               Boot.lastError = new Error();
               throw "Error: Array contains non " + "Vec2" + " types.";
            }
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function fromVector(param1:Vector.<Vec2>) : Vec2List
      {
         var _loc4_:* = null as Vec2;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot convert null Vector to Nape list";
         }
         var _loc2_:Vec2List = new Vec2List();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public function zpp_vm() : void
      {
         zpp_inner.valmod();
      }
      
      public function zpp_gl() : int
      {
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = zpp_inner.inner.length;
         }
         return zpp_inner.user_length;
      }
      
      public function unshift(param1:Vec2) : Boolean
      {
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_vm();
         var _loc2_:Boolean = zpp_inner.adder != null ? zpp_inner.adder(param1) : true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               if(zpp_inner.push_ite == null)
               {
                  zpp_inner.push_ite = empty() ? null : zpp_inner.inner.iterator_at(zpp_gl() - 1);
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
         var _loc4_:* = null as Vec2;
         var _loc5_:int = 0;
         var _loc1_:String = "[";
         var _loc2_:Boolean = true;
         var _loc3_:Vec2Iterator = iterator();
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc5_ = _loc3_.zpp_inner.zpp_gl();
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc5_ ? true : (_loc3_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
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
      
      public function shift() : Vec2
      {
         var _loc2_:* = null as ZNPNode_ZPP_Vec2;
         var _loc3_:* = null as Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + "List is immutable";
         }
         zpp_inner.modify_test();
         if(empty())
         {
            Boot.lastError = new Error();
            throw "Error: Cannot remove from empty list";
         }
         zpp_vm();
         var _loc1_:ZPP_Vec2 = null;
         if(zpp_inner.reverse_flag)
         {
            if(zpp_inner.at_ite != null && zpp_inner.at_ite.next == null)
            {
               zpp_inner.at_ite = null;
            }
            _loc2_ = zpp_gl() == 1 ? null : zpp_inner.inner.iterator_at(zpp_gl() - 2);
            _loc1_ = _loc2_ == null ? zpp_inner.inner.head.elt : _loc2_.next.elt;
            if(_loc1_.outer == null)
            {
               _loc1_.outer = new Vec2();
               _loc4_ = _loc1_.outer.zpp_inner;
               if(_loc4_.outer != null)
               {
                  _loc4_.outer.zpp_inner = null;
                  _loc4_.outer = null;
               }
               _loc4_._isimmutable = null;
               _loc4_._validate = null;
               _loc4_._invalidate = null;
               _loc4_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc4_;
               _loc1_.outer.zpp_inner = _loc1_;
            }
            _loc3_ = _loc1_.outer;
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc3_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.erase(_loc2_);
            }
         }
         else
         {
            _loc1_ = zpp_inner.inner.head.elt;
            if(_loc1_.outer == null)
            {
               _loc1_.outer = new Vec2();
               _loc4_ = _loc1_.outer.zpp_inner;
               if(_loc4_.outer != null)
               {
                  _loc4_.outer.zpp_inner = null;
                  _loc4_.outer = null;
               }
               _loc4_._isimmutable = null;
               _loc4_._validate = null;
               _loc4_._invalidate = null;
               _loc4_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc4_;
               _loc1_.outer.zpp_inner = _loc1_;
            }
            _loc3_ = _loc1_.outer;
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc3_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.pop();
            }
         }
         zpp_inner.invalidate();
         if(_loc1_.outer == null)
         {
            _loc1_.outer = new Vec2();
            _loc4_ = _loc1_.outer.zpp_inner;
            if(_loc4_.outer != null)
            {
               _loc4_.outer.zpp_inner = null;
               _loc4_.outer = null;
            }
            _loc4_._isimmutable = null;
            _loc4_._validate = null;
            _loc4_._invalidate = null;
            _loc4_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc4_;
            _loc1_.outer.zpp_inner = _loc1_;
         }
         return _loc1_.outer;
      }
      
      public function remove(param1:Vec2) : Boolean
      {
         var _loc4_:* = null as ZPP_Vec2;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_vm();
         var _loc2_:Boolean = false;
         var _loc3_:ZNPNode_ZPP_Vec2 = zpp_inner.inner.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
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
      
      public function push(param1:Vec2) : Boolean
      {
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_vm();
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
                  zpp_inner.push_ite = empty() ? null : zpp_inner.inner.iterator_at(zpp_gl() - 1);
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
      
      public function pop() : Vec2
      {
         var _loc2_:* = null as Vec2;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZNPNode_ZPP_Vec2;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + "List is immutable";
         }
         zpp_inner.modify_test();
         if(empty())
         {
            Boot.lastError = new Error();
            throw "Error: Cannot remove from empty list";
         }
         zpp_vm();
         var _loc1_:ZPP_Vec2 = null;
         if(zpp_inner.reverse_flag)
         {
            _loc1_ = zpp_inner.inner.head.elt;
            if(_loc1_.outer == null)
            {
               _loc1_.outer = new Vec2();
               _loc3_ = _loc1_.outer.zpp_inner;
               if(_loc3_.outer != null)
               {
                  _loc3_.outer.zpp_inner = null;
                  _loc3_.outer = null;
               }
               _loc3_._isimmutable = null;
               _loc3_._validate = null;
               _loc3_._invalidate = null;
               _loc3_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc3_;
               _loc1_.outer.zpp_inner = _loc1_;
            }
            _loc2_ = _loc1_.outer;
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc2_);
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
            _loc4_ = zpp_gl() == 1 ? null : zpp_inner.inner.iterator_at(zpp_gl() - 2);
            _loc1_ = _loc4_ == null ? zpp_inner.inner.head.elt : _loc4_.next.elt;
            if(_loc1_.outer == null)
            {
               _loc1_.outer = new Vec2();
               _loc3_ = _loc1_.outer.zpp_inner;
               if(_loc3_.outer != null)
               {
                  _loc3_.outer.zpp_inner = null;
                  _loc3_.outer = null;
               }
               _loc3_._isimmutable = null;
               _loc3_._validate = null;
               _loc3_._invalidate = null;
               _loc3_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc3_;
               _loc1_.outer.zpp_inner = _loc1_;
            }
            _loc2_ = _loc1_.outer;
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc2_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.erase(_loc4_);
            }
         }
         zpp_inner.invalidate();
         if(_loc1_.outer == null)
         {
            _loc1_.outer = new Vec2();
            _loc3_ = _loc1_.outer.zpp_inner;
            if(_loc3_.outer != null)
            {
               _loc3_.outer.zpp_inner = null;
               _loc3_.outer = null;
            }
            _loc3_._isimmutable = null;
            _loc3_._validate = null;
            _loc3_._invalidate = null;
            _loc3_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc3_;
            _loc1_.outer.zpp_inner = _loc1_;
         }
         return _loc1_.outer;
      }
      
      public function merge(param1:Vec2List) : void
      {
         var _loc3_:* = null as Vec2;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot merge with null list";
         }
         var _loc2_:Vec2Iterator = param1.iterator();
         while(true)
         {
            _loc2_.zpp_inner.zpp_inner.valmod();
            _loc4_ = _loc2_.zpp_inner.zpp_gl();
            _loc2_.zpp_critical = true;
            if(!(_loc2_.zpp_i < _loc4_ ? true : (_loc2_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc2_, _loc2_.zpp_inner = null, false)))
            {
               break;
            }
            _loc2_.zpp_critical = false;
            _loc2_.zpp_i = (_loc4_ = _loc2_.zpp_i) + 1;
            _loc3_ = _loc2_.zpp_inner.at(_loc4_);
            if(!has(_loc3_))
            {
               add(_loc3_);
            }
         }
      }
      
      public function iterator() : Vec2Iterator
      {
         zpp_vm();
         return Vec2Iterator.get(this);
      }
      
      public function has(param1:Vec2) : Boolean
      {
         zpp_vm();
         return zpp_inner.inner.has(param1.zpp_inner);
      }
      
      public function get length() : int
      {
         return zpp_gl();
      }
      
      public function foreach(param1:Function) : Vec2List
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot execute null on list elements";
         }
         var _loc3_:Vec2Iterator = iterator();
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc4_ = _loc3_.zpp_inner.zpp_gl();
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc4_ ? true : (_loc3_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
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
      
      public function filter(param1:Function) : Vec2List
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot select elements of list with null";
         }
         var _loc3_:int = 0;
         while(_loc3_ < zpp_gl())
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
         return this;
      }
      
      public function empty() : Boolean
      {
         return zpp_gl() == 0;
      }
      
      public function copy(param1:Boolean = false) : Vec2List
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:Number = NaN;
         var _loc10_:* = null as Vec2;
         var _loc11_:Boolean = false;
         var _loc2_:Vec2List = new Vec2List();
         var _loc3_:Vec2Iterator = iterator();
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc5_ = _loc3_.zpp_inner.zpp_gl();
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc5_ ? true : (_loc3_.zpp_next = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
            {
               break;
            }
            _loc3_.zpp_critical = false;
            _loc3_.zpp_i = (_loc5_ = _loc3_.zpp_i) + 1;
            _loc4_ = _loc3_.zpp_inner.at(_loc5_);
            §§push(_loc2_);
            if(param1)
            {
               _loc6_ = false;
               if(_loc4_ != null && _loc4_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               if(_loc4_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc8_ = _loc4_.zpp_inner;
               if(_loc8_._validate != null)
               {
                  _loc8_._validate();
               }
               _loc7_ = _loc4_.zpp_inner.x;
               if(_loc4_.zpp_disp)
               {
                  Boot.lastError = new Error();
                  throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
               }
               _loc8_ = _loc4_.zpp_inner;
               if(_loc8_._validate != null)
               {
                  _loc8_._validate();
               }
               _loc9_ = _loc4_.zpp_inner.y;
               if(_loc7_ != _loc7_ || _loc9_ != _loc9_)
               {
                  Boot.lastError = new Error();
                  throw "Error: Vec2 components cannot be NaN";
               }
               if(ZPP_PubPool.poolVec2 == null)
               {
                  _loc10_ = new Vec2();
               }
               else
               {
                  _loc10_ = ZPP_PubPool.poolVec2;
                  ZPP_PubPool.poolVec2 = _loc10_.zpp_pool;
                  _loc10_.zpp_pool = null;
                  _loc10_.zpp_disp = false;
                  if(_loc10_ == ZPP_PubPool.nextVec2)
                  {
                     ZPP_PubPool.nextVec2 = null;
                  }
               }
               if(_loc10_.zpp_inner == null)
               {
                  _loc11_ = false;
                  §§push(_loc10_);
                  if(ZPP_Vec2.zpp_pool == null)
                  {
                     _loc8_ = new ZPP_Vec2();
                  }
                  else
                  {
                     _loc8_ = ZPP_Vec2.zpp_pool;
                     ZPP_Vec2.zpp_pool = _loc8_.next;
                     _loc8_.next = null;
                  }
                  _loc8_.weak = false;
                  _loc8_._immutable = _loc11_;
                  _loc8_.x = _loc7_;
                  _loc8_.y = _loc9_;
                  §§pop().zpp_inner = _loc8_;
                  _loc10_.zpp_inner.outer = _loc10_;
               }
               else
               {
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc8_ = _loc10_.zpp_inner;
                  if(_loc8_._immutable)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 is immutable";
                  }
                  if(_loc8_._isimmutable != null)
                  {
                     _loc8_._isimmutable();
                  }
                  if(_loc7_ != _loc7_ || _loc9_ != _loc9_)
                  {
                     Boot.lastError = new Error();
                     throw "Error: Vec2 components cannot be NaN";
                  }
                  §§push(false);
                  if(_loc10_ != null && _loc10_.zpp_disp)
                  {
                     Boot.lastError = new Error();
                     throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                  }
                  _loc8_ = _loc10_.zpp_inner;
                  if(_loc8_._validate != null)
                  {
                     _loc8_._validate();
                  }
                  if(_loc10_.zpp_inner.x == _loc7_)
                  {
                     §§pop();
                     if(_loc10_ != null && _loc10_.zpp_disp)
                     {
                        Boot.lastError = new Error();
                        throw "Error: " + "Vec2" + " has been disposed and cannot be used!";
                     }
                     _loc8_ = _loc10_.zpp_inner;
                     if(_loc8_._validate != null)
                     {
                        _loc8_._validate();
                     }
                     §§push(_loc10_.zpp_inner.y == _loc9_);
                  }
                  if(!§§pop())
                  {
                     _loc10_.zpp_inner.x = _loc7_;
                     _loc10_.zpp_inner.y = _loc9_;
                     _loc8_ = _loc10_.zpp_inner;
                     if(_loc8_._invalidate != null)
                     {
                        _loc8_._invalidate(_loc8_);
                     }
                  }
                  _loc10_;
               }
               _loc10_.zpp_inner.weak = _loc6_;
               §§push(_loc10_);
            }
            else
            {
               §§push(_loc4_);
            }
            §§pop().push(§§pop());
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + "List is immutable";
         }
         if(zpp_inner.reverse_flag)
         {
            while(!empty())
            {
               pop();
            }
         }
         else
         {
            while(!empty())
            {
               shift();
            }
         }
      }
      
      public function at(param1:int) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         zpp_vm();
         if(param1 < 0 || param1 >= zpp_gl())
         {
            Boot.lastError = new Error();
            throw "Error: Index out of bounds";
         }
         if(zpp_inner.reverse_flag)
         {
            param1 = zpp_gl() - 1 - param1;
         }
         if(param1 < zpp_inner.at_index || zpp_inner.at_ite == null)
         {
            zpp_inner.at_index = param1;
            zpp_inner.at_ite = zpp_inner.inner.iterator_at(param1);
         }
         else
         {
            while(zpp_inner.at_index != param1)
            {
               zpp_inner.at_index = zpp_inner.at_index + 1;
               zpp_inner.at_ite = zpp_inner.at_ite.next;
            }
         }
         var _loc2_:ZPP_Vec2 = zpp_inner.at_ite.elt;
         if(_loc2_.outer == null)
         {
            _loc2_.outer = new Vec2();
            _loc3_ = _loc2_.outer.zpp_inner;
            if(_loc3_.outer != null)
            {
               _loc3_.outer.zpp_inner = null;
               _loc3_.outer = null;
            }
            _loc3_._isimmutable = null;
            _loc3_._validate = null;
            _loc3_._invalidate = null;
            _loc3_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc3_;
            _loc2_.outer.zpp_inner = _loc2_;
         }
         return _loc2_.outer;
      }
      
      public function add(param1:Vec2) : Boolean
      {
         return zpp_inner.reverse_flag ? push(param1) : unshift(param1);
      }
   }
}
