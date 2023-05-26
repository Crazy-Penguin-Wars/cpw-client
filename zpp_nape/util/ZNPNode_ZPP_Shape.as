package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.shape.ZPP_Shape;
   
   public class ZNPNode_ZPP_Shape
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Shape = null;
       
      
      public var next:ZNPNode_ZPP_Shape;
      
      public var elt:ZPP_Shape;
      
      public function ZNPNode_ZPP_Shape()
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
