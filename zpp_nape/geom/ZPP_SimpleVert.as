package zpp_nape.geom
{
   import flash.Boot;
   import zpp_nape.ZPP_ID;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleVert;
   
   public class ZPP_SimpleVert
   {
      
      public static var zpp_pool:ZPP_SimpleVert = null;
       
      
      public var y:Number;
      
      public var x:Number;
      
      public var node:ZPP_Set_ZPP_SimpleVert;
      
      public var next:ZPP_SimpleVert;
      
      public var links:ZPP_Set_ZPP_SimpleVert;
      
      public var id:int;
      
      public var forced:Boolean;
      
      public function ZPP_SimpleVert()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         node = null;
         next = null;
         id = 0;
         links = null;
         y = 0;
         x = 0;
         forced = false;
         id = ZPP_ID.ZPP_SimpleVert();
         if(ZPP_Set_ZPP_SimpleVert.zpp_pool == null)
         {
            links = new ZPP_Set_ZPP_SimpleVert();
         }
         else
         {
            links = ZPP_Set_ZPP_SimpleVert.zpp_pool;
            ZPP_Set_ZPP_SimpleVert.zpp_pool = links.next;
            links.next = null;
         }
         links.lt = ZPP_SimpleVert.less_xy;
      }
      
      public static function less_xy(param1:ZPP_SimpleVert, param2:ZPP_SimpleVert) : Boolean
      {
         return param1.y < param2.y || param1.y == param2.y && param1.x < param2.x;
      }
      
      public static function swap_nodes(param1:ZPP_SimpleVert, param2:ZPP_SimpleVert) : void
      {
         var _loc3_:ZPP_Set_ZPP_SimpleVert = param1.node;
         param1.node = param2.node;
         param2.node = _loc3_;
      }
      
      public static function get(param1:Number, param2:Number) : ZPP_SimpleVert
      {
         var _loc3_:* = null as ZPP_SimpleVert;
         if(ZPP_SimpleVert.zpp_pool == null)
         {
            _loc3_ = new ZPP_SimpleVert();
         }
         else
         {
            _loc3_ = ZPP_SimpleVert.zpp_pool;
            ZPP_SimpleVert.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.x = param1;
         _loc3_.y = param2;
         return _loc3_;
      }
   }
}
