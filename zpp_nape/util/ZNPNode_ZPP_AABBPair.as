package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.space.ZPP_AABBPair;
   
   public class ZNPNode_ZPP_AABBPair
   {
      
      public static var zpp_pool:ZNPNode_ZPP_AABBPair = null;
       
      
      public var next:ZNPNode_ZPP_AABBPair;
      
      public var elt:ZPP_AABBPair;
      
      public function ZNPNode_ZPP_AABBPair()
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
