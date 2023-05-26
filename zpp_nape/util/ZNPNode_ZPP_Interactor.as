package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.phys.ZPP_Interactor;
   
   public class ZNPNode_ZPP_Interactor
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Interactor = null;
       
      
      public var next:ZNPNode_ZPP_Interactor;
      
      public var elt:ZPP_Interactor;
      
      public function ZNPNode_ZPP_Interactor()
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
