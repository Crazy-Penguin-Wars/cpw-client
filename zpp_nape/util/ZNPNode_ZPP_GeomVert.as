package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_GeomVert;
   
   public class ZNPNode_ZPP_GeomVert
   {
      
      public static var zpp_pool:ZNPNode_ZPP_GeomVert = null;
       
      
      public var next:ZNPNode_ZPP_GeomVert;
      
      public var elt:ZPP_GeomVert;
      
      public function ZNPNode_ZPP_GeomVert()
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
