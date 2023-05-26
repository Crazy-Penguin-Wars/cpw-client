package zpp_nape.dynamics
{
   import flash.Boot;
   
   public class ZPP_SensorArbiter extends ZPP_Arbiter
   {
      
      public static var zpp_pool:ZPP_SensorArbiter = null;
       
      
      public var next:ZPP_SensorArbiter;
      
      public function ZPP_SensorArbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         next = null;
         super();
         type = ZPP_Arbiter.SENSOR;
         sensorarb = this;
      }
   }
}
