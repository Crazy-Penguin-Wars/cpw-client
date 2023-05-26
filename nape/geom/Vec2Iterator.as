package nape.geom
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Vec2List;
   
   public final class Vec2Iterator
   {
      
      public static var zpp_pool:Vec2Iterator = null;
       
      
      public var zpp_next:Vec2Iterator;
      
      public var zpp_inner:Vec2List;
      
      public var zpp_i:int;
      
      public var zpp_critical:Boolean;
      
      public function Vec2Iterator()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_next = null;
         zpp_critical = false;
         zpp_i = 0;
         zpp_inner = null;
         if(!ZPP_Vec2List.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "Vec2" + "Iterator derp!";
         }
      }
      
      public static function get(param1:Vec2List) : Vec2Iterator
      {
         var _loc3_:* = null as Vec2Iterator;
         var _loc2_:Vec2Iterator = Vec2Iterator.zpp_pool == null ? (ZPP_Vec2List.§internal§ = true, _loc3_ = new Vec2Iterator(), ZPP_Vec2List.§internal§ = false, _loc3_) : (_loc3_ = Vec2Iterator.zpp_pool, Vec2Iterator.zpp_pool = _loc3_.zpp_next, _loc3_);
         _loc2_.zpp_i = 0;
         _loc2_.zpp_inner = param1;
         _loc2_.zpp_critical = false;
         return _loc2_;
      }
      
      public function next() : Vec2
      {
         zpp_critical = false;
         var _loc1_:int;
         zpp_i = (_loc1_ = zpp_i) + 1;
         return zpp_inner.at(_loc1_);
      }
      
      public function hasNext() : Boolean
      {
         zpp_inner.zpp_inner.valmod();
         var _loc1_:int = zpp_inner.zpp_gl();
         zpp_critical = true;
         if(zpp_i < _loc1_)
         {
            return true;
         }
         zpp_next = Vec2Iterator.zpp_pool;
         Vec2Iterator.zpp_pool = this;
         zpp_inner = null;
         return false;
      }
   }
}
