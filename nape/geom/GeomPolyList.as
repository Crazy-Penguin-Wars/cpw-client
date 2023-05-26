package nape.geom
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_GeomPoly;
   import zpp_nape.util.ZNPNode_ZPP_GeomPoly;
   import zpp_nape.util.ZPP_GeomPolyList;
   
   public final class GeomPolyList
   {
       
      
      public var zpp_inner:ZPP_GeomPolyList;
      
      public function GeomPolyList()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = null;
         zpp_inner = new ZPP_GeomPolyList();
         zpp_inner.outer = this;
      }
      
      public static function fromArray(param1:Array) : GeomPolyList
      {
         var _loc4_:* = null as GeomPoly;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot convert null Array to Nape list";
         }
         var _loc2_:GeomPolyList = new GeomPolyList();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            if(!(_loc4_ is GeomPoly))
            {
               Boot.lastError = new Error();
               throw "Error: Array contains non " + "GeomPoly" + " types.";
            }
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function fromVector(param1:Vector.<GeomPoly>) : GeomPolyList
      {
         var _loc4_:* = null as GeomPoly;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot convert null Vector to Nape list";
         }
         var _loc2_:GeomPolyList = new GeomPolyList();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public function unshift(param1:GeomPoly) : Boolean
      {
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + "List is immutable";
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
                  §§push(zpp_inner);
                  if(zpp_inner.inner.head == null)
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
                        zpp_inner.user_length = zpp_inner.inner.length;
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
         var _loc4_:* = null as GeomPoly;
         var _loc5_:int = 0;
         var _loc6_:* = null as GeomPolyList;
         var _loc1_:String = "[";
         var _loc2_:Boolean = true;
         zpp_inner.valmod();
         var _loc3_:GeomPolyIterator = GeomPolyIterator.get(this);
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc6_ = _loc3_.zpp_inner;
            _loc6_.zpp_inner.valmod();
            if(_loc6_.zpp_inner.zip_length)
            {
               _loc6_.zpp_inner.zip_length = false;
               _loc6_.zpp_inner.user_length = _loc6_.zpp_inner.inner.length;
            }
            _loc5_ = _loc6_.zpp_inner.user_length;
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc5_ ? true : (_loc3_.zpp_next = GeomPolyIterator.zpp_pool, GeomPolyIterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
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
      
      public function shift() : GeomPoly
      {
         var _loc2_:* = null as ZNPNode_ZPP_GeomPoly;
         var _loc3_:* = null as GeomPoly;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + "List is immutable";
         }
         zpp_inner.modify_test();
         if(zpp_inner.inner.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot remove from empty list";
         }
         zpp_inner.valmod();
         var _loc1_:ZPP_GeomPoly = null;
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
               zpp_inner.user_length = zpp_inner.inner.length;
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
                  zpp_inner.user_length = zpp_inner.inner.length;
               }
               §§push(§§pop().iterator_at(zpp_inner.user_length - 2));
            }
            _loc2_ = §§pop();
            _loc1_ = _loc2_ == null ? zpp_inner.inner.head.elt : _loc2_.next.elt;
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
         return _loc1_.outer;
      }
      
      public function remove(param1:GeomPoly) : Boolean
      {
         var _loc4_:* = null as ZPP_GeomPoly;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc2_:Boolean = false;
         var _loc3_:ZNPNode_ZPP_GeomPoly = zpp_inner.inner.head;
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
      
      public function push(param1:GeomPoly) : Boolean
      {
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + "List is immutable";
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
                  §§push(zpp_inner);
                  if(zpp_inner.inner.head == null)
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
                        zpp_inner.user_length = zpp_inner.inner.length;
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
      
      public function pop() : GeomPoly
      {
         var _loc2_:* = null as GeomPoly;
         var _loc3_:* = null as ZNPNode_ZPP_GeomPoly;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + "List is immutable";
         }
         zpp_inner.modify_test();
         if(zpp_inner.inner.head == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot remove from empty list";
         }
         zpp_inner.valmod();
         var _loc1_:ZPP_GeomPoly = null;
         if(zpp_inner.reverse_flag)
         {
            _loc1_ = zpp_inner.inner.head.elt;
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
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = zpp_inner.inner.length;
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
                  zpp_inner.user_length = zpp_inner.inner.length;
               }
               §§push(§§pop().iterator_at(zpp_inner.user_length - 2));
            }
            _loc3_ = §§pop();
            _loc1_ = _loc3_ == null ? zpp_inner.inner.head.elt : _loc3_.next.elt;
            _loc2_ = _loc1_.outer;
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc2_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.erase(_loc3_);
            }
         }
         zpp_inner.invalidate();
         return _loc1_.outer;
      }
      
      public function merge(param1:GeomPolyList) : void
      {
         var _loc3_:* = null as GeomPoly;
         var _loc4_:int = 0;
         var _loc5_:* = null as GeomPolyList;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot merge with null list";
         }
         param1.zpp_inner.valmod();
         var _loc2_:GeomPolyIterator = GeomPolyIterator.get(param1);
         while(true)
         {
            _loc2_.zpp_inner.zpp_inner.valmod();
            _loc5_ = _loc2_.zpp_inner;
            _loc5_.zpp_inner.valmod();
            if(_loc5_.zpp_inner.zip_length)
            {
               _loc5_.zpp_inner.zip_length = false;
               _loc5_.zpp_inner.user_length = _loc5_.zpp_inner.inner.length;
            }
            _loc4_ = _loc5_.zpp_inner.user_length;
            _loc2_.zpp_critical = true;
            if(!(_loc2_.zpp_i < _loc4_ ? true : (_loc2_.zpp_next = GeomPolyIterator.zpp_pool, GeomPolyIterator.zpp_pool = _loc2_, _loc2_.zpp_inner = null, false)))
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
      
      public function iterator() : GeomPolyIterator
      {
         zpp_inner.valmod();
         return GeomPolyIterator.get(this);
      }
      
      public function has(param1:GeomPoly) : Boolean
      {
         zpp_inner.valmod();
         return zpp_inner.inner.has(param1.zpp_inner);
      }
      
      public function get length() : int
      {
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = zpp_inner.inner.length;
         }
         return zpp_inner.user_length;
      }
      
      public function foreach(param1:Function) : GeomPolyList
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc6_:* = null as GeomPolyList;
         if(param1 == null)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot execute null on list elements";
         }
         zpp_inner.valmod();
         var _loc3_:GeomPolyIterator = GeomPolyIterator.get(this);
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc6_ = _loc3_.zpp_inner;
            _loc6_.zpp_inner.valmod();
            if(_loc6_.zpp_inner.zip_length)
            {
               _loc6_.zpp_inner.zip_length = false;
               _loc6_.zpp_inner.user_length = _loc6_.zpp_inner.inner.length;
            }
            _loc4_ = _loc6_.zpp_inner.user_length;
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc4_ ? true : (_loc3_.zpp_next = GeomPolyIterator.zpp_pool, GeomPolyIterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
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
      
      public function filter(param1:Function) : GeomPolyList
      {
         var _loc4_:* = null as GeomPoly;
         var _loc5_:* = null;
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
               zpp_inner.user_length = zpp_inner.inner.length;
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
         return zpp_inner.inner.head == null;
      }
      
      public function copy(param1:Boolean = false) : GeomPolyList
      {
         var _loc4_:* = null as GeomPoly;
         var _loc5_:int = 0;
         var _loc6_:* = null as GeomPolyList;
         var _loc2_:GeomPolyList = new GeomPolyList();
         zpp_inner.valmod();
         var _loc3_:GeomPolyIterator = GeomPolyIterator.get(this);
         while(true)
         {
            _loc3_.zpp_inner.zpp_inner.valmod();
            _loc6_ = _loc3_.zpp_inner;
            _loc6_.zpp_inner.valmod();
            if(_loc6_.zpp_inner.zip_length)
            {
               _loc6_.zpp_inner.zip_length = false;
               _loc6_.zpp_inner.user_length = _loc6_.zpp_inner.inner.length;
            }
            _loc5_ = _loc6_.zpp_inner.user_length;
            _loc3_.zpp_critical = true;
            if(!(_loc3_.zpp_i < _loc5_ ? true : (_loc3_.zpp_next = GeomPolyIterator.zpp_pool, GeomPolyIterator.zpp_pool = _loc3_, _loc3_.zpp_inner = null, false)))
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
               throw "Error: " + "GeomPoly" + " is not a copyable type";
            }
            §§pop().push(_loc4_);
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "GeomPoly" + "List is immutable";
         }
         if(zpp_inner.reverse_flag)
         {
            while(zpp_inner.inner.head != null)
            {
               pop();
            }
         }
         else
         {
            while(zpp_inner.inner.head != null)
            {
               shift();
            }
         }
      }
      
      public function at(param1:int) : GeomPoly
      {
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
               zpp_inner.user_length = zpp_inner.inner.length;
            }
            param1 = zpp_inner.user_length - 1 - param1;
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
         return zpp_inner.at_ite.elt.outer;
      }
      
      public function add(param1:GeomPoly) : Boolean
      {
         return zpp_inner.reverse_flag ? push(param1) : unshift(param1);
      }
   }
}
