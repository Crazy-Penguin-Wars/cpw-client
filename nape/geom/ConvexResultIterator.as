package nape.geom
{
   import flash.Boot;
   import zpp_nape.util.ZPP_ConvexResultList;
   
   public final class ConvexResultIterator
   {
      
      public static var zpp_pool:ConvexResultIterator = null;
       
      
      public var zpp_next:ConvexResultIterator;
      
      public var zpp_inner:ConvexResultList;
      
      public var zpp_i:int;
      
      public var zpp_critical:Boolean;
      
      public function ConvexResultIterator()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_next = null;
         zpp_critical = false;
         zpp_i = 0;
         zpp_inner = null;
         if(!ZPP_ConvexResultList.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "ConvexResult" + "Iterator derp!";
         }
      }
      
      public static function get(param1:ConvexResultList) : ConvexResultIterator
      {
         var _loc3_:* = null as ConvexResultIterator;
         var _loc2_:ConvexResultIterator = ConvexResultIterator.zpp_pool == null ? (ZPP_ConvexResultList.§internal§ = true, _loc3_ = new ConvexResultIterator(), ZPP_ConvexResultList.§internal§ = false, _loc3_) : (_loc3_ = ConvexResultIterator.zpp_pool, ConvexResultIterator.zpp_pool = _loc3_.zpp_next, _loc3_);
         _loc2_.zpp_i = 0;
         _loc2_.zpp_inner = param1;
         _loc2_.zpp_critical = false;
         return _loc2_;
      }
      
      public function next() : ConvexResult
      {
         zpp_critical = false;
         var _loc1_:int;
         zpp_i = (_loc1_ = zpp_i) + 1;
         return zpp_inner.at(_loc1_);
      }
      
      public function hasNext() : Boolean
      {
         zpp_inner.zpp_inner.valmod();
         var _loc2_:ConvexResultList = zpp_inner;
         _loc2_.zpp_inner.valmod();
         if(_loc2_.zpp_inner.zip_length)
         {
            _loc2_.zpp_inner.zip_length = false;
            _loc2_.zpp_inner.user_length = _loc2_.zpp_inner.inner.length;
         }
         var _loc1_:int = _loc2_.zpp_inner.user_length;
         zpp_critical = true;
         if(zpp_i < _loc1_)
         {
            return true;
         }
         zpp_next = ConvexResultIterator.zpp_pool;
         ConvexResultIterator.zpp_pool = this;
         zpp_inner = null;
         return false;
      }
   }
}
