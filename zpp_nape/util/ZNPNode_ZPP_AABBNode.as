package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.space.ZPP_AABBNode;
   
   public class ZNPNode_ZPP_AABBNode
   {
      
      public static var zpp_pool:ZNPNode_ZPP_AABBNode = null;
       
      
      public var next:ZNPNode_ZPP_AABBNode;
      
      public var elt:ZPP_AABBNode;
      
      public function ZNPNode_ZPP_AABBNode()
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
