package nape.shape
{
   import flash.Boot;
   import zpp_nape.util.ZPP_EdgeList;
   
   public final class EdgeIterator
   {
      
      public static var zpp_pool:EdgeIterator = null;
       
      
      public var zpp_next:EdgeIterator;
      
      public var zpp_inner:EdgeList;
      
      public var zpp_i:int;
      
      public var zpp_critical:Boolean;
      
      public function EdgeIterator()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_next = null;
         zpp_critical = false;
         zpp_i = 0;
         zpp_inner = null;
         if(!ZPP_EdgeList.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "Edge" + "Iterator derp!";
         }
      }
      
      public static function get(param1:EdgeList) : EdgeIterator
      {
         var _loc3_:* = null as EdgeIterator;
         var _loc2_:EdgeIterator = EdgeIterator.zpp_pool == null ? (ZPP_EdgeList.§internal§ = true, _loc3_ = new EdgeIterator(), ZPP_EdgeList.§internal§ = false, _loc3_) : (_loc3_ = EdgeIterator.zpp_pool, EdgeIterator.zpp_pool = _loc3_.zpp_next, _loc3_);
         _loc2_.zpp_i = 0;
         _loc2_.zpp_inner = param1;
         _loc2_.zpp_critical = false;
         return _loc2_;
      }
      
      public function next() : Edge
      {
         zpp_critical = false;
         var _loc1_:int;
         zpp_i = (_loc1_ = zpp_i) + 1;
         return zpp_inner.at(_loc1_);
      }
      
      public function hasNext() : Boolean
      {
         zpp_inner.zpp_inner.valmod();
         var _loc2_:EdgeList = zpp_inner;
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
         zpp_next = EdgeIterator.zpp_pool;
         EdgeIterator.zpp_pool = this;
         zpp_inner = null;
         return false;
      }
   }
}
