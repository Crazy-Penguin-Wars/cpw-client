package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_CutInt;
   
   public class ZNPNode_ZPP_CutInt
   {
      
      public static var zpp_pool:ZNPNode_ZPP_CutInt = null;
       
      
      public var next:ZNPNode_ZPP_CutInt;
      
      public var elt:ZPP_CutInt;
      
      public function ZNPNode_ZPP_CutInt()
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
