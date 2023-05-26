package zpp_nape.util
{
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.geom.Vec2List;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class ZPP_MixVec2List extends Vec2List
   {
       
      
      public var zip_length:Boolean;
      
      public var inner:ZPP_Vec2;
      
      public var at_ite:ZPP_Vec2;
      
      public var at_index:int;
      
      public var _length:int;
      
      public function ZPP_MixVec2List()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         at_index = 0;
         at_ite = null;
         zip_length = false;
         _length = 0;
         inner = null;
         super();
         at_ite = null;
         at_index = 0;
         zip_length = true;
         _length = 0;
      }
      
      public static function get(param1:ZPP_Vec2, param2:Boolean = false) : ZPP_MixVec2List
      {
         var _loc3_:ZPP_MixVec2List = new ZPP_MixVec2List();
         _loc3_.inner = param1;
         _loc3_.zpp_inner.immutable = param2;
         return _loc3_;
      }
      
      override public function zpp_vm() : void
      {
         zpp_inner.validate();
         if(inner.modified)
         {
            zip_length = true;
            _length = 0;
            at_ite = null;
         }
      }
      
      override public function zpp_gl() : int
      {
         var _loc1_:* = null as ZPP_Vec2;
         var _loc2_:* = null as ZPP_Vec2;
         zpp_vm();
         if(zip_length)
         {
            _length = 0;
            _loc1_ = inner.next;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_;
               _length = _length + 1;
               _loc1_ = _loc1_.next;
            }
            zip_length = false;
         }
         return _length;
      }
      
      override public function unshift(param1:Vec2) : Boolean
      {
         var _loc3_:* = null as ZPP_Vec2;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_vm();
         if(param1.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " is already in use";
         }
         var _loc2_:Boolean = zpp_inner.adder != null ? zpp_inner.adder(param1) : true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               _loc3_ = inner.iterator_at(zpp_gl() - 1);
               inner.insert(_loc3_,param1.zpp_inner);
            }
            else
            {
               inner.add(param1.zpp_inner);
            }
            zpp_inner.invalidate();
            if(zpp_inner.post_adder != null)
            {
               zpp_inner.post_adder(param1);
            }
         }
         return _loc2_;
      }
      
      override public function shift() : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
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
            if(at_ite != null && at_ite.next == null)
            {
               at_ite = null;
            }
            _loc2_ = zpp_gl() == 1 ? null : inner.iterator_at(zpp_gl() - 2);
            _loc1_ = _loc2_ == null ? inner.next : _loc2_.next;
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
               inner.erase(_loc2_);
            }
         }
         else
         {
            _loc1_ = inner.next;
            if(_loc1_.outer == null)
            {
               _loc1_.outer = new Vec2();
               _loc2_ = _loc1_.outer.zpp_inner;
               if(_loc2_.outer != null)
               {
                  _loc2_.outer.zpp_inner = null;
                  _loc2_.outer = null;
               }
               _loc2_._isimmutable = null;
               _loc2_._validate = null;
               _loc2_._invalidate = null;
               _loc2_.next = ZPP_Vec2.zpp_pool;
               ZPP_Vec2.zpp_pool = _loc2_;
               _loc1_.outer.zpp_inner = _loc1_;
            }
            _loc3_ = _loc1_.outer;
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc3_);
            }
            if(!zpp_inner.dontremove)
            {
               inner.pop();
            }
         }
         zpp_inner.invalidate();
         if(_loc1_.outer == null)
         {
            _loc1_.outer = new Vec2();
            _loc2_ = _loc1_.outer.zpp_inner;
            if(_loc2_.outer != null)
            {
               _loc2_.outer.zpp_inner = null;
               _loc2_.outer = null;
            }
            _loc2_._isimmutable = null;
            _loc2_._validate = null;
            _loc2_._invalidate = null;
            _loc2_.next = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc2_;
            _loc1_.outer.zpp_inner = _loc1_;
         }
         return _loc1_.outer;
      }
      
      override public function remove(param1:Vec2) : Boolean
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
         var _loc3_:ZPP_Vec2 = inner.next;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            if(param1.zpp_inner == _loc4_)
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
               inner.remove(param1.zpp_inner);
            }
            zpp_inner.invalidate();
         }
         return _loc2_;
      }
      
      override public function push(param1:Vec2) : Boolean
      {
         var _loc3_:* = null as ZPP_Vec2;
         if(zpp_inner.immutable)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + "List is immutable";
         }
         zpp_inner.modify_test();
         zpp_vm();
         if(param1.zpp_inner._inuse)
         {
            Boot.lastError = new Error();
            throw "Error: " + "Vec2" + " is already in use";
         }
         var _loc2_:Boolean = zpp_inner.adder != null ? zpp_inner.adder(param1) : true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               inner.add(param1.zpp_inner);
            }
            else
            {
               _loc3_ = inner.iterator_at(zpp_gl() - 1);
               inner.insert(_loc3_,param1.zpp_inner);
            }
            zpp_inner.invalidate();
            if(zpp_inner.post_adder != null)
            {
               zpp_inner.post_adder(param1);
            }
         }
         return _loc2_;
      }
      
      override public function pop() : Vec2
      {
         var _loc2_:* = null as Vec2;
         var _loc3_:* = null as ZPP_Vec2;
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
            _loc1_ = inner.next;
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
               inner.pop();
            }
         }
         else
         {
            if(at_ite != null && at_ite.next == null)
            {
               at_ite = null;
            }
            _loc3_ = zpp_gl() == 1 ? null : inner.iterator_at(zpp_gl() - 2);
            _loc1_ = _loc3_ == null ? inner.next : _loc3_.next;
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
            _loc2_ = _loc1_.outer;
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc2_);
            }
            if(!zpp_inner.dontremove)
            {
               inner.erase(_loc3_);
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
      
      override public function clear() : void
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
      
      override public function at(param1:int) : Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
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
         if(param1 < at_index || at_ite == null)
         {
            at_index = 0;
            at_ite = inner.next;
            _loc2_ = at_ite;
         }
         while(at_index != param1)
         {
            at_index = at_index + 1;
            at_ite = at_ite.next;
            _loc2_ = at_ite;
         }
         _loc2_ = at_ite;
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
   }
}
