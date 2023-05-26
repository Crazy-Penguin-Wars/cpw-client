package zpp_nape.util
{
   import flash.Boot;
   import nape.geom.RayResult;
   
   public class ZNPNode_RayResult
   {
      
      public static var zpp_pool:ZNPNode_RayResult = null;
       
      
      public var next:ZNPNode_RayResult;
      
      public var elt:RayResult;
      
      public function ZNPNode_RayResult()
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
