package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_BodyListener;
   
   public class ZNPNode_ZPP_BodyListener
   {
      
      public static var zpp_pool:ZNPNode_ZPP_BodyListener = null;
       
      
      public var next:ZNPNode_ZPP_BodyListener;
      
      public var elt:ZPP_BodyListener;
      
      public function ZNPNode_ZPP_BodyListener()
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
