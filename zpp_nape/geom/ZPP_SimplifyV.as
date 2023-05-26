package zpp_nape.geom
{
   import flash.Boot;
   
   public class ZPP_SimplifyV
   {
      
      public static var zpp_pool:ZPP_SimplifyV = null;
       
      
      public var y:Number;
      
      public var x:Number;
      
      public var prev:ZPP_SimplifyV;
      
      public var next:ZPP_SimplifyV;
      
      public var forced:Boolean;
      
      public var flag:Boolean;
      
      public function ZPP_SimplifyV()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         forced = false;
         flag = false;
         prev = null;
         next = null;
         y = 0;
         x = 0;
      }
      
      public static function get(param1:ZPP_GeomVert) : ZPP_SimplifyV
      {
         var _loc2_:* = null as ZPP_SimplifyV;
         if(ZPP_SimplifyV.zpp_pool == null)
         {
            _loc2_ = new ZPP_SimplifyV();
         }
         else
         {
            _loc2_ = ZPP_SimplifyV.zpp_pool;
            ZPP_SimplifyV.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         _loc2_.flag = false;
         return _loc2_;
      }
   }
}
