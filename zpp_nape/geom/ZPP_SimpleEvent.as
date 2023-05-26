package zpp_nape.geom
{
   import flash.Boot;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleEvent;
   
   public class ZPP_SimpleEvent
   {
      
      public static var zpp_pool:ZPP_SimpleEvent = null;
       
      
      public var vertex:ZPP_SimpleVert;
      
      public var type:int;
      
      public var segment2:ZPP_SimpleSeg;
      
      public var segment:ZPP_SimpleSeg;
      
      public var node:ZPP_Set_ZPP_SimpleEvent;
      
      public var next:ZPP_SimpleEvent;
      
      public function ZPP_SimpleEvent()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         next = null;
         node = null;
         segment2 = null;
         segment = null;
         vertex = null;
         type = 0;
      }
      
      public static function swap_nodes(param1:ZPP_SimpleEvent, param2:ZPP_SimpleEvent) : void
      {
         var _loc3_:ZPP_Set_ZPP_SimpleEvent = param1.node;
         param1.node = param2.node;
         param2.node = _loc3_;
      }
      
      public static function less_xy(param1:ZPP_SimpleEvent, param2:ZPP_SimpleEvent) : Boolean
      {
         if(param1.vertex.x < param2.vertex.x)
         {
            return true;
         }
         if(param1.vertex.x > param2.vertex.x)
         {
            return false;
         }
         if(param1.vertex.y < param2.vertex.y)
         {
            return true;
         }
         if(param1.vertex.y > param2.vertex.y)
         {
            return false;
         }
         return param1.type < param2.type;
      }
      
      public static function get(param1:ZPP_SimpleVert) : ZPP_SimpleEvent
      {
         var _loc2_:* = null as ZPP_SimpleEvent;
         if(ZPP_SimpleEvent.zpp_pool == null)
         {
            _loc2_ = new ZPP_SimpleEvent();
         }
         else
         {
            _loc2_ = ZPP_SimpleEvent.zpp_pool;
            ZPP_SimpleEvent.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         _loc2_.vertex = param1;
         return _loc2_;
      }
   }
}
