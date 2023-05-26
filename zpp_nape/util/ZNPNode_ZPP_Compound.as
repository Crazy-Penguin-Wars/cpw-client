package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.phys.ZPP_Compound;
   
   public class ZNPNode_ZPP_Compound
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Compound = null;
       
      
      public var next:ZNPNode_ZPP_Compound;
      
      public var elt:ZPP_Compound;
      
      public function ZNPNode_ZPP_Compound()
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
