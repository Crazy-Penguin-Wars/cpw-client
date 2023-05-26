package zpp_nape.util
{
   import flash.Boot;
   import zpp_nape.dynamics.ZPP_SensorArbiter;
   
   public class ZNPNode_ZPP_SensorArbiter
   {
      
      public static var zpp_pool:ZNPNode_ZPP_SensorArbiter = null;
       
      
      public var next:ZNPNode_ZPP_SensorArbiter;
      
      public var elt:ZPP_SensorArbiter;
      
      public function ZNPNode_ZPP_SensorArbiter()
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
