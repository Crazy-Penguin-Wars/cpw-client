package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_PartitionVertex;
   
   public class ZNPNode_ZPP_PartitionVertex
   {
      
      public static var zpp_pool:ZNPNode_ZPP_PartitionVertex = null;
       
      
      public var next:ZNPNode_ZPP_PartitionVertex;
      
      public var elt:ZPP_PartitionVertex;
      
      public function ZNPNode_ZPP_PartitionVertex()
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
