package zpp_nape.util
{
   import flash.Boot;
   
   public class Hashable2_Boolfalse
   {
      
      public static var zpp_pool:Hashable2_Boolfalse = null;
       
      
      public var value:Boolean;
      
      public var next:Hashable2_Boolfalse;
      
      public var id:int;
      
      public var hnext:Hashable2_Boolfalse;
      
      public var di:int;
      
      public function Hashable2_Boolfalse()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         di = 0;
         id = 0;
         hnext = null;
         next = null;
         value = false;
      }
      
      public static function get(param1:int, param2:int, param3:Boolean) : Hashable2_Boolfalse
      {
         var _loc5_:* = null as Hashable2_Boolfalse;
         if(Hashable2_Boolfalse.zpp_pool == null)
         {
            _loc5_ = new Hashable2_Boolfalse();
         }
         else
         {
            _loc5_ = Hashable2_Boolfalse.zpp_pool;
            Hashable2_Boolfalse.zpp_pool = _loc5_.next;
            _loc5_.next = null;
         }
         _loc5_.id = param1;
         _loc5_.di = param2;
         var _loc4_:Hashable2_Boolfalse = _loc5_;
         _loc4_.value = param3;
         return _loc4_;
      }
      
      public static function getpersist(param1:int, param2:int) : Hashable2_Boolfalse
      {
         var _loc3_:* = null as Hashable2_Boolfalse;
         if(Hashable2_Boolfalse.zpp_pool == null)
         {
            _loc3_ = new Hashable2_Boolfalse();
         }
         else
         {
            _loc3_ = Hashable2_Boolfalse.zpp_pool;
            Hashable2_Boolfalse.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.id = param1;
         _loc3_.di = param2;
         return _loc3_;
      }
      
      public static function ordered_get(param1:int, param2:int, param3:Boolean) : Hashable2_Boolfalse
      {
         var _loc4_:* = null as Hashable2_Boolfalse;
         var _loc5_:* = null as Hashable2_Boolfalse;
         if(param1 <= param2)
         {
            if(Hashable2_Boolfalse.zpp_pool == null)
            {
               _loc5_ = new Hashable2_Boolfalse();
            }
            else
            {
               _loc5_ = Hashable2_Boolfalse.zpp_pool;
               Hashable2_Boolfalse.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            _loc5_.id = param1;
            _loc5_.di = param2;
            _loc4_ = _loc5_;
            _loc4_.value = param3;
            §§push(_loc4_);
         }
         else
         {
            if(Hashable2_Boolfalse.zpp_pool == null)
            {
               _loc5_ = new Hashable2_Boolfalse();
            }
            else
            {
               _loc5_ = Hashable2_Boolfalse.zpp_pool;
               Hashable2_Boolfalse.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            _loc5_.id = param2;
            _loc5_.di = param1;
            _loc4_ = _loc5_;
            _loc4_.value = param3;
            §§push(_loc4_);
         }
         return §§pop();
      }
      
      public static function ordered_get_persist(param1:int, param2:int) : Hashable2_Boolfalse
      {
         var _loc3_:* = null as Hashable2_Boolfalse;
         if(param1 <= param2)
         {
            if(Hashable2_Boolfalse.zpp_pool == null)
            {
               _loc3_ = new Hashable2_Boolfalse();
            }
            else
            {
               _loc3_ = Hashable2_Boolfalse.zpp_pool;
               Hashable2_Boolfalse.zpp_pool = _loc3_.next;
               _loc3_.next = null;
            }
            _loc3_.id = param1;
            _loc3_.di = param2;
            §§push(_loc3_);
         }
         else
         {
            if(Hashable2_Boolfalse.zpp_pool == null)
            {
               _loc3_ = new Hashable2_Boolfalse();
            }
            else
            {
               _loc3_ = Hashable2_Boolfalse.zpp_pool;
               Hashable2_Boolfalse.zpp_pool = _loc3_.next;
               _loc3_.next = null;
            }
            _loc3_.id = param2;
            _loc3_.di = param1;
            §§push(_loc3_);
         }
         return §§pop();
      }
   }
}
