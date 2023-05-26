package zpp_nape.util
{
   import flash.Boot;
   
   public class FastHash2_Hashable2_Boolfalse
   {
       
      
      public var table:Vector.<Hashable2_Boolfalse>;
      
      public var cnt:int;
      
      public function FastHash2_Hashable2_Boolfalse()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         cnt = 0;
         table = null;
         cnt = 0;
         table = new Vector.<Hashable2_Boolfalse>(1048576,true);
      }
      
      public function remove(param1:Hashable2_Boolfalse) : void
      {
         var _loc4_:* = null as Hashable2_Boolfalse;
         var _loc2_:int = param1.id * 106039 + param1.di & 1048575;
         var _loc3_:Hashable2_Boolfalse = table[_loc2_];
         if(_loc3_ == param1)
         {
            table[_loc2_] = _loc3_.hnext;
         }
         else if(_loc3_ != null)
         {
            do
            {
               _loc4_ = _loc3_;
               _loc3_ = _loc3_.hnext;
            }
            while(_loc3_ != null && _loc3_ != param1);
            
            _loc4_.hnext = _loc3_.hnext;
         }
         param1.hnext = null;
         cnt = cnt - 1;
      }
      
      public function maybeAdd(param1:Hashable2_Boolfalse) : void
      {
         var _loc2_:int = param1.id * 106039 + param1.di & 1048575;
         var _loc3_:Hashable2_Boolfalse = table[_loc2_];
         if(_loc3_ == null)
         {
            table[_loc2_] = param1;
            param1.hnext = null;
         }
         else
         {
            param1.hnext = _loc3_.hnext;
            _loc3_.hnext = param1;
         }
         cnt = cnt + 1;
      }
      
      public function has(param1:int, param2:int) : Boolean
      {
         var _loc3_:Hashable2_Boolfalse = table[param1 * 106039 + param2 & 1048575];
         if(_loc3_ == null)
         {
            return false;
         }
         if(_loc3_.id == param1 && _loc3_.di == param2)
         {
            return true;
         }
         do
         {
            _loc3_ = _loc3_.hnext;
         }
         while(_loc3_ != null && (_loc3_.id != param1 || _loc3_.di != param2));
         
         return _loc3_ != null;
      }
      
      public function clear() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as Hashable2_Boolfalse;
         var _loc5_:* = null as Hashable2_Boolfalse;
         var _loc1_:int = 0;
         var _loc2_:int = table.length;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = _loc1_++;
            _loc4_ = table[_loc3_];
            if(_loc4_ != null)
            {
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_.hnext;
                  _loc4_.hnext = null;
                  _loc4_;
                  _loc4_ = _loc5_;
               }
               table[_loc3_] = null;
            }
         }
      }
      
      public function add(param1:Hashable2_Boolfalse) : void
      {
         var _loc2_:int = param1.id * 106039 + param1.di & 1048575;
         var _loc3_:Hashable2_Boolfalse = table[_loc2_];
         if(_loc3_ == null)
         {
            table[_loc2_] = param1;
            param1.hnext = null;
         }
         else
         {
            param1.hnext = _loc3_.hnext;
            _loc3_.hnext = param1;
         }
         cnt = cnt + 1;
      }
   }
}
