package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_CbSetPair;
   
   public class ZNPNode_ZPP_CbSetPair
   {
      
      public static var zpp_pool:ZNPNode_ZPP_CbSetPair = null;
       
      
      public var next:ZNPNode_ZPP_CbSetPair;
      
      public var elt:ZPP_CbSetPair;
      
      public function ZNPNode_ZPP_CbSetPair()
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
