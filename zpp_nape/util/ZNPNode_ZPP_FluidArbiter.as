package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.dynamics.ZPP_FluidArbiter;
   
   public class ZNPNode_ZPP_FluidArbiter
   {
      
      public static var zpp_pool:ZNPNode_ZPP_FluidArbiter = null;
       
      
      public var next:ZNPNode_ZPP_FluidArbiter;
      
      public var elt:ZPP_FluidArbiter;
      
      public function ZNPNode_ZPP_FluidArbiter()
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
