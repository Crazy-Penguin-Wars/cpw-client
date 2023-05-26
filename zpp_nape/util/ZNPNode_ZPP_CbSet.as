package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_CbSet;
   
   public class ZNPNode_ZPP_CbSet
   {
      
      public static var zpp_pool:ZNPNode_ZPP_CbSet = null;
       
      
      public var next:ZNPNode_ZPP_CbSet;
      
      public var elt:ZPP_CbSet;
      
      public function ZNPNode_ZPP_CbSet()
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
