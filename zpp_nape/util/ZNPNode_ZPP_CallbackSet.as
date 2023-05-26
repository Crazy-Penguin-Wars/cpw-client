package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.space.ZPP_CallbackSet;
   
   public class ZNPNode_ZPP_CallbackSet
   {
      
      public static var zpp_pool:ZNPNode_ZPP_CallbackSet = null;
       
      
      public var next:ZNPNode_ZPP_CallbackSet;
      
      public var elt:ZPP_CallbackSet;
      
      public function ZNPNode_ZPP_CallbackSet()
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
