package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_ToiEvent;
   
   public class ZNPNode_ZPP_ToiEvent
   {
      
      public static var zpp_pool:ZNPNode_ZPP_ToiEvent = null;
       
      
      public var next:ZNPNode_ZPP_ToiEvent;
      
      public var elt:ZPP_ToiEvent;
      
      public function ZNPNode_ZPP_ToiEvent()
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
