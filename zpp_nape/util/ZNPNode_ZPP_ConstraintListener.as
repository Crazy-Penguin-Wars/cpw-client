package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_ConstraintListener;
   
   public class ZNPNode_ZPP_ConstraintListener
   {
      
      public static var zpp_pool:ZNPNode_ZPP_ConstraintListener = null;
       
      
      public var next:ZNPNode_ZPP_ConstraintListener;
      
      public var elt:ZPP_ConstraintListener;
      
      public function ZNPNode_ZPP_ConstraintListener()
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
