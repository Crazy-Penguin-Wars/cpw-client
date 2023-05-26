package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_SimplifyP;
   
   public class ZNPNode_ZPP_SimplifyP
   {
      
      public static var zpp_pool:ZNPNode_ZPP_SimplifyP = null;
       
      
      public var next:ZNPNode_ZPP_SimplifyP;
      
      public var elt:ZPP_SimplifyP;
      
      public function ZNPNode_ZPP_SimplifyP()
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
