package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.dynamics.ZPP_InteractionGroup;
   
   public class ZNPNode_ZPP_InteractionGroup
   {
      
      public static var zpp_pool:ZNPNode_ZPP_InteractionGroup = null;
       
      
      public var next:ZNPNode_ZPP_InteractionGroup;
      
      public var elt:ZPP_InteractionGroup;
      
      public function ZNPNode_ZPP_InteractionGroup()
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
