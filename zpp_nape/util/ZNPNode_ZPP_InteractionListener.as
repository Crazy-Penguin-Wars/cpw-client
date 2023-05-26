package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_InteractionListener;
   
   public class ZNPNode_ZPP_InteractionListener
   {
      
      public static var zpp_pool:ZNPNode_ZPP_InteractionListener = null;
       
      
      public var next:ZNPNode_ZPP_InteractionListener;
      
      public var elt:ZPP_InteractionListener;
      
      public function ZNPNode_ZPP_InteractionListener()
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
