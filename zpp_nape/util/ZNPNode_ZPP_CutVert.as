package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_CutVert;
   
   public class ZNPNode_ZPP_CutVert
   {
      
      public static var zpp_pool:ZNPNode_ZPP_CutVert = null;
       
      
      public var next:ZNPNode_ZPP_CutVert;
      
      public var elt:ZPP_CutVert;
      
      public function ZNPNode_ZPP_CutVert()
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
