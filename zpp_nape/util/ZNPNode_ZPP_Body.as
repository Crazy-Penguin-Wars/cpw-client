package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.phys.ZPP_Body;
   
   public class ZNPNode_ZPP_Body
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Body = null;
       
      
      public var next:ZNPNode_ZPP_Body;
      
      public var elt:ZPP_Body;
      
      public function ZNPNode_ZPP_Body()
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
