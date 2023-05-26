package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.shape.ZPP_Edge;
   
   public class ZNPNode_ZPP_Edge
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Edge = null;
       
      
      public var next:ZNPNode_ZPP_Edge;
      
      public var elt:ZPP_Edge;
      
      public function ZNPNode_ZPP_Edge()
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
