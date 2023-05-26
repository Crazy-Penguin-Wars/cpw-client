package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class ZNPNode_ZPP_Vec2
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Vec2 = null;
       
      
      public var next:ZNPNode_ZPP_Vec2;
      
      public var elt:ZPP_Vec2;
      
      public function ZNPNode_ZPP_Vec2()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         elt = null;
         next = null;
      }
   }
}
