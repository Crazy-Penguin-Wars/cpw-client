package zpp_nape.geom
{
   import flash.Boot;
   
   public class ZPP_SimplifyP
   {
      
      public static var zpp_pool:ZPP_SimplifyP = null;
       
      
      public var next:ZPP_SimplifyP;
      
      public var min:ZPP_SimplifyV;
      
      public var max:ZPP_SimplifyV;
      
      public function ZPP_SimplifyP()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         max = null;
         min = null;
         next = null;
      }
      
      public static function get(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV) : ZPP_SimplifyP
      {
         var _loc3_:* = null as ZPP_SimplifyP;
         if(ZPP_SimplifyP.zpp_pool == null)
         {
            _loc3_ = new ZPP_SimplifyP();
         }
         else
         {
            _loc3_ = ZPP_SimplifyP.zpp_pool;
            ZPP_SimplifyP.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.min = param1;
         _loc3_.max = param2;
         return _loc3_;
      }
   }
}
