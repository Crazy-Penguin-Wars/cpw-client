package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_CbType;
   
   public class ZNPNode_ZPP_CbType
   {
      
      public static var zpp_pool:ZNPNode_ZPP_CbType = null;
       
      
      public var next:ZNPNode_ZPP_CbType;
      
      public var elt:ZPP_CbType;
      
      public function ZNPNode_ZPP_CbType()
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
