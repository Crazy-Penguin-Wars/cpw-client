package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_SimpleEvent;
   
   public class ZNPNode_ZPP_SimpleEvent
   {
      
      public static var zpp_pool:ZNPNode_ZPP_SimpleEvent = null;
       
      
      public var next:ZNPNode_ZPP_SimpleEvent;
      
      public var elt:ZPP_SimpleEvent;
      
      public function ZNPNode_ZPP_SimpleEvent()
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
