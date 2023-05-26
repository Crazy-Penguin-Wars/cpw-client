package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_SimpleVert;
   
   public class ZNPNode_ZPP_SimpleVert
   {
      
      public static var zpp_pool:ZNPNode_ZPP_SimpleVert = null;
       
      
      public var next:ZNPNode_ZPP_SimpleVert;
      
      public var elt:ZPP_SimpleVert;
      
      public function ZNPNode_ZPP_SimpleVert()
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
