package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.dynamics.ZPP_ColArbiter;
   
   public class ZNPNode_ZPP_ColArbiter
   {
      
      public static var zpp_pool:ZNPNode_ZPP_ColArbiter = null;
       
      
      public var next:ZNPNode_ZPP_ColArbiter;
      
      public var elt:ZPP_ColArbiter;
      
      public function ZNPNode_ZPP_ColArbiter()
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
