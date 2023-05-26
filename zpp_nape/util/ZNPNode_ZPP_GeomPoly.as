package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_GeomPoly;
   
   public class ZNPNode_ZPP_GeomPoly
   {
      
      public static var zpp_pool:ZNPNode_ZPP_GeomPoly = null;
       
      
      public var next:ZNPNode_ZPP_GeomPoly;
      
      public var elt:ZPP_GeomPoly;
      
      public function ZNPNode_ZPP_GeomPoly()
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
