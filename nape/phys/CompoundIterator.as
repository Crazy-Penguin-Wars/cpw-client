package nape.phys
{
   import flash.Boot;
   import zpp_nape.util.ZPP_CompoundList;
   
   public final class CompoundIterator
   {
      
      public static var zpp_pool:CompoundIterator = null;
       
      
      public var zpp_next:CompoundIterator;
      
      public var zpp_inner:CompoundList;
      
      public var zpp_i:int;
      
      public var zpp_critical:Boolean;
      
      public function CompoundIterator()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_next = null;
         zpp_critical = false;
         zpp_i = 0;
         zpp_inner = null;
         if(!ZPP_CompoundList.§internal§)
         {
            Boot.lastError = new Error();
            throw "Error: Cannot instantiate " + "Compound" + "Iterator derp!";
         }
      }
      
      public static function get(param1:CompoundList) : CompoundIterator
      {
         var _loc3_:* = null as CompoundIterator;
         var _loc2_:CompoundIterator = CompoundIterator.zpp_pool == null ? (ZPP_CompoundList.§internal§ = true, _loc3_ = new CompoundIterator(), ZPP_CompoundList.§internal§ = false, _loc3_) : (_loc3_ = CompoundIterator.zpp_pool, CompoundIterator.zpp_pool = _loc3_.zpp_next, _loc3_);
         _loc2_.zpp_i = 0;
         _loc2_.zpp_inner = param1;
         _loc2_.zpp_critical = false;
         return _loc2_;
      }
      
      public function next() : Compound
      {
         zpp_critical = false;
         var _loc1_:int;
         zpp_i = (_loc1_ = zpp_i) + 1;
         return zpp_inner.at(_loc1_);
      }
      
      public function hasNext() : Boolean
      {
         zpp_inner.zpp_inner.valmod();
         var _loc2_:CompoundList = zpp_inner;
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
         zpp_next = CompoundIterator.zpp_pool;
         CompoundIterator.zpp_pool = this;
         zpp_inner = null;
         return false;
      }
   }
}
