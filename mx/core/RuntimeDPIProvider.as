package mx.core
{
   import flash.system.Capabilities;
   
   public class RuntimeDPIProvider
   {
       
      
      public function RuntimeDPIProvider()
      {
         super();
      }
      
      mx_internal static function classifyDPI(dpi:Number) : Number
      {
         if(dpi < 200)
         {
            return DPIClassification.DPI_160;
         }
         if(dpi <= 280)
         {
            return DPIClassification.DPI_240;
         }
         return DPIClassification.DPI_320;
      }
      
      public function get runtimeDPI() : Number
      {
         return mx_internal::classifyDPI(Capabilities.screenDPI);
      }
   }
}
