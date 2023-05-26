package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.dynamics.ZPP_Arbiter;
   
   public class ZNPNode_ZPP_Arbiter
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Arbiter = null;
       
      
      public var next:ZNPNode_ZPP_Arbiter;
      
      public var elt:ZPP_Arbiter;
      
      public function ZNPNode_ZPP_Arbiter()
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
