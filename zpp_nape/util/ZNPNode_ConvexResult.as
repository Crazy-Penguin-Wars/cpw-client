package zpp_nape.util
{
   import flash.Boot;
   import nape.geom.ConvexResult;
   
   public class ZNPNode_ConvexResult
   {
      
      public static var zpp_pool:ZNPNode_ConvexResult = null;
       
      
      public var next:ZNPNode_ConvexResult;
      
      public var elt:ConvexResult;
      
      public function ZNPNode_ConvexResult()
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
