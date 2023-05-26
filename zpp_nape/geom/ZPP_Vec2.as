package zpp_nape.geom
{
   import flash.Boot;
   import nape.geom.Vec2;
   
   public class ZPP_Vec2
   {
      
      public static var zpp_pool:ZPP_Vec2 = null;
       
      
      public var y:Number;
      
      public var x:Number;
      
      public var weak:Boolean;
      
      public var pushmod:Boolean;
      
      public var outer:Vec2;
      
      public var next:ZPP_Vec2;
      
      public var modified:Boolean;
      
      public var length:int;
      
      public var _validate:Object;
      
      public var _isimmutable:Object;
      
      public var _invalidate:Object;
      
      public var _inuse:Boolean;
      
      public var _immutable:Boolean;
      
      public function ZPP_Vec2()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         y = 0;
         x = 0;
         length = 0;
         pushmod = false;
         modified = false;
         _inuse = false;
         next = null;
         weak = false;
         outer = null;
         _isimmutable = null;
         _immutable = false;
         _validate = null;
         _invalidate = null;
      }
      
      public static function get(param1:Number, param2:Number, param3:Boolean = false) : ZPP_Vec2
      {
         var _loc4_:* = null as ZPP_Vec2;
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc4_ = new ZPP_Vec2();
         }
         else
         {
            _loc4_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc4_.next;
            _loc4_.next = null;
         }
         _loc4_.weak = false;
         _loc4_._immutable = param3;
         _loc4_.x = param1;
         _loc4_.y = param2;
         return _loc4_;
      }
      
      public function try_remove(param1:ZPP_Vec2) : Boolean
      {
         var _loc2_:ZPP_Vec2 = null;
         var _loc3_:ZPP_Vec2 = next;
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
      
      public function toString() : String
      {
         return "{ x: " + x + " y: " + y + " }";
      }
      
      public function splice(param1:ZPP_Vec2, param2:int) : ZPP_Vec2
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
         var _loc3_:* = null as ZPP_Vec2;
         var _loc1_:ZPP_Vec2 = next;
         var _loc2_:ZPP_Vec2 = null;
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
      
      public function remove(param1:ZPP_Vec2) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc2_:ZPP_Vec2 = null;
         var _loc3_:ZPP_Vec2 = next;
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
      
      public function pop_unsafe() : ZPP_Vec2
      {
         var _loc1_:ZPP_Vec2 = next;
         pop();
         return _loc1_;
      }
      
      public function pop() : void
      {
         var _loc1_:ZPP_Vec2 = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function iterator_at(param1:int) : ZPP_Vec2
      {
         var _loc2_:ZPP_Vec2 = next;
         while(param1-- > 0 && _loc2_ != null)
         {
            _loc2_ = _loc2_.next;
         }
         return _loc2_;
      }
      
      public function insert(param1:ZPP_Vec2, param2:ZPP_Vec2) : ZPP_Vec2
      {
         param2._inuse = true;
         var _loc3_:ZPP_Vec2 = param2;
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
      
      public function inlined_pop_unsafe() : ZPP_Vec2
      {
         var _loc1_:ZPP_Vec2 = next;
         pop();
         return _loc1_;
      }
      
      public function inlined_pop() : void
      {
         var _loc1_:ZPP_Vec2 = next;
         next = _loc1_.next;
         _loc1_._inuse = false;
         if(next == null)
         {
            pushmod = true;
         }
         modified = true;
         length = length - 1;
      }
      
      public function inlined_insert(param1:ZPP_Vec2, param2:ZPP_Vec2) : ZPP_Vec2
      {
         param2._inuse = true;
         var _loc3_:ZPP_Vec2 = param2;
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
      
      public function inlined_has(param1:ZPP_Vec2) : Boolean
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_Vec2 = next;
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
      
      public function inlined_erase(param1:ZPP_Vec2) : ZPP_Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         var _loc3_:* = null as ZPP_Vec2;
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
      
      public function inlined_add(param1:ZPP_Vec2) : ZPP_Vec2
      {
         param1._inuse = true;
         var _loc2_:ZPP_Vec2 = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
      
      public function has(param1:ZPP_Vec2) : Boolean
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_Vec2 = next;
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
      
      public function erase(param1:ZPP_Vec2) : ZPP_Vec2
      {
         var _loc2_:* = null as ZPP_Vec2;
         var _loc3_:* = null as ZPP_Vec2;
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
      
      public function begin() : ZPP_Vec2
      {
         return next;
      }
      
      public function back() : ZPP_Vec2
      {
         var _loc1_:ZPP_Vec2 = next;
         var _loc2_:ZPP_Vec2 = _loc1_;
         while(_loc2_ != null)
         {
            _loc1_ = _loc2_;
            _loc2_ = _loc2_.next;
         }
         return _loc1_;
      }
      
      public function at(param1:int) : ZPP_Vec2
      {
         var _loc2_:ZPP_Vec2 = iterator_at(param1);
         return _loc2_ != null ? _loc2_ : null;
      }
      
      public function addAll(param1:ZPP_Vec2) : void
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc2_:ZPP_Vec2 = param1.next;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            add(_loc3_);
            _loc2_ = _loc2_.next;
         }
      }
      
      public function add(param1:ZPP_Vec2) : ZPP_Vec2
      {
         param1._inuse = true;
         var _loc2_:ZPP_Vec2 = param1;
         _loc2_.next = next;
         next = _loc2_;
         modified = true;
         length = length + 1;
         return param1;
      }
   }
}
