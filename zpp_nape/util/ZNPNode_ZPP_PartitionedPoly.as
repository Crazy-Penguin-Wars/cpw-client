package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_PartitionedPoly;
   
   public class ZNPNode_ZPP_PartitionedPoly
   {
      
      public static var zpp_pool:ZNPNode_ZPP_PartitionedPoly = null;
       
      
      public var next:ZNPNode_ZPP_PartitionedPoly;
      
      public var elt:ZPP_PartitionedPoly;
      
      public function ZNPNode_ZPP_PartitionedPoly()
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
