package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.space.ZPP_Component;
   
   public class ZNPNode_ZPP_Component
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Component = null;
       
      
      public var next:ZNPNode_ZPP_Component;
      
      public var elt:ZPP_Component;
      
      public function ZNPNode_ZPP_Component()
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
